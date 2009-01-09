From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t7700: demonstrate misbehavior of 'repack -a' when local packs exist
Date: Fri,  9 Jan 2009 16:14:39 -0600
Message-ID: <rjZ2Q9koCqY3UL6iGB8a-6LSgDb7keG498cZLN5piAaXDVuhlLM0Jhi-Qkjb7AimF_xZvap4QIk@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 23:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLPeL-0006Ro-OB
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 23:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313AbZAIWOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbZAIWOw
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 17:14:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53144 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182AbZAIWOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 17:14:51 -0500
Received: by mail.nrlssc.navy.mil id n09MEnTi004127; Fri, 9 Jan 2009 16:14:49 -0600
X-OriginalArrivalTime: 09 Jan 2009 22:14:49.0405 (UTC) FILETIME=[AFF69ED0:01C972A7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105043>

The ability to "...fatten [the] local repository by packing everything that
is needed by the local ref into a single new pack, including things that are
borrowed from alternates"[1] is supposed to be provided by the '-a' or '-A'
options to repack when '-l' is not used, but there is a flaw.  For each
pack in the local repository without a .keep file, repack supplies a
--unpacked=<pack> argument to pack-objects.

The --unpacked option to pack-objects, with or without an argument, causes
pack-objects to ignore any object which is packed in a pack not mentioned
in an argument to --unpacked=.  So, if there are local packs, and
'repack -a' is called, then any objects which reside in packs accessible
through alternates will _not_ be packed.  If there are no local packs, then
no --unpacked argument will be supplied, and repack will behave as expected.

[1] http://mid.gmane.org/7v8wrwidi3.fsf@gitster.siamese.dyndns.org

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


FYI: I won't be looking in to a fix for this immediately. So if someone else
     has time and the inclination, please be my guest. Also, you can thank a
     transformer blow, and lots of disk loss for the discovery of this bug.

-brandon


 t/t7700-repack.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 3f602ea..f5682d6 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -69,5 +69,24 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	done
 '
 
+test_expect_failure 'packed obs in alt ODB are repacked when local repo has packs' '
+	rm -f .git/objects/pack/* &&
+	echo new_content >> file1 &&
+	git add file1 &&
+	git commit -m more_content &&
+	git repack &&
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
 test_done
 
-- 
1.6.1.76.gc123b
