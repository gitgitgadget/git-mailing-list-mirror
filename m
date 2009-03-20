From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/5] git-repack.sh: don't use --kept-pack-only option to pack-objects
Date: Thu, 19 Mar 2009 22:47:51 -0500
Message-ID: <t_s5aa51o2kq_ePRWgLTEg6KbvKii55gDA1y-1oKgx9KP4EKyrqg8sDFaph97G5MPoLgUx_vx48@cipher.nrlssc.navy.mil>
References: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEpak5ue1ZM7YICzIF-RsnmN68psiOC0Tnz9bsH5tTxgVEU0bxG-OtJ8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, drafnel@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVk6-000158-Ct
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbZCTDsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZCTDsN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:48:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60260 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZCTDsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:48:12 -0400
Received: by mail.nrlssc.navy.mil id n2K3m6KT019885; Thu, 19 Mar 2009 22:48:07 -0500
In-Reply-To: <t_s5aa51o2kq_ePRWgLTEpak5ue1ZM7YICzIF-RsnmN68psiOC0Tnz9bsH5tTxgVEU0bxG-OtJ8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2009 03:48:06.0543 (UTC) FILETIME=[ADB079F0:01C9A90E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113886>

The --kept-pack-only option to pack-objects treats all kept packs as equal.
This results in objects that reside in an alternate pack that has a .keep
file, not being packed into a newly created pack when the user specifies the
-a option to repack.  Since the user may not have any control over the
alternate database, git should not refrain from repacking those objects
even though they are in a pack with a .keep file.

This fixes the 'packed obs in alternate ODB kept pack are repacked' test in
t7700.
---
 git-repack.sh     |    6 +-----
 t/t7700-repack.sh |    2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 0144c2d..1782a23 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -71,11 +71,7 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-		if test -n "$existing"
-		then
-			args="--kept-pack-only"
-		fi
-		if test -n "$args" -a -n "$unpack_unreachable" -a \
+		if test -n "$existing" -a -n "$unpack_unreachable" -a \
 			-n "$remove_redundant"
 		then
 			args="$args $unpack_unreachable"
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index e869995..1242c9d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -88,7 +88,7 @@ test_expect_failure 'packed obs in alt ODB are repacked when local repo has pack
 	done
 '
 
-test_expect_failure 'packed obs in alternate ODB kept pack are repacked' '
+test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	# swap the .keep so the commit object is in the pack with .keep
 	for p in alt_objects/pack/*.pack
 	do
-- 
1.6.2.16.geb16e
