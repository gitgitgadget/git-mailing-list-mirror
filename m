From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 5/6] repack: do not fall back to incremental repacking with [-a|-A]
Date: Wed, 12 Nov 2008 11:59:06 -0600
Message-ID: <WFmMnhNsYRw3IUD8hZk59At-5jc1rZU5GaB35sb1epRZ6zwd7IMw9V94SQyEliIEyriM4J5j3AM@cipher.nrlssc.navy.mil>
References: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Bod6u3kdkWtabbRw1_B1XS8U8eP3drqEMEsFa_-Q_Qu-xrbOsLcdzo@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Ll3-y-Spr-gg7enTTiJoZ2xRB8K4w13wAlZBhI9MXJqCLarfq3OODE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59PVSBNnWW0Ot3Am0gtsYesn_-APZGMYcRjOXaJqcBZo4pwvAKF-s_s0@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 19:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K1I-0002R5-MX
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYKLR7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYKLR7g
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:59:36 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50121 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYKLR7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:59:33 -0500
Received: by mail.nrlssc.navy.mil id mACHxHgo019943; Wed, 12 Nov 2008 11:59:17 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59PVSBNnWW0Ot3Am0gtsYesn_-APZGMYcRjOXaJqcBZo4pwvAKF-s_s0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Nov 2008 17:59:17.0622 (UTC) FILETIME=[618CB160:01C944F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100789>

When repack is called with either the -a or -A option, the user has
requested to repack all objects including those referenced by the
alternates mechanism. Currently, if there are no local packs without
.keep files, then repack will call pack-objects with the
'--unpacked --incremental' options which causes it to exclude alternate
packed objects. So, remove this fallback.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-repack.sh |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 8bb2201..4d313d1 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -71,13 +71,10 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-	fi
-	if test -z "$args"
-	then
-		args='--unpacked --incremental'
-	elif test -n "$unpack_unreachable"
-	then
-		args="$args $unpack_unreachable"
+		if test -n "$args" -a -n "$unpack_unreachable"
+		then
+			args="$args $unpack_unreachable"
+		fi
 	fi
 	;;
 esac
-- 
1.6.0.3.552.g12334
