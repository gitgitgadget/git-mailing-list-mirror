From: Junio C Hamano <junio@twinsun.com>
Subject: [PATCH] mailinfo: handle folded header.
Date: Sat, 23 Jul 2005 02:10:31 -0700
Message-ID: <7vfyu5horr.fsf@totally-fudged-out-message-id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 11:11:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwG24-0007gg-A2
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVGWJKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 05:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGWJKr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 05:10:47 -0400
Received: from alcor.twinsun.com ([198.147.65.9]:9052 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id S261248AbVGWJKo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 05:10:44 -0400
Received: from sic.twinsun.com ([192.54.239.17])
	by alcor.twinsun.com (8.12.9/8.12.9) with ESMTP id j6N9AV3x016438;
	Sat, 23 Jul 2005 02:10:32 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j6N9AVY11971;
	Sat, 23 Jul 2005 02:10:31 -0700 (PDT)
Received: from sic.twinsun.com ([192.54.239.17])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2005072302103126159
 ; Sat, 23 Jul 2005 02:10:31 -0700
Received: from arte (arte.twinsun.com [192.54.239.5])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j6N9AVY11967;
	Sat, 23 Jul 2005 02:10:31 -0700 (PDT)
Received: by arte (sSMTP sendmail emulation); Sat, 23 Jul 2005 02:10:31 -0700
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some people split their long E-mail address over two lines
using the RFC2822 header "folding".  We can lose authorship
information this way, so make a minimum effort to deal with it,
instead of special casing only the "Subject:" field.

We could teach mailsplit to unfold the folded header, but
teaching mailinfo about folding would make more sense; a single
message can be fed to mailinfo without going through mailsplit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  This was done primarily to help Yoshifuji-san ;-) but I am not
  sure if it is worth this half-effort.  His address would be
  parsed as:

    Author: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI
    Email: yoshfuji@linux-ipv6.org

  which, while it is certainly better than the emptiness we would
  get without this patch, I suspect that it is not really what he
  would want to see either.

  We _might_ want to go all the way, decoding the mime encoded
  strings and convert them to utf8 (not limited to the From: but
  also the Subject: field).  I dunno.  I am submitting this
  patch in this form because it is an improvement over the
  current version without opening this can of worms.  I'll let
  other people open it by submitting a separate patch on top of
  this one if they want to.

 tools/mailinfo.c |   64 +++++++++++++++++++++++-------------------------------
 1 files changed, 27 insertions(+), 37 deletions(-)

25c8a3906c9f8645d7482abb2ef2de2b51155e45
diff --git a/tools/mailinfo.c b/tools/mailinfo.c
--- a/tools/mailinfo.c
+++ b/tools/mailinfo.c
@@ -89,45 +89,14 @@ static void handle_subject(char *line)
 	strcpy(subject, line);
 }
 
-static void add_subject_line(char *line)
-{
-	while (isspace(*line))
-		line++;
-	*--line = ' ';
-	strcat(subject, line);
-}
-
 static void check_line(char *line, int len)
 {
-	static int cont = -1;
-	if (!memcmp(line, "From:", 5) && isspace(line[5])) {
+	if (!memcmp(line, "From:", 5) && isspace(line[5]))
 		handle_from(line+6);
-		cont = 0;
-		return;
-	}
-	if (!memcmp(line, "Date:", 5) && isspace(line[5])) {
+	else if (!memcmp(line, "Date:", 5) && isspace(line[5]))
 		handle_date(line+6);
-		cont = 0;
-		return;
-	}
-	if (!memcmp(line, "Subject:", 8) && isspace(line[8])) {
+	else if (!memcmp(line, "Subject:", 8) && isspace(line[8]))
 		handle_subject(line+9);
-		cont = 1;
-		return;
-	}
-	if (isspace(*line)) {
-		switch (cont) {
-		case 0:
-			fprintf(stderr, "I don't do 'Date:' or 'From:' line continuations\n");
-			break;
-		case 1:
-			add_subject_line(line);
-			return;
-		default:
-			break;
-		}
-	}
-	cont = -1;
 }
 
 static char * cleanup_subject(char *subject)
@@ -246,9 +215,30 @@ static void handle_body(void)
 	}
 }
 
+static int read_one_header_line(char *line, int sz, FILE *in)
+{
+	int ofs = 0;
+	while (ofs < sz) {
+		int peek, len;
+		if (fgets(line + ofs, sz - ofs, in) == NULL)
+			return ofs;
+		len = eatspace(line + ofs);
+		if (len == 0)
+			return ofs;
+		peek = fgetc(in); ungetc(peek, in);
+		if (peek == ' ' || peek == '\t') {
+			/* Yuck, 2822 header "folding" */
+			ofs += len;
+			continue;
+		}
+		return ofs + len;
+	}
+	return ofs;
+}
+
 static void usage(void)
 {
-	fprintf(stderr, "mailinfo msg-file path-file < email\n");
+	fprintf(stderr, "mailinfo msg-file patch-file < email\n");
 	exit(1);
 }
 
@@ -266,8 +256,8 @@ int main(int argc, char ** argv)
 		perror(argv[2]);
 		exit(1);
 	}
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = eatspace(line);
+	while (1) {
+		int len = read_one_header_line(line, sizeof(line), stdin);
 		if (!len) {
 			handle_body();
 			break;
