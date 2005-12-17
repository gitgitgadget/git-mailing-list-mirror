From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH] Fix git-am --skip
Date: Sat, 17 Dec 2005 01:01:06 -0500
Message-ID: <20051217060106.GS30531@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 07:03:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnV8H-0006P8-AA
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 07:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVLQGBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 01:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVLQGBM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 01:01:12 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:58536 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1751018AbVLQGBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 01:01:11 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1EnV7y-0004gY-00; Sat, 17 Dec 2005 01:01:06 -0500
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13770>

git-am --skip does not unpack the next patch and ends up reapplying the
old patch, believing that it is the new patch in the sequence.

If the old patch applied successfully it will commit it with the
supposedly skipped log message and ends up dropping the following patch.
If the patch did not apply the user is left with the conflict he tried
to skip and has to unpack the next patch in the sequence by hand to get
git-am back on track.

By clearing the resume variable whenever skips bumps the sequence
counter we correctly unpack the next patch. I also added another
resume= in the case a patch file is missing from the sequence to
avoid the same problem when a file in the sequence was removed.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>

---

 git-am.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

5cfce3a48e6a6cf08caa5fae990eeeaf08154921
diff --git a/git-am.sh b/git-am.sh
index 1a114bc..731ab1f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -211,6 +211,7 @@ this=`cat "$dotest/next"`
 if test "$skip" = t
 then
 	this=`expr "$this" + 1`
+	resume=
 fi
 
 if test "$this" -gt "$last"
@@ -225,6 +226,7 @@ do
 	msgnum=`printf "%0${prec}d" $this`
 	next=`expr "$this" + 1`
 	test -f "$dotest/$msgnum" || {
+		resume=
 		go_next
 		continue
 	}
-- 
0.99.9.GIT
