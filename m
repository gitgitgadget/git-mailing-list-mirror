From: Linus Torvalds <torvalds@osdl.org>
Subject: Support "git cmd --help" syntax
Date: Sat, 15 Apr 2006 11:13:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604151054380.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 15 20:14:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUpHS-0004Yl-5A
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 20:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWDOSNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 14:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWDOSNz
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 14:13:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030303AbWDOSNy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 14:13:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3FIDotH014897
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Apr 2006 11:13:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3FIDnfJ010730;
	Sat, 15 Apr 2006 11:13:49 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18755>


The "--help" argument is special, in that it is (along with "--version") 
in that is taken by the "git" program itself rather than the sub-command, 
and thus we've had the syntax "git --help cmd".

However, as anybody who has ever used CVS or some similar devil-spawn 
program, it's confusing as h*ll when options before the sub-command act 
differently from options after the sub-command, so this quick hack just 
makes it acceptable to do "git cmd --help" instead, and get the exact same 
result.

It may be hacky, but it's simple and does the trick.

Of course, this does not help if you use one of the non-builtin commands 
without using the "git" helper. Ie you won't be getting a man-page just 
because you do "git-rev-list --help". Don't expect us to be quite _that_ 
helpful.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git.c b/git.c
index 78ed403..13c6d51 100644
--- a/git.c
+++ b/git.c
@@ -411,6 +411,12 @@ static void handle_internal_command(int 
 	};
 	int i;
 
+	/* Turn "git cmd --help" into "git help cmd" */
+	if (argc > 1 && !strcmp(argv[1], "--help")) {
+		argv[1] = argv[0];
+		argv[0] = cmd = "help";
+	}
+
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
