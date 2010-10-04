From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 2/4] tg-depend: reduce: apply transitive reduction to the dependecies
Date: Tue,  5 Oct 2010 00:28:18 +0200
Message-ID: <1286231300-29268-2-git-send-email-bert.wesarg@googlemail.com>
References: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tWO-0000QR-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab0JDW2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:28:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58423 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0JDW23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:28:29 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so4091341bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wn1+vQtUp7sBoDOfpAjpJjjJO5kcfZ3/vuNMsslDu8I=;
        b=hDcUy+nYctA4wVbOHMuMkjffPIGaoo5E6+Hsd7MjQskrEsd/esCkQqkpaQx2EWVpG8
         bhLmly5c+NvTK0nV5x9AGjF0NwhFiJnxeIvth4mkGkg2yl2coM+gOTWmOt821IouDxgL
         2qmHkTNAVUKyZugCuouYPaIbh74zbIYEGmrhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IUsEhMFoKz4LitRA/3nDfcSf2C+3AvjgULdq6M3CFt7MoXNM3bZ7zRmfv5pGkvMd5r
         3W/4I6aGUGEdvgcac7O5qtTLvuyUyvu9bK38DlCAnzV6R4kZmvKDaZr9mxTjZ2iR2S1O
         KHaXkzM2fIW1k4kNiY9H+Q90lPKIR1BnXy7LA=
Received: by 10.204.141.16 with SMTP id k16mr7670912bku.177.1286231307619;
        Mon, 04 Oct 2010 15:28:27 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id s34sm4251496bkk.13.2010.10.04.15.28.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:28:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158131>

This uses the tred(1) and gvpr(1) programs from the graphviz package to reduce
the dependencies of the given TopGit branch.

It provides a also a new subcommand (tg tred) to play with it.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

 .gitignore                 |    2 +
 README                     |   42 +++++++++++++++++-
 contrib/tg-completion.bash |   36 ++++++++++++++--
 tg-depend.sh               |  103 +++++++++++++++++++++++++++++--------------
 tg-tred.sh                 |   53 ++++++++++++++++++++++
 5 files changed, 196 insertions(+), 40 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3298889..290cfdc 100644 .gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -38,5 +38,7 @@
 /tg-remote.txt
 /tg-summary
 /tg-summary.txt
+/tg-tred
+/tg-tred.txt
 /tg-update
 /tg-update.txt
diff --git a/README b/README
index ce0c3a6..4f49015 100644 README
--- a/README
+++ b/README
@@ -260,8 +260,8 @@ tg delete
 tg depend
 ~~~~~~~~~
 	Change dependencies of a TopGit-controlled topic branch.
-	This should have several subcommands, but only 'add' is
-	supported right now.
+	This should have several subcommands, but only 'add' and
+	'reduce' is supported right now.
 
 	The 'add' subcommand takes an argument of a topic branch
 	to be added, adds it to '.topdeps', performs a commit and
@@ -270,6 +270,9 @@ tg depend
 	adjusting '.topmsg', prepare them in the index before
 	calling 'tg depend add'.
 
+	The 'reduce' subcommand uses 'tg tred' to reduce the dependency
+	list of the current.
+
 	TODO: Subcommand for removing dependencies, obviously
 
 tg info
@@ -528,6 +531,41 @@ tg log
 ~~~~~~
 	Prints the git log of the named topgit branch.
 
+tg tred
+~~~~~~~
+	Prints the transitive reduction of the dependecies for the current
+	or named TopGit branch.
+
+	To actually use this reduced dependency list, feed the output into
+	the .topdeps file, commit and run tg update, like:
+
+	$ tg tred > .topdeps
+	$ git add -f .topdeps
+	$ git commit -m "transitive reduced TopGit dependencies"
+	$ tg update
+
+	If you want to see the differences to the current dependencies, run
+	this:
+
+	# against HEAD
+	$ diff -u -L current -L tred <(git show HEAD:.topdeps) <(tg tred)
+
+	# against the index
+	$ diff -u -L current -L tred <(git show     :.topdeps) <(tg tred -i)
+
+	# against the working dir
+	$ diff -u -L current -L tred <(cat           .topdeps) <(tg tred -w)
+
+	To see the reduced dependency graph of all topics run this:
+
+	$ diff -u -L current -L tred \
+		<(tg summary --graphviz | nop) \
+		<(tg summary --graphviz | tred)
+
+	TODO: tg tred -a for reducing all branches
+	TODO: tg tred -r for reducing recursive all from the current/named
+	      branch
+
 TODO: tg rename
 
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index ccf1a32..026b9fd 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -267,16 +267,27 @@ _tg_delete ()
 
 _tg_depend ()
 {
-	local subcommands="add"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	local subcommands="add reduce"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__tgcomp "$subcommands"
 		return
 	fi
 
-	case "$subcommand" in
-	add)
-		__tgcomp "$(__tg_refs)"
+	case "$subcommand:$cur" in
+	add:-*)
+		__tgcomp "
+			--stage-only
+		";;
+	add:*)
+		__tgcomp "$(__tg_refs)";;
+	reduce:-*)
+		__tgcomp "
+			--stage-only
+			--staged
+		";;
 	esac
 }
 
@@ -431,6 +442,22 @@ _tg_summary ()
 	esac
 }
 
