From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/5] pack-objects: only repack or loosen objects residing in "local" packs
Date: Thu, 19 Mar 2009 22:47:52 -0500
Message-ID: <t_s5aa51o2kq_ePRWgLTEvwR8O51ATzGH2_NEfAeCgOx3i1IYGfgLg3-dTPOh68RhaeQgBB9s2g@cipher.nrlssc.navy.mil>
References: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEpak5ue1ZM7YICzIF-RsnmN68psiOC0Tnz9bsH5tTxgVEU0bxG-OtJ8@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEg6KbvKii55gDA1y-1oKgx9KP4EKyrqg8sDFaph97G5MPoLgUx_vx48@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, drafnel@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVk7-000158-2T
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbZCTDsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbZCTDsN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:48:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60262 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbZCTDsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:48:12 -0400
Received: by mail.nrlssc.navy.mil id n2K3m6KV019885; Thu, 19 Mar 2009 22:48:07 -0500
In-Reply-To: <t_s5aa51o2kq_ePRWgLTEg6KbvKii55gDA1y-1oKgx9KP4EKyrqg8sDFaph97G5MPoLgUx_vx48@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2009 03:48:06.0652 (UTC) FILETIME=[ADC11BC0:01C9A90E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113888>

These two features were invented for use by repack when repack will delete
the local packs that have been made redundant.  The packs accessible
through alternates are not deleted by repack, so the objects contained in
them are still accessible after the local packs are deleted.  They do not
need to be repacked into the new pack or loosened.  For the case of
loosening they would immediately be deleted by the subsequent prune-packed
that is called by repack anyway.

This fixes the test
'packed unreachable obs in alternate ODB are not loosened' in t7700.
---
 builtin-pack-objects.c |    4 ++--
 t/t7700-repack.sh      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 1c6d2c4..22d69ef 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1966,7 +1966,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		const unsigned char *sha1;
 		struct object *o;
 
-		if (p->pack_keep)
+		if (!p->pack_local || p->pack_keep)
 			continue;
 		if (open_pack_index(p))
 			die("cannot open pack index");
@@ -2002,7 +2002,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	const unsigned char *sha1;
 
 	for (p = packed_git; p; p = p->next) {
-		if (p->pack_keep)
+		if (!p->pack_local || p->pack_keep)
 			continue;
 
 		if (open_pack_index(p))
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1242c9d..31e6d22 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -113,7 +113,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	done
 '
 
-test_expect_failure 'packed unreachable obs in alternate ODB are not loosened' '
+test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f alt_objects/pack/*.keep &&
 	mv .git/objects/pack/* alt_objects/pack/ &&
 	csha1=$(git rev-parse HEAD^{commit}) &&
-- 
1.6.2.16.geb16e
