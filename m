From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 1/6] Make read_one_header_line return a flag not a length.
Date: Tue, 23 May 2006 13:44:11 -0600
Message-ID: <m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FicoT-0002eP-CK
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEWTpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEWTpA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:45:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46467 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751147AbWEWTo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:44:59 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJiB1r020679;
	Tue, 23 May 2006 13:44:11 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJiBvN020678;
	Tue, 23 May 2006 13:44:11 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m18xosjznu.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Tue, 23 May 2006 13:42:45 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20624>


Currently we only use the return value from read_one_header line
to tell if the line we have read is a header or not.  So make
it a flag.  This paves the way for better email detection.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 mailinfo.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

40f4ca44ec851e435ce9453c682c71b9c67063b9
diff --git a/mailinfo.c b/mailinfo.c
index b276519..83a2986 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -331,7 +331,7 @@ struct header_def {
 	int namelen;
 };
 
-static void check_header(char *line, int len, struct header_def *header)
+static void check_header(char *line, struct header_def *header)
 {
 	int i;
 
@@ -349,7 +349,7 @@ static void check_header(char *line, int
 	}
 }
 
-static void check_subheader_line(char *line, int len)
+static void check_subheader_line(char *line)
 {
 	static struct header_def header[] = {
 		{ "Content-Type", handle_subcontent_type },
@@ -357,9 +357,9 @@ static void check_subheader_line(char *l
 		  handle_content_transfer_encoding },
 		{ NULL },
 	};
-	check_header(line, len, header);
+	check_header(line, header);
 }
-static void check_header_line(char *line, int len)
+static void check_header_line(char *line)
 {
 	static struct header_def header[] = {
 		{ "From", handle_from },
@@ -370,7 +370,7 @@ static void check_header_line(char *line
 		  handle_content_transfer_encoding },
 		{ NULL },
 	};
-	check_header(line, len, header);
+	check_header(line, header);
 }
 
 static int read_one_header_line(char *line, int sz, FILE *in)
@@ -709,8 +709,8 @@ static void handle_multipart_body(void)
 		return;
 	/* We are on boundary line.  Start slurping the subhead. */
 	while (1) {
-		int len = read_one_header_line(line, sizeof(line), stdin);
-		if (!len) {
+		int hdr = read_one_header_line(line, sizeof(line), stdin);
+		if (!hdr) {
 			if (handle_multipart_one_part() < 0)
 				return;
 			/* Reset per part headers */
@@ -718,7 +718,7 @@ static void handle_multipart_body(void)
 			charset[0] = 0;
 		}
 		else
-			check_subheader_line(line, len);
+			check_subheader_line(line);
 	}
 	fclose(patchfile);
 	if (!patch_lines) {
@@ -787,15 +787,15 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 	while (1) {
-		int len = read_one_header_line(line, sizeof(line), stdin);
-		if (!len) {
+		int hdr = read_one_header_line(line, sizeof(line), stdin);
+		if (!hdr) {
 			if (multipart_boundary[0])
 				handle_multipart_body();
 			else
 				handle_body();
 			break;
 		}
-		check_header_line(line, len);
+		check_header_line(line);
 	}
 	return 0;
 }
-- 
1.3.2.g5041c-dirty
