From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/5] remote-svn-alpha updates
Date: Tue,  5 Jul 2011 22:45:45 +0600
Message-ID: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:45:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe8kG-0002tr-JC
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 18:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab1GEQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 12:44:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49913 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab1GEQoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 12:44:34 -0400
Received: by bwd5 with SMTP id 5so4899798bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CoIFDe9+NAUo6MplfE40LFdVsA1K7zBOGt2zypbtXXA=;
        b=UVJbUcbTmCcXauQcfmBsHfR6Smlx97ENPPqQEllQT8dE9dvfX0wEUULrhv/soM5DDW
         JoD4CC0gxkHFVUCyz2kgHIc5edytX1PLwYs74bmrsyN539ibhi6MKxJ4940qpM7b+aPw
         K7umamTsChKvfNVBv+slJrbBdBCZT6NjkYfE8=
Received: by 10.204.57.71 with SMTP id b7mr7080048bkh.117.1309884272725;
        Tue, 05 Jul 2011 09:44:32 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id l24sm6696272bkw.15.2011.07.05.09.44.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 09:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176617>

Most notable for this series is adding some tests for
remote-svn-alpha helper and not (over)writing refs/heads/master.

The helper is able to import whole svn repository root as the only
remote branch. But it doesn't reuse any previously imported data,
i.e. each time whole history is imported. Also it can't yet push,
and can't configure svn username other than Guest and password
other than empty.

Works both in git clone and git remote add & git fetch scenarios.
$ git clone -b master svn-alpha::http://some.org/svnrepo
"-b master" tells to use remote branch master as a local HEAD to
be checked out. This is necessary because the helper can't tell
git that HEAD is a "symlink" to refs/heads/master and even can't
tell it's sha1 (lists it as "? HEAD") before actually importing.
$ git remote add svn svn-alpha::http://some.org/svnrepo
$ git fetch svn

Known bugs are:
1) absolutely empty (no r1) svn repo import fails
2) git clone needs either --bare, -n or -b master

The patch base is svn-fe-pu at git://repo.or.cz/git/jrn.git
also a commit 7153183171de77d084a4c24ef19d23d6313ded2a can be used
as an earlier patch base.

For the last two commits some new svn-fe options[1] are required.

Whole git-remote-svn-alpha and a test script are cited at the bottom
of this letter as a quick reference for those who don't track svn-fe-pu.

[1] http://thread.gmane.org/gmane.comp.version-control.git/176578

Dmitry Ivankov (5):
  svn-fe: use svnrdump --quiet in remote-svn-alpha
  svn-fe: allow svnadmin instead of svnrdump in svn helper
  svn-fe: add a test for remote-svn-alpha
  svn-fe: use svn-fe --no-progress in remote-svn-alpha
  svn-fe: use proper refspec in remote-svn-alpha

 contrib/svn-fe/git-remote-svn-alpha        |   42 ++++-
 contrib/svn-fe/t/.gitignore                |    3 +
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |  238 ++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+), 9 deletions(-)
 create mode 100644 contrib/svn-fe/t/.gitignore
 create mode 100755 contrib/svn-fe/t/t9010-remote-svn-alpha.sh

-- 
1.7.3.4

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
new file mode 100755
index 0000000..d4b90ae
--- /dev/null
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -0,0 +1,79 @@
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
+try_svnrdump () {
+	command -v svnrdump >/dev/null &&
+	echo "svnrdump dump --non-interactive --username=Guest --password= \
+		--quiet --incremental" ||
+	true
+}
+
+svnadmin_wrap () {
+	path=${1##file://} &&
+	test "z$path" != "z$1" &&
+	svnadmin dump --incremental --deltas --quiet "$path" "$2"
+}
+
+try_svnadmin () {
+	command -v svnadmin >/dev/null &&
+	echo svnadmin_wrap ||
+	true
+}
+
+SVNDUMP=""
+SVNDUMP=${SVNDUMP:-`try_svnrdump`}
+SVNDUMP=${SVNDUMP:-`try_svnadmin`}
+
+do_import () {
+	revs=$1 url=$2 dst=$3
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --no-progress) 3<&0 || die "FAILURE"
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
+
+while read -r cmd args
+do
+	case $cmd in
+	capabilities)
+		echo import
+		echo "refspec HEAD:$private_ref"
+		echo "refspec $remote_ref:$private_ref"
+		echo
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
+		do_import 0:HEAD "$url" "$private_ref"
+		need_import=""
+		;;
+	*)
+		die "remote-svn-alpha: unsupported command: $cmd $args"
+	esac
+done
diff --git a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
new file mode 100755
index 0000000..786cc1f
--- /dev/null
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -0,0 +1,238 @@
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
+dump_to_svnrepo_uuid () {
+	dump="$1" &&
+	path="$2" &&
+	uuid="$3" &&
+	svnadmin create "$path" &&
+	svnadmin load "$path" < "$dump" &&
+	eval "svnadmin setuuid \"$path\" $uuid"
+}
+
+dump_to_svnrepo () {
+	dump_to_svnrepo_uuid "$1" "$2" ""
+}
+
+svnurl () {
+	printf "svn-alpha::file://%s/%s" "$(pwd)" "$1"
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
+	cat >small.dump.r0 <<-EOF &&
+	SVN-fs-dump-format-version: 3
+	EOF
+	for x in `seq 1 1 10`; do
+		{
+			echo &&
+			echo "Revision-number: $x" &&
+			echo Prop-content-length: $(wc -c <props) &&
+			echo Content-length: $(wc -c <props) &&
+			echo &&
+			cat props &&
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
+	uuid="19fe5d53-e0aa-44a8-8179-255e62a5445c" &&
+	cat small.dump.r0 >small.dump &&
+	for x in `seq 1 1 10`; do
+		cat small.dump.r$x >>small.dump &&
+		dump_to_svnrepo_uuid small.dump small.svn.r0-$x "$uuid"
+	done &&
+	dump_to_svnrepo_uuid small.dump small.svn "$uuid" &&
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
+	git clone "$url" tiny1.git
+'
+
+test_expect_success TINY_SVN 'clone --mirror tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --mirror "$url" tiny2.git
+'
+
+test_expect_success TINY_SVN 'clone --bare tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --mirror "$url" tiny3.git
+'
+
+test_expect_success TINY_SVN 'clone -b master tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone -b master "$url" tiny4.git
+'
+
+test_expect_success SMALL_SVN 'clone -b master small' '
+	deinit_git &&
+	url=$(svnurl small.svn) &&
+	git clone -b master "$url" small.git
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory &&
+	git clone -b master "$url" small_dir.git
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path/file' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory/somefile3 &&
+	git clone -b master "$url" small_dir_file.git
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
+test_expect_success TINY_SVN 'fetch TINY does not write to refs/heads/master' '
+	reinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn &&
+	git show-ref --verify refs/remotes/svn/master &&
+	test_must_fail git show-ref --verify refs/heads/master
+'
+
+test_done
