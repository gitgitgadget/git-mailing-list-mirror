From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 2/3] --dirstat-by-file: Make it faster and more correct
Date: Mon, 11 Apr 2011 00:48:51 +0200
Message-ID: <1302475732-741-3-git-send-email-johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:49:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q93S9-0006jo-U7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 00:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab1DJWtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 18:49:53 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49096 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757872Ab1DJWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 18:49:52 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG004JEKR35670@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:51 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 761181EEFEC8_DA2340FB	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:51 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3E8021EEFD31_DA2340FF	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:51 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG00KXIKQDX600@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:51 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1302475732-741-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171295>

Currently, when using --dirstat-by-file, it first does the full --dirstat
analysis (using diffcore_count_changes()), and then resets 'damage' to 1,
if any damage was found by diffcore_count_changes().

But --dirstat-by-file is not interested in the file damage per se. It only
cares if the file changed at all. In that sense it only cares if the blob
SHA1 for a file has changed. We therefore only need to compare the SHA1s
of each file pair in the diff queue. As a result, we can skip the entire
--dirstat analysis and simply set 'damage' to 1 for each entry where the
SHA1 has changed.

This makes --dirstat-by-file faster, and also bypasses --dirstat's practice
of ignoring rearranged lines within a file.

The patch also contains an added testcase verifying that --dirstat-by-file
now detects changes that only rearrange lines within a file.

Signed-off-by: Johan Herland <johan@herland.net>
---
 diff.c                                             |   25 ++++++++++++++++----
 t/t4013-diff-various.sh                            |    2 +
 .../diff.diff_--dirstat-by-file_initial_rearrange  |    3 ++
 3 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat-by-file_initial_rearrange

diff --git a/diff.c b/diff.c
index 9fa8410..a224048 100644
--- a/diff.c
+++ b/diff.c
@@ -1538,9 +1538,27 @@ static void show_dirstat(struct diff_options *options)
 		struct diff_filepair *p = q->queue[i];
 		const char *name;
 		unsigned long copied, added, damage;
+		int content_changed;
 
 		name = p->one->path ? p->one->path : p->two->path;
 
+		if (p->one->sha1_valid && p->two->sha1_valid)
+			content_changed = hashcmp(p->one->sha1, p->two->sha1);
+		else
+			content_changed = 1;
+
+		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE)) {
+			/*
+			 * In --dirstat-by-file mode, we don't really need to
+			 * look at the actual file contents at all.
+			 * The fact that the SHA1 changed is enough for us to
+			 * add this file to the list of results
+			 * (with each file contributing equal damage).
+			 */
+			damage = content_changed ? 1 : 0;
+			goto found_damage;
+		}
+
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			diff_populate_filespec(p->one, 0);
 			diff_populate_filespec(p->two, 0);
@@ -1563,14 +1581,11 @@ static void show_dirstat(struct diff_options *options)
 		/*
 		 * Original minus copied is the removed material,
 		 * added is the new material.  They are both damages
-		 * made to the preimage. In --dirstat-by-file mode, count
-		 * damaged files, not damaged lines. This is done by
-		 * counting only a single damaged line per file.
+		 * made to the preimage.
 		 */
 		damage = (p->one->size - copied) + added;
-		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE) && damage > 0)
-			damage = 1;
 
+found_damage:
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
 		dir.files[dir.nr].name = name;
 		dir.files[dir.nr].changed = damage;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3b1b392..6428a90 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -302,6 +302,8 @@ diff master master^ side
 diff --dirstat master~1 master~2
 # --dirstat doesn't notice changes that simply rearrange existing lines
 diff --dirstat initial rearrange
+# ...but --dirstat-by-file does notice changes that only rearrange lines
+diff --dirstat-by-file initial rearrange
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff_--dirstat-by-file_initial_rearrange b/t/t4013/diff.diff_--dirstat-by-file_initial_rearrange
new file mode 100644
index 0000000..e48e33f
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat-by-file_initial_rearrange
@@ -0,0 +1,3 @@
+$ git diff --dirstat-by-file initial rearrange
+ 100.0% dir/
+$
-- 
1.7.5.rc1.3.g4d7b
