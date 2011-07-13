From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [GSoC'11] [PATCH/RFC v2 0/9] remote-svn-alpha updates
Date: Wed, 13 Jul 2011 21:26:44 +0600
Message-ID: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1Kf-0002R6-4V
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab1GMP0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab1GMP03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:29 -0400
Received: by eyx24 with SMTP id 24so2112126eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tMxXfDX+/oObwMUdHygFYsbSwOphFEnwYD1WNQ3vBkU=;
        b=GKfPCmpiuuP9D/7A8cw/ARYVIztpLqtx3ZA/BsnB2s0jUBOpRRQ5QEEQRebIhvhbyW
         7ev5eklVoRBEqtOB9fUd/DlIo4dRRTi7GxcSM2zZyYXQp2esAM9rEvZUMoalUR2zBCa6
         0Jp7IkjJ9ymR0thDXTdZ95lieLW++t4J6eW90=
Received: by 10.213.96.144 with SMTP id h16mr410021ebn.16.1310570786951;
        Wed, 13 Jul 2011 08:26:26 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177044>

This is a second iteration of remote-svn-alpha series [1].

The main changes are:
1) more strict errors checking - be ready for helper exit code being checked[3]
2) saving "rN" marks as a commit->svn revision mapping
3) supporting incremental imports

"2)" could be even nicer if there were a way for git-remote add or git-clone to
setup a show-notes config option. Another interesting aspect is notes_ref commits
author (vcs-svn <vcs-svn@local>) and timestamps ("now"). Timestamps make notes sha1
diverge on different repos/importers, so fetching notes from a peer git repo is not
fast-forward and a bad thing is they are stored in a private namespace - not likely
place for user to perform merges. But as the tests show, one may want to trust peer
notes and fetch --force svn updated imported by a peer.

But anyway, there are a few tests in this series and it looks like the helper is
really able to import from svn incrementally and exchange/clone imported data
between different git repositories. Same limitations as earlier: only whole svnroot,
only import, needs svnrdump (for file:// svnadmin+svnlook would suffice)

Further improvements for a just import from svn and maybe clone/fetch svn data from
another git peers are:
a) mentioned above "2)" problems
b) adding various configuration options (like svn username and password)
c) add progress indication, either true percentage of # of imported revisions or
some adaptive indicator or any other informative one
d) maybe issue a checkpoint command from time to time or somehow allow to specify
how many revisions to fetch - for huge initial imports
e) import a subdirectory (of svnroot) history
f) shallow imports
g) save all revprops/fileprops whether they have git counterparts or not, ideally
these are sufficient to convert the imported history back to svn lossless
h) get rid of bashisms in this helper or rewrite it in C.

These do not block proceeding to the next topics:
i) push commits to svn
ii) track svn branches.


The patch base is svn-fe-pu at git://repo.or.cz/git/jrn.git
also a commit 7153183171de77d084a4c24ef19d23d6313ded2a can be used
as an earlier patch base.

For the last five commits (those just after the "add a test") some 
new svn-fe options[2] are required.

Whole git-remote-svn-alpha and a test script are cited at the bottom
of this letter as a quick reference for those who don't track svn-fe-pu.

[1] http://thread.gmane.org/gmane.comp.version-control.git/176617
[2] http://thread.gmane.org/gmane.comp.version-control.git/177025
[3] http://thread.gmane.org/gmane.comp.version-control.git/176002/focus=176019

Dmitry Ivankov (9):
  svn-fe: use svnrdump --quiet in remote-svn-alpha
  svn-fe: avoid error on no-op imports in remote-svn-alpha
  svn-fe: allow svnadmin instead of svnrdump in remote-svn-alpha
  svn-fe: add a test for remote-svn-alpha
  svn-fe: use svn-fe --no-progress in remote-svn-alpha
  svn-fe: use proper refspec in remote-svn-alpha
  svn-fe: write svnrev notes in remote-svn-alpha
  svn-fe: import incrementally in svn-remote-alpha
  svn-fe: reuse import-marks in remote-svn-alpha

 contrib/svn-fe/git-remote-svn-alpha        |  140 +++++++++++-
 contrib/svn-fe/t/.gitignore                |    3 +
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |  351 ++++++++++++++++++++++++++++
 3 files changed, 485 insertions(+), 9 deletions(-)
 create mode 100644 contrib/svn-fe/t/.gitignore
 create mode 100755 contrib/svn-fe/t/t9010-remote-svn-alpha.sh

