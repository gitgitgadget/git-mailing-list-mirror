From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] pretty: handle broken commit headers gracefully
Date: Wed, 17 Apr 2013 20:33:35 +0200
Message-ID: <516EEAFF.6000209@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com> <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org> <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org> <7vli8hhgmn.fsf@alter.siamese.dyndns.org> <20130417063942.GA27703@sigill.intra.peff.net> <516EE300.7020200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 20:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USXAu-00060c-SD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 20:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966227Ab3DQSdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 14:33:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:48201 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966029Ab3DQSdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 14:33:39 -0400
Received: from [192.168.2.105] (p4FFD858B.dip.t-dialin.net [79.253.133.139])
	by india601.server4you.de (Postfix) with ESMTPSA id 7E7821F1;
	Wed, 17 Apr 2013 20:33:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516EE300.7020200@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221560>

Centralize the parsing of the date and time zone strings in the new
helper function show_ident_date() and make sure it checks the pointers
provided by split_ident_line() for NULL before use.

Reported-by: Ivan Lyapunov <dront78@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
The first test case passes on v1.8.1, i.e. it also showed the epoch.
The second one passes on v1.8.1 and on master because there already
is a NULL check in format_person_part().

 pretty.c               | 45 ++++++++++++++++++++++++---------------------
 t/t4211-log-corrupt.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 21 deletions(-)
 create mode 100755 t/t4211-log-corrupt.sh

diff --git a/pretty.c b/pretty.c
index d3a82d2..c116248 100644
--- a/pretty.c
+++ b/pretty.c
@@ -393,6 +393,19 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
 	strbuf_addstr(sb, "?=");
 }
 
+static const char *show_ident_date(const struct ident_split *ident,
+				   enum date_mode mode)
+{
+	unsigned long date = 0;
+	int tz = 0;
+
+	if (ident->date_begin && ident->date_end)
+		date = strtoul(ident->date_begin, NULL, 10);
+	if (ident->tz_begin && ident->tz_end)
+		tz = strtol(ident->tz_begin, NULL, 10);
+	return show_date(date, tz, mode);
+}
+
 void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
@@ -401,12 +414,10 @@ void pp_user_info(const struct pretty_print_context *pp,
 	struct strbuf mail;
 	struct ident_split ident;
 	int linelen;
-	char *line_end, *date;
+	char *line_end;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
 	int max_length = 78; /* per rfc2822 */
-	unsigned long time;
-	int tz;
 
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
@@ -438,8 +449,6 @@ void pp_user_info(const struct pretty_print_context *pp,
 	strbuf_add(&name, namebuf, namelen);
 
 	namelen = name.len + mail.len + 3; /* ' ' + '<' + '>' */
-	time = strtoul(ident.date_begin, &date, 10);
-	tz = strtol(date, NULL, 10);
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		strbuf_addstr(sb, "From: ");
@@ -472,13 +481,16 @@ void pp_user_info(const struct pretty_print_context *pp,
 
 	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
-		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, pp->date_mode));
+		strbuf_addf(sb, "Date:   %s\n",
+			    show_ident_date(&ident, pp->date_mode));
 		break;
 	case CMIT_FMT_EMAIL:
-		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
+		strbuf_addf(sb, "Date: %s\n",
+			    show_ident_date(&ident, DATE_RFC2822));
 		break;
 	case CMIT_FMT_FULLER:
-		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, pp->date_mode));
+		strbuf_addf(sb, "%sDate: %s\n", what,
+			    show_ident_date(&ident, pp->date_mode));
 		break;
 	default:
 		/* notin' */
@@ -688,8 +700,6 @@ static size_t format_person_part(struct strbuf *sb, char part,
 {
 	/* currently all placeholders have same length */
 	const int placeholder_len = 2;
-	int tz;
-	unsigned long date = 0;
 	struct ident_split s;
 	const char *name, *mail;
 	size_t maillen, namelen;
@@ -716,30 +726,23 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	if (!s.date_begin)
 		goto skip;
 
-	date = strtoul(s.date_begin, NULL, 10);
-
 	if (part == 't') {	/* date, UNIX timestamp */
 		strbuf_add(sb, s.date_begin, s.date_end - s.date_begin);
 		return placeholder_len;
 	}
 
-	/* parse tz */
-	tz = strtoul(s.tz_begin + 1, NULL, 10);
-	if (*s.tz_begin == '-')
-		tz = -tz;
-
 	switch (part) {
 	case 'd':	/* date */
-		strbuf_addstr(sb, show_date(date, tz, dmode));
+		strbuf_addstr(sb, show_ident_date(&s, dmode));
 		return placeholder_len;
 	case 'D':	/* date, RFC2822 style */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_RFC2822));
 		return placeholder_len;
 	case 'r':	/* date, relative */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_RELATIVE));
 		return placeholder_len;
 	case 'i':	/* date, ISO 8601 */
-		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_ISO8601));
 		return placeholder_len;
 	}
 
diff --git a/t/t4211-log-corrupt.sh b/t/t4211-log-corrupt.sh
new file mode 100755
index 0000000..ec5099b
--- /dev/null
+++ b/t/t4211-log-corrupt.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='git log with invalid commit headers'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit foo &&
+
+	git cat-file commit HEAD |
+	sed "/^author /s/>/>-<>/" >broken_email.commit &&
+	git hash-object -w -t commit broken_email.commit >broken_email.hash &&
+	git update-ref refs/heads/broken_email $(cat broken_email.hash)
+'
+
+test_expect_success 'git log with broken author email' '
+	{
+		echo commit $(cat broken_email.hash)
+		echo "Author: A U Thor <author@example.com>"
+		echo "Date:   Thu Jan 1 00:00:00 1970 +0000"
+		echo
+		echo "    foo"
+	} >expect.out &&
+	: >expect.err &&
+
+	git log broken_email >actual.out 2>actual.err &&
+
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success 'git log --format with broken author email' '
+	echo "A U Thor+author@example.com+" >expect.out &&
+	: >expect.err &&
+
+	git log --format="%an+%ae+%ad" broken_email >actual.out 2>actual.err &&
+
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_done
-- 
1.8.2.1
