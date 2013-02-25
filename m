From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] handle malformed dates in ident lines
Date: Mon, 25 Feb 2013 13:38:15 -0500
Message-ID: <20130225183815.GA14438@sigill.intra.peff.net>
References: <20130225183009.GB13912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2wl-0005kH-4x
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924Ab3BYSiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:38:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60085 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3BYSiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:38:18 -0500
Received: (qmail 25610 invoked by uid 107); 25 Feb 2013 18:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 13:39:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 13:38:15 -0500
Content-Disposition: inline
In-Reply-To: <20130225183009.GB13912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217077>

The split_ident_line function is used by many code paths to
find the name, mail, and date fields of an identity line.
It will return failure when the output is completely
unparseable, but may return success (along with a NULL date
field) if the date is empty or malformed.  Callers that care
about the date need to handle this situation explicitly, or
they will end up segfaulting as they feed the NULL date to
strtoul or similar.

There are basically three options:

  1. Reject the ident line entirely (i.e., do the same thing
     we would do if the name or email were missing). We
     already use this strategy in git-commit's
     determine_author_info.

  2. Process the name and email, but refuse to work on any
     date portions. format_person_part does this, and a
     commit with such an ident would yield an empty string
     for "--format=%at".

  3. Proceed with some obviously bogus sentinel value for
     the time (e.g., the start of the epoch).

Only two of the existing callers read the date but do not
handle this case at all: pp_user_info and git-blame's
get_ac_line. This patch modifies both to use option (3). The
hope is that this is friendly (we still produce some output)
but the epoch start date will give the user a clue that the
date is not valid.

Signed-off-by: Jeff King <peff@peff.net>
---
Having written that, I feel like the case for doing (3) is somewhat
flimsy. I don't know that it really matters that much either way, but
I'd be just as happy to do any of the others.

In fact, I really wonder if split_ident_line shouldn't simply be
returning error in such a case. The comment above it claims that reflogs
do not have such a timestamp, but they do. I suspect it is a weird
interaction of the reflog walker on format_person_part, but I haven't
checked. I wonder if we can simply fix the reflog code to pass a string
with the date in the usual way (since we _should_ have it at some
point). If not, then we can perhaps make things safer for other callers
with a wrapper like:

  /* safe default version */
  int split_ident_line(...)
  {
          /* calls less safe but more flexible version; i.e., the
           * existing one */
          if (split_ident_line_date_optional(...) < 0)
                  return -1;
          if (!ident.date_begin)
                  return -1;
          return 0;
  }

 builtin/blame.c | 13 +++++++++----
 pretty.c        | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 86100e9..2edff25 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1375,10 +1375,15 @@ static void get_ac_line(const char *inbuf, const char *what,
 	maillen = ident.mail_end - ident.mail_begin;
 	mailbuf = ident.mail_begin;
 
-	*time = strtoul(ident.date_begin, NULL, 10);
-
-	len = ident.tz_end - ident.tz_begin;
-	strbuf_add(tz, ident.tz_begin, len);
+	if (ident.date_begin) {
+		*time = strtoul(ident.date_begin, NULL, 10);
+		len = ident.tz_end - ident.tz_begin;
+		strbuf_add(tz, ident.tz_begin, len);
+	}
+	else {
+		*time = 0;
+		strbuf_addstr(tz, "-0000");
+	}
 
 	/*
 	 * Now, convert both name and e-mail using mailmap
diff --git a/pretty.c b/pretty.c
index eae57ad..4b19908 100644
--- a/pretty.c
+++ b/pretty.c
@@ -391,7 +391,7 @@ void pp_user_info(const struct pretty_print_context *pp,
 	struct strbuf mail;
 	struct ident_split ident;
 	int linelen;
-	char *line_end, *date;
+	char *line_end;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
 	int max_length = 78; /* per rfc2822 */
@@ -428,8 +428,17 @@ void pp_user_info(const struct pretty_print_context *pp,
 	strbuf_add(&name, namebuf, namelen);
 
 	namelen = name.len + mail.len + 3; /* ' ' + '<' + '>' */
-	time = strtoul(ident.date_begin, &date, 10);
-	tz = strtol(date, NULL, 10);
+
+	if (ident.date_begin) {
+		char *date;
+		time = strtoul(ident.date_begin, &date, 10);
+		tz = strtol(date, NULL, 10);
+	}
+	else {
+		/* ident has missing or malformed date */
+		time = 0;
+		tz = 0;
+	}
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		strbuf_addstr(sb, "From: ");
-- 
1.8.1.4.4.g265d2fa
