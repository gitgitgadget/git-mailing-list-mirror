From: "James R. McKaskill" <james@foobar.co.nz>
Subject: [RFC 2/2] add tests for git svn-fetch|push
Date: Sat, 18 Aug 2012 13:39:16 -0400
Message-ID: <1345311556-70767-3-git-send-email-james@foobar.co.nz>
References: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
Cc: "James R. McKaskill" <james@foobar.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 19:40:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2n0M-0004L3-00
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab2HRRjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:39:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62216 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2HRRjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 13:39:41 -0400
Received: by obbuo13 with SMTP id uo13so7054144obb.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 10:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=XzhXHjhcKKxuWfAlfntRSBj2kYQB3JwzcPMd0AxSQXU=;
        b=kCMZxklxwaqoI0DnBoHbtLjz80E+6BfztZjxnqMKpJTAYdlOx53kyPgKMtfkUSRJ9C
         a/7+O55h1V5fm7opW+MCXzibJnakd4lSmmm1QAUJDwU6HFpPWmfiT+rmKiXL3kYxCuFO
         ZFpMv1ULu8WzY2QFxJuSznb6fNAOfGM9X7rb95ixpR844kz1ep7H0ESstwzQsJYTNFYP
         FeUzED9VgaufAzbiFBsn6aEZbxafSNVY3PZ7Pfx1XDWRf9QfnRdlAoTlax4sZyGrNMsM
         BEKCzqmkVQjyWCR87VN2KX5eqDQS8CloSalUU2LVVJ+gGQGWsK2tvwPhWPm3mh3HURoZ
         R23w==
Received: by 10.50.207.73 with SMTP id lu9mr5419449igc.19.1345311579558;
        Sat, 18 Aug 2012 10:39:39 -0700 (PDT)
Received: from aeir.local.net ([155.63.0.254])
        by mx.google.com with ESMTPS id gy9sm8037271igc.1.2012.08.18.10.39.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Aug 2012 10:39:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
X-Gm-Message-State: ALoCoQl7PEU3hijhh1BBStwUOHXHD1CQVo2+0RSWBWJ+MS/wu+qxE8xnxlIjA+3mfQz+4+Z7vT2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203686>

From: "James R. McKaskill" <james@foobar.co.nz>


Signed-off-by: James R. McKaskill <james@foobar.co.nz>
---
 t/lib-git-svn-fetch.sh          | 131 +++++++++++
 t/t9050-git-svn-fetch.sh        |  85 +++++++
 t/t9051-git-svn-fetch-branch.sh | 245 ++++++++++++++++++++
 t/t9052-git-svn-push.sh         | 140 ++++++++++++
 t/t9053-git-svn-push-branch.sh  | 478 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1079 insertions(+)
 create mode 100644 t/lib-git-svn-fetch.sh
 create mode 100755 t/t9050-git-svn-fetch.sh
 create mode 100755 t/t9051-git-svn-fetch-branch.sh
 create mode 100755 t/t9052-git-svn-push.sh
 create mode 100755 t/t9053-git-svn-push-branch.sh

