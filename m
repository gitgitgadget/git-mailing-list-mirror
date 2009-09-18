From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] git-push: add option --repo-all
Date: Fri, 18 Sep 2009 14:44:03 +0400
Message-ID: <1253270643-20262-1-git-send-email-catap@catap.ru>
References: <m3r5u43a8h.fsf@localhost.localdomain>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 18 12:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Moaxb-0003u4-Oi
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 12:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbZIRKoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 06:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbZIRKoi
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 06:44:38 -0400
Received: from mx.catap.ru ([85.25.165.176]:55670 "EHLO mx.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbZIRKoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 06:44:37 -0400
Received: from ip43.125.dars-ip.ru ([79.132.125.43] helo=satellite.home.catap.ru)
	by mx.catap.ru with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1Moax7-0005cH-Fq; Fri, 18 Sep 2009 14:44:33 +0400
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1Moawd-0005HU-DY; Fri, 18 Sep 2009 14:44:03 +0400
X-Mailer: git-send-email 1.6.2
In-Reply-To: <m3r5u43a8h.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128793>

Example of usage: I write some software on my laptop and some time
pushing to my home/private server for backup. Some time ago my
software is done and I openin it on github, but I'm don't like kill my
private repos. Now update a two remotes repo is'n sexy, because I'm
need using a some shell wrapper:

    git remote show | while read repo; do git push $repo; done

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 Documentation/git-push.txt |    3 ++
 builtin-push.c             |   34 +++++++++++++++++++++-----------
 t/t5523-push-repo-all.sh   |   46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 12 deletions(-)
 create mode 100755 t/t5523-push-repo-all.sh

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ba6a8a2..92e45c2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -134,6 +134,9 @@ useful if you write an alias or script around 'git-push'.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
+--repo-all::
+	Send changes to all remote repos.
+
 -v::
 --verbose::
 	Run verbosely.
diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..2b25293 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository> | --repo-all] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -88,19 +88,13 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(struct remote *remote, void *priv)
 {
+	int flags = *((int *)priv);
 	int i, errs;
-	struct remote *remote = remote_get(repo);
 	const char **url;
 	int url_nr;
 
-	if (!remote) {
-		if (repo)
-			die("bad repository '%s'", repo);
-		die("No destination configured to push to.");
-	}
-
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
@@ -171,13 +165,16 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
 	int tags = 0;
+	int repo_all = 0;
 	int rc;
+	struct remote *remote;
 	const char *repo = NULL;	/* default repository */
 
 	struct option options[] = {
 		OPT_BIT('q', "quiet", &flags, "be quiet", TRANSPORT_PUSH_QUIET),
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
+		OPT_BOOLEAN( 0 , "repo-all", &repo_all, "push to all remote repos"),
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
@@ -197,11 +194,24 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		add_refspec("refs/tags/*");
 
 	if (argc > 0) {
-		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1);
+		if (repo_all) {
+			set_refspecs(argv, argc);
+		} else {
+			repo = argv[0];
+			set_refspecs(argv + 1, argc - 1);
+		}
 	}
 
-	rc = do_push(repo, flags);
+	remote = remote_get(repo);
+	if (!remote && !repo_all) {
+		if (repo)
+			die("bad repository '%s'", repo);
+		die("No destination configured to push to.");
+	}
+
+	rc = repo_all ?
+		for_each_remote(do_push, &flags) : do_push(remote, &flags);
+
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/t/t5523-push-repo-all.sh b/t/t5523-push-repo-all.sh
new file mode 100755
index 0000000..865b8a1
--- /dev/null
+++ b/t/t5523-push-repo-all.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='pushing to all remote repos repository'
+
+. ./test-lib.sh
+
+mk_repos () {
+	rm -rf maste mirror-1 mirror-2 &&
+	mkdir mirror-1 &&
+	(
+		cd mirror-1 &&
+		git init
+	) &&
+	mkdir mirror-2 &&
+	(
+		cd mirror-2 &&
+		git init
+	) &&
+	mkdir master &&
+	(
+		cd master &&
+		git init &&
+		git remote add mirror-1 ../mirror-1
+		git remote add mirror-2 ../mirror-2
+	)
+}
+
+
+test_expect_success 'push to mirrors' '
+
+	mk_repos &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git remote show &&
+		git push --all --repo-all -f
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_1_master=$(cd mirror-1 && git show-ref -s --verify refs/heads/master) &&
+	mirror_2_master=$(cd mirror-2 && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_1_master" &&
+	test "$master_master" = "$mirror_2_master"
+
+'
+
+test_done
-- 
1.6.2
