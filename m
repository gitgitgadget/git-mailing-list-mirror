From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of subtrees separately.
Date: Sun, 26 Apr 2009 18:29:42 -0400
Message-ID: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 10:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyCuv-0001tO-JZ
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 00:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZDZWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZDZWcJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 18:32:09 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38124 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZDZWcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 18:32:07 -0400
Received: by fxm2 with SMTP id 2so1999159fxm.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=mH90Ez9cH0AS3egQHvXGG2CgYYkH/7zqa7MIUNiv6Ss=;
        b=aXJhFKBQ98mqB8Oc+wzBnMXtwJmMbi+5XY2x1z61TzShqiZhwb5VN1C8NLgaPOfehH
         IxceSHo6LvCvw1YUxjxnrXOd/rehx5NgbvI7jBcsb+BvZWv1bHsTZLcXRTJN0tlUIoKS
         GWCLmrWkaQ/j0UO5vi1oHeg2EajNwPtncAAlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bxJHTQkQ7Ue6h3QukwdB4uPlYout+r4WgI42ifP854uo6haGb71zq7T33SslwAMold
         Itm3N4lwf41cET6N0aIcmowcfX2pVCatH8845Zu8bh5eHmEYn3VMl2wVER1OiSwIO1SZ
         U4sfDB/0TUZVVbcgxe4Z/S/CJ86smZ63UBy3s=
Received: by 10.103.249.19 with SMTP id b19mr2719466mus.86.1240785124551;
        Sun, 26 Apr 2009 15:32:04 -0700 (PDT)
Received: from afterlife.apenwarr.local (CPE001c10b0d47a-CM00195efb67e8.cpe.net.cable.rogers.com [99.249.243.14])
        by mx.google.com with ESMTPS id u9sm2965172muf.7.2009.04.26.15.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 15:32:03 -0700 (PDT)
Received: by afterlife.apenwarr.local (sSMTP sendmail emulation); Sun, 26 Apr 2009 18:30:00 -0400
X-Mailer: git-send-email 1.6.3.rc2.8.gbe66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117612>

Many projects are made of a combination of several subprojects/libraries and
some application-specific code.  In some cases, particularly when the
subprojects are all maintained independently, 'git submodule' is the best
way to deal with this situation.  But if you frequently change the
subprojects as part of developing your application, use multiple branches,
and sometimes want to push your subproject changes upstream, the overhead of
manually managing submodules can be excessive.

'git subtree' provides an alternative mechanism, based around the
'git merge -s subtree' merge strategy.  Instead of tracking a submodule
separately, you merge its history into your main project, and occasionally
extract a new "virtual history" from your mainline that can be easily merged
back into the upstream project.  The virtual history can be incrementally
expanded as you make more changes to the superproject.

You would normally then merge the virtual history back into your mainline
(the --rejoin option). This results in extra commits in your application
that appear to change the same files, but these extra commits will tend to
be ignored by git's merge simplification algorithm anyway.

For example, gitweb (commit 1130ef3) was merged into git as of commit
0a8f4f0, after which it was no longer maintained separately.  But imagine it
had been maintained separately, and we wanted to extract git's changes to
gitweb since that time, to share with the upstream.  You could do this:

git subtree split --prefix=gitweb --annotate='(split) ' \
	0a8f4f0^.. --onto=1130ef3 --rejoin

If gitweb had originally been merged using 'git subtree add' (or a previous
split had been done with --rejoin specified), then you could incrementally
produce the list of new changes without needing to remember any commit ids:

git subtree split --prefix=gitweb --annotate='(split) ' --rejoin
---
 Makefile         |    1 +
 command-list.txt |    1 +
 git-subtree.sh   |  435 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 437 insertions(+), 0 deletions(-)
 create mode 100755 git-subtree.sh

