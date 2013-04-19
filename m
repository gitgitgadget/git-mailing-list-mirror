From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Teach git to change to a given directory using -C option
Date: Fri, 19 Apr 2013 20:21:48 +0800
Message-ID: <1366374108-23725-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 14:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTAKF-0005Ia-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 14:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968341Ab3DSMVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 08:21:55 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:51368 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968238Ab3DSMVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 08:21:54 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so1948087dad.4
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OOeOaMbLzhrlLKPSyqYgK9aSwBxafH/eYjo9zL8m+zo=;
        b=BEKW+gOJrP2NXGprZOXyaXnyBz6k0b+dG7Yv1FALfN0bF0tr+m6SHMmJxJUri8NPOB
         att38NqIV/uMsK9J4evN7VSVviQGTksvojao/5xh6Y80W9SN8/yNAxesFMvxIpQynoWI
         Mtit6AEB906QclopdWxGARRWvF1LtSTDAOnrpdvqWpXo+pXhRbOCaMB3pUKIBsli0hJN
         GqPmTLAffkU4fR8yQQAynzK/gueLHBGYuMqssSbH2zMYwd7Gc4IQ/rCZ05VaupoH1uZm
         fMygQ97pqtLLYVcu95F4bmX9Qdekkl5aVpjxjiunXtT8PLBF2CXjv+KzBKdrZAo72Uv6
         bVzQ==
X-Received: by 10.66.251.231 with SMTP id zn7mr3239017pac.71.1366374114199;
        Fri, 19 Apr 2013 05:21:54 -0700 (PDT)
Received: from bigbear.localdomain ([60.51.114.108])
        by mx.google.com with ESMTPS id uy3sm13311147pbc.7.2013.04.19.05.21.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 05:21:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.339.g52a3e01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221761>

This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
Often I find myself needing to find out quickly the status of a repository that
is not in my currenct working directory, like this:

         $ (cd ~/foo; git log -1)

With this patch now i can simply do:

         $ git -C ~/.zsh log -1 

That's just one example. I think those who are familiar with the -C arguments
to "make" and "tar" commands would get the "handiness" of having this option in
git.

 Documentation/git.txt |  3 +++
 git.c                 | 11 ++++++++++-
 t/t0050-filesystem.sh |  9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a875f2..20bba86 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -379,6 +379,9 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-C <directory>::
+	Change to given directory before doing anything else.
+
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index 1ada169..6426a2e 100644
--- a/git.c
+++ b/git.c
@@ -53,7 +53,16 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		/*
 		 * Check remaining flags.
 		 */
-		if (!prefixcmp(cmd, "--exec-path")) {
+		if (!prefixcmp(cmd, "-C")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1]))
+				die_errno("Cannot change to '%s'", (*argv)[1]);
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
 				git_set_argv_exec_path(cmd + 1);
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 05d78d2..ef1cb75 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -88,6 +88,15 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
 	test "z$(git cat-file blob :$camel)" = z1
 '
 
+test_expect_success 'git -C <dir> changes directory to <dir>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	git -C dir1 add a.txt &&
+	git -C dir1 commit -m "initial in dir1" &&
+	t1=$(git -C dir1 log --format=%s) &&
+	test "$t1" = "initial in dir1"
+'
+
 test_expect_success "setup unicode normalization tests" '
 	test_create_repo unicode &&
 	cd unicode &&
-- 
1.8.2.1.339.g52a3e01
