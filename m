Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324C1203BD
	for <e@80x24.org>; Sat, 16 Jul 2016 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbcGPH40 (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 03:56:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:45880 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751017AbcGPH4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 03:56:25 -0400
Received: (qmail 8215 invoked by uid 102); 16 Jul 2016 07:56:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 03:56:26 -0400
Received: (qmail 22972 invoked by uid 107); 16 Jul 2016 07:56:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 03:56:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jul 2016 03:56:21 -0400
Date:	Sat, 16 Jul 2016 03:56:21 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 12/12] receive-pack: send keepalives during quiet periods
Message-ID: <20160716075621.GA10275@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
 <20160715104347.GL19271@sigill.intra.peff.net>
 <CAGZ79kbernZHx9SUG-_vbxy-g77_3ki1uc-21LCviwrH=aXp6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbernZHx9SUG-_vbxy-g77_3ki1uc-21LCviwrH=aXp6w@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 10:24:16AM -0700, Stefan Beller wrote:

> > @@ -319,10 +331,60 @@ static void rp_error(const char *err, ...)
> >  static int copy_to_sideband(int in, int out, void *arg)
> >  {
> >         char data[128];
> 
> While looking at this code, do you think it is feasible to increase the
> size of data[] to 1024 ? (The largest that is possible when
> side-band, but no side-band-64k is given).

I don't see any reason it could not be increased. On the other hand, I
find it unlikely to accomplish anything. We are relaying stderr over
sideband 2 here, so assuming that typically consists of human-readable
lines, they're unlikely to go over 128 (and if they do, they simply get
split into two packets).

I suppose if your hooks dump large ascii art to the user, we could save
a few framing bytes.

So I don't mind it, but it's definitely orthogonal to this series.

> The method was short and concise, this adds a lot of lines.
> Remembering d751dd11 (2016-07-10, hoist out handle_nonblock
> function for xread and xwrite), do you think it would be reasonable to
> put the whole poll handling into a dedicated function, maybe even reuse the
> that function?
> 
>     if (keepalive_active) {
>         if (wrapper_around_poll(&data_in) < 0) // handles EINTR internally
>             break;
>         if (!data_in)
>             send_keep_alive();
>     }
> 
> I am not sure if that makes this function more legible, just food for thought.

That would skip the EINTR continue, though since we're looping anyway
here, I'm not sure it's a big deal. The biggest simplification is more
like this, I think:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e41f55f..8d792a2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -328,6 +328,32 @@ static void rp_error(const char *err, ...)
 	va_end(params);
 }
 
+/* returns 1 if data is available, 0 otherwise */
+static int keepalive_poll(int in, int out)
+{
+	struct pollfd pfd;
+	int ret;
+
+	pfd.fd = fd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 1000 * keepalive_in_sec);
+
+	if (ret < 0) {
+		if (errno == EINTR)
+			return 0; /* no data, we should try again */
+		else
+			return 1; /* no data, but read should return real error */
+	}
+	if (ret == 0) {
+		/* no data; send a keepalive packet */
+		static const char buf[] = "0005\1";
+		write_or_die(out, buf, sizeof(buf) - 1);
+		return 0;
+	}
+	/* else there is actual data to read */
+	return 1;
+}
+
 static int copy_to_sideband(int in, int out, void *arg)
 {
 	char data[128];
@@ -341,26 +367,8 @@ static int copy_to_sideband(int in, int out, void *arg)
 	while (1) {
 		ssize_t sz;
 
-		if (keepalive_active) {
-			struct pollfd pfd;
-			int ret;
-
-			pfd.fd = in;
-			pfd.events = POLLIN;
-			ret = poll(&pfd, 1, 1000 * keepalive_in_sec);
-
-			if (ret < 0) {
-				if (errno == EINTR)
-					continue;
-				else
-					break;
-			} else if (ret == 0) {
-				/* no data; send a keepalive packet */
-				static const char buf[] = "0005\1";
-				write_or_die(1, buf, sizeof(buf) - 1);
-				continue;
-			} /* else there is actual data to read */
-		}
+		if (keepalive_active && !keepalive_poll(in, 1))
+			continue;
 
 		sz = xread(in, data, sizeof(data));
 		if (sz <= 0)

Note that there are actually three outcomes to poll (error, timeout, or
data), and this simplifies away the "error" case to just "try to read
some data" and assumes that the read() will cover (which is similar to
what xread() does).

I dunno if it really helps much, though. There's still a bunch of
keepalive logic in the function to handle the NUL-signal case.

I guess your proposal is more to have an "xpoll" that handles the EINTR
looping, and leave that logic in place. I think that still leaves most
of the complexity in the function.

> > +                       } else if (ret == 0) {
> > +                               /* no data; send a keepalive packet */
> > +                               static const char buf[] = "0005\1";
> 
> and the \1 is the first sideband. Why do we choose that sideband?

What other sideband do you propose? :)

More seriously, this is modeled on the similar keepalive in upload-pack.
The only other option is sideband 2, and IIRC, clients do bad things
with empty band-2 packets (like printing "remote: " but never finishing
the line if we never send any actual data).

> > +                               write_or_die(1, buf, sizeof(buf) - 1);
> > +                               continue;
> > +                       } /* else there is actual data to read */
> 
> "If there is data to read, we need to break the while(1), to actually
> read the data?"

We're not breaking the while; we're falling through to the read call.

> I got confused and needed to go back and read the actual code again,
> would it make sense to rather have a loop here?
> 
>     while (1) {
>        while(keepalive_active) {
>         if (wrapper_around_poll(&data_in) < 0) // handles EINTR internally
>             break;
>         if (!data_in)
>             send_keep_alive();
>         else
>             break;
>         }

This doesn't do the same thing. On poll() error, you are only breaking
out of the inner loop. My intent was to stop copy_to_sideband()
entirely. Perhaps this is the source of confusion; you were thinking of
this more like the loop in xread() where we _want_ to do the final
read() (even though we expect it to be an error!) to give the caller the
correct errno value.

Whereas here, I think it's fine to leave as soon as poll() complains. At
least that was how I wrote it.

I don't think doing it your way is actually wrong, it just wasn't what I
intended.

> > +               if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
> > +                       const char *p = memchr(data, '\0', sz);
> > +                       if (p) {
> > +                               /*
> > +                                * The NUL tells us to start sending keepalives. Make
> > +                                * sure we send any other data we read along
> > +                                * with it.
> > +                                */
> > +                               keepalive_active = 1;
> > +                               send_sideband(1, 2, data, p - data, use_sideband);
> > +                               send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
> > +                               continue;
> 
> Oh, I see why the turn_on_keepalive_on_NUL doesn't work as well as I thought.
> I wonder if we can use a better read function, that would stop reading at a NUL,
> and return early instead?

How would you do that, if not by read()ing a byte at a time (which is
inefficient)? Otherwise you have to deal with the leftovers (after the
NUL) in your buffer. It's one of the reasons I went with a single-byte
signal, because otherwise it gets rather complicated to do robustly.

-Peff
