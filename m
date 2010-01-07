From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH (v2) 1/2] rebase: fix --onto A...B parsing and add tests
Date: Thu, 07 Jan 2010 20:05:02 +0900
Message-ID: <20100107200502.6117@nanako3.lavabit.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> <20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> <7vocl7yxef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 12:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSqAy-0006QB-Re
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 12:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0AGLFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 06:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172Ab0AGLFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 06:05:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56265 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab0AGLFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 06:05:07 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 9B44411BA3D;
	Thu,  7 Jan 2010 05:05:07 -0600 (CST)
Received: from 9668.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id IOF7O626JSO8; Thu, 07 Jan 2010 05:05:07 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=2bdS8fgzwXfcdZbGXKoNhLJ4WBCddYMk8FfvcOWOWoMM6/sEsl+Jm3a3uFEvX+O5PNnzCEXaPOCTKy1mI9Sb7dIj83pXwTkpsd8IOzJUCvc9YAIe8Ou6ruDh4KkwjoGOqKo54J4hhPX6eWYrbqeXfkbsyRO2Zxmu6Yltb0RxCl4=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vocl7yxef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136336>

The previous patch didn't parse "rebase --onto A...B" correctly when A
isn't an empty string. It also tried to be careful to notice a case in
which there are more than one merge bases, but forgot to give --all opt=
ion
to merge-base, making the test pointless.

=46ix these problems and add a test script to verify. Improvements to t=
he
script to parse A...B syntax was taken from review comments by Johannes
Schindelin.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 git-rebase.sh                    |   33 ++++++++++-------
 t/t3415-rebase-onto-threedots.sh |   75 ++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 94 insertions(+), 14 deletions(-)
 create mode 100755 t/t3415-rebase-onto-threedots.sh

diff --git a/git-rebase.sh b/git-rebase.sh
index 6503113..9bd8974 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -419,22 +419,27 @@ fi
=20
 # Make sure the branch to rebase onto is valid.
 onto_name=3D${newbase-"$upstream_name"}
-if	left=3D$(expr "$onto_name" : '\(.*\)\.\.\.') &&
-	right=3D$(expr "$onto_name" : '\.\.\.\(.*\)$') &&
-	: ${left:=3DHEAD} ${right:=3DHEAD} &&
-	onto=3D$(git merge-base "$left" "$right")
-then
-	case "$onto" in
-	?*"$LF"?*)
-		die "$onto_name: there are more than one merge bases"
-		;;
-	'')
+case "$onto_name" in
+*...*)
+	if	left=3D${onto_name%...*} right=3D${onto_name#*...} &&
+		onto=3D$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
+	then
+		case "$onto" in
+		?*"$LF"?*)
+			die "$onto_name: there are more than one merge bases"
+			;;
+		'')
+			die "$onto_name: there is no merge base"
+			;;
+		esac
+	else
 		die "$onto_name: there is no merge base"
-		;;
-	esac
-else
+	fi
+	;;
+*)
 	onto=3D$(git rev-parse --verify "${onto_name}^0") || exit
-fi
+	;;
+esac
=20
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
diff --git a/t/t3415-rebase-onto-threedots.sh b/t/t3415-rebase-onto-thr=
eedots.sh
new file mode 100755
index 0000000..da378c4
--- /dev/null
+++ b/t/t3415-rebase-onto-threedots.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description=3D'git rebase --onto A...B'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-rebase.sh"
+
+# Rebase only the tip commit of "topic" on merge base between "master"
+# and "topic".  Cannot do this for "side" with "master" because there
+# is no single merge base.
+#
+#
+#	    F---G topic                             G'
+#	   /                                       /
+# A---B---C---D---E master      -->       A---B---C---D---E
+#      \   \ /
+#	\   x
+#	 \ / \=20
+#	  H---I---J---K side
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	git branch side &&
+	test_commit C &&
+	git branch topic &&
+	git checkout side &&
+	test_commit H &&
+	git checkout master &&
+	test_tick &&
+	git merge H &&
+	git tag D &&
+	test_commit E &&
+	git checkout topic &&
+	test_commit F &&
+	test_commit G &&
+	git checkout side &&
+	test_tick &&
+	git merge C &&
+	git tag I &&
+	test_commit J &&
+	test_commit K
+'
+
+test_expect_success 'rebase --onto master...topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --onto master...topic F &&
+	git rev-parse HEAD^1 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --onto master...' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --onto master... F &&
+	git rev-parse HEAD^1 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --onto master...side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	test_must_fail git rebase --onto master...side J
+'
+
+test_done
--=20
1.6.6.53.g75f61




--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
