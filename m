From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/5] t7700-repack: add two new tests demonstrating repacking flaws
Date: Thu, 19 Mar 2009 22:47:50 -0500
Message-ID: <t_s5aa51o2kq_ePRWgLTEpak5ue1ZM7YICzIF-RsnmN68psiOC0Tnz9bsH5tTxgVEU0bxG-OtJ8@cipher.nrlssc.navy.mil>
References: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, drafnel@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVk8-000158-Ed
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbZCTDsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZCTDsP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:48:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60261 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbZCTDsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:48:12 -0400
Received: by mail.nrlssc.navy.mil id n2K3m6KR019885; Thu, 19 Mar 2009 22:48:07 -0500
In-Reply-To: <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2009 03:48:06.0465 (UTC) FILETIME=[ADA49310:01C9A90E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113887>

  1) The new --kept-pack-only mechansim of rev-list/pack-objects has
     replaced --unpacked=.  This new mechansim does not operate solely on
     "local" packs now.  The result is that objects residing in an alternate
     pack which has a .keep file will not be repacked with repack -a.

     This flaw is only apparent when a commit object is the one residing in
     an alternate kept pack.

  2) The 'repack unpacked objects' and 'loosen unpacked objects' mechanisms
     of pack-objects, i.e. --keep-unreachable and --unpack-unreachable,
     now do not operate solely on local packs.  The --keep-unreachable
     option no longer has any callers, but --unpack-unreachable is used when
     repack is called with '-A -d' and the local repo has existing packs.
     In this case, objects residing in alternate, not-kept packs will be
     loosened, and then immediately deleted by repack's call to
     prune-packed.

     The test must manually call pack-objects to avoid the call to
     prune-packed that is made by repack when -d is used.
---
 t/t7700-repack.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f5682d6..e869995 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -88,5 +88,49 @@ test_expect_failure 'packed obs in alt ODB are repacked when local repo has pack
 	done
 '
 
+test_expect_failure 'packed obs in alternate ODB kept pack are repacked' '
+	# swap the .keep so the commit object is in the pack with .keep
+	for p in alt_objects/pack/*.pack
+	do
+		base_name=$(basename $p .pack)
+		if test -f alt_objects/pack/$base_name.keep
+		then
+			rm alt_objects/pack/$base_name.keep
+		else
+			touch alt_objects/pack/$base_name.keep
+		fi
+	done
+	git repack -a -d &&
+	myidx=$(ls -1 .git/objects/pack/*.idx) &&
+	test -f "$myidx" &&
+	for p in alt_objects/pack/*.idx; do
+		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
+	done | while read sha1 rest; do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+			echo "Missing object in local pack: $sha1"
+			return 1
+		fi
+	done
+'
+
+test_expect_failure 'packed unreachable obs in alternate ODB are not loosened' '
+	rm -f alt_objects/pack/*.keep &&
+	mv .git/objects/pack/* alt_objects/pack/ &&
+	csha1=$(git rev-parse HEAD^{commit}) &&
+	git reset --hard HEAD^ &&
+	sleep 1 &&
+	git reflog expire --expire=now --expire-unreachable=now --all &&
+	# The pack-objects call on the next line is equivalent to
+	# git repack -A -d without the call to prune-packed
+	git pack-objects --honor-pack-keep --non-empty --all --reflog \
+	    --unpack-unreachable </dev/null pack &&
+	rm -f .git/objects/pack/* &&
+	mv pack-* .git/objects/pack/ &&
+	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
+		egrep "^$csha1 " | sort | uniq | wc -l) &&
+	echo > .git/objects/info/alternates &&
+	test_must_fail git show $csha1
+'
+
 test_done
 
-- 
1.6.2.16.geb16e
