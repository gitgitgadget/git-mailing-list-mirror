From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2] remote-testsvn: use internal argv_array of struct child_process
 in cmd_import()
Date: Fri, 18 Jul 2014 21:55:16 +0200
Message-ID: <53C97BA4.7020503@web.de>
References: <53C93B33.5070006@web.de> <xmqq8unqmqk7.fsf@gitster.dls.corp.google.com> <53C975C5.8020709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8EFm-0005iu-23
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbaGRTze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 15:55:34 -0400
Received: from mout.web.de ([212.227.15.3]:54471 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035AbaGRTzd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 15:55:33 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MHpKH-1X6qg03ykH-003b7Y; Fri, 18 Jul 2014 21:55:30
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C975C5.8020709@web.de>
X-Provags-ID: V03:K0:M78Kfji19f+5gLWgbYe514G/yBZIHbwr7szc9Cx2w59gkkpMHUS
 FX5f1nv1uawEj40Hyr1iwBnOmRPqMU3RvWoZEuTRqvoQO3KCr6WwHWWmdsC4k1M9h/FDXhj
 oQRyiEGyXc52NfHirCfZb8eMkIhyo6LpplM+EXFrrbqIdUClLcu3nlgGQQyAk0ILEzaSFuI
 oB0x6QMIVMJawexoPRWYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253844>

Use the existing argv_array member instead of providing our own.  This
way we don't have to initialize or clean it up explicitly.  Because of
that automatic cleanup, we need to keep our own reference to the
command name instead of using .argv[0] to print the warning at the end.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The added command pointer makes the patch more complicated, but I think
it still counts as a cleanup.

 remote-testsvn.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 6be55cb..e3ad11b 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -175,8 +175,8 @@ static int cmd_import(const char *line)
 	char *note_msg;
 	unsigned char head_sha1[20];
 	unsigned int startrev;
-	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
 	struct child_process svndump_proc;
+	const char *command;
 
 	if (read_ref(private_ref, head_sha1))
 		startrev = 0;
@@ -200,17 +200,17 @@ static int cmd_import(const char *line)
 		if(dumpin_fd < 0)
 			die_errno("Couldn't open svn dump file %s.", url);
 	} else {
+		command = "svnrdump";
 		memset(&svndump_proc, 0, sizeof(struct child_process));
 		svndump_proc.out = -1;
-		argv_array_push(&svndump_argv, "svnrdump");
-		argv_array_push(&svndump_argv, "dump");
-		argv_array_push(&svndump_argv, url);
-		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
-		svndump_proc.argv = svndump_argv.argv;
+		argv_array_push(&svndump_proc.args, command);
+		argv_array_push(&svndump_proc.args, "dump");
+		argv_array_push(&svndump_proc.args, url);
+		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
 
 		code = start_command(&svndump_proc);
 		if (code)
-			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
+			die("Unable to start %s, code %d", command, code);
 		dumpin_fd = svndump_proc.out;
 	}
 	/* setup marks file import/export */
@@ -226,8 +226,7 @@ static int cmd_import(const char *line)
 	if (!dump_from_file) {
 		code = finish_command(&svndump_proc);
 		if (code)
-			warning("%s, returned %d", svndump_proc.argv[0], code);
-		argv_array_clear(&svndump_argv);
+			warning("%s, returned %d", command, code);
 	}
 
 	return 0;
-- 
2.0.2
