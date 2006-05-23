From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 3/6] Refactor commit messge handling.
Date: Tue, 23 May 2006 13:47:28 -0600
Message-ID: <m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
	<m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:48:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ficrb-0003ID-1B
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWEWTsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEWTsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:48:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50563 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750888AbWEWTsP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:48:15 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJlTWl020716;
	Tue, 23 May 2006 13:47:29 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJlS8w020715;
	Tue, 23 May 2006 13:47:29 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 23 May 2006 13:45:37 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20626>


- Move handle_info into main so it is called once
  after everything has been parsed.  This allows the removal
  of a static variable and removes two duplicate calls.

- Move parsing of inbody headers into handle_commit.
  This means we parse the in-body headers after we have decoded
  the character set, and it removes code duplication between
  handle_multipart_one_part and handle_body.

- Change the flag indicating that we have seen an in body
  prefix header into another bit in seen.
  This is a little more general and allows the possibility of parsing
  in body headers after the body message has begun.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 mailinfo.c |   58 ++++++++++++++++++++++------------------------------------
 1 files changed, 22 insertions(+), 36 deletions(-)

3f6fe4d5e86c3d8d1fad75bfeb71f398966813d4
diff --git a/mailinfo.c b/mailinfo.c
index bee7b20..3fa9505 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -237,38 +237,41 @@ static int eatspace(char *line)
 #define SEEN_FROM 01
 #define SEEN_DATE 02
 #define SEEN_SUBJECT 04
+#define SEEN_PREFIX  0x08
 
 /* First lines of body can have From:, Date:, and Subject: */
-static int handle_inbody_header(int *seen, char *line)
+static void handle_inbody_header(int *seen, char *line)
 {
+	if (*seen & SEEN_PREFIX)
+		return;
 	if (!memcmp("From:", line, 5) && isspace(line[5])) {
 		if (!(*seen & SEEN_FROM) && handle_from(line+6)) {
 			*seen |= SEEN_FROM;
-			return 1;
+			return;
 		}
 	}
 	if (!memcmp("Date:", line, 5) && isspace(line[5])) {
 		if (!(*seen & SEEN_DATE)) {
 			handle_date(line+6);
 			*seen |= SEEN_DATE;
-			return 1;
+			return;
 		}
 	}
 	if (!memcmp("Subject:", line, 8) && isspace(line[8])) {
 		if (!(*seen & SEEN_SUBJECT)) {
 			handle_subject(line+9);
 			*seen |= SEEN_SUBJECT;
-			return 1;
+			return;
 		}
 	}
 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
 		if (!(*seen & SEEN_SUBJECT)) {
 			handle_subject(line);
 			*seen |= SEEN_SUBJECT;
-			return 1;
+			return;
 		}
 	}
-	return 0;
+	*seen |= SEEN_PREFIX;
 }
 
 static char *cleanup_subject(char *subject)
@@ -590,12 +593,7 @@ static void decode_transfer_encoding(cha
 static void handle_info(void)
 {
 	char *sub;
-	static int done_info = 0;
-
-	if (done_info)
-		return;
 
-	done_info = 1;
 	sub = cleanup_subject(subject);
 	cleanup_space(name);
 	cleanup_space(date);
@@ -609,7 +607,7 @@ static void handle_info(void)
 /* We are inside message body and have read line[] already.
  * Spit out the commit log.
  */
-static int handle_commit_msg(void)
+static int handle_commit_msg(int *seen)
 {
 	if (!cmitmsg)
 		return 0;
@@ -633,6 +631,11 @@ static int handle_commit_msg(void)
 		decode_transfer_encoding(line);
 		if (metainfo_charset)
 			convert_to_utf8(line, charset);
+
+		handle_inbody_header(seen, line);
+		if (!(*seen & SEEN_PREFIX))
+			continue;
+
 		fputs(line, cmitmsg);
 	} while (fgets(line, sizeof(line), stdin) != NULL);
 	fclose(cmitmsg);
@@ -664,26 +667,16 @@ static void handle_patch(void)
  * that the first part to contain commit message and a patch, and
  * handle other parts as pure patches.
  */
-static int handle_multipart_one_part(void)
+static int handle_multipart_one_part(int *seen)
 {
-	int seen = 0;
 	int n = 0;
-	int len;
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 	again:
-		len = eatspace(line);
 		n++;
-		if (!len)
-			continue;
 		if (is_multipart_boundary(line))
 			break;
-		if (0 <= seen && handle_inbody_header(&seen, line))
-			continue;
-		seen = -1; /* no more inbody headers */
-		line[len] = '\n';
-		handle_info();
-		if (handle_commit_msg())
+		if (handle_commit_msg(seen))
 			goto again;
 		handle_patch();
 		break;
@@ -695,6 +688,7 @@ static int handle_multipart_one_part(voi
 
 static void handle_multipart_body(void)
 {
+	int seen = 0;
 	int part_num = 0;
 
 	/* Skip up to the first boundary */
@@ -709,7 +703,7 @@ static void handle_multipart_body(void)
 	while (1) {
 		int hdr = read_one_header_line(line, sizeof(line), stdin);
 		if (!hdr) {
-			if (handle_multipart_one_part() < 0)
+			if (handle_multipart_one_part(&seen) < 0)
 				return;
 			/* Reset per part headers */
 			transfer_encoding = TE_DONTCARE;
@@ -730,18 +724,9 @@ static void handle_body(void)
 {
 	int seen = 0;
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = eatspace(line);
-		if (!len)
-			continue;
-		if (0 <= seen && handle_inbody_header(&seen, line))
-			continue;
-		seen = -1; /* no more inbody headers */
-		line[len] = '\n';
-		handle_info();
-		handle_commit_msg();
+	if (fgets(line, sizeof(line), stdin) != NULL) {
+		handle_commit_msg(&seen);
 		handle_patch();
-		break;
 	}
 	fclose(patchfile);
 	if (!patch_lines) {
@@ -791,6 +776,7 @@ int main(int argc, char **argv)
 				handle_multipart_body();
 			else
 				handle_body();
+			handle_info();
 			break;
 		}
 		check_header_line(line);
-- 
1.3.2.g5041c-dirty
