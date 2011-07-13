From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 8/9] svn-fe: import incrementally in svn-remote-alpha
Date: Wed, 13 Jul 2011 21:26:52 +0600
Message-ID: <1310570813-16648-9-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1LC-0002iX-Ow
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab1GMP0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab1GMP0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:44 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2112126eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ho+L8dv6hxkF/9iK4/fcwRNUZTbWvj1Q9R9bzvXQSEE=;
        b=jfEcieYckZsTPMOR7uj6IYVrLPZaAnXGjELGmT+xItPwVh8kf/14Tgxp2dXDgsd1yA
         ndYds0F7ugCkvXgSxlbQ/YjOKlVkDaibrIChqEinxA0fC2Wz7XSj7VDPC18uEVRvTzK9
         SRqGh3wTEYJ1mY42jBRV4dwPO/rr/E5wljLfw=
Received: by 10.213.114.73 with SMTP id d9mr9030ebq.74.1310570802166;
        Wed, 13 Jul 2011 08:26:42 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177049>

svn-remote-alpha already maintains commits tree imported from svn
and a mapping to the original svn revision numbers as notes content.
svn-fe --incremental requires import marks from previous revisions.

Just generate import marks from notes on each import. This is cheap
on small repositories, fine for a few tests.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha        |   57 +++++++++++++++++++++-
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |   72 ++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index c2af393..f4e737d 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -57,9 +57,60 @@ SVNDUMP=${SVNDUMP:-`try_svnrdump`}
 SVNDUMP=${SVNDUMP:-`try_svnadmin`}
 test -n "$SVNDUMP" || die "neither svnrdump nor svnadmin & svnlook was found"
 
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
+	mkdir -p "$git_dir/$marks_dir"
+	if test ! -f "$git_dir/$marks_dir/marks"; then
+		touch "$git_dir/$marks_dir/marks"
+	fi
+	if test "$rev" = "-1"; then
+		return 0
+	fi
+	do_gen_marks "$notes" >"$git_dir/$marks_dir/marks"
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
 do_import () {
 	revs=$1 url=$2 dst=$3 notes=$4
-	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --notes_ref="$notes" --no-progress) 3<&0 || die "FAILURE"
+	rev=$(last_imported_rev "$dst" "$notes")
+	start_rev=$(($rev + 1))
+	revs="$start_rev:HEAD"
+	prepare_marks $dst $notes $rev
+	echo "feature import-marks=$git_dir/$marks_dir/marks"
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --notes-ref="$notes" --incremental --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
@@ -78,11 +129,15 @@ do
 	case $cmd in
 	capabilities)
 		echo import
+		echo gitdir
 		echo "refspec HEAD:$private_ref"
 		echo "refspec $remote_ref:$private_ref"
 		echo "refspec $remote_notes:$private_notes"
 		echo
 		;;
+	gitdir)
+		git_dir="$args"
+		;;
 	list)
 		echo "? HEAD"
 		echo "? $remote_ref"
diff --git a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
index 5102428..9d9aca0 100755
--- a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -276,4 +276,76 @@ test_expect_success SMALL_SVN 'fetch SMALL writes revnum notes' '
 	test_cmp expect.note actual.note
 '
 
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
 test_done
-- 
1.7.3.4
