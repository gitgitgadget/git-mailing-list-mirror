From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/6] repack: don't repack local objects in packs with .keep file
Date: Wed, 12 Nov 2008 11:59:05 -0600
Message-ID: <WFmMnhNsYRw3IUD8hZk59PVSBNnWW0Ot3Am0gtsYesn_-APZGMYcRjOXaJqcBZo4pwvAKF-s_s0@cipher.nrlssc.navy.mil>
References: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Bod6u3kdkWtabbRw1_B1XS8U8eP3drqEMEsFa_-Q_Qu-xrbOsLcdzo@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Ll3-y-Spr-gg7enTTiJoZ2xRB8K4w13wAlZBhI9MXJqCLarfq3OODE@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 19:00:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K1H-0002R5-0l
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYKLR7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbYKLR7c
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:59:32 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50118 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbYKLR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:59:31 -0500
Received: by mail.nrlssc.navy.mil id mACHxHUE019934; Wed, 12 Nov 2008 11:59:17 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59Ll3-y-Spr-gg7enTTiJoZ2xRB8K4w13wAlZBhI9MXJqCLarfq3OODE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Nov 2008 17:59:17.0528 (UTC) FILETIME=[617E5980:01C944F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100788>

If the user created a .keep file for a local pack, then it can be inferred
that the user does not want those objects repacked.

This fixes the repack bug tested by t7700.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-repack.sh     |    2 +-
 t/t7700-repack.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index d39eb6c..8bb2201 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -83,7 +83,7 @@ case ",$all_into_one," in
 esac
 
 args="$args $local $quiet $no_reuse$extra"
-names=$(git pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+names=$(git pack-objects --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$names" ]; then
 	if test -z "$quiet"; then
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 7aaff0b..356afe3 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -4,7 +4,7 @@ test_description='git repack works correctly'
 
 . ./test-lib.sh
 
-test_expect_failure 'objects in packs marked .keep are not repacked' '
+test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 > file1 &&
 	echo content2 > file2 &&
 	git add . &&
-- 
1.6.0.3.552.g12334
