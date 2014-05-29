From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 12:16:28 -0400
Message-ID: <20140529161628.GB3763@sigill.intra.peff.net>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>
To: Rodrigo Fernandes <rtfrodrigo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 29 18:17:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq31i-0001TK-Ne
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937AbaE2QRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:17:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:33520 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757687AbaE2QQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:16:30 -0400
Received: (qmail 3938 invoked by uid 102); 29 May 2014 16:16:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 11:16:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 12:16:28 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250392>

On Thu, May 29, 2014 at 05:50:56PM +0700, Duy Nguyen wrote:

> On Thu, May 29, 2014 at 5:29 PM, Rodrigo Fernandes <rtfrodrigo@gmail.com> wrote:
> > I get an empty response on the date field, but since pretty has `%ad`
> > it should follow the --date and return the date even if wrong.
> >
> > ...
> >
> > I tried to check the source code but have no idea where to start,
> > maybe if you point me on some direction I can take a look for my self.
> 
> pretty.c, format_commit_one() -> format_person_part() ->
> show_ident_date() -> show_date(). The last one is in date.c

show_ident_date() recently learned to always print "Jan 1 1970" as a
sentinel for dates that cannot be parsed (or for --date=raw, "0 +0000").
But I do not think we hit that code path at all here.

It looks like split_ident_line notices the bogus date and returns NULL
for s.date_begin. Then format_person_part skips the placeholder, since
it knows we have nothing worth showing.

I think we probably want to do something like:

diff --git a/pretty.c b/pretty.c
index 3c43db5..7214a2c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -732,14 +732,6 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		return placeholder_len;
 	}
 
-	if (!s.date_begin)
-		goto skip;
-
-	if (part == 't') {	/* date, UNIX timestamp */
-		strbuf_add(sb, s.date_begin, s.date_end - s.date_begin);
-		return placeholder_len;
-	}
-
 	switch (part) {
 	case 'd':	/* date */
 		strbuf_addstr(sb, show_ident_date(&s, dmode));
@@ -753,6 +745,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'i':	/* date, ISO 8601 */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_ISO8601));
 		return placeholder_len;
+	case 't':	/* date, UNIX timestamp */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_RAW));
+		return placeholder_len;
 	}
 
 skip:

to at least make --format date output consistent with the rest of git
(and to make "%at" consistent with "%ad" and --date=raw). That still
doesn't address Rodrigo's concern, though (we would print "0 +0000").

For that, we would want on top:

  1. Teach split_ident_line to return _something_ for his malformed
     case.

  2. Teach show_ident_line to treat DATE_RAW to truly output raw
     content, even if it is malformed.

I am not sure whether those are a good idea or not. The current code
provides some level of sanitization, so that a parser of log output will
not get malformed cruft. And DATE_RAW may mean "show me what is in the
raw commit, even if it is broken". Or it may just mean "show me the date
in unix timestamp format, because that is easy to parse".

I'd argue that if somebody really wants the former, they should be using
"--pretty=raw", which will show the raw commit headers, without any
parsing or fixup at all.

-Peff
