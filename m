From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] git-ls-remote: show and optionally store remote refs.
Date: Sat, 23 Jul 2005 17:54:26 -0700
Message-ID: <7v7jfhkoql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:54:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUlJ-0004Oy-6U
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVGXAya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGXAya
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:54:30 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21170 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261851AbVGXAy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:54:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005425.QQNX1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:54:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Retrieve and list the remote refs from git, http, and rsync
repositories, and optionally stores the retrieved refs in the
local repository under the same name.

To access a git URL, git-peek-remote command is used.  An http
URL needs to have an up-to-date info/refs file for discovery,
which will be introduced by a later update-server-info patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile             |    3 +
 git-ls-remote-script |  104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100755 git-ls-remote-script

cb508fd7eb23a40432231977a9e7f12eb8d3e9de
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script git-parse-remote git-verify-tag-script
+	git-branch-script git-parse-remote git-verify-tag-script \
+	git-ls-remote-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-ls-remote-script b/git-ls-remote-script
new file mode 100755
--- /dev/null
+++ b/git-ls-remote-script
@@ -0,0 +1,104 @@
+#!/bin/sh
+#
+. git-sh-setup-script || die "Not a git archive"
+
+usage () {
+    echo >&2 "usage: $0 [--heads] [--tags] [--overwrite | --store] repo"
+    exit 1;
+}
+
+while case "$#" in 0) break;; esac
+do
+  case "$1" in
+  -h|--h|--he|--hea|--head|--heads)
+  heads=heads; shift ;;
+  -o|--o|--ov|--ove|--over|--overw|--overwr|--overwri|--overwrit|--overwrite)
+  overwrite=overwrite; shift ;;
+  -s|--s|--st|--sto|--stor|--store)
+  store=store; shift ;;
+  -t|--t|--ta|--tag|--tags)
+  tags=tags; shift ;;
+  --)
+  shift; break ;;
+  -*)
+  usage ;;
+  *)
+  break ;;
+  esac
+done
+
+case "$#" in 1) ;; *) usage ;; esac
+case ",$store,$overwrite," in *,,*) ;; *) usage ;; esac
+
+case ",$heads,$tags," in
+,,,) heads=heads tags=tags other=other ;;
+esac
+
+. git-parse-remote "$@"
+peek_repo="$_remote_repo"
+
+tmp=.ls-remote-$$
+trap "rm -fr $tmp-*" 0 1 2 3 15
+tmpdir=$tmp-d
+
+case "$peek_repo" in
+http://* | https://* )
+        if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+            curl_extra_args="-k"
+        fi
+	curl -ns $curl_extra_args "$peek_repo/info/refs" || exit 1
+	;;
+
+rsync://* )
+	mkdir $tmpdir
+	rsync -rq "$peek_repo/refs" $tmpdir || exit 1
+	(cd $tmpdir && find refs -type f) |
+	while read path
+	do
+		cat "$tmpdir/$path" | tr -d '\012'
+		echo "	$path"
+	done &&
+	rm -fr $tmpdir
+	;;
+
+* )
+	git-peek-remote "$peek_repo"
+	;;
+esac |
+
+while read sha1 path
+do
+	case "$path" in
+	refs/heads/*)
+		group=heads ;;
+	refs/tags/*)
+		group=tags ;;
+	*)
+		group=other ;;
+	esac
+	case ",$heads,$tags,$other," in
+	*,$group,*)
+		;;
+	*)
+		continue;;
+	esac
+
+	echo "$sha1	$path"
+
+	case "$path,$store,$overwrite," in
+	*,,, | HEAD,*) continue ;;
+	esac
+
+	if test -f "$GIT_DIR/$path" && test "$overwrite" == ""
+	then
+		continue
+	fi
+
+	# Be careful.  We may not have that object yet!
+	if git-cat-file -t "$sha1" >/dev/null 2>&1
+	then
+		echo "$sha1" >"$GIT_DIR/$path"
+	else
+		echo >&2 "* You have not fetched updated $path ($sha1)."
+	fi
+done
