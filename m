From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Thu, 07 Jan 2010 20:05:09 +0900
Message-ID: <20100107200509.6117@nanako3.lavabit.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> <20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> <7vocl7yxef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 12:05:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSqBM-0006Wn-Sd
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 12:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0AGLFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 06:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178Ab0AGLFO
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 06:05:14 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56272 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0AGLFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 06:05:13 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 01DB911BA19;
	Thu,  7 Jan 2010 05:05:13 -0600 (CST)
Received: from 9668.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id UO9EJV5NTE5Z; Thu, 07 Jan 2010 05:05:12 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=UkR/qa4mRFFhwhaN/hNmaKoABzk7APc4yF9uvx1rpeZtbuPjzP1S5m4q81sz/PDIv5RNFI4uDVvSJ7UViVJ2aDPHHSejugz/mkZYVxcdUgIgI3B/qhTRfr3YqPmM4hAO05n6eZxP2cdln/iT5jSrfAOJmLm1BsFYkp1SUk8BvYI=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vocl7yxef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136338>

When rewriting commits on a topic branch, sometimes it is easier to
compare the version of commits before and after the rewrite if they are
based on the same commit that forked from the upstream. An earlier comm=
it
by Junio (fixed up by the previous commit) gives "--onto A...B" syntax =
to
rebase command, and rebases on top of the merge base between A and B;
teach the same to the interactive version, too.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 git-rebase--interactive.sh       |   21 ++++++++++++++++++++-
 t/t3415-rebase-onto-threedots.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..f7ae02c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -482,6 +482,25 @@ get_saved_options () {
 	test -f "$DOTEST"/rebase-root && REBASE_ROOT=3Dt
 }
=20
+LF=3D'
+'
+parse_onto () {
+	case "$1" in
+	*...*)
+		if	left=3D${1%...*} right=3D${1#*...} &&
+			onto=3D$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
+		then
+			case "$onto" in
+			?*"$LF"?* | '')
+				exit 1 ;;
+			esac
+			echo "$onto"
+			exit 0
+		fi
+	esac
+	git rev-parse --verify "$1^0"
+}
+
 while test $# !=3D 0
 do
 	case "$1" in
@@ -589,7 +608,7 @@ first and then run 'git rebase --continue' again."
 		;;
 	--onto)
 		shift
-		ONTO=3D$(git rev-parse --verify "$1") ||
+		ONTO=3D$(parse_onto "$1") ||
 			die "Does not point to a valid commit: $1"
 		;;
 	--)
diff --git a/t/t3415-rebase-onto-threedots.sh b/t/t3415-rebase-onto-thr=
eedots.sh
index da378c4..5e7eb88 100755
--- a/t/t3415-rebase-onto-threedots.sh
+++ b/t/t3415-rebase-onto-threedots.sh
@@ -72,4 +72,34 @@ test_expect_success 'rebase --onto master...side' '
 	test_must_fail git rebase --onto master...side J
 '
=20
+test_expect_success 'rebase -i --onto master...topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+	set_fake_editor &&
+	EXPECT_COUNT=3D1 git rebase -i --onto master...topic F &&
+	git rev-parse HEAD^1 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --onto master...' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+	set_fake_editor &&
+	EXPECT_COUNT=3D1 git rebase -i --onto master... F &&
+	git rev-parse HEAD^1 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --onto master...side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	test_must_fail git rebase -i --onto master...side J
+'
+
 test_done
--=20
1.6.6.53.g75f61




--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
