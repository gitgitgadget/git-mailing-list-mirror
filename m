From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 6/6] Allow in body headers beyond the in body header prefix.
Date: Tue, 23 May 2006 13:58:36 -0600
Message-ID: <m1irnwikcz.fsf_-_@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
	<m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
	<m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r72kiksz.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzd8iklr.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:59:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fid2O-0005pL-B2
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWEWT7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEWT7Z
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:59:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60035 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751208AbWEWT7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:59:25 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJwaSe020822;
	Tue, 23 May 2006 13:58:36 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJwahk020821;
	Tue, 23 May 2006 13:58:36 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m1mzd8iklr.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 23 May 2006 13:53:20 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20629>


- handle_from is fixed to not mangle it's input line.

- Then handle_inbody_header is allowed to look in
  the body of a commit message for additional headers
  that we haven't already seen.

This allows patches with all of the right information in
unfortunate places to be imported.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 mailinfo.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

eca59d2fd60af47170cdbfdebf3384465f0e7635
diff --git a/mailinfo.c b/mailinfo.c
index c642ff4..99374b3 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -72,11 +72,14 @@ static int bogus_from(char *line)
 	return 1;
 }
 
-static int handle_from(char *line)
+static int handle_from(char *in_line)
 {
-	char *at = strchr(line, '@');
+	char line[1000];
+	char *at;
 	char *dst;
 
+	strcpy(line, in_line);
+	at = strchr(line, '@');
 	if (!at)
 		return bogus_from(line);
 
@@ -242,8 +245,6 @@ #define SEEN_PREFIX  0x08
 /* First lines of body can have From:, Date:, and Subject: */
 static void handle_inbody_header(int *seen, char *line)
 {
-	if (*seen & SEEN_PREFIX)
-		return;
 	if (!memcmp("From:", line, 5) && isspace(line[5])) {
 		if (!(*seen & SEEN_FROM) && handle_from(line+6)) {
 			*seen |= SEEN_FROM;
-- 
1.3.2.g5041c-dirty