diff --git a/t/lib-git-svn-fetch.sh b/t/lib-git-svn-fetch.sh
new file mode 100644
index 0000000..16326a9
--- /dev/null
+++ b/t/lib-git-svn-fetch.sh
@@ -0,0 +1,131 @@
+#!/bin/sh
+
+. ./test-lib.sh
+
+if test -z "$SVNSERVE_PORT"
+then
+	skip_all='skipping svn-(fetch|push) test. (set $SVNSERVE_PORT to enable)'
+	test_done
+fi
+
+svn --version | grep "version 1.7" &> /dev/null
+if [ ! $? -eq 0 ]
+then
+	skip_all='skipping svn-(fetch|push) test. (need svn 1.7 or newer)'
+	test_done
+fi
+
+svnrepo=$PWD/svnrepo
+svnconf=$PWD/svnconf
+svnurl="svn://localhost:$SVNSERVE_PORT"
+null_sha1=0000000000000000000000000000000000000000
+
+# We need this, because we should pass empty configuration directory to
+# the 'svn commit' to avoid automated property changes and other stuff
+# that could be set from user's configuration files in ~/.subversion.
+svn_cmd () {
+	[ -d "$svnconf" ] || mkdir "$svnconf"
+	cat > "$svnconf/servers" <<!
+[global]
+store-plaintext-passwords = yes
+!
+	orig_svncmd="$1"; shift
+	if [ -z "$orig_svncmd" ]; then
+		svn
+		return
+	fi
+	echo svn $orig_svncmd $@
+	svn "$orig_svncmd" --username committer --password pass --no-auth-cache --non-interactive --config-dir "$svnconf" "$@"
+}
+
+function test_file() {
+	file_contents="`cat $1`"
+	test_contents="$2"
+	test "$file_contents" == "$test_contents"
+}
+
+function svn_date() {
+	revision="$1"
+	directory="$2"
+	svn_cmd log -r "$revision" --xml -l 1 "$directory" | grep "<date>" | sed -re 's#^<date>([^\.Z]*)\.[0-9]+Z</date>#\1Z#g'
+}
+
+function test_git_subject() {
+	commit="$1"
+	subject="$2"
+	commit_subject="`git log -1 --pretty=format:%s $commit`"
+	echo test_git_subject "$commit_subject" "$subject"
+	test "$commit_subject" == "$subject"
+}
+
+function test_git_author() {
+	commit="$1"
+	author="$2"
+	commit_author="`git log -1 --pretty=format:'%an <%ae>' $commit`"
+	echo test_git_author "$commit_author" "$author"
+	test "$commit_author" == "$author"
+}
+
+function test_git_date() {
+	commit="$1"
+	date="$2"
+	commit_date="`git log -1 --pretty=format:%ai $commit | sed -re 's#^([^ ]*) ([^ ]*) \+0000$#\1T\2Z#g'`"
+	echo test_git_date "$commit_date" "$date"
+	test "$commit_date" == "$date"
+}
+
+function test_svn_subject() {
+	subject="$1"
+	revision=`test -n "$2" && echo "-r $2"`
+	commit_subject="`svn log -l 1 --xml $revision | grep '<msg>' | sed -re 's#<msg>(.*)#\1#g' | sed -re 's#(.*)</msg>#\1#g'`"
+	echo test_svn_subject "$commit_subject" "$subject"
+	test "$commit_subject" == "$subject"
+}
+
+function test_svn_author() {
+	author="$1"
+	revision=`test -n "$2" && echo "-r $2"`
+	commit_author="`svn log -l 1 --xml $revision | grep '<author>' | sed -re 's#<author>(.*)</author>#\1#g'`"
+	echo test_svn_author "$commit_author" "$author"
+	test "$commit_author" == "$author"
+}
+
+show_ref() {
+	(git show-ref --head $1 | head -n 1 | cut -d ' ' -f 1) || echo $1
+}
+
+show_tag() {
+	show_ref refs/tags/$1 | git cat-file --batch | grep object | cut -f 2 -d ' '
+}
+
+merge_base() {
+	git merge-base `show_ref $1` `show_ref $2`
+}
+
+test_expect_success 'start svnserve' '
+	killall svnserve &> /dev/null
+	killall lt-svnserve &> /dev/null
+	rm -rf "$svnrepo" &&
+	mkdir -p "$svnrepo" &&
+	svnadmin create "$svnrepo" &&
+	cat > "$svnrepo/conf/svnserve.conf" <<!
+[general]
+auth-access = write
+password-db = passwd
+!
+	cat > "$svnrepo/conf/passwd" <<!
+[users]
+committer = pass
+!
+	cat > .git/svn-authors <<!
+committer:pass = C O Mitter <committer@example.com>
+!
+	svnserve --daemon \
+		--listen-port $SVNSERVE_PORT \
+		--root "$svnrepo" \
+		--listen-host localhost &&
+	git config svn.user committer &&
+	git config svn.url $svnurl &&
+	git config svn.remote svn &&
+	svn_cmd co $svnurl svnco
+'
diff --git a/t/t9050-git-svn-fetch.sh b/t/t9050-git-svn-fetch.sh
new file mode 100755
index 0000000..7ac3643
--- /dev/null
+++ b/t/t9050-git-svn-fetch.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='git svn-fetch non trunk'
+. ./lib-git-svn-fetch.sh
+
+test_expect_success 'fetch empty' '
+	git svn-fetch -v &&
+	test_must_fail test -x .git/refs/svn/latest &&
+	test_must_fail git checkout svn/master &&
+	test_must_fail git checkout svn/trunk
+'
+
+test_expect_success 'init repo' '
+	cd svnco &&
+	svn_cmd mkdir empty-dir &&
+	echo "some contents" > file.txt &&
+	svn_cmd add file.txt &&
+	svn_cmd ci -m "some commit" &&
+	cd ..
+'
+
+date=`svn_date HEAD svnco`
+
+test_expect_success 'fetch repo' '
+	git svn-fetch -v &&
+	test $(GIT_SVN_FETCH_REPORT_LATEST=1 git svn-fetch) -eq 1 &&
+	git checkout svn/master &&
+	test -d empty-dir &&
+	test -e empty-dir/.gitempty &&
+	test_file file.txt "some contents" &&
+	test_git_subject HEAD "some commit" &&
+	test_git_author HEAD "C O Mitter <committer@example.com>" &&
+	test_git_date HEAD $date
+'
+
+test_expect_success 'auto crlf' '
+	cd svnco &&
+	echo "666f6f0d0a6261720d0a" | xxd -r -p > crlf.txt &&
+	svn_cmd add crlf.txt &&
+	svn_cmd ci -m "crlf" &&
+	cd .. &&
+	echo "* text=auto" > .git/info/attributes &&
+	git config svn.eol crlf &&
+	git config core.eol lf &&
+	git svn-fetch -v &&
+	git checkout svn/master &&
+	echo "666f6f0a6261720a" | xxd -r -p > crlf_test.txt &&
+	test "$(cat crlf.txt)" = "$(cat crlf_test.txt)"
+'
+
+test_expect_success 'move file' '
+	cd svnco &&
+	seq 1 1000 > somefile &&
+	svn_cmd add somefile &&
+	svn_cmd ci -m "adding some file" &&
+	svn_cmd mv somefile somefile2 &&
+	svn_cmd ci -m "moving file" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout -f svn/master &&
+	cmp somefile2 svnco/somefile2
+'
+
+test_expect_success 'move folder' '
+	cd svnco &&
+	svn_cmd mkdir folder &&
+	cd folder &&
+	seq 1 1000 > file1 &&
+	seq 1000 2000 > file2 &&
+	seq 3000 50000 > file3 &&
+	svn_cmd add file1 file2 file3 &&
+	cd .. &&
+	svn_cmd ci -m "add some folder" &&
+	svn_cmd mv folder folder2 &&
+	svn_cmd ci -m "move folder" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout -f svn/master &&
+	cmp folder2/file1 svnco/folder2/file1 &&
+	cmp folder2/file2 svnco/folder2/file2 &&
+	cmp folder2/file3 svnco/folder2/file3
+'
+
+test_done
+
diff --git a/t/t9051-git-svn-fetch-branch.sh b/t/t9051-git-svn-fetch-branch.sh
new file mode 100755
index 0000000..277dcd3
--- /dev/null
+++ b/t/t9051-git-svn-fetch-branch.sh
@@ -0,0 +1,245 @@
+#!/bin/sh
+
+test_description='git svn-fetch branch'
+. ./lib-git-svn-fetch.sh
+
+test_expect_success 'setup branches' '
+	cd svnco &&
+	svn_cmd mkdir Trunk &&
+	svn_cmd mkdir Branches &&
+	svn_cmd mkdir Tags &&
+	touch Trunk/file.txt &&
+	svn_cmd add Trunk/file.txt &&
+	svn_cmd ci -m "init" &&
+	svn_cmd up &&
+	echo "other" >> Trunk/file.txt &&
+	svn_cmd ci -m "trunk file" &&
+	svn_cmd up &&
+	cd .. &&
+	git config svn.trunk Trunk &&
+	git config svn.branches Branches &&
+	git config svn.tags Tags &&
+	git config svn.trunkref trunk &&
+	git svn-fetch -v
+'
+
+test_expect_success 'copied branch' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/Branch &&
+	svn_cmd ci -m "create branch" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	test `show_ref svn/trunk` == `show_ref svn/Branch`
+'
+
+test_expect_success 'copied and edited branch' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/CopiedBranch &&
+	echo "more" >> Branches/CopiedBranch/file2.txt &&
+	svn_cmd add Branches/CopiedBranch/file2.txt &&
+	svn_cmd ci -m "create copied branch" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/CopiedBranch &&
+	test_file file.txt "other" &&
+	test_file file2.txt "more" &&
+	test_git_subject HEAD "create copied branch" &&
+	test_git_subject HEAD~1 "trunk file" &&
+	test_git_subject HEAD~2 "init" &&
+	test `git log --pretty=oneline svn/trunk..svn/CopiedBranch | wc -l` -eq 1 &&
+	merge_base svn/trunk svn/CopiedBranch
+'
+
+test_expect_success 'edited and copied branch' '
+	cd svnco &&
+	echo "more" >> Trunk/file2.txt &&
+	svn_cmd add Trunk/file2.txt &&
+	svn_cmd copy Trunk Branches/EditCopyBranch &&
+	svn_cmd ci -m "create edit copy branch" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/EditCopyBranch &&
+	test_file file.txt "other" &&
+	test_file file2.txt "more" &&
+	test_git_subject HEAD "create edit copy branch" &&
+	test `show_ref svn/trunk` == `show_ref svn/EditCopyBranch`
+'
+
+# the copy commits shouldn't create git commits
+
+test_expect_success 'copy, copy, copy' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/FastCopy2 &&
+	svn_cmd copy Branches/FastCopy2 Branches/FastCopy1 &&
+	svn_cmd copy Branches/FastCopy2 Branches/FastCopy3 &&
+	svn_cmd ci -m "fast copy" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	test `show_ref svn/FastCopy1` == `show_ref svn/FastCopy2` &&
+	test `show_ref svn/FastCopy1` == `show_ref svn/FastCopy3` &&
+	test `show_ref svn/FastCopy1` == `show_ref svn/trunk` &&
+	test_must_fail test_git_subject svn/FastCopy1 "fast copy"
+'
+
+# 'edit copy delete 1' shouldn't create a git commit
+
+test_expect_success 'edit, copy, and delete' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/EditCopyDelete &&
+	svn_cmd ci -m "edit copy delete 1" &&
+	svn_cmd up &&
+	echo "edit copy delete" >> Branches/EditCopyDelete/file3.txt &&
+	svn_cmd add Branches/EditCopyDelete/file3.txt &&
+	svn_cmd copy Branches/EditCopyDelete Branches/EditCopyDelete2 &&
+	svn_cmd rm --force Branches/EditCopyDelete &&
+	svn_cmd ci -m "edit copy delete 2" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	test_must_fail git checkout svn/EditCopyDelete &&
+	git checkout svn/EditCopyDelete2 &&
+	test_git_subject HEAD "edit copy delete 2" &&
+	test_must_fail test_git_subject HEAD~1 "edit copy delete 1" &&
+	test_file file3.txt "edit copy delete"
+'
+
+test_expect_success 'copy, edit, copy, and delete' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/CopyEditCopyDelete &&
+	echo "copy edit copy delete" >> Branches/CopyEditCopyDelete/file4.txt &&
+	svn_cmd add Branches/CopyEditCopyDelete/file4.txt &&
+	svn_cmd copy Branches/CopyEditCopyDelete Branches/CopyEditCopyDelete2 &&
+	svn_cmd rm --force Branches/CopyEditCopyDelete &&
+	svn_cmd ci -m "copy edit copy delete" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	test_must_fail git checkout svn/CopyEditCopyDelete &&
+	git checkout svn/CopyEditCopyDelete2 &&
+	test_git_subject HEAD "copy edit copy delete" &&
+	test_file file4.txt "copy edit copy delete"
+'
+
+test_expect_success 'non copied branch' '
+	cd svnco &&
+	svn_cmd mkdir Branches/NonCopiedBranch &&
+	echo "non copied" >> Branches/NonCopiedBranch/file.txt &&
+	svn_cmd add Branches/NonCopiedBranch/file.txt &&
+	svn_cmd ci -m "create non-copied branch" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/NonCopiedBranch &&
+	test_file file.txt "non copied" &&
+	test ! -e file2.txt &&
+	test_git_subject HEAD "create non-copied branch" &&
+	test `git log --pretty=oneline | wc -l` -eq 1 &&
+	test_must_fail merge_base svn/trunk svn/NonCopiedBranch
+'
+
+test_expect_success 'removed branch' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/RemovedBranch &&
+	svn_cmd ci -m "create branch" &&
+	cd .. &&
+	git svn-fetch -v &&
+	test `show_ref svn/RemovedBranch` == `show_ref svn/trunk` &&
+	rev=$(GIT_SVN_FETCH_REPORT_LATEST=1 git svn-fetch) &&
+	cd svnco &&
+	svn_cmd rm Branches/RemovedBranch &&
+	svn_cmd ci -m "remove branch" &&
+	cd .. &&
+	git svn-fetch -v &&
+	test_must_fail git checkout svn/RemovedBranch &&
+	cd svnco &&
+	echo $rev &&
+	svn_cmd copy Branches/RemovedBranch@$rev Branches/RemovedBranch2 &&
+	svn_cmd ci -m "copy branch" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	test `show_ref svn/RemovedBranch2` == `show_ref svn/trunk` &&
+	git checkout svn/RemovedBranch2 &&
+	cd svnco &&
+	svn_cmd copy Trunk Branches/RemovedBranch &&
+	echo "foo" > Branches/RemovedBranch/newfile.txt &&
+	svn_cmd add Branches/RemovedBranch/newfile.txt &&
+	svn_cmd ci -m "create branch again" &&
+	svn_cmd up &&
+	svn_cmd rm Branches/RemovedBranch2 &&
+	svn_cmd copy Branches/RemovedBranch@$rev Branches/RemovedBranch2 &&
+	svn_cmd ci -m "copy branch again" &&
+	svn_cmd up &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/RemovedBranch &&
+	git checkout svn/RemovedBranch2 &&
+	test `show_ref svn/RemovedBranch` != `show_ref svn/trunk` &&
+	test `show_ref svn/RemovedBranch2` == `show_ref svn/trunk`
+'
+
+test_expect_success 'move branch' '
+	cd svnco &&
+	svn_cmd copy Trunk Branches/MovedBranch &&
+	svn_cmd ci -m "create branch" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/MovedBranch &&
+	cd svnco &&
+	svn_cmd mv Branches/MovedBranch Branches/MovedBranch2 &&
+	svn_cmd ci -m "move branch" &&
+	cd .. &&
+	git svn-fetch -v &&
+	test_must_fail git checkout svn/MovedBranch &&
+	git checkout svn/MovedBranch2 &&
+	test `show_ref svn/MovedBranch2` == `show_ref svn/trunk`
+'
+
+test_expect_success 'tag' '
+	cd svnco &&
+	svn_cmd copy Trunk Tags/Tag &&
+	svn_cmd ci -m "create tag" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/Tag &&
+	test `show_tag svn/Tag` == `show_ref svn/trunk` &&
+	rev=$(GIT_SVN_FETCH_REPORT_LATEST=1 git svn-fetch) &&
+	cd svnco &&
+	svn_cmd rm Tags/Tag &&
+	svn_cmd ci -m "remove tag" &&
+	cd .. &&
+	git svn-fetch -v &&
+	test_must_fail git checkout svn/Tag &&
+	cd svnco &&
+	svn_cmd copy Tags/Tag@$rev Branches/CopiedTag &&
+	svn_cmd ci -m "copy tag" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/CopiedTag &&
+	test `show_ref svn/trunk` == `show_ref refs/remotes/svn/CopiedTag` &&
+	cd svnco &&
+	svn_cmd copy Branches/CopiedTag Tags/Tag &&
+	svn_cmd ci -m "create tag again" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git checkout svn/Tag &&
+	test `show_tag svn/Tag` == `show_ref svn/trunk` &&
+	cd svnco &&
+	svn_cmd copy Tags/Tag Tags/Tag2 &&
+	svn_cmd ci -m "create 2nd tag" &&
+	svn_cmd rm Tags/Tag &&
+	svn_cmd copy Tags/Tag2 Tags/Tag &&
+	svn_cmd ci -m "recreate tag from 2nd" &&
+	cd .. &&
+	git svn-fetch -v &&
+	test `show_tag svn/Tag` == `show_tag svn/Tag2` &&
+	test `show_tag svn/Tag` == `show_ref svn/trunk`
+
+'
+
+test_done
+
diff --git a/t/t9052-git-svn-push.sh b/t/t9052-git-svn-push.sh
new file mode 100755
index 0000000..1a8cf1e
--- /dev/null
+++ b/t/t9052-git-svn-push.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+
+test_description='git svn-push'
+. ./lib-git-svn-fetch.sh
+
+test_expect_success 'init push' '
+	echo "foo" > file.txt &&
+	git add file.txt &&
+	git commit -a -m "initial commit" &&
+	git svn-push -v refs/remotes/svn/master $null_sha1 master &&
+	cd svnco &&
+	svn_cmd up &&
+	test_svn_subject "initial commit" &&
+	test_svn_author committer &&
+	test_file file.txt "foo" &&
+	cd ..
+'
+
+test_expect_success 'multiple commits' '
+	echo "bar" >> file.txt &&
+	git commit -a -m "second commit" &&
+	mkdir a &&
+	echo "fefifofum" >> a/test &&
+	git add a/test &&
+	git commit -a -m "third commit" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up -r 2 &&
+	test_svn_subject "second commit" &&
+	test_svn_author committer &&
+	echo foo > file_test.txt &&
+	echo bar >> file_test.txt &&
+	test_file file.txt "$(cat file_test.txt)" &&
+	test ! -e a &&
+	svn_cmd up -r 3 &&
+	test_svn_subject "third commit" &&
+	test_svn_author committer &&
+	test_file a/test "fefifofum" &&
+	cd ..
+'
+
+test_expect_success 'remove git empty directories' '
+	mkdir -p b/c/d &&
+	touch b/c/d/foo.txt &&
+	git add b/c/d/foo.txt &&
+	git commit -a -m "add dir" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	test -e b/c/d/foo.txt &&
+	cd .. &&
+	rm -rf b &&
+	git commit -a -m "rm dir" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	test ! -e b &&
+	cd ..
+'
+
+test_expect_success 'remove file' '
+	touch foo.txt &&
+	git add foo.txt &&
+	git commit -a -m "add file" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	test -e foo.txt &&
+	cd .. &&
+	rm foo.txt &&
+	git commit -a -m "rm file" &&
+	git svn-push -v svn/master svn/master master
+	cd svnco &&
+	svn_cmd up &&
+	test ! -e foo.txt &&
+	cd ..
+'
+
+test_expect_success 'remove svn empty directories' '
+	cd svnco &&
+	svn_cmd mkdir empty &&
+	svn_cmd commit -m "make empty" &&
+	cd .. &&
+	git svn-fetch -v &&
+	git reset --hard svn/master &&
+	test -e empty/.gitempty &&
+	rm empty/.gitempty &&
+	git commit -a -m "remove empty" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	test "$(git clean -n -d | grep empty)" = "Would remove empty/" &&
+	cd ..
+'
+
+test_expect_success '.git files' '
+	mkdir h &&
+	touch h/.githidden &&
+	git add h/.githidden &&
+	git commit -a -m "add h/.githidden" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	test -e h &&
+	test ! -e h/.githidden &&
+	cd ..
+'
+
+test_expect_success 'modify file' '
+	echo "foo" > file.txt &&
+	git add file.txt &&
+	git commit -a -m "edit1" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	test_svn_subject "edit1" &&
+	test_file file.txt "foo" &&
+	cd .. &&
+	echo "bar" > file.txt &&
+	git commit -a -m "edit2" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	test_svn_subject "edit2" &&
+	test_file file.txt "bar" &&
+	cd ..
+'
+
+test_expect_success 'big file' '
+	seq 1 100000 > file.txt &&
+	git add file.txt &&
+	git commit -a -m "big file" &&
+	git svn-push -v svn/master svn/master master &&
+	cd svnco &&
+	svn_cmd up &&
+	cmp file.txt ../file.txt &&
+	cd ..
+'
+
+test_done
+
diff --git a/t/t9053-git-svn-push-branch.sh b/t/t9053-git-svn-push-branch.sh
new file mode 100755
index 0000000..501ab3c
--- /dev/null
+++ b/t/t9053-git-svn-push-branch.sh
@@ -0,0 +1,478 @@
+#!/bin/sh
+
+test_description='git svn-push branch'
+. ./lib-git-svn-fetch.sh
+
+function check_branched() {
+	copyfrom_path="$1"
+	copyfrom_rev="$2"
+	echo check_branched $1 $2
+	svn_cmd log --stop-on-copy -v --xml | grep copyfrom-path=\"/$copyfrom_path\" &&
+	svn_cmd log --stop-on-copy -v --xml | grep copyfrom-rev=\"$copyfrom_rev\"
+}
+
+test_expect_success 'setup branches' '
+	git config svn.trunk Trunk &&
+	git config svn.branches Branches &&
+	git config svn.tags Tags &&
+	git config svn.trunkref trunk &&
+	cd svnco &&
+	svn_cmd mkdir Branches &&
+	svn_cmd mkdir Tags &&
+	svn_cmd ci -m "svn init" &&
+	cd ..
+'
+
+test_expect_success 'init trunk' '
+	echo "foo" > file.txt &&
+	git add file.txt &&
+	git commit -a -m "init trunk" &&
+	git svn-push -v refs/remotes/svn/trunk $null_sha1 master &&
+	test `show_ref svn/trunk` == `show_ref master` &&
+	cd svnco &&
+	svn_cmd up &&
+	test -d Trunk &&
+	test_svn_subject "init trunk" &&
+	test_svn_author committer &&
+	test_file Trunk/file.txt "foo" &&
+	cd ..
+'
+
+test_expect_success 'modify file' '
+	cd svnco/Trunk &&
+	echo "bar23" > file.txt &&
+	svn_cmd ci -m "svn edit" &&
+	cd ../.. &&
+	git svn-fetch -v &&
+	git reset --hard svn/trunk &&
+	test_file file.txt "bar23" &&
+	echo "foo" > file.txt &&
+	git commit -a -m "git edit" &&
+	git svn-push -v svn/trunk svn/trunk HEAD &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Trunk &&
+	test_svn_subject "git edit" &&
+	test_svn_subject "svn edit" PREV &&
+	test_file file.txt "foo" &&
+	cd ../..
+'
+
+test_expect_success 'modify file2' '
+	cd svnco/Trunk &&
+	echo "bar" > svn.txt &&
+	svn_cmd add svn.txt &&
+	svn_cmd ci -m "svn edit" &&
+	cd ../.. &&
+	git svn-fetch -v &&
+	git reset --hard svn/trunk &&
+	test_file svn.txt "bar" &&
+	echo "foo" > svn.txt &&
+	git commit -a -m "git edit" &&
+	git svn-push -v svn/trunk svn/trunk HEAD &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Trunk &&
+	test_svn_subject "git edit" &&
+	test_svn_subject "svn edit" PREV &&
+	test_file svn.txt "foo" &&
+	cd ../..
+'
+
+function svn_head() {
+	wd=`pwd` &&
+	cd svnco &&
+	cd "$1" &&
+	svn info | grep Revision | sed -e 's/Revision: *//g' &&
+	cd "$wd"
+}
+
+init_trunk_rev=`svn_head Trunk`
+init_trunk_path=Trunk
+
+test_expect_success 'create standalone branch' '
+	git symbolic-ref HEAD refs/heads/standalone &&
+	git rm -r --cached . &&
+	echo "bar" > file.txt &&
+	git add file.txt &&
+	rm svn.txt &&
+	git commit -a -m "init standalone" &&
+	git svn-push -v refs/remotes/svn/standalone $null_sha1 standalone &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/standalone &&
+	test_file file.txt "bar" &&
+	test_svn_subject "init standalone" &&
+	test_must_fail svn_cmd log PREV &&
+	cd ../../..
+'
+
+test_expect_success 'create branch' '
+	git checkout -b CreateBranch master &&
+	git svn-push -v refs/remotes/svn/CreateBranch $null_sha1 CreateBranch &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/CreateBranch &&
+	test_file file.txt "foo" &&
+	test_svn_subject "Create Branches/CreateBranch" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../..
+'
+
+init_trunk_rev=`svn_head Branches/CreateBranch`
+init_trunk_path=Branches/CreateBranch
+
+test_expect_success 'create and edit branch' '
+	git checkout -b CreateEditBranch master &&
+	echo "foo2" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "create/edit branch" &&
+	git svn-push -v refs/remotes/svn/CreateEditBranch $null_sha1 CreateEditBranch &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/CreateEditBranch &&
+	test_file file.txt "foo" &&
+	test_file file2.txt "foo2" &&
+	test_svn_subject "create/edit branch" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../..
+'
+
+test_expect_success 'create tag' '
+	git checkout master &&
+	git tag SimpleTag &&
+	git svn-push -v refs/tags/svn/SimpleTag $null_sha1 HEAD &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Tags/SimpleTag &&
+	test_file file.txt "foo" &&
+	test_svn_subject "Create Tags/SimpleTag" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../..
+'
+
+test_expect_success 'create annotated tag' '
+	git checkout master &&
+	git tag -m "annotate tag" AnnotatedTag &&
+	git svn-push -v refs/tags/svn/AnnotatedTag $null_sha1 AnnotatedTag &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Tags/AnnotatedTag &&
+	test_file file.txt "foo" &&
+	test_svn_subject "annotate tag" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../..
+'
+
+test_expect_success 'replace branch' '
+	git checkout -b ReplaceBranch master &&
+	echo "before replace" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "before replace" &&
+	before_sha1=`show_ref HEAD` &&
+	git svn-push -v refs/remotes/svn/ReplaceBranch $null_sha1 ReplaceBranch &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/ReplaceBranch &&
+	test_file file2.txt "before replace" &&
+	test_svn_subject "before replace" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../.. &&
+	git checkout master &&
+	git branch -D ReplaceBranch &&
+	git checkout -b ReplaceBranch master &&
+	echo "after replace" > file3.txt &&
+	git add file3.txt &&
+	git commit -a -m "after replace" &&
+	git svn-push -v svn/ReplaceBranch $before_sha1 ReplaceBranch &&
+	cd svnco/Branches/ReplaceBranch &&
+	svn_cmd up &&
+	test ! -e file2.txt &&
+	test_file file3.txt "after replace" &&
+	test_svn_subject "after replace" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../..
+'
+
+test_expect_success 'replace tag' '
+	git checkout -b temp master &&
+	echo "foo" > file3.txt &&
+	git add file3.txt &&
+	git commit -a -m "before replace tag" &&
+	old_sha1=`show_ref HEAD` &&
+	git tag ReplaceTag &&
+	git svn-push -v refs/tags/svn/ReplaceTag $null_sha1 ReplaceTag &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Tags/ReplaceTag &&
+	test_svn_subject "before replace tag" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../.. &&
+	git reset --hard master &&
+	echo "bar" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "after replace tag" &&
+	git tag -f ReplaceTag &&
+	git svn-push -v svn/ReplaceTag $old_sha1 ReplaceTag &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Tags/ReplaceTag &&
+	test_svn_subject "after replace tag" &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../.. &&
+	echo "bar2" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "dummy commit" &&
+	git tag -f -m "create replace tag" ReplaceTag &&
+	git svn-push -v svn/ReplaceTag HEAD~ ReplaceTag &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Tags/ReplaceTag &&
+	test_svn_subject "create replace tag" &&
+	test_svn_subject "after replace tag" PREV &&
+	cd ../../.. &&
+	git checkout master &&
+	git branch -D temp
+'
+
+test_expect_success 'delete branch' '
+	git checkout -b DeleteBranch master &&
+	git svn-push -v refs/remotes/svn/DeleteBranch $null_sha1 DeleteBranch &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/DeleteBranch &&
+	test_svn_subject "Create Branches/DeleteBranch" &&
+	cd ../../.. &&
+	git checkout master &&
+	git svn-push -v svn/DeleteBranch DeleteBranch $null_sha1 &&
+	git branch -D DeleteBranch &&
+	cd svnco &&
+	svn_cmd up &&
+	test ! -e Branches/DeleteBranch &&
+	cd ..
+'
+
+test_expect_success 'delete tag' '
+	git checkout master &&
+	git tag DeleteTag &&
+	git svn-push -v refs/tags/svn/DeleteTag $null_sha1 DeleteTag &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Tags/DeleteTag &&
+	test_svn_subject "Create Tags/DeleteTag" &&
+	cd ../../.. &&
+	git svn-push -v svn/DeleteTag DeleteTag $null_sha1 &&
+	git tag -d DeleteTag &&
+	cd svnco &&
+	svn_cmd up &&
+	test ! -e Tags/DeleteTag &&
+	cd ..
+'
+
+test_expect_success 'modify and create branch' '
+	git checkout -b MCBranch1 master &&
+	git svn-push -v refs/remotes/svn/MCBranch1 $null_sha1 MCBranch1 &&
+	cd svnco &&
+	svn_cmd up &&
+	cd .. &&
+	init_trunk_rev=`svn_head Branches/MCBranch1`
+	init_trunk_path=Branches/MCBranch1 &&
+	echo "bar" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "some modification on MCBranch1" &&
+	echo "$null_sha1 `show_ref HEAD` refs/remotes/svn/MCBranch2" >> cmds.txt &&
+	echo "`show_ref master` `show_ref HEAD` refs/remotes/svn/MCBranch1" >> cmds.txt &&
+	git svn-push -v --stdin < cmds.txt &&
+	rm -f cmds.txt &&
+	before_rev=`svn_head Branches/MCBranch1` &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/MCBranch1 &&
+	test_svn_subject "some modification on MCBranch1" &&
+	cd ../MCBranch2 &&
+	test_svn_subject "Create Branches/MCBranch2" &&
+	check_branched Branches/MCBranch1 $(($before_rev+1)) &&
+	cd ../../..
+'
+test_expect_success 'modify and replace branch' '
+	git checkout -b MRBranch1 master &&
+	echo "change" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "some modification on MRBranch1" &&
+	git svn-push -v refs/remotes/svn/MRBranch1 $null_sha1 MRBranch1 &&
+	git svn-push -v refs/remotes/svn/MRBranch2 $null_sha1 master &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/MRBranch1 &&
+	test_svn_subject "some modification on MRBranch1" &&
+	cd ../MRBranch2 &&
+	test_svn_subject "Create Branches/MRBranch2" &&
+	cd ../../.. &&
+	before_rev=`svn_head Branches/MRBranch2` &&
+	git checkout -b MRBranch2 master &&
+	echo "bar" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "some modification on MRBranch2" &&
+	echo "`show_ref MRBranch1` `show_ref MRBranch2` svn/MRBranch1" > cmds.txt &&
+	echo "`show_ref master` `show_ref MRBranch2` svn/MRBranch2" >> cmds.txt &&
+	git svn-push -v --stdin < cmds.txt &&
+	rm -f cmds.txt &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/MRBranch1 &&
+	test_svn_subject "Create Branches/MRBranch1" &&
+	check_branched Branches/MRBranch2 $(($before_rev+1)) &&
+	cd ../MRBranch2 &&
+	test_svn_subject "some modification on MRBranch2" &&
+	test_svn_subject "Create Branches/MRBranch2" PREV &&
+	check_branched $init_trunk_path $init_trunk_rev &&
+	cd ../../..
+'
+
+test_expect_success 'tag deleted branch' '
+	git checkout -b DeleteBranch master &&
+	echo "foo" > file2.txt &&
+	git add file2.txt &&
+	git commit -a -m "commit on deleted branch" &&
+	git svn-push -v refs/remotes/svn/DeleteBranch $null_sha1 HEAD &&
+	git tag TagOnDeleteBranch &&
+	git checkout master &&
+	git svn-push -v svn/DeleteBranch DeleteBranch $null_sha1 &&
+	git svn-push -v refs/tags/svn/TagOnDeleteBranch $null_sha1 TagOnDeleteBranch &&
+	cd svnco &&
+	svn_cmd up &&
+	test ! -e Branches/DeleteBranch &&
+	cd Tags/TagOnDeleteBranch &&
+	test_svn_subject "Create Tags/TagOnDeleteBranch" &&
+	test_must_fail svn_cmd log -r PREV --stop-on-copy &&
+	cd ../../.. &&
+	git branch -D DeleteBranch
+'
+
+test_expect_success 'push left merge' '
+	git checkout -b LeftLeft master &&
+	echo "left" > left.txt &&
+	git add left.txt &&
+	git commit -m "left" &&
+	git svn-push -v refs/remotes/svn/LeftMerged $null_sha1 HEAD &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/LeftMerged &&
+	prev_path=`svn_cmd log --stop-on-copy -v --xml | grep copyfrom-path | sed -re "s#.*copyfrom-path=\"([^\"]*)\".*#copyfrom-path=\"\1\"#g"` &&
+	prev_rev=`svn_cmd log --stop-on-copy -v --xml | grep copyfrom-rev | sed -re "s#.*copyfrom-rev=\"([^\"]*)\".*#copyfrom-rev=\"\1\"#g"` &&
+	echo prev_path $prev_path &&
+	echo prev_rev $prev_rev &&
+	cd ../../.. &&
+	git checkout -b LeftRight master &&
+	echo "right" > right.txt &&
+	git add right.txt &&
+	git commit -m "right" &&
+	git checkout LeftLeft &&
+	git merge --no-ff "merge commit" HEAD LeftRight &&
+	git svn-push -v svn/LeftMerged svn/LeftMerged LeftLeft &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/LeftMerged &&
+	test_file left.txt "left" &&
+	test_file right.txt "right" &&
+	test_svn_subject "merge commit" &&
+	test_svn_subject "left" PREV &&
+	svn_cmd log --stop-on-copy -v --xml | grep $prev_path &&
+	svn_cmd log --stop-on-copy -v --xml | grep $prev_rev &&
+	cd ../../..
+'
+
+test_expect_success 'push right merge' '
+	git checkout -b RightLeft master &&
+	echo "left" > left.txt &&
+	git add left.txt &&
+	git commit -m "left" &&
+	git svn-push -v refs/remotes/svn/RightMerged $null_sha1 HEAD &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/RightMerged &&
+	prev_path=`svn_cmd log --stop-on-copy -v --xml | grep copyfrom-path | sed -re "s#.*copyfrom-path=\"([^\"]*)\".*#copyfrom-path=\"\1\"#g"` &&
+	prev_rev=`svn_cmd log --stop-on-copy -v --xml | grep copyfrom-rev | sed -re "s#.*copyfrom-rev=\"([^\"]*)\".*#copyfrom-rev=\"\1\"#g"` &&
+	echo prev_path $prev_path &&
+	echo prev_rev $prev_rev &&
+	cd ../../.. &&
+	git checkout -b RightRight master &&
+	echo "right" > right.txt &&
+	git add right.txt &&
+	git commit -m "right" &&
+	git merge --no-ff "merge commit" HEAD RightLeft &&
+	git svn-push -v svn/RightMerged svn/RightMerged RightRight &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/RightMerged &&
+	test_svn_subject "merge commit" &&
+	test_svn_subject "left" PREV &&
+	svn_cmd log --stop-on-copy -v --xml | grep $prev_path &&
+	svn_cmd log --stop-on-copy -v --xml | grep $prev_rev &&
+	cd ../../..
+'
+
+test_expect_success 'unseen new commit in svn' '
+	cd svnco &&
+	svn_cmd cp Trunk Branches/Unseen &&
+	svn_cmd ci -m "make branch" &&
+	cd .. &&
+	git svn-fetch -v &&
+	cd svnco/Branches/Unseen &&
+	echo "foo" > unseen.txt &&
+	svn_cmd add unseen.txt &&
+	svn_cmd ci -m "unseen file" &&
+	cd ../../.. &&
+	git checkout -b unseen svn/Unseen &&
+	echo "bar" > seen.txt &&
+	git add seen.txt &&
+	git commit -m "seen file" &&
+	# This should push the commit and then fail, so after the fetch
+	# and rebase no push should be required
+	test_must_fail git svn-push -v svn/Unseen unseen~1 unseen &&
+	git svn-fetch -v &&
+	git rebase svn/Unseen &&
+	test `show_ref svn/Unseen` == `show_ref unseen` &&
+	cd svnco/Branches/Unseen &&
+	svn_cmd up &&
+	test_file unseen.txt "foo" &&
+	test_file seen.txt "bar" &&
+	cd ../../..
+'
+
+test_expect_success 'intermingled commits' '
+	git checkout -b intermingled svn/trunk &&
+	echo "bar" > file1.txt &&
+	git add file1.txt &&
+	git commit -m "commit 1" &&
+	echo "foo" > file2.txt &&
+	git add file2.txt &&
+	git commit -m "commit 2" &&
+	port=$(($SVNSERVE_PORT+1)) || exit 1
+	GIT_SVN_PUSH_PAUSE=$port git svn-push -v refs/remotes/svn/intermingled $null_sha1 HEAD &
+	push_pid=$! &&
+	until nc -z localhost $port; do sleep 1; done &&
+	cd svnco &&
+	svn_cmd up &&
+	cd Branches/intermingled &&
+	echo "foobar" > file3.txt &&
+	svn_cmd add file3.txt &&
+	svn_cmd ci -m "svn commit" &&
+	cd ../../.. &&
+	nc -z localhost $port &&
+	test_must_fail wait $push_pid &&
+	git svn-fetch -v &&
+	git rebase svn/intermingled &&
+	git svn-push -v svn/intermingled svn/intermingled HEAD &&
+	cd svnco &&
+	svn_cmd up &&
+	cd .. &&
+	rev=`svn_head Branches/intermingled` &&
+	cd svnco/Branches/intermingled &&
+	test_svn_subject "commit 2" $rev &&
+	test_svn_subject "svn commit" $(($rev-1)) &&
+	test_svn_subject "commit 1" $(($rev-2)) &&
+	cd ../../..
+'
+
+test_done
-- 
1.7.11.3
