From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 2/6] Move B and Q decoding into check header.
Date: Tue, 23 May 2006 13:45:37 -0600
Message-ID: <m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:46:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ficpo-0002v6-JN
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWEWTqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEWTqZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:46:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48515 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751168AbWEWTqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:46:25 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJjb2l020696;
	Tue, 23 May 2006 13:45:37 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJjbSb020695;
	Tue, 23 May 2006 13:45:37 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m14pzgjzlg.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Tue, 23 May 2006 13:44:11 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20625>


B and Q decoding is not appropriate for in body headers, so move
it up to where we explicitly know we have a real email header.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 mailinfo.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

3cccc5a0728a981cc6f4ea72e81513fd902e29a2
diff --git a/mailinfo.c b/mailinfo.c
index 83a2986..bee7b20 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -324,6 +324,7 @@ static void cleanup_space(char *buf)
 	}
 }
 
+static void decode_header_bq(char *it);
 typedef int (*header_fn_t)(char *);
 struct header_def {
 	const char *name;
@@ -343,6 +344,10 @@ static void check_header(char *line, str
 		int len = header[i].namelen;
 		if (!strncasecmp(line, header[i].name, len) &&
 		    line[len] == ':' && isspace(line[len + 1])) {
+			/* Unwrap inline B and Q encoding, and optionally
+			 * normalize the meta information to utf8.
+			 */
+			decode_header_bq(line + len + 2);
 			header[i].func(line + len + 2);
 			break;
 		}
@@ -597,13 +602,6 @@ static void handle_info(void)
 	cleanup_space(email);
 	cleanup_space(sub);
 
-	/* Unwrap inline B and Q encoding, and optionally
-	 * normalize the meta information to utf8.
-	 */
-	decode_header_bq(name);
-	decode_header_bq(date);
-	decode_header_bq(email);
-	decode_header_bq(sub);
 	printf("Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n",
 	       name, email, sub, date);
 }
-- 
1.3.2.g5041c-dirty
