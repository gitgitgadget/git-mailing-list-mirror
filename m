Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E9B2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdFBTfQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:35:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:34033 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbdFBTfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:35:14 -0400
Received: (qmail 21144 invoked by uid 109); 2 Jun 2017 18:35:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:35:06 +0000
Received: (qmail 30231 invoked by uid 111); 2 Jun 2017 18:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 14:35:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 14:35:04 -0400
Date:   Fri, 2 Jun 2017 14:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
Message-ID: <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 07:25:43PM +0200, René Scharfe wrote:

> Am 02.06.2017 um 05:08 schrieb Jeff King:
> > In theory the solution is:
> > 
> >    1. Start using localtime() instead of gmtime() with an adjustment when
> >       we are converting to the local timezone (i.e., format-local). We
> >       should be able to do this portably.
> > 
> >       This is easy to do, and it's better than handling %z ourselves,
> >       because it makes %Z work, too.
> > 
> >    2. When showing the author's timezone, do some trickery to set the
> >       program's timezone, then use localtime(), then restore the program
> >       timezone.
> > 
> >       I couldn't get this to work reliably. And anyway, we'd still have
> >       nothing to put in %Z since we don't have a timezone name at all in
> >       the git objects. We just have "+0400" or whatever.
> > 
> > So I don't see a portable way to make (2) work.
> 
> We could create a strftime wrapper that also takes a time zone offset,
> with platform-specific implementations.  Is it worth the effort?
> 
> What reliability issues did you run into?

My patch is below for reference.  The issue is that we have to stuff a
name into $TZ that the system libc will parse into something sensible.
Just setting it to "%+05d" doesn't work at all. glibc at least seems to
accept names like FOO+4, but:

  - I have no idea if that's portable

  - it only allows single-hour offsets, so +0330 is out. There might be
    some way to represent that, but I'm not sure if it's portable
    (FOO+0300 doesn't seem to work even on glibc).

  - that sets %Z to "FOO", which is obviously nonsense

> > If we do handle "%z" ourselves (either always or for just the one case),
> > what should the matching %Z say? Right now (and I think with René's
> > patch) it says GMT, which is actively misleading. We should probably
> > replace it with the same text as "%z". That's not quite what the user
> > wanted, but at least it's accurate.
> 
> On Linux "%z %Z" is expanded to "+0200 CEST" for me, while on Windows I
> get "Mitteleurop▒ische Sommerzeit Mitteleurop▒ische Sommerzeit".  (That
> "▒" is probably supposed to be an "ä".)  POSIX requires  +hhmm or -hhmm
> format for %z, and for %Z is to be "Replaced by the timezone name or
> abbreviation".
> 
> I'd say "GMT+0200" etc. is a nice enough timezone name, i.e. having %Z
> resolve to the same as %z plus a literal prefix of "GMT" should at least
> not be wrong.

I thought that, too, but I think it is wrong based on my understanding
of how $TZ is parsed. There something like "EDT-4" means "call this EDT,
and by the way it is 4 hours behind GMT".

So what you're proposing isn't wrong per se, but your notation means
something totally different than what similar-looking notation looks
like on the $TZ end, which is bound to create confusion.

> Alternatively we could have a lookup table mapping a few typical offsets
> to timezone names, but e.g. handling daylight saving times would
> probably be too hard (when did that part of the world switch in the
> given year?  north or south of the equator?)..

Right, I don't think the mapping of zone to offset is reversible,
because many zones map to the same offset. If I tell you I'm in -0500,
even just in the US that could mean Eastern Standard Time (winter, no
DST) or Central Daylight Time (summer, DST). Not to mention that other
political entities in the same longitude have their own zones which do
DST at different times (or were even established as zones at different
times; historical dates need to use the zones as they were at that
time).

> > As far as the patch itself goes, I'm disappointed to lose the automatic
> > "%" handling for all of the other callers. But I suspect the boilerplate
> > involved in any solution that lets callers choose whether or not to use
> > it would end up being longer than just handling it in each caller.
> 
> Actually I felt uneasy when you added that forced %% handling because it
> put a policy into an otherwise neutral interpreter function.  I just had
> no practical argument against it -- until now.
> 
> I'd rather see strbuf_expand also lose the hard-coded percent sign, but
> again I don't have an actual user for such a flexibility (yet).
> 
> Perhaps we should add a fully neutral strbuf_expand_core (or whatever),
> make strbuf_expand a wrapper with hard-coded % and %% handling and use
> the core function in the strftime wrapper.  Except that the function is
> not easily stackable.  Hmm..

Right, that's the boilerplate trickiness I was referring to. It's
probably not worth the effort.

Anyway, here's my patch. I've been testing it with:

  ./git log --format='%ai%n%ad%n' --date=format:'%Y-%m-%d %H:%M:%S %z (%Z)'

which lets you compare a variety of commits with the existing formatting
routine.

---
diff --git a/date.c b/date.c
index 63fa99685..a6214172e 100644
--- a/date.c
+++ b/date.c
@@ -196,6 +196,34 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
+	if (mode->type == DATE_STRFTIME) {
+		char *orig_tz;
+		time_t t = time;
+
+		if (!mode->local) {
+			char *new_tz = xstrfmt("GIT%+d", -tz / 100);
+			orig_tz = xstrdup_or_null(getenv("TZ"));
+			setenv("TZ", new_tz, 1);
+			free(new_tz);
+			tzset();
+		}
+
+		tm = localtime(&t);
+		strbuf_reset(&timebuf);
+		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
+
+		if (!mode->local) {
+			if (orig_tz)
+				setenv("TZ", orig_tz, 1);
+			else
+				unsetenv("TZ");
+			free(orig_tz);
+			tzset();
+		}
+
+		return timebuf.buf;
+	}
+
 	if (mode->local)
 		tz = local_tzoffset(time);
 
@@ -245,8 +273,6 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
-	else if (mode->type == DATE_STRFTIME)
-		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],

