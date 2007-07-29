From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] rebase: try not to munge commit log message
Date: Sat, 28 Jul 2007 18:11:03 -0700
Message-ID: <7vlkd0nheg.fsf_-_@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
	<20070728101156.20304d11.seanlkml@sympatico.ca>
	<7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net>
	<7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 29 03:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IExJP-0001D9-N6
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 03:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654AbXG2BLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 21:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758646AbXG2BLH
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 21:11:07 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48852 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757752AbXG2BLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 21:11:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729011105.DQOV1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 28 Jul 2007 21:11:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VDB31X00J1kojtg0000000; Sat, 28 Jul 2007 21:11:04 -0400
In-Reply-To: <7vzm1gnhin.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 28 Jul 2007 18:08:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54073>

This makes rebase/am keep the original commit log message
better, even when it does not conform to "single line paragraph
to say what it does, then explain and defend why it is a good
change in later paragraphs" convention.

This change is a two-edged sword.  While the earlier behaviour
would make such commit log messages more friendly to readers who
expect to get the birds-eye view with oneline summary formats,
users who primarily use git as a way to interact with foreign
SCM systems would not care much about the convenience of oneline
git log tools, but care more about preserving their own
convention.  This changes their commits less useful to readers
who read them with git tools while keeping them more consistent
with the foreign SCM systems they interact with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mailinfo.c          |   29 +++++++++++++++++++++----
 t/t3405-rebase-malformed.sh |   48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 5 deletions(-)
 create mode 100755 t/t3405-rebase-malformed.sh

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b4f6e91..b558754 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -237,8 +237,6 @@ static int eatspace(char *line)
 
 static char *cleanup_subject(char *subject)
 {
-	if (keep_subject)
-		return subject;
 	for (;;) {
 		char *p;
 		int len, remove;
@@ -425,6 +423,7 @@ static int read_one_header_line(char *line, int sz, FILE *in)
 			if (addlen >= sz - len)
 				addlen = sz - len - 1;
 			memcpy(line + len, continuation, addlen);
+			line[len] = '\n';
 			len += addlen;
 		}
 	}
@@ -846,6 +845,22 @@ static void handle_body(void)
 	return;
 }
 
+static void output_header_lines(FILE *fout, const char *hdr, char *data)
+{
+	while (1) {
+		char *ep = strchr(data, '\n');
+		int len;
+		if (!ep)
+			len = strlen(data);
+		else
+			len = ep - data;
+		fprintf(fout, "%s: %.*s\n", hdr, len, data);
+		if (!ep)
+			break;
+		data = ep + 1;
+	}
+}
+
 static void handle_info(void)
 {
 	char *sub;
@@ -863,9 +878,13 @@ static void handle_info(void)
 			continue;
 
 		if (!memcmp(header[i], "Subject", 7)) {
-			sub = cleanup_subject(hdr);
-			cleanup_space(sub);
-			fprintf(fout, "Subject: %s\n", sub);
+			if (keep_subject)
+				sub = hdr;
+			else {
+				sub = cleanup_subject(hdr);
+				cleanup_space(sub);
+			}
+			output_header_lines(fout, "Subject", sub);
 		} else if (!memcmp(header[i], "From", 4)) {
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name);
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
new file mode 100755
index 0000000..e4e2e64
--- /dev/null
+++ b/t/t3405-rebase-malformed.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='rebase should not insist on git message convention'
+
+. ./test-lib.sh
+
+cat >F <<\EOF
+This is an example of a commit log message
+that does not  conform to git commit convention.
+
+It has two paragraphs, but its first paragraph is not friendly
+to oneline summary format.
+EOF
+
+test_expect_success setup '
+
+	>file1 &&
+	>file2 &&
+	git add file1 file2 &&
+	test_tick &&
+	git commit -m "Initial commit" &&
+
+	git checkout -b side &&
+	cat F >file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -F F &&
+
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >F0 &&
+
+	git checkout master &&
+
+	echo One >file1 &&
+	test_tick &&
+	git add file1 &&
+	git commit -m "Second commit"
+'
+
+test_expect_success rebase '
+
+	git rebase master side &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >F1 &&
+
+	diff -u F0 F1 &&
+	diff -u F F0
+'
+
+test_done
-- 
1.5.3.rc3.24.g83b3d
