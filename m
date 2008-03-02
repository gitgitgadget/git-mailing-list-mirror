From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 10/10] Additional tests to capture worktree special cases
Date: Sun, 2 Mar 2008 17:35:43 +0700
Message-ID: <20080302103543.GA9028@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlYR-0003hH-4u
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYCBKfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYCBKfu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:35:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:48037 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYCBKft (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:35:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6064633wah.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=vVJrcZ0x6gB5H+qHWtUn9tCRN7cm8lwesi3hanF5Ix8=;
        b=bZsa5a/n6tsFEfBC9FYmiWZojG9ZV9Iw/3q3lCgWhk0izgTZXUdz0lga2P7QevYlxyLyp6hztImgPWth1aMWH/au8kJpuHTzD6bzTiwFUpeGJW5LHKtchFEfhUm0wD/W/ejIdWLYTIWFTdBUDtsfQ3zE5NjvOl/FGRWmkeykBK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=gp9RVTyFzvEcDznQW8FbygSD4Z3VvzyZJct+SP5bx6zT2bM00c3lqC4UktbR9/FXklB2xXP7yS5mczW4AXVWhdmyxHn9BATN/wgqi8GMF4dIHsQmWdu9Mase0o/LeZ8LQqIIhKtYn9wTHktEYJkJHlixIK74jqzkMUPCwdHDRtI=
Received: by 10.114.37.1 with SMTP id k1mr3141585wak.6.1204454149346;
        Sun, 02 Mar 2008 02:35:49 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id k37sm18491580waf.55.2008.03.02.02.35.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:35:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:35:43 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75771>

Most of them are for setup_git_directory_gently() commands
as those are likely to break.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1501-worktree.sh |   57 +++++++++++++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7ee3820..a53c1f5 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -47,7 +47,19 @@ export GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
-say "core.worktree =3D absolute path"
+say "core.worktree =3D absolute path with GIT_DIR unset"
+mkdir -p $(pwd)/repo.git/work/sub/dir || exit 1
+unset GIT_DIR
+export GIT_CONFIG=3D$(pwd)/repo.git/config
+git config core.worktree "$(pwd)/repo.git/work"
+test_rev_parse 'outside'      false false false
+cd repo.git/work || exit 1
+test_rev_parse 'inside'       false true true ''
+cd sub/dir || exit 1
+test_rev_parse 'subdirectory' false true true sub/dir/
+cd ../../../.. || exit 1
+
+say "core.worktree =3D absolute path with GIT_DIR set"
 export GIT_DIR=3D$(pwd)/repo.git
 export GIT_CONFIG=3D$GIT_DIR/config
 git config core.worktree "$(pwd)/work"
@@ -58,6 +70,47 @@ cd sub/dir || exit 1
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
+test_expect_success '"git ls-files -o" gets correct prefix' '
+	(cd work/sub && touch untracked &&
+	test "$(git ls-files -o)" =3D untracked)'
+
+rm work/sub/untracked || exit 1
+
+cat <<EOF >expected
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	sub/tracked
+EOF
+
+cat <<EOF >expected2
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	tracked
+EOF
+
+test_expect_success '"git diff-files" gets correct prefix' '
+	(cd work/sub  && touch tracked &&
+	git add tracked && echo modified > tracked &&
+	git diff-files > ../../result &&
+	git diff-files --relative > ../../result2 &&
+	git rm -f tracked) &&
+	cmp result expected &&
+	cmp result2 expected2'
+
+cat <<EOF >expected
+:100644 100644 e69de29... 0000000... M	sub/tracked
+EOF
+
+cat <<EOF >expected2
+:100644 100644 e69de29... 0000000... M	tracked
+EOF
+
+
+test_expect_success '"git diff" gets correct prefix' '
+	(cd work/sub  && touch tracked &&
+	git add tracked && echo modified > tracked &&
+	git diff --raw > ../../result &&
+	git diff --raw --relative > ../../result2 &&
+	git rm -f tracked) &&
+	cmp result expected &&
+	cmp result2 expected2'
+
 say "GIT_WORK_TREE=3Drelative path (override core.worktree)"
 export GIT_DIR=3D$(pwd)/repo.git
 export GIT_CONFIG=3D$GIT_DIR/config
@@ -103,7 +156,7 @@ test_expect_success 'repo finds its work tree from =
work tree, too' '
 	 test sub/dir/tracked =3D "$(git ls-files)")
 '
=20
-test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE'=
 '
+test_expect_success '"git diff" setup worktree properly' '
 	cd repo.git/work/sub/dir &&
 	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
 		git diff --exit-code tracked &&
--=20
1.5.4.2.281.g28d0e
