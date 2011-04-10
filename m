From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 3/3] Teach --dirstat to not completely ignore rearranged
 lines within a file
Date: Mon, 11 Apr 2011 00:48:52 +0200
Message-ID: <1302475732-741-4-git-send-email-johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:50:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q93SM-0006tP-Pp
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015Ab1DJWt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 18:49:57 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49105 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750Ab1DJWty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 18:49:54 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG004JOKR55670@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:53 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 58A401EF0058_DA23411B	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:53 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1BA371EEFF88_DA23411F	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:53 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG00KXIKQDX600@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:53 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1302475732-741-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171296>

Currently, the --dirstat analysis fails to detect when lines within a
file are rearranged, because the "damage" calculated by show_dirstat()
is 0. However, if the SHA1 sum has changed, we already now that there
should be at least some minimum amount of damage.

This patch teaches show_dirstat() to assign a minimum amount of damage
(== 1) to entries for which the analysis otherwise yields zero damage.
Obviously this is not a complete fix, but it's at least better to
underrepresent these changes, rather than simply pretending that they
don't exist.

Also, with the added SHA1 comparison, we can safely skip the --dirstat
analysis when the SHA1s do happen to match (e.g. for a pure file rename)

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/diff-options.txt                |    4 ++--
 diff.c                                        |   19 ++++++++++++++++++-
 t/t4013-diff-various.sh                       |    2 --
 t/t4013/diff.diff_--dirstat_initial_rearrange |    1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 23772d6..7e4bd42 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -74,8 +74,8 @@ endif::git-format-patch[]
 	counted for the parent directory, unless `--cumulative` is used.
 +
 Note that the `--dirstat` option computes the changes while ignoring
-pure code movements within a file.  In other words, rearranging lines
-in a file is not counted as a change.
+the amount of pure code movements within a file.  In other words,
+rearranging lines in a file is not counted as much as other changes.
 
 --dirstat-by-file[=<limit>]::
 	Same as `--dirstat`, but counts changed files instead of lines.
diff --git a/diff.c b/diff.c
index a224048..3e0bc1f 100644
--- a/diff.c
+++ b/diff.c
@@ -1547,6 +1547,16 @@ static void show_dirstat(struct diff_options *options)
 		else
 			content_changed = 1;
 
+		if (!content_changed) {
+			/*
+			 * The SHA1 has not changed, so pre-/post-content is
+			 * identical. We can therefore skip looking at the
+			 * file contents altogether.
+			 */
+			damage = 0;
+			goto found_damage;
+		}
+
 		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE)) {
 			/*
 			 * In --dirstat-by-file mode, we don't really need to
@@ -1555,7 +1565,7 @@ static void show_dirstat(struct diff_options *options)
 			 * add this file to the list of results
 			 * (with each file contributing equal damage).
 			 */
-			damage = content_changed ? 1 : 0;
+			damage = 1;
 			goto found_damage;
 		}
 
@@ -1582,8 +1592,15 @@ static void show_dirstat(struct diff_options *options)
 		 * Original minus copied is the removed material,
 		 * added is the new material.  They are both damages
 		 * made to the preimage.
+		 * If the resulting damage is zero, we know that
+		 * diffcore_count_changes() considers the two entries to
+		 * be identical, but since content_changed is true, we
+		 * know that there must have been _some_ kind of change,
+		 * so we force all entries to have damage > 0.
 		 */
 		damage = (p->one->size - copied) + added;
+		if (!damage)
+			damage = 1;
 
 found_damage:
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6428a90..93a6f20 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -300,9 +300,7 @@ diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
 diff master master^ side
 diff --dirstat master~1 master~2
-# --dirstat doesn't notice changes that simply rearrange existing lines
 diff --dirstat initial rearrange
-# ...but --dirstat-by-file does notice changes that only rearrange lines
 diff --dirstat-by-file initial rearrange
 EOF
 
diff --git a/t/t4013/diff.diff_--dirstat_initial_rearrange b/t/t4013/diff.diff_--dirstat_initial_rearrange
index fb2e17d..5fb02c1 100644
--- a/t/t4013/diff.diff_--dirstat_initial_rearrange
+++ b/t/t4013/diff.diff_--dirstat_initial_rearrange
@@ -1,2 +1,3 @@
 $ git diff --dirstat initial rearrange
+ 100.0% dir/
 $
-- 
1.7.5.rc1.3.g4d7b