diff --git a/Makefile b/Makefile
index 5c8e83a..f14e11c 100644
--- a/Makefile
+++ b/Makefile
@@ -305,6 +305,7 @@ SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
+SCRIPT_SH += git-subtree.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_PERL += git-add--interactive.perl
diff --git a/command-list.txt b/command-list.txt
index fb03a2e..9be4774 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -113,6 +113,7 @@ git-stash                               mainporcelain
 git-status                              mainporcelain common
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
+git-subtree                             mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain common
diff --git a/git-subtree.sh b/git-subtree.sh
new file mode 100755
index 0000000..39c377c
--- /dev/null
+++ b/git-subtree.sh
@@ -0,0 +1,435 @@
+#!/bin/bash
+#
+# git-subtree.sh: split/join git repositories in subdirectories of this one
+#
+# Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
+#
+if [ $# -eq 0 ]; then
+    set -- -h
+fi
+OPTS_SPEC="\
+git subtree add --prefix=<prefix> <commit>
+git subtree split [options...] --prefix=<prefix> <commit...>
+git subtree merge --prefix=<prefix> <commit>
+git subtree pull  --prefix=<prefix> <repository> <refspec...>
+--
+h,help        show the help
+q             quiet
+d             show debug messages
+prefix=       the name of the subdir to split out
+ options for 'split'
+annotate=     add a prefix to commit message of new commits
+onto=         try connecting new tree to an existing one
+rejoin        merge the new branch back into HEAD
+ignore-joins  ignore prior --rejoin commits
+"
+eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)
+. git-sh-setup
+require_work_tree
+
+quiet=
+debug=
+command=
+onto=
+rejoin=
+ignore_joins=
+annotate=
+
+debug()
+{
+	if [ -n "$debug" ]; then
+		echo "$@" >&2
+	fi
+}
+
+say()
+{
+	if [ -z "$quiet" ]; then
+		echo "$@" >&2
+	fi
+}
+
+assert()
+{
+	if "$@"; then
+		:
+	else
+		die "assertion failed: " "$@"
+	fi
+}
+
+
+#echo "Options: $*"
+
+while [ $# -gt 0 ]; do
+	opt="$1"
+	shift
+	case "$opt" in
+		-q) quiet=1 ;;
+		-d) debug=1 ;;
+		--annotate) annotate="$1"; shift ;;
+		--no-annotate) annotate= ;;
+		--prefix) prefix="$1"; shift ;;
+		--no-prefix) prefix= ;;
+		--onto) onto="$1"; shift ;;
+		--no-onto) onto= ;;
+		--rejoin) rejoin=1 ;;
+		--no-rejoin) rejoin= ;;
+		--ignore-joins) ignore_joins=1 ;;
+		--no-ignore-joins) ignore_joins= ;;
+		--) break ;;
+	esac
+done
+
+command="$1"
+shift
+case "$command" in
+	add|merge|pull) default= ;;
+	split) default="--default HEAD" ;;
+	*) die "Unknown command '$command'" ;;
+esac
+
+if [ -z "$prefix" ]; then
+	die "You must provide the --prefix option."
+fi
+dir="$prefix"
+
+if [ "$command" != "pull" ]; then
+	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
+	if [ -n "$dirs" ]; then
+		die "Error: Use --prefix instead of bare filenames."
+	fi
+fi
+
+debug "command: {$command}"
+debug "quiet: {$quiet}"
+debug "revs: {$revs}"
+debug "dir: {$dir}"
+debug "opts: {$*}"
+debug
+
+cache_setup()
+{
+	cachedir="$GIT_DIR/subtree-cache/$$"
+	rm -rf "$cachedir" || die "Can't delete old cachedir: $cachedir"
+	mkdir -p "$cachedir" || die "Can't create new cachedir: $cachedir"
+	debug "Using cachedir: $cachedir" >&2
+}
+
+cache_get()
+{
+	for oldrev in $*; do
+		if [ -r "$cachedir/$oldrev" ]; then
+			read newrev <"$cachedir/$oldrev"
+			echo $newrev
+		fi
+	done
+}
+
+cache_set()
+{
+	oldrev="$1"
+	newrev="$2"
+	if [ "$oldrev" != "latest_old" \
+	     -a "$oldrev" != "latest_new" \
+	     -a -e "$cachedir/$oldrev" ]; then
+		die "cache for $oldrev already exists!"
+	fi
+	echo "$newrev" >"$cachedir/$oldrev"
+}
+
+# if a commit doesn't have a parent, this might not work.  But we only want
+# to remove the parent from the rev-list, and since it doesn't exist, it won't
+# be there anyway, so do nothing in that case.
+try_remove_previous()
+{
+	if git rev-parse "$1^" >/dev/null 2>&1; then
+		echo "^$1^"
+	fi
+}
+
+find_existing_splits()
+{
+	debug "Looking for prior splits..."
+	dir="$1"
+	revs="$2"
+	git log --grep="^git-subtree-dir: $dir\$" \
+		--pretty=format:'%s%n%n%b%nEND' $revs |
+	while read a b junk; do
+		case "$a" in
+			git-subtree-mainline:) main="$b" ;;
+			git-subtree-split:) sub="$b" ;;
+			*)
+				if [ -n "$main" -a -n "$sub" ]; then
+					debug "  Prior: $main -> $sub"
+					cache_set $main $sub
+					try_remove_previous "$main"
+					try_remove_previous "$sub"
+					main=
+					sub=
+				fi
+				;;
+		esac
+	done
+}
+
+copy_commit()
+{
+	# We're doing to set some environment vars here, so
+	# do it in a subshell to get rid of them safely later
+	debug copy_commit "{$1}" "{$2}" "{$3}"
+	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+	(
+		read GIT_AUTHOR_NAME
+		read GIT_AUTHOR_EMAIL
+		read GIT_AUTHOR_DATE
+		read GIT_COMMITTER_NAME
+		read GIT_COMMITTER_EMAIL
+		read GIT_COMMITTER_DATE
+		export  GIT_AUTHOR_NAME \
+			GIT_AUTHOR_EMAIL \
+			GIT_AUTHOR_DATE \
+			GIT_COMMITTER_NAME \
+			GIT_COMMITTER_EMAIL \
+			GIT_COMMITTER_DATE
+		(echo -n "$annotate"; cat ) |
+		git commit-tree "$2" $3  # reads the rest of stdin
+	) || die "Can't copy commit $1"
+}
+
+add_msg()
+{
+	dir="$1"
+	latest_old="$2"
+	latest_new="$3"
+	cat <<-EOF
+		Add '$dir/' from commit '$latest_new'
+		
+		git-subtree-dir: $dir
+		git-subtree-mainline: $latest_old
+		git-subtree-split: $latest_new
+	EOF
+}
+
+merge_msg()
+{
+	dir="$1"
+	latest_old="$2"
+	latest_new="$3"
+	cat <<-EOF
+		Split '$dir/' into commit '$latest_new'
+		
+		git-subtree-dir: $dir
+		git-subtree-mainline: $latest_old
+		git-subtree-split: $latest_new
+	EOF
+}
+
+toptree_for_commit()
+{
+	commit="$1"
+	git log -1 --pretty=format:'%T' "$commit" -- || exit $?
+}
+
+subtree_for_commit()
+{
+	commit="$1"
+	dir="$2"
+	git ls-tree "$commit" -- "$dir" |
+	while read mode type tree name; do
+		assert [ "$name" = "$dir" ]
+		echo $tree
+		break
+	done
+}
+
+tree_changed()
+{
+	tree=$1
+	shift
+	if [ $# -ne 1 ]; then
+		return 0   # weird parents, consider it changed
+	else
+		ptree=$(toptree_for_commit $1)
+		if [ "$ptree" != "$tree" ]; then
+			return 0   # changed
+		else
+			return 1   # not changed
+		fi
+	fi
+}
+
+copy_or_skip()
+{
+	rev="$1"
+	tree="$2"
+	newparents="$3"
+	assert [ -n "$tree" ]
+
+	identical=
+	nonidentical=
+	p=
+	gotparents=
+	for parent in $newparents; do
+		ptree=$(toptree_for_commit $parent) || exit $?
+		[ -z "$ptree" ] && continue
+		if [ "$ptree" = "$tree" ]; then
+			# an identical parent could be used in place of this rev.
+			identical="$parent"
+		else
+			nonidentical="$parent"
+		fi
+		
+		# sometimes both old parents map to the same newparent;
+		# eliminate duplicates
+		is_new=1
+		for gp in $gotparents; do
+			if [ "$gp" = "$parent" ]; then
+				is_new=
+				break
+			fi
+		done
+		if [ -n "$is_new" ]; then
+			gotparents="$gotparents $parent"
+			p="$p -p $parent"
+		fi
+	done
+	
+	if [ -n "$identical" ]; then
+		echo $identical
+	else
+		copy_commit $rev $tree "$p" || exit $?
+	fi
+}
+
+ensure_clean()
+{
+	if ! git diff-index HEAD --exit-code --quiet; then
+		die "Working tree has modifications.  Cannot add."
+	fi
+	if ! git diff-index --cached HEAD --exit-code --quiet; then
+		die "Index has modifications.  Cannot add."
+	fi
+}
+
+cmd_add()
+{
+	if [ -e "$dir" ]; then
+		die "'$dir' already exists.  Cannot add."
+	fi
+	ensure_clean
+	
+	set -- $revs
+	if [ $# -ne 1 ]; then
+		die "You must provide exactly one revision.  Got: '$revs'"
+	fi
+	rev="$1"
+	
+	debug "Adding $dir as '$rev'..."
+	git read-tree --prefix="$dir" $rev || exit $?
+	git checkout "$dir" || exit $?
+	tree=$(git write-tree) || exit $?
+	
+	headrev=$(git rev-parse HEAD) || exit $?
+	if [ -n "$headrev" -a "$headrev" != "$rev" ]; then
+		headp="-p $headrev"
+	else
+		headp=
+	fi
+	commit=$(add_msg "$dir" "$headrev" "$rev" |
+		 git commit-tree $tree $headp -p "$rev") || exit $?
+	git reset "$commit" || exit $?
+}
+
+cmd_split()
+{
+	debug "Splitting $dir..."
+	cache_setup || exit $?
+	
+	if [ -n "$onto" ]; then
+		debug "Reading history for --onto=$onto..."
+		git rev-list $onto |
+		while read rev; do
+			# the 'onto' history is already just the subdir, so
+			# any parent we find there can be used verbatim
+			debug "  cache: $rev"
+			cache_set $rev $rev
+		done
+	fi
+	
+	if [ -n "$ignore_joins" ]; then
+		unrevs=
+	else
+		unrevs="$(find_existing_splits "$dir" "$revs")"
+	fi
+	
+	# We can't restrict rev-list to only $dir here, because some of our
+	# parents have the $dir contents the root, and those won't match.
+	# (and rev-list --follow doesn't seem to solve this)
+	grl='git rev-list --reverse --parents $revs $unrevs'
+	revmax=$(eval "$grl" | wc -l)
+	revcount=0
+	createcount=0
+	eval "$grl" |
+	while read rev parents; do
+		revcount=$(($revcount + 1))
+		say -n "$revcount/$revmax ($createcount)
"
+		debug "Processing commit: $rev"
+		exists=$(cache_get $rev)
+		if [ -n "$exists" ]; then
+			debug "  prior: $exists"
+			continue
+		fi
+		createcount=$(($createcount + 1))
+		debug "  parents: $parents"
+		newparents=$(cache_get $parents)
+		debug "  newparents: $newparents"
+		
+		tree=$(subtree_for_commit $rev "$dir")
+		debug "  tree is: $tree"
+		[ -z $tree ] && continue
+
+		newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
+		debug "  newrev is: $newrev"
+		cache_set $rev $newrev
+		cache_set latest_new $newrev
+		cache_set latest_old $rev
+	done || exit $?
+	latest_new=$(cache_get latest_new)
+	if [ -z "$latest_new" ]; then
+		die "No new revisions were found"
+	fi
+	
+	if [ -n "$rejoin" ]; then
+		debug "Merging split branch into HEAD..."
+		latest_old=$(cache_get latest_old)
+		git merge -s ours \
+			-m "$(merge_msg $dir $latest_old $latest_new)" \
+			$latest_new >&2
+	fi
+	echo $latest_new
+	exit 0
+}
+
+cmd_merge()
+{
+	ensure_clean
+	
+	set -- $revs
+	if [ $# -ne 1 ]; then
+		die "You must provide exactly one revision.  Got: '$revs'"
+	fi
+	rev="$1"
+	
+	git merge -s subtree $rev
+}
+
+cmd_pull()
+{
+	ensure_clean
+	set -x
+	git pull -s subtree "$@"
+}
+
+"cmd_$command" "$@"
-- 
1.6.3.rc2.8.gbe66.dirty