+_tg_tred ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
 _tg_update ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -491,6 +518,7 @@ _tg ()
 	push)        _tg_push ;;
 	remote)      _tg_remote ;;
 	summary)     _tg_summary ;;
+	tred)        _tg_tred ;;
 	update)      _tg_update ;;
 	*)           COMPREPLY=() ;;
 	esac
diff --git a/tg-depend.sh b/tg-depend.sh
index 474ccda..413cde2 100644 tg-depend.sh
--- a/tg-depend.sh
+++ b/tg-depend.sh
@@ -3,53 +3,51 @@
 # (c) Petr Baudis <pasky@suse.cz>  2008
 # GPLv2
 
-name=
-
-
 usage()
 {
-    echo "Usage: tg [...] depend add NAME" >&2
-    exit 1
+	echo "Usage: tg [...] depend add    [--stage-only] NAME" >&2
+	echo "   or: tg [...] depend reduce [--stage-only] [--staged]" >&2
+	exit 1
 }
 
-## Parse options
-
+## Get command
 subcmd="$1"; shift || :
 case "$subcmd" in
 	-h|"")
 		usage;;
-	add)
+	add|reduce)
 		;;
 	*)
 		die "unknown subcommand ($subcmd)";;
 esac
 
-while [ -n "$1" ]; do
-	arg="$1"; shift
-	case "$arg" in
-	-*)
-		usage;;
-	*)
-		[ -z "$name" ] || die "name already specified ($name)"
-		name="$arg";;
-	esac
-done
-
-
-## Sanity checks
-
-[ -n "$name" ] || die "no branch name specified"
-branchrev="$(git rev-parse --verify "$name" 2>/dev/null)" ||
-	die "invalid branch name: $name"
-
-# Check that we are on a TopGit branch.
-current_name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
-current_base_rev="$(git rev-parse --short --verify "refs/top-bases/$current_name" 2>/dev/null)" ||
-	die "not a TopGit-controlled branch"
-
 ## Record new dependency
 depend_add()
 {
+	local name=
+	local do_commit=true
+
+	## Parse options
+
+	while [ -n "$1" ]; do
+		arg="$1"; shift
+		case "$arg" in
+		--stage-only)
+			do_commit=false;;
+		-*)
+			usage;;
+		*)
+			[ -z "$name" ] || die "name already specified ($name)"
+			name="$arg";;
+		esac
+	done
+
+	## Sanity checks
+
+	[ -n "$name" ] || die "no branch name specified"
+	branchrev="$(git rev-parse --verify "$name" 2>/dev/null)" ||
+		die "invalid branch name: $name"
+
 	[ "$name" = "$current_name" ] &&
 		die "$name cannot depend on itself."
 
@@ -62,10 +60,47 @@ depend_add()
 
 	echo "$name" >>"$root_dir/.topdeps"
 	git add -f "$root_dir/.topdeps"
-	git commit -m"New TopGit dependency: $name"
-	$tg update
+	$do_commit && {
+		git commit -m"New TopGit dependency: $name"
+		$tg update
+	} ||
+		echo "New TopGit dependency: $name" >> "$git_dir/PREPARE_COMMIT_MSG"
+}
+
+## Reduce dependencies
+depend_reduce()
+{
+	local do_commit=true
+	local tred_mode=
+
+	## Parse options
+
+	while [ -n "$1" ]; do
+		arg="$1"; shift
+		case "$arg" in
+		--stage-only)
+			do_commit=false;;
+		--staged)
+			tred_mode=-i;;
+		*)
+			usage;;
+		esac
+	done
+
+	$tg tred $tred_mode >"$root_dir/.topdeps"
+	git add -f "$root_dir/.topdeps"
+	$do_commit && {
+		git commit -m"transitive reduced TopGit dependencies"
+		$tg update
+	} ||
+		echo "transitive reduced TopGit dependencies" >> "$git_dir/PREPARE_COMMIT_MSG"
 }
 
-depend_$subcmd
+# Check that we are on a TopGit branch.
+current_name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+current_base_rev="$(git rev-parse --short --verify "refs/top-bases/$current_name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+depend_$subcmd "$@"
 
 # vim:noet
diff --git a/tg-tred.sh b/tg-tred.sh
new file mode 100644
index 0000000..577bc26 tg-tred.sh
--- /dev/null
+++ b/tg-tred.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>              2008
+# (c) Bert Wesarg <bert.wesarg@googlemail.com> 2009
+# GPLv2
+
+name=
+topic=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i)
+		topic='(i)';;
+	-w)
+		topic='(w)';;
+	-*)
+		echo "Usage: tg [...] tred [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+type tred >/dev/null 2>&1 ||
+	die "need the tred(1) tool from the graphviz package"
+type gvpr >/dev/null 2>&1 ||
+	die "need the gvpr(1) tool from the graphviz package"
+
+graph_fan_out "$name" $topic |
+	tred |
+	gvpr -a "\"${name}\"" '
+BEG_G {
+    node_t n;
+    edge_t e;
+
+    n = isNode($, ARGV[0]);
+    if (n == NULL) {
+        printf(2, "tg tred: %s is not a known branch", ARGV[0]);
+        exit(1);
+    }
+    for (e = fstout(n); e; e = nxtout(e))
+        printf("%s\n", e.head.name);
+}
+'
-- 
tg: (06b6e18..) bw/tred (depends on: bw/fan-in-out)
