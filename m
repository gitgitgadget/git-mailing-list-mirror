From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 5/6] More accurately detect header lines in
 read_one_header_line
Date: Tue, 23 May 2006 13:53:20 -0600
Message-ID: <m1mzd8iklr.fsf_-_@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
	<m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
	<m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r72kiksz.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FicxH-0004gD-Dc
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWEWTyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWEWTyI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:54:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56451 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751194AbWEWTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:54:07 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJrKpt020792;
	Tue, 23 May 2006 13:53:20 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJrKRl020791;
	Tue, 23 May 2006 13:53:20 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m1r72kiksz.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 23 May 2006 13:49:00 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20628>


Only count lines of the form '^.*: ' and '^From ' as email
header lines. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 mailinfo.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

b955444f0bfb4ee9a5cd31686dd7eeec0750e235
diff --git a/mailinfo.c b/mailinfo.c
index 99989c2..c642ff4 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -385,20 +385,29 @@ static int read_one_header_line(char *li
 {
 	int ofs = 0;
 	while (ofs < sz) {
+		const char *colon;
 		int peek, len;
 		if (fgets(line + ofs, sz - ofs, in) == NULL)
-			return ofs;
+			break;
 		len = eatspace(line + ofs);
 		if (len == 0)
-			return ofs;
-		peek = fgetc(in); ungetc(peek, in);
-		if (peek == ' ' || peek == '\t') {
-			/* Yuck, 2822 header "folding" */
-			ofs += len;
-			continue;
+			break;
+		colon = strchr(line, ':');
+		if (!colon || !isspace(colon[1])) {
+			/* Readd the newline */
+			line[ofs + len] = '\n';
+			line[ofs + len + 1] = '\0';
+			break;
 		}
-		return ofs + len;
+		ofs += len;
+		/* Yuck, 2822 header "folding" */
+		peek = fgetc(in); ungetc(peek, in);
+		if (peek != ' ' && peek != '\t')
+			break;
 	}
+	/* Count mbox From headers as headers */
+	if (!ofs && !memcmp(line, "From ", 5))
+		ofs = 1;
 	return ofs;
 }
 
-- 
1.3.2.g5041c-dirty
