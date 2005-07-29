From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/2] git-merge-cache -q doesn't complain about failing merge program
Date: Fri, 29 Jul 2005 14:53:38 +0200
Message-ID: <20050729125338.GB21909@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 14:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyUN3-0005dy-BZ
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 14:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVG2Mxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 08:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVG2Mxp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 08:53:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51983 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262591AbVG2Mxo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 08:53:44 -0400
Received: (qmail 26102 invoked by uid 2001); 29 Jul 2005 12:53:38 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-merge-cache reporting failed merge program is undesirable for
Cogito, since it emits its own more appropriate error message in that
case. However, I want to show other possible git-merge-cache error
messages. So -q will just silence this particular error.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---

There's more of patches to come. All those which are overflowing this
series are in the git-pb branch as well and you'd get them by pulling
it.

commit 8ddefe85adc8e035864be615c87844ef982f4bc6
tree d5e6c49f93d2e4138ad63faa7fcfb893f4843c88
parent 527a155a0400df1af2e1da64fc02f2dd003413a8
author Petr Baudis <pasky@suse.cz> Fri, 29 Jul 2005 14:52:53 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 29 Jul 2005 14:52:53 +0200

 Documentation/git-merge-cache.txt |    9 +++++++--
 merge-cache.c                     |   23 +++++++++++++++--------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge-cache.txt b/Documentation/git-merge-cache.txt
--- a/Documentation/git-merge-cache.txt
+++ b/Documentation/git-merge-cache.txt
@@ -9,7 +9,7 @@ git-merge-cache - Runs a merge for files
 
 SYNOPSIS
 --------
-'git-merge-cache' [-o] <merge-program> (-a | -- | <file>\*) 
+'git-merge-cache' [-o] [-q] <merge-program> (-a | -- | <file>\*) 
 
 DESCRIPTION
 -----------
@@ -32,6 +32,11 @@ OPTIONS
 	returned errors, and only return the error code after all the
 	merges are over.
 
+-q::
+	Do not complain about failed merge program (the merge program
+	failure usually indicates conflicts during merge). This is for
+	porcelains which might want to emit custom messages.
+
 If "git-merge-cache" is called with multiple <file>s (or -a) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
@@ -40,7 +45,7 @@ Typically this is run with the a script 
 the RCS package.
 
 A sample script called "git-merge-one-file-script" is included in the
-ditribution.
+distribution.
 
 ALERT ALERT ALERT! The git "merge object order" is different from the
 RCS "merge" program merge object order. In the above ordering, the
diff --git a/merge-cache.c b/merge-cache.c
--- a/merge-cache.c
+++ b/merge-cache.c
@@ -5,7 +5,7 @@
 
 static const char *pgm = NULL;
 static const char *arguments[8];
-static int one_shot;
+static int one_shot, quiet;
 static int err;
 
 static void run_program(void)
@@ -27,10 +27,13 @@ static void run_program(void)
 		die("unable to execute '%s'", pgm);
 	}
 	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status) || WEXITSTATUS(status)) {
-		if (one_shot)
+		if (one_shot) {
 			err++;
-		else
-			die("merge program failed");
+		} else {
+			if (quiet)
+				die("merge program failed");
+			exit(1);
+		}
 	}
 }
 
@@ -97,15 +100,19 @@ int main(int argc, char **argv)
 	int i, force_file = 0;
 
 	if (argc < 3)
-		usage("git-merge-cache [-o] <merge-program> (-a | <filename>*)");
+		usage("git-merge-cache [-o] [-q] <merge-program> (-a | <filename>*)");
 
 	read_cache();
 
 	i = 1;
-	if (!strcmp(argv[1], "-o")) {
+	if (!strcmp(argv[i], "-o")) {
 		one_shot = 1;
 		i++;
 	}
+	if (!strcmp(argv[i], "-q")) {
+		quiet = 1;
+		i++;
+	}
 	pgm = argv[i++];
 	for (; i < argc; i++) {
 		char *arg = argv[i];
@@ -122,7 +129,7 @@ int main(int argc, char **argv)
 		}
 		merge_file(arg);
 	}
-	if (err)
+	if (err && quiet)
 		die("merge program failed");
-	return 0;
+	return err;
 }
