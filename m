From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/7] Add a --push option to "git-remote add"
Date: Mon, 28 Apr 2008 11:32:14 -0400
Message-ID: <65b938da49b447129297d4dbf20191be52d16670.1209391614.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:35:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMi-0004Kp-R9
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935679AbYD1Pcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935627AbYD1Pcm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:42 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60623 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935635AbYD1Pcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:35 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004f9-HF; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80544>

This patch adds a --push option to "git-remote add" which sets up a
push refspec.  This will be useful after the following patch to
"git-push", which will make heavier use of push refspecs.  Even now,
however, the option combination "--mirror --push" can be used to set
up a mirror *of this repository*, with a normal fetch refspec
(refs/heads/*:refs/remotes/mirror/*) but with the remote.<nick>.mirror
option set.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-remote.txt |   25 +++++++++++++++++++------
 builtin-remote.c             |   32 ++++++++++++++++++++++++--------
 t/t5505-remote.sh            |   26 +++++++++++++++++++++++++-
 t/t5517-push-mirror.sh       |    2 +-
 4 files changed, 69 insertions(+), 16 deletions(-)

	My earlier preference for "--mirror" as an option for
	mirrored-from-here remotes is due to my earlier experience
	with arch (from which I migrated to git).  However, I'm very
	fine with "--mirror --push" since it's consistent with the
	meaning of the new option --push.

	This patch does not depend on patch 4, on the contrary the
	dependency is the other way round.  However, it does not make
	much sense as an independent change.  That's why the documentation
	for --push leaves something to be desired.  It will be fixed in
	patch 4, as the doc will refer to the behavior implemented there.

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index b20e851..e779905 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-remote'
-'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] [--push] <name> <url>
 'git-remote' rm <name>
 'git-remote' show <name>
 'git-remote' prune <name>
@@ -47,11 +47,24 @@ With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
 branch the `HEAD` at the remote repository actually points at.
 +
-In mirror mode, enabled with `\--mirror`, the refs will not be stored
-in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
-only makes sense in bare repositories.  If a remote uses mirror
-mode, furthermore, `git push` will always behave as if `\--mirror`
-was passed.
+`\--push` mode adds a `push` configuration line for the remote.
+It also affects the operation of mirror mode.
++
+Mirror mode, enabled with `\--mirror`, specifies that one of the
+repositories (either the current one or the remote one) is giving
+up control on its refs namespace to the other repository.  If a
+remote uses mirror mode, furthermore, `git push` will always
+behave as if `\--mirror` was passed.
+
+If `\--mirror` is given without `\--push`, this repository will
+act as a mirror of the remote, and hence the remote's refs will not
+be stored in the 'refs/remotes/' namespace, but in 'refs/heads/';
+this only makes sense in bare repositories.  If the two options
+are given in combination, instead, the other repository will
+act as a mirror of this one; in this case, the effect of mirror
+mode is that `git-push` will always add any newly created local
+refs to the remote, will force updates of locally updated refs,
+and will remove any deleted refs from the remote too.
 
 'rm'::
 
diff --git a/builtin-remote.c b/builtin-remote.c
index 8b63619..759dddb 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -56,7 +56,7 @@ static int fetch_remote(const char *name)
 
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0;
+	int fetch = 0, mirror = 0, push = 0;
 	struct path_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
@@ -71,6 +71,7 @@ static int add(int argc, const char **argv)
 			"branch(es) to track", opt_parse_track),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
 		OPT_BOOLEAN(0, "mirror", &mirror, "no separate remotes"),
+		OPT_BOOLEAN(0, "push", &push, "make \"git push\" work on this remote"),
 		OPT_END()
 	};
 
@@ -101,23 +102,38 @@ static int add(int argc, const char **argv)
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", name);
 
-	if (track.nr == 0)
-		path_list_append("*", &track);
-	for (i = 0; i < track.nr; i++) {
-		struct path_list_item *item = track.items + i;
+	for (i = 0; i < (track.nr ? track.nr : 1); i++) {
+		const char *path = track.nr ? track.items[i].path : "*";
 
 		strbuf_reset(&buf2);
 		strbuf_addch(&buf2, '+');
-		if (mirror)
+		if (mirror && !push)
 			strbuf_addf(&buf2, "refs/%s:refs/%s",
-					item->path, item->path);
+					path, path);
 		else
 			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
-					item->path, name, item->path);
+					path, name, path);
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return 1;
 	}
 
+	if (push) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.push", name);
+
+		for (i = 0; i < (track.nr ? track.nr : 1); i++) {
+			strbuf_reset(&buf2);
+			if (track.nr) {
+				const char *path = track.items[i].path;
+				strbuf_addf(&buf2, "refs/heads/%s:refs/heads/%s",
+						path, path);
+			} else
+				strbuf_addstr(&buf2, ":");
+			if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+				return 1;
+		}
+	}
+
 	if (mirror) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 48ff2d4..56e5e06 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -28,7 +28,7 @@ tokens_match () {
 }
 
 check_remote_track () {
-	actual=$(git remote show "$1" | sed -n -e '$p') &&
+	actual=$(git remote show "$1" | sed -n -e '/Tracked/!d;n;p') &&
 	shift &&
 	tokens_match "$*" "$actual"
 }
@@ -269,4 +269,28 @@ test_expect_success 'reject adding remote with an invalid name' '
 
 '
 
+test_expect_success 'fetching from push mirror leaves refs/head intact' '
+
+	(cd four && git init
+	 >file34 &&
+	 git add file34 &&
+	 test_tick &&
+	 git commit -m "Initial alternative")
+	cd one && 
+	git remote add --mirror --push four ../four &&
+	git fetch four &&
+	git rev-parse -s --verify refs/remotes/four/master
+	! test -f file34
+'
+
+test_expect_success 'fetching from mirror overwrites refs/head' '
+
+	cd four &&
+	test -f file34 &&
+	git remote add --mirror one ../one &&
+	git fetch one &&
+	! git rev-parse -s --verify refs/remotes/one/master
+	! test -f file34
+'
+
 test_done
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..cacc08c 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -25,7 +25,7 @@ mk_repo_pair () {
 	(
 		cd master &&
 		git init &&
-		git remote add $1 up ../mirror
+		git remote add --push $1 up ../mirror
 	)
 }
 
-- 
1.5.5
