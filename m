From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] provide global temporary directory
Date: Sat,  9 Oct 2010 22:20:20 +0200
Message-ID: <c6914b6c0299420aa4fecc5c7a511e64e0cb8844.1286620937.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4fuV-0003p5-4P
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760492Ab0JIUUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:20:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41063 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab0JIUUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:20:42 -0400
Received: by ewy20 with SMTP id 20so122454ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7Yx3LwYvAOtO6StxVNQrz4prVsLRQ9MydqgWy4hakbA=;
        b=KseEqtQUDTV1QjpoAdJnVKxwowDBcZr+DK2u6skLblAvcj/h9mwE18sFWXAtsC23X2
         M36H8asF3BoTijqc80ONfLAmQlths9AahZzTK5i1c+7G18/5SB6eVO/teDZj+LGi5Acc
         eVCoEiVN744blhNOgY526VNUOmNOrU31p5vn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iBEYrohN52fyUHMsMwG7E4qpYBdTynPZB0FNawPFaePWdR8pcvyFDRi4z0V5HebTGX
         WzfujQsA3Qm/tdH5pCdG7HhpRND+0GvAuxI4iUk8WP+Qqfuey/hgMTPmziLYNdNPdYW1
         0uv/N3ovUVXyZYMak03L8takLVFKGBCiB2VnM=
Received: by 10.14.37.10 with SMTP id x10mr763205eea.30.1286655638297;
        Sat, 09 Oct 2010 13:20:38 -0700 (PDT)
Received: from localhost ([92.117.193.93])
        by mx.google.com with ESMTPS id p53sm359605eeh.19.2010.10.09.13.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:20:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158604>

The standard procedure 'tmp=mktemp; trap "rm $tmp" 0' was broken with the
introduction of the pager. Which overwrites the trap itself to close and
remove the pager fifo.

Now tg provides a temp playground and all other temp files should be created
inside this directory and only this directory will be removed with the exit
trap. setup_pager still overwrites the trap, but keeps the rm command from
the global temp directory. To simplify this the new function get_temp() is
provided.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-export.sh  |    3 +--
 tg-info.sh    |    3 +--
 tg-mail.sh    |    4 +---
 tg-patch.sh   |    3 +--
 tg-push.sh    |    3 +--
 tg-summary.sh |    3 +--
 tg-update.sh  |    3 +--
 tg.sh         |   27 +++++++++++++++++++--------
 8 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 6d82d55..921e933 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -57,8 +57,7 @@ if [ -z "$branches" ]; then
 fi
 
 
-playground="$(mktemp -d -t tg-export.XXXXXX)"
-trap 'rm -rf "$playground"' EXIT
+playground="$(get_temp tg-export -d)"
 
 
 ## Collapse driver
diff --git a/tg-info.sh b/tg-info.sh
index 7d6a34c..10e257e 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -51,7 +51,7 @@ fi
 git cat-file blob "$name:.topdeps" |
 	sed '1{ s/^/Depends: /; n; }; s/^/         /;'
 
-depcheck="$(mktemp -t tg-depcheck.XXXXXX)"
+depcheck="$(get_temp tg-depcheck)"
 missing_deps=
 needs_update "$name" >"$depcheck" || :
 if [ -n "$missing_deps" ]; then
@@ -72,6 +72,5 @@ if [ -s "$depcheck" ]; then
 else
 	echo "Up-to-date."
 fi
-rm "$depcheck"
 
 # vim:noet
diff --git a/tg-mail.sh b/tg-mail.sh
index 8167ade..dd4a95a 100644
--- a/tg-mail.sh
+++ b/tg-mail.sh
@@ -34,7 +34,7 @@ if [ -n "$in_reply_to" ]; then
 fi
 
 
-patchfile="$(mktemp -t tg-mail.XXXXXX)"
+patchfile="$(get_temp tg-mail)"
 
 $tg patch "$name" >"$patchfile"
 
@@ -54,6 +54,4 @@ people=
 # NOTE: git-send-email handles cc itself
 eval git send-email $send_email_args "$people" "$patchfile"
 
-rm "$patchfile"
-
 # vim:noet
diff --git a/tg-patch.sh b/tg-patch.sh
index 7bafdfe..68efcf0 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -51,7 +51,7 @@ echo
 [ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
 
 # Evil obnoxious hack to work around the lack of git diff --exclude
-git_is_stupid="$(mktemp -t tg-patch-changes.XXXXXX)"
+git_is_stupid="$(get_temp tg-patch-changes)"
 git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"$name"} -- |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
