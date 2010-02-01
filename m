From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: [PATCH 2/2] upload-pack: Add a pre-upload-pack hook
Date: Mon,  1 Feb 2010 14:02:07 +0530
Message-ID: <1265013127-12589-3-git-send-email-ford_prefect@gentoo.org>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
 <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
 <1265013127-12589-2-git-send-email-ford_prefect@gentoo.org>
Cc: ford_prefect@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 09:32:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbrhq-0000Nf-13
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 09:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab0BAIcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 03:32:22 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:60131 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab0BAIcW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 03:32:22 -0500
Received: from localhost.localdomain (unknown [122.171.0.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 8E9EC1B4186;
	Mon,  1 Feb 2010 08:32:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265013127-12589-2-git-send-email-ford_prefect@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138595>

This hook is run after want/have are communicated and before the actual
upload operation is begun. It is passed the set of want and have, as
well as the type of operation (fetch/clone). The intended use for this
hook is to reject large uploads (such as very large initial clones).
---
 Documentation/git-upload-pack.txt       |    5 +-
 Documentation/githooks.txt              |   37 ++++++++++--
 t/Makefile                              |    1 +
 t/t5507-pre-upload-pack.sh              |   93 +++++++++++++++++++++++++++++++
 templates/hooks--pre-upload-pack.sample |   11 ++++
 upload-pack.c                           |   20 +++++--
 6 files changed, 153 insertions(+), 14 deletions(-)
 create mode 100644 t/t5507-pre-upload-pack.sh
 create mode 100644 templates/hooks--pre-upload-pack.sample

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 63f3b5c..5c9474d 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -20,8 +20,11 @@ The UI for the protocol is on the 'git-fetch-pack' side, and the
 program pair is meant to be used to pull updates from a remote
 repository.  For push operations, see 'git-send-pack'.
 
+Before starting the upload operation, `pre-upload-pack`hook may be
+called (see linkgit:githooks[5]).
+
 After finishing the operation successfully, `post-upload-pack`
-hook is called (see linkgit:githooks[5]).
+hook may be called (see linkgit:githooks[5]).
 
 OPTIONS
 -------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 47bcfd1..99f8882 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -310,16 +310,18 @@ Both standard output and standard error output are forwarded to
 'git-send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
-post-upload-pack
-----------------
+pre-upload-pack
+---------------
 
-Note that this hook is POTENTIALLY INSECURE. It is run as the user who
+Note that this hook is POTENTIALLY INSECURE on shared systems where
+the owner of the repository is not trusted. It is run as the user who
 is pulling, so an attacker can make a victim run arbitrary code by
-convincing him to clone a repository. To enable this hook, git must be
-compiled with the ALLOW_INSECURE_HOOKS option.
+convincing him to clone a repository. To enable this hook, git must
+be compiled with the ALLOW_INSECURE_HOOKS option.
 
-After upload-pack successfully finishes its operation, this hook is called
-for logging purposes.
+Before the upload-pack is started (but after want/have have been
+communicated), this hook is be called. It can be used, for example,
+to deny very large uploads.
 
 The hook is passed various pieces of information, one per line, from its
 standard input.  Currently the following items can be fed to the hook, but
@@ -334,6 +336,27 @@ have SHA-1::
     the resulting pack, claiming to have them already.  Can occur zero
     or more times in the input.
 
+kind string:
+    Either "clone" (when the client did not give us any "have", and asked
+    for all our refs with "want"), or "fetch" (otherwise).
+
+post-upload-pack
+----------------
+
+The same SECURITY CONCERNS as pre-upload-pack apply here.
+
+After upload-pack successfully finishes its operation, this hook is called
+(for example, for logging).
+
+want SHA-1::
+    40-byte hexadecimal object name the client asked to include in the
+    resulting pack.  Can occur one or more times in the input.
+
+have SHA-1::
+    40-byte hexadecimal object name the client asked to exclude from
+    the resulting pack, claiming to have them already.  Can occur zero
+    or more times in the input.
+
 time float::
     Number of seconds spent for creating the packfile.
 
diff --git a/t/Makefile b/t/Makefile
index af3c99e..a884e75 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -18,6 +18,7 @@ TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
 ifndef ALLOW_INSECURE_HOOKS
 	T := $(filter-out t5501-post-upload-pack.sh,$(T))
+	T := $(filter-out t5507-pre-upload-pack.sh,$(T))
 endif
 
 all: pre-clean
diff --git a/t/t5507-pre-upload-pack.sh b/t/t5507-pre-upload-pack.sh
new file mode 100644
index 0000000..d3a7ba7
--- /dev/null
+++ b/t/t5507-pre-upload-pack.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+
+test_description='pre upload-hook'
+
+. ./test-lib.sh
+
+LOGFILE=".git/pre-upload-pack-log"
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	git reset --hard A &&
+	test_commit C &&
+	git branch prev B &&
+	mkdir -p .git/hooks &&
+	{
+		echo "#!$SHELL_PATH" &&
+		echo "cat >pre-upload-pack-log"
+	} >".git/hooks/pre-upload-pack" &&
+	chmod +x .git/hooks/pre-upload-pack
+'
+
+test_expect_success initial '
+	rm -fr sub &&
+	git init sub &&
+	(
+		cd sub &&
+		git fetch --no-tags .. prev
+	) &&
+	want=$(sed -n "s/^want //p" "$LOGFILE") &&
+	test "$want" = "$(git rev-parse --verify B)" &&
+	! grep "^have " "$LOGFILE" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = fetch
+'
+
+test_expect_success second '
+	rm -fr sub &&
+	git init sub &&
+	(
+		cd sub &&
+		git fetch --no-tags .. prev:refs/remotes/prev &&
+		git fetch --no-tags .. master
+	) &&
+	want=$(sed -n "s/^want //p" "$LOGFILE") &&
+	test "$want" = "$(git rev-parse --verify C)" &&
+	have=$(sed -n "s/^have //p" "$LOGFILE") &&
+	test "$have" = "$(git rev-parse --verify B)" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = fetch
+'
+
+test_expect_success all '
+	rm -fr sub &&
+	HERE=$(pwd) &&
+	git init sub &&
+	(
+		cd sub &&
+		git clone "file://$HERE/.git" new
+	) &&
+	sed -n "s/^want //p" "$LOGFILE" | sort >actual &&
+	git rev-parse A B C | sort >expect &&
+	test_cmp expect actual &&
+	! grep "^have " "$LOGFILE" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = clone
+'
+
+cat > pre-upload-pack <<EOF
+#!$SHELL_PATH
+kind=\$(awk '/^kind /{print \$2; exit}' -)
+if test "\$kind" = "clone"; then
+  echo "Sorry, no cloning!"
+exit 1; fi
+EOF
+
+test_expect_success 'with failing hook' '
+	rm -fr .git
+	test_create_repo src &&
+	(
+		cd src &&
+		mkdir .git/hooks &&
+		mv ../pre-upload-pack ".git/hooks/pre-upload-pack" &&
+		chmod +x .git/hooks/pre-upload-pack &&
+		echo foo > file &&
+		git add file &&
+		git commit -m initial
+	) &&
+	test_must_fail git clone -n "file://$(pwd)/src" dst
+
+'
+
+test_done
diff --git a/templates/hooks--pre-upload-pack.sample b/templates/hooks--pre-upload-pack.sample
new file mode 100644
index 0000000..7342d23
--- /dev/null
+++ b/templates/hooks--pre-upload-pack.sample
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+# This sample shows how one may reject an upload-pack where the client is
+# trying to perform an initial clone clone
+
+kind=$(awk '/^kind /{print $2; exit}' -)
+
+if test "$kind" = "clone"; then
+  echo "Sorry, the clone operation is not allowed"
+  exit 1
+fi
diff --git a/upload-pack.c b/upload-pack.c
index c992cb4..9c33e63 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -171,14 +171,19 @@ static int feed_obj_to_hook(const char *label, struct object_array *oa, int i, i
 				sha1_to_hex(oa->objects[i].item->sha1));
 }
 
-static int run_post_upload_pack_hook(size_t total, struct timeval *tv)
+static int run_upload_pack_hook(int post, size_t total, struct timeval *tv)
 {
 	const char *argv[2];
 	struct child_process proc;
 	int err, i;
 
-	argv[0] = "hooks/post-upload-pack";
-	argv[1] = NULL;
+	if (!post) {
+		argv[0] = "hooks/pre-upload-pack";
+		argv[1] = NULL;
+	} else {
+		argv[0] = "hooks/post-upload-pack";
+		argv[1] = NULL;
+	}
 
 	if (access(argv[0], X_OK) < 0)
 		return 0;
@@ -197,10 +202,10 @@ static int run_post_upload_pack_hook(size_t total, struct timeval *tv)
 		err |= feed_obj_to_hook("want", &want_obj, i, proc.in);
 	for (i = 0; !err && i < have_obj.nr; i++)
 		err |= feed_obj_to_hook("have", &have_obj, i, proc.in);
-	if (!err)
+	if (!err && post)
 		err |= feed_msg_to_hook(proc.in, "time %ld.%06ld\n",
 					(long)tv->tv_sec, (long)tv->tv_usec);
-	if (!err)
+	if (!err && post)
 		err |= feed_msg_to_hook(proc.in, "size %ld\n", (long)total);
 	if (!err)
 		err |= feed_msg_to_hook(proc.in, "kind %s\n",
@@ -758,7 +763,10 @@ static void upload_pack(void)
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
-		create_pack_file();
+		if (run_upload_pack_hook(0, 0, NULL))
+			error("pre-upload hook aborted");
+		else
+			create_pack_file();
 	}
 }
 
-- 
1.6.6.1
