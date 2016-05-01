From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t5510: run auto-gc in the foreground
Date: Sun,  1 May 2016 17:37:43 +0200
Message-ID: <20160501153743.323-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 01 17:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awtWQ-0000Z8-9m
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 17:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcEAPiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 11:38:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39351 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467AbcEAPiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 11:38:06 -0400
Received: from x4db03e24.dyn.telefonica.de ([77.176.62.36] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1awtRY-0000gW-O8; Sun, 01 May 2016 17:38:02 +0200
X-Mailer: git-send-email 2.8.2.356.ge684b1d
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1462117082.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293194>

The last test added to 't5510-fetch' in 0898c9628104 (fetch: release
pack files before garbage-collecting, 2016-01-13) may sporadically
trigger following error message from the test harness:

  rm: cannot remove 'trash directory.t5510-fetch/auto-gc/.git': Directo=
ry not empty

The test in question forces an auto-gc, which, if the system supports
it, runs in the background by default, and occasionally takes long
enough for the test to finish and for 'test_done' to start
housekeeping.  This can lead to the test's 'git gc --auto' in the
background and 'test_done's 'rm -rf $trash' in the foreground racing
each other to create and delete files and directories.  It might just
happen that 'git gc' re-creates a directory that 'rm -rf' already
visited and removed, which ultimately triggers the above error.

Disable detaching the auto-gc process to ensure that it finishes
before the test can continue, thus avoiding this racy situation.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t5510-fetch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 38321d19efbe..454d896390c0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -682,6 +682,7 @@ test_expect_success 'fetching with auto-gc does not=
 lock up' '
 	(
 		cd auto-gc &&
 		git config gc.autoPackLimit 1 &&
+		git config gc.autoDetach false &&
 		GIT_ASK_YESNO=3D"$D/askyesno" git fetch >fetch.out 2>&1 &&
 		! grep "Should I try again" fetch.out
 	)
--=20
2.8.2.356.ge684b1d
