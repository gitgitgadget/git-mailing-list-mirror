From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/5] t5510: add tests for fetch --prune
Date: Sat, 15 Oct 2011 07:04:23 +0200
Message-ID: <1318655066-29001-3-git-send-email-cmn@elego.de>
References: <1318655066-29001-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 07:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REwQO-0001QL-PH
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab1JOFE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 01:04:28 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48769 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab1JOFE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:04:27 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc6671.pool.mediaWays.net [77.188.102.113])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 2AA224618C;
	Sat, 15 Oct 2011 07:03:58 +0200 (CEST)
Received: (nullmailer pid 29047 invoked by uid 1000);
	Sat, 15 Oct 2011 05:04:26 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318655066-29001-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183635>

The failures will be fixed in later commits.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5510-fetch.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 7e433b1..8b5e925 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -76,6 +76,56 @@ test_expect_success "fetch test for-merge" '
 	cut -f -2 .git/FETCH_HEAD >actual &&
 	test_cmp expected actual'
=20
+test_expect_success 'fetch --prune on its own works as expected' '
+	cd "$D" &&
+	git clone . prune &&
+	cd prune &&
+	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
+
+	git fetch --prune origin &&
+	test_must_fail git rev-parse origin/extrabranch
+'
+
+test_expect_failure 'fetch --prune with a branch name keeps branches' =
'
+	cd "$D" &&
+	git clone . prune-branch &&
+	cd prune-branch &&
+	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
+
+	git fetch --prune origin master &&
+	git rev-parse origin/extrabranch
+'
+
+test_expect_failure 'fetch --prune with a namespace keeps other namesp=
aces' '
+	cd "$D" &&
+	git clone . prune-namespace &&
+	cd prune-namespace &&
+
+	git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
+	git rev-parse origin/master
+'
+
+test_expect_failure 'fetch --prune --tags does not delete the remote-t=
racking branches' '
+	cd "$D" &&
+	git clone . prune-tags &&
+	cd prune-tags &&
+	git fetch origin refs/heads/master:refs/tags/sometag &&
+
+	git fetch --prune --tags origin &&
+	git rev-parse origin/master &&
+	test_must_fail git rev-parse somebranch
+'
+
+test_expect_failure 'fetch --prune --tags with branch does not delete =
other remote-tracking branches' '
+	cd "$D" &&
+	git clone . prune-tags-branch &&
+	cd prune-tags-branch &&
+	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
+
+	git fetch --prune --tags origin master &&
+	git rev-parse origin/extrabranch
+'
+
 test_expect_success 'fetch tags when there is no tags' '
=20
     cd "$D" &&
--=20
1.7.5.2.354.g349bf
