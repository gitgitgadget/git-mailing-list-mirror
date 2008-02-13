From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH] new test: rev-list --cherry-pick excludes an empty commit against a superseding merge
Date: Wed, 13 Feb 2008 11:10:13 +0100
Message-ID: <1202897413-7762-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
References: <20080213092910.GA20219@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 11:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEaQ-00077t-Ti
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764276AbYBMKKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 05:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764152AbYBMKKW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:10:22 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:32538 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763150AbYBMKKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:10:18 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-3.tower-164.messagelabs.com!1202897416!11373290!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 27204 invoked from network); 13 Feb 2008 10:10:16 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-3.tower-164.messagelabs.com with SMTP; 13 Feb 2008 10:10:16 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 04:10:16 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 04:10:15 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 11:10:13 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id BF4CB1B23F; Wed, 13 Feb 2008 11:10:13 +0100 (CET)
X-Mailer: git-send-email 1.5.4
In-Reply-To: <20080213092910.GA20219@digi.com>
X-OriginalArrivalTime: 13 Feb 2008 10:10:14.0025 (UTC) FILETIME=[9FE2D790:01C86E28]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15726.002
X-TM-AS-Result: No--12.636300-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73765>

Currently rev-list --cherry-pick kicks out two commits if they introduc=
e the
same change to their first parent and ignores other parents.  This can =
be bad
if both sides used the ours strategy to supersede old development branc=
hes.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
 t/t6007-rev-list-cherry-pick-file.sh |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

Hello,

I'm not sure if combined diff is the right term.  I'm open for a better
one.

Moreover I'm not happy with the shortlog, maybe someone has a better
suggestion?

diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-ch=
erry-pick-file.sh
index 4b8611c..26f62e1 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -29,7 +29,13 @@ test_expect_success setup '
 	git checkout branch foo &&
 	test_tick &&
 	git commit -m "B" &&
-	git tag B
+	git tag B &&
+	test_tick &&
+	git checkout -b emptymerge A &&
+	git merge --no-ff -s ours master branch &&
+	test_tick &&
+	git checkout -b empty A &&
+	git commit --allow-empty -m empty
 '
=20
 test_expect_success '--cherry-pick foo comes up empty' '
@@ -54,4 +60,10 @@ test_expect_success '--cherry-pick with independent,=
 but identical branches' '
 		HEAD...master -- foo)"
 '
=20
+# don't kick out commits c1, c2 with diff c1 c1^ =3D=3D diff c2 c2^ bu=
t=20
+# with different combined diffs
+test_expect_failure '--cherry-pick with a superseding merge and an emp=
ty commit' '
+	test "4" =3D=3D "$(git rev-list --cherry-pick empty...emptymerge | wc=
 -l)"
+'
+
 test_done
--=20
1.5.4