-- 
1.7.3.4
diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
new file mode 100755
index 0000000..8096ef2
--- /dev/null
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -0,0 +1,177 @@
+#!/bin/bash
+set -o pipefail
+set -e
+
+die () {
+	printf >&2 'fatal: %s\n' "$*"
+	exit 128
+}
+
+usage () {
+	printf >&2 'usage: %s\n' "$*"
+	exit 129
+}
+
+svnrdump_wrap () {
+	exec 6<&1 &&
+
+	EX=$(
+		(svnrdump dump --non-interactive --username=Guest --password= \
+			--quiet "$1" "$2" >&6) 2>&1; test $? -ne 0 || echo Success
+	) &&
+	if test "z$EX" != "zSuccess"; then
+		if test "z$EX" = "zLOWER cannot be greater than UPPER."; then
+			return 0
+		fi
+		echo "$EX" >&2
+		return 1
+	fi
+}
+
+try_svnrdump () {
+	command -v svnrdump >/dev/null &&
+	echo svnrdump_wrap ||
+	true
+}
+
+svnadmin_wrap () {
+	path=${1##file://} &&
+	test "z$path" != "z$1" &&
+	latest=$(svnlook youngest "$path") &&
+	future=$(( $latest + 1 )) &&
+	asked=${2#-r} &&
+	asked=${asked%:*} &&
+	test "$asked" -eq "$future" ||
+	svnadmin dump --incremental --deltas --quiet "$path" "$2"
+}
+
+try_svnadmin () {
+	command -v svnadmin >/dev/null &&
+	command -v svnlook >/dev/null &&
+	echo svnadmin_wrap ||
+	true
+}
+
+SVNDUMP=""
+SVNDUMP=${SVNDUMP:-`try_svnrdump`}
+SVNDUMP=${SVNDUMP:-`try_svnadmin`}
+test -n "$SVNDUMP" || die "neither svnrdump nor svnadmin & svnlook was found"
+
+git_dir=""
+marks_dir="info/fast-import/svn-alpha/$repo"
+
+do_gen_marks () {
+	notes=$1
+	test "z$git_dir" != "$z" || die "we were not told the gitdir"
+	git --git-dir="$git_dir" ls-tree -r "$notes" |
+	{
+		while read -r mode type sha path
+		do
+			data=$(git --git-dir="$git_dir" cat-file blob $sha | tail -n 1)
+			data=${data##r}
+			commit=$(echo $path | tr -d /)
+			echo ":$data $commit"
+		done
+	}
+}
+
+prepare_marks () {
+	dst=$1 notes=$2 rev=$3
+	test "z$git_dir" != "$z" || die "we were not told the gitdir"
+	path="$git_dir/$marks_dir"
+	mkdir -p "$path"
+	path="$path/marks"
+
+	if test ! -f "$path"; then
+		touch "$path"
+	fi
+	if test "$rev" = "-1"; then
+		return 0
+	fi
+	mark_sha=""
+	{
+		while read -r m sha
+		do
+			if test "$m" = ":$rev"; then
+				mark_sha="$sha"
+			fi
+		done
+	} <"$path"
+	dst_sha=$( git rev-parse "$dst" )
+	if test -n "$mark_sha"; then
+		test "$mark_sha" = "$dst_sha" || die "latest mark and note diverge"
+	else
+		do_gen_marks "$notes" >"$path"
+	fi
+}
+
+last_imported_rev () {
+	dst=$1 notes=$2
+	test "z$git_dir" != "$z" || die "we were not told the gitdir"
+	git --git-dir="$git_dir" show-ref -q --verify $dst || {
+		echo "-1"
+		return 0
+	}
+	rev=$(git --git-dir="$git_dir" log --show-notes="$notes" -1 --format=%N $dst)
+	rev=${rev##r}
+	test "z$rev" != "z" || {
+		die "remote HEAD has no note"
+	}
+	echo $rev
+}
+
+do_import () {
+	revs=$1 url=$2 dst=$3 notes=$4
+	rev=$(last_imported_rev "$dst" "$notes")
+	start_rev=$(($rev + 1))
+	revs="$start_rev:HEAD"
+	prepare_marks $dst $notes $rev
+	echo "feature import-marks=$git_dir/$marks_dir/marks"
+	echo "feature export-marks=$git_dir/$marks_dir/marks"
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --notes-ref="$notes" --incremental --no-progress) 3<&0 || die "FAILURE"
+	exec 1>&-
+}
+
+test "${2+set}" ||
+usage 'git remote-svn-alpha <repository> <URL> < commandlist'
+repo=$1
+url=$2
+need_import=""
+remote_ref="refs/heads/master"
+private_ref="refs/svn-alpha/$repo/SVNHEAD"
+remote_notes="refs/notes/svnr"
+private_notes="refs/svn-alpha/$repo/SVNR"
+
+while read -r cmd args
+do
+	case $cmd in
+	capabilities)
+		echo import
+		echo gitdir
+		echo "refspec HEAD:$private_ref"
+		echo "refspec $remote_ref:$private_ref"
+		echo "refspec $remote_notes:$private_notes"
+		echo
+		;;
+	gitdir)
+		git_dir="$args"
+		;;
+	list)
+		echo "? HEAD"
+		echo "? $remote_ref"
+		echo
+		;;
+	import)
+		test "$args" = "HEAD" || test "$args" = "$remote_ref" ||
+		die "remote-svn-alpha: unsupported import ref argument: $args"
+		need_import="yes"
+		;;
+	'')
+		test "$need_import" = "yes" || exit 0
+		do_import 0:HEAD "$url" "$private_ref" "$private_notes"
+		need_import=""
+		;;
+	*)
+		die "remote-svn-alpha: unsupported command: $cmd $args"
+	esac
+done
diff --git a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
new file mode 100755
index 0000000..9d9aca0
--- /dev/null
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -0,0 +1,351 @@
+#!/bin/sh
+
+test_description='check svn-alpha remote helper'
+
+PATH=$(pwd)/..:$PATH
+TEST_DIRECTORY=$(pwd)/../../../t
+. $TEST_DIRECTORY/test-lib.sh
+
+if command -v svnrdump >/dev/null; then
+	test_set_prereq SVNRDUMP
+fi
+
+deinit_git () {
+	rm -fr .git
+}
+
+reinit_git () {
+	deinit_git &&
+	git init
+}
+
+properties () {
+	while test "$#" -ne 0
+	do
+		property="$1" &&
+		value="$2" &&
+		printf "%s\n" "K ${#property}" &&
+		printf "%s\n" "$property" &&
+		printf "%s\n" "V ${#value}" &&
+		printf "%s\n" "$value" &&
+		shift 2 ||
+		return 1
+	done
+}
+
+text_no_props () {
+	text="$1
+" &&
+	printf "%s\n" "Prop-content-length: 10" &&
+	printf "%s\n" "Text-content-length: ${#text}" &&
+	printf "%s\n" "Content-length: $((${#text} + 10))" &&
+	printf "%s\n" "" "PROPS-END" &&
+	printf "%s\n" "$text"
+}
+
+dump_to_svnrepo () {
+	dump="$1" &&
+	path="$2" &&
+	svnadmin create "$path" &&
+	svnadmin load "$path" < "$dump"
+}
+
+svnurl () {
+	printf "svn-alpha::file://%s/%s" "$(pwd)" "$1"
+}
+
+test_nr_revs () {
+	n=$1 &&
+	repo=$2 &&
+	ref=$3 &&
+	git --git-dir="$repo" log --format=oneline "$ref" >revs &&
+	test_line_count = "$n" revs
+}
+
+test_expect_success 'svnadmin is present' '
+	command -v svnadmin &&
+	test_set_prereq SVNADMIN
+'
+
+test_expect_success SVNADMIN 'create empty svnrepo' '
+	echo "SVN-fs-dump-format-version: 2" > empty.dump &&
+	dump_to_svnrepo empty.dump empty.svn &&
+	test_set_prereq EMPTY_SVN
+'
+
+test_expect_success SVNADMIN 'create tiny svnrepo' '
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		cat <<-\EOF &&
+
+		Node-path: directory
+		Node-kind: dir
+		Node-action: add
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+		Node-path: directory/somefile
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi
+	} >tiny.dump &&
+	dump_to_svnrepo tiny.dump tiny.svn &&
+	test_set_prereq TINY_SVN
+'
+
+test_expect_success SVNADMIN 'create small svndump' '
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >props_dump &&
+	cat >small.dump.r0 <<-EOF &&
+	SVN-fs-dump-format-version: 3
+	EOF
+	for x in `seq 1 1 10`; do
+		{
+			echo &&
+			echo "Revision-number: $x" &&
+			cat props_dump &&
+
+			if test "$x" -eq "1"; then
+				cat <<-\EOF
+
+				Node-path: directory
+				Node-kind: dir
+				Node-action: add
+				Prop-content-length: 10
+				Content-length: 10
+
+				PROPS-END
+
+				EOF
+			fi
+			echo "Node-path: directory/somefile$x" &&
+			echo "Node-kind: file" &&
+			echo "Node-action: add" &&
+			text_no_props hi
+		} >small.dump.r$x
+	done &&
+	test_set_prereq SMALL_SVNDUMP
+'
+
+test_expect_success SMALL_SVNDUMP 'create small svnrepo' '
+	rm -rf small.svn* &&
+	svnadmin create small.svn &&
+	for x in `seq 1 1 10`; do
+		cat small.dump.r0 small.dump.r$x >part.dump &&
+		svnadmin load small.svn <part.dump &&
+		cp -r small.svn small.svn.r0-$x
+	done &&
+	test_set_prereq SMALL_SVN
+'
+
+test_expect_failure EMPTY_SVN 'fetch empty' '
+	reinit_git &&
+	url=$(svnurl empty.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn
+'
+
+test_expect_failure TINY_SVN 'clone tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone "$url" tiny1.git &&
+	test_nr_revs 1 tiny1.git refs/remotes/origin/master
+'
+
+test_expect_success TINY_SVN 'clone --mirror tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --mirror "$url" tiny2.git &&
+	test_nr_revs 1 tiny2.git refs/heads/master
+'
+
+test_expect_success TINY_SVN 'clone --bare tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --bare "$url" tiny3.git &&
+	test_nr_revs 1 tiny3.git refs/heads/master
+'
+
+test_expect_success TINY_SVN 'clone -b master tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone -b master "$url" tiny4.git &&
+	test_nr_revs 1 tiny4.git/.git refs/heads/master
+'
+
+test_expect_success SMALL_SVN 'clone -b master small' '
+	deinit_git &&
+	url=$(svnurl small.svn) &&
+	git clone -b master "$url" small.git &&
+	test_nr_revs 10 small.git/.git refs/heads/master
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory &&
+	git clone -b master "$url" small_dir.git &&
+	test_nr_revs 10 small_dir.git/.git refs/heads/master
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path/file' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory/somefile3 &&
+	git clone -b master "$url" small_dir_file.git &&
+	test_nr_revs 10 small_dir_file.git/.git refs/heads/master
+'
+
+test_expect_success SMALL_SVN 'fetch each rev of SMALL separately' '
+	reinit_git &&
+	url=$(svnurl small.svn) &&
+
+	for x in `seq 1 1 10`; do
+		git remote add svn_$x "$url.r0-$x"
+	done &&
+	git remote update &&
+
+	git remote add svn "$url" &&
+	git fetch svn &&
+
+	git rev-parse -s remotes/svn_7/master~5 >ref7_2 &&
+	git rev-parse -s remotes/svn/master~8 >ref_2 &&
+	test_cmp ref7_2 ref_2
+'
+
+test_expect_success SMALL_SVN 'fetch updates from SMALL' '
+	reinit_git &&
+	url=$(svnurl link.svn) &&
+	git remote add svn "$url" &&
+
+	ln -sfn small.svn.r0-5 link.svn &&
+	git fetch svn &&
+	test_nr_revs 5 .git refs/remotes/svn/master &&
+
+	ln -sfn small.svn.r0-10 link.svn &&
+	git fetch svn &&
+	test_nr_revs 10 .git refs/remotes/svn/master &&
+
+	git fetch svn &&
+	test_nr_revs 10 .git refs/remotes/svn/master
+'
+
+test_expect_success TINY_SVN 'fetch TINY does not write to refs/heads/master' '
+	reinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn &&
+	git show-ref --verify refs/remotes/svn/master &&
+	test_must_fail git show-ref --verify refs/heads/master
+'
+
+test_expect_success SMALL_SVN 'fetch SMALL writes revnum notes' '
+	reinit_git &&
+	url=$(svnurl small.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn &&
+	git log --show-notes=refs/svn-alpha/svn/SVNR --format=%N -1 refs/remotes/svn/master^ >actual.note &&
+	echo r9 >expect.note &&
+	echo >>expect.note &&
+	test_cmp expect.note actual.note
+'
+
+test_expect_success SMALL_SVN 'marks from notes regeneration' '
+	reinit_git &&
+	url=$(svnurl link.svn) &&
+	git remote add svn "$url" &&
+
+	ln -sfn small.svn.r0-5 link.svn &&
+	git fetch svn &&
+	test_nr_revs 5 .git refs/remotes/svn/master &&
+
+	rm -rf .git/info/fast-import/svn-alpha &&
+
+	ln -sfn small.svn.r0-10 link.svn &&
+	git fetch svn &&
+	test_nr_revs 10 .git refs/remotes/svn/master
+'
+
+test_expect_success SMALL_SVN 'clone to bootstrap' '
+	deinit_git &&
+	url=$(svnurl link.svn) &&
+	ln -sfn small.svn.r0-5 link.svn &&
+	git clone -b master "$url" master.git &&
+	{
+		cd master.git &&
+		git branch pub_head refs/svn-alpha/origin/SVNHEAD &&
+		git branch pub_notes refs/svn-alpha/origin/SVNR &&
+		cd ..
+	} &&
+	ln -sfn small.svn.r0-8 link.svn &&
+	git clone master.git slave.git &&
+	{
+		cd slave.git &&
+		git remote add svn "$url" &&
+		git update-ref refs/svn-alpha/svn/SVNHEAD refs/remotes/origin/pub_head &&
+		git update-ref refs/svn-alpha/svn/SVNR refs/remotes/origin/pub_notes &&
+		git fetch svn &&
+		git merge-base refs/svn-alpha/svn/SVNR refs/remotes/origin/pub_notes &&
+		cd ..
+	} &&
+	test_nr_revs 8 slave.git/.git refs/remotes/svn/master
+'
+
+test_expect_success SMALL_SVN 'clone and exchange' '
+	deinit_git &&
+	url=$(svnurl link.svn) &&
+	ln -sfn small.svn.r0-1 link.svn &&
+	git clone -b master "$url" A.git &&
+	git clone -b master "$url" B.git &&
+	test_nr_revs 1 A.git/.git origin/master &&
+	test_nr_revs 1 B.git/.git origin/master &&
+
+	git --git-dir=A.git/.git remote add B B.git &&
+	git --git-dir=B.git/.git remote add A A.git &&
+	refspecs="+refs/svn-alpha/origin/SVNR:refs/svn-alpha/origin/SVNR"
+	refspecs="$refspecs refs/svn-alpha/origin/SVNHEAD:refs/svn-alpha/origin/SVNHEAD"
+
+	ln -sfn small.svn.r0-2 link.svn &&
+	git --git-dir=A.git/.git fetch origin &&
+
+	git --git-dir=B.git/.git fetch -f A $refspecs &&
+
+	ln -sfn small.svn.r0-3 link.svn &&
+	git --git-dir=B.git/.git fetch origin &&
+
+	git --git-dir=A.git/.git fetch B $refspecs &&
+
+	git --git-dir=A.git/.git fetch origin &&
+	git --git-dir=B.git/.git fetch origin &&
+
+	test_nr_revs 3 A.git/.git origin/master &&
+	test_nr_revs 3 B.git/.git origin/master
+'
+
+test_done
