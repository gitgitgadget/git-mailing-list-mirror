Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06649F
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 00:20:28 -0800 (PST)
Received: (qmail 24375 invoked by uid 109); 13 Dec 2023 08:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Dec 2023 08:20:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25362 invoked by uid 111); 13 Dec 2023 08:20:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Dec 2023 03:20:27 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Dec 2023 03:20:27 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] mailinfo: fix out-of-bounds memory reads in
 unquote_quoted_pair()
Message-ID: <20231213082027.GB1684525@coredump.intra.peff.net>
References: <20231212221243.GA1656116@coredump.intra.peff.net>
 <ZXlYIZ0Hb1kN84NU@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXlYIZ0Hb1kN84NU@tanuki>

On Wed, Dec 13, 2023 at 08:07:21AM +0100, Patrick Steinhardt wrote:

> >  static const char *unquote_quoted_string(struct strbuf *outbuf, const char *in)
> >  {
> > -	int c;
> >  	int take_next_literally = 0;
> >  
> > -	while ((c = *in++) != 0) {
> > +	while (*in) {
> > +		int c = *in++;
> >  		if (take_next_literally == 1) {
> >  			take_next_literally = 0;
> >  		} else {
> 
> I was wondering whether we want to convert `unquote_quoted_pair()` in
> the same way. It's not subject to the same issue because it doesn't
> return `in` to its callers. But it would lower the cognitive overhead a
> bit by keeping the coding style consistent. But please feel free to
> ignore this remark.

I dunno. I don't think the consistency matters that much between
functions, and on its own, the "while ((c = *in++))" pattern is not
harmful. It's used elsewhere in the same file for other functions that
are also fine (for decoding q/b headers).

> Another thing I was wondering about is the recursive nature of these
> functions, and whether it can lead to similar issues like we recently
> had when parsing revisions with stack exhaustion. I _think_ this should
> not be much of a problem in this case though, as we're talking about
> mail headers here. While the length of header values isn't restricted
> per se (the line length is restricted to 1000, but with Comment Folding
> Whitespace values can span multiple lines), but mail provdiers will sure
> clamp down on mails with a "From:" header that is megabytes in size.

It's just unquote_comment() that is recursive, but yeah, there is
nothing to stop it from recursing forever on "((((((...". The stack
requirements are pretty small, though. I needed between 2^17 and 2^18
bytes to segfault on my machine using:

  perl -e 'print "From: ", "(" x 2**18;' |
  git mailinfo /dev/null /dev/null

Absurdly big for an email, but maybe within the realm of possibility? I
think it might be possible to drop the recursion and just use a depth
counter, like this:

diff --git a/mailinfo.c b/mailinfo.c
index 737b9e5e13..db236f9f9f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -59,6 +59,7 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 {
 	int take_next_literally = 0;
+	int depth = 1;
 
 	strbuf_addch(outbuf, '(');
 
@@ -72,11 +73,14 @@ static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 				take_next_literally = 1;
 				continue;
 			case '(':
-				in = unquote_comment(outbuf, in);
+				strbuf_addch(outbuf, '(');
+				depth++;
 				continue;
 			case ')':
 				strbuf_addch(outbuf, ')');
-				return in;
+				if (!--depth)
+					return in;
+				continue;
 			}
 		}
 
I doubt it's a big deal either way, but if it's that easy to do it might
be worth it.

-Peff