@@ -61,7 +61,6 @@ if [ -s "$git_is_stupid" ]; then
 else
 	echo "No changes."
 fi
-rm "$git_is_stupid"
 
 echo '-- '
 echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topdeps" | paste -s -d' '))"
diff --git a/tg-push.sh b/tg-push.sh
index 199d738..a928fba 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -45,8 +45,7 @@ for name in $branches; do
 	ref_exists "$name" || die "detached HEAD? Can't push $name"
 done
 
-_listfile="$(mktemp -t tg-push-listfile.XXXXXX)"
-trap "rm -f \"$_listfile\"" 0
+_listfile="$(get_temp tg-push-listfile)"
 
 push_branch()
 {
diff --git a/tg-summary.sh b/tg-summary.sh
index af16888..612bd27 100644
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -55,10 +55,9 @@ EOT
 fi
 
 if [ -n "$sort" ]; then
-	tsort_input=`mktemp`
+	tsort_input="$(get_temp tg-summary-sort)"
 	exec 4>$tsort_input
 	exec 5<$tsort_input
-	rm $tsort_input
 fi
 
 ## List branches
diff --git a/tg-update.sh b/tg-update.sh
index b256c7c..5162c52 100644
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -27,7 +27,7 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 
 ## First, take care of our base
 
-depcheck="$(mktemp -t tg-depcheck.XXXXXX)"
+depcheck="$(get_temp tg-depcheck)"
 missing_deps=
 needs_update "$name" >"$depcheck" || :
 [ -z "$missing_deps" ] || die "some dependencies are missing: $missing_deps"
@@ -96,7 +96,6 @@ if [ -s "$depcheck" ]; then
 else
 	info "The base is up-to-date."
 fi
-rm "$depcheck"
 
 # Home, sweet home...
 # (We want to always switch back, in case we were on the base from failed
diff --git a/tg.sh b/tg.sh
index 3718702..abcfe1f 100644
--- a/tg.sh
+++ b/tg.sh
@@ -152,7 +152,7 @@ recurse_deps()
 	_name="$1"; # no shift
 	_depchain="$*"
 
-	_depsfile="$(mktemp -t tg-depsfile.XXXXXX)"
+	_depsfile="$(get_temp tg-depsfile)"
 	# If no_remotes is unset check also our base against remote base.
 	# Checking our head against remote head has to be done in the helper.
 	if test -z "$no_remotes" && has_remote "top-bases/$_name"; then
@@ -185,7 +185,6 @@ recurse_deps()
 		eval "$_cmd"
 	done <"$_depsfile"
 	missing_deps="${missing_deps# }"
-	rm "$_depsfile"
 	return $_ret
 }
 
@@ -336,19 +335,28 @@ setup_pager()
 	# now spawn pager
 	export LESS="${LESS:-FRSX}"	# as in pager.c:pager_preexec()
 
-	_pager_fifo_dir="$(mktemp -t -d tg-pager-fifo.XXXXXX)"
-	_pager_fifo="$_pager_fifo_dir/0"
-	mkfifo -m 600 "$_pager_fifo"
+	# setup_pager should be called only once per command
+	pager_fifo="$tg_tmp_dir/pager"
+	mkfifo -m 600 "$pager_fifo"
 
-	"$TG_PAGER" < "$_pager_fifo" &
-	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
+	"$TG_PAGER" < "$pager_fifo" &
+	exec > "$pager_fifo"		# dup2(pager_fifo.in, 1)
 
 	# this is needed so e.g. `git diff` will still colorize it's output if
 	# requested in ~/.gitconfig with color.diff=auto
 	export GIT_PAGER_IN_USE=1
 
 	# atexit(close(1); wait pager)
-	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wait" EXIT
+	# deliberately overwrites the global EXIT trap
+	trap "exec >&-; rm -rf \"$tg_tmp_dir\"; wait" EXIT
+}
+
+# get_temp NAME [-d]
+# creates a new temporary file (or directory with -d) in the global
+# temporary directory $tg_tmp_dir with pattern prefix NAME
+get_temp()
+{
+	mktemp ${2-} "$tg_tmp_dir/$1.XXXXXX"
 }
 
 ## Startup
@@ -368,6 +376,9 @@ tg="tg"
 # make sure merging the .top* files will always behave sanely
 setup_ours
 setup_hook "pre-commit"
+# create global temporary directories, inside GIT_DIR
+tg_tmp_dir="$(mktemp -d "$git_dir/tg-tmp.XXXXXX")"
+trap "rm -rf \"$tg_tmp_dir\"" EXIT
 
 ## Dispatch
 
-- 
1.7.1.1067.g5aeb7
