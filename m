From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote-testsvn: use internal argv_array of struct child_process
 in cmd_import()
Date: Fri, 18 Jul 2014 17:20:19 +0200
Message-ID: <53C93B33.5070006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 17:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X89xd-0003x6-LO
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 17:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbaGRPUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 11:20:33 -0400
Received: from mout.web.de ([212.227.15.14]:57057 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009AbaGRPUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 11:20:33 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Mbhiv-1WrSSA1oV3-00J6S0; Fri, 18 Jul 2014 17:20:31
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:yWqqB3QhkgFDTcjqCi303EJ/ZGXknoVh81e7Bxnw2ksOnkxdk13
 Kl4H76TepvonY3TebZxZl3f0qDxJkxbU0sNBwLNZiu/jQ8SWkEwl5wZLaH4RAvG/Lp6q3lO
 v6DHtPY/LuV3E0+56mympDkBKjuwlw3GEiDz/96YdeS9uY6rvGP7JwoWfimFyVMjQVddypH
 dqLyMLOj9gkhd7CE4QkWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253823>

Use the existing argv_array member instead of providing our own.  This
way we don't have to initialize or clean it up explicitly.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 remote-testsvn.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 6be55cb..31415bd 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -175,7 +175,6 @@ static int cmd_import(const char *line)
 	char *note_msg;
 	unsigned char head_sha1[20];
 	unsigned int startrev;
-	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
 	struct child_process svndump_proc;
 
 	if (read_ref(private_ref, head_sha1))
@@ -202,11 +201,10 @@ static int cmd_import(const char *line)
 	} else {
 		memset(&svndump_proc, 0, sizeof(struct child_process));
 		svndump_proc.out = -1;
-		argv_array_push(&svndump_argv, "svnrdump");
-		argv_array_push(&svndump_argv, "dump");
-		argv_array_push(&svndump_argv, url);
-		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
-		svndump_proc.argv = svndump_argv.argv;
+		argv_array_push(&svndump_proc.args, "svnrdump");
+		argv_array_push(&svndump_proc.args, "dump");
+		argv_array_push(&svndump_proc.args, url);
+		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
 
 		code = start_command(&svndump_proc);
 		if (code)
@@ -227,7 +225,6 @@ static int cmd_import(const char *line)
 		code = finish_command(&svndump_proc);
 		if (code)
 			warning("%s, returned %d", svndump_proc.argv[0], code);
-		argv_array_clear(&svndump_argv);
 	}
 
 	return 0;
-- 
2.0.0
