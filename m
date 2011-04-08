From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/3] --dirstat-by-file: Make it faster and more correct
Date: Fri, 8 Apr 2011 16:50:49 +0200
Message-ID: <201104081650.49254.johan@herland.net>
References: <201104071549.37187.johan@herland.net> <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com> <201104081646.35750.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 16:52:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8D2q-00082w-U1
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 16:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332Ab1DHOwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 10:52:16 -0400
Received: from smtp.opera.com ([213.236.208.81]:47024 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418Ab1DHOwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 10:52:15 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p38EonVU008805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Apr 2011 14:50:49 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <201104081646.35750.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171126>

Currently, when using --dirstat-by-file, it first does the full --dirstat
analysis (using diffcore_count_changes()), and then resets 'damage' to 1,
if any damage was found by diffcore_count_changes().

But --dirstat-by-file is not interested in the file damage per se. It only
cares if the file changed at all. In that sense it only cares if the blob
SHA1 for a file has changed. Fortunately, determining which files have
changed is already done when we build the diff_queue, and by the time we
get to show_dirstat(), we know that each entry in the queue correspond to
a changed file. Therefore we can skip the entire --dirstat analysis and
simply set 'damage' to 1 for each entry in the diff queue.

This makes --dirstat-by-file faster, and also bypasses --dirstat's issues
with detecting changes that merely rearrange lines.

The patch also contains an added testcase verifying that --dirstat-by-file
now detects changes that only rearrange lines.

Signed-off-by: Johan Herland <johan@herland.net>
---

I hope someone with more intimate diffcore knowledge can verify that
the diff queue indeed never contains entries that should be considered
"unchanged" by --dirstat-by-file.


...Johan

 diff.c                                             |   21 +++++++++++++++----
 t/t4013-diff-various.sh                            |    2 +
 .../diff.diff_--dirstat-by-file_initial_rearrange  |    3 ++
 3 files changed, 21 insertions(+), 5 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat-by-file_initial_rearrange

diff --git a/diff.c b/diff.c
index 9fa8410..28d9293 100644
--- a/diff.c
+++ b/diff.c
@@ -1541,6 +1541,20 @@ static void show_dirstat(struct diff_options *options)
 
 		name = p->one->path ? p->one->path : p->two->path;
 
+		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE)) {
+			/*
+			 * In --dirstat-by-file mode, we're only interested in
+			 * whether the file changed _at_all_.
+			 * We don't need to look at the actual file contents.
+			 * Assuming that the diff queue does not contain
+			 * unchanged entries, we can unconditionally add this
+			 * file to the list of results (with each file
+			 * contributing equal damage).
+			 */
+			damage = 1;
+			goto found_damage;
+		}
+
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			diff_populate_filespec(p->one, 0);
 			diff_populate_filespec(p->two, 0);
@@ -1563,14 +1577,11 @@ static void show_dirstat(struct diff_options *options)
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
index 8cc94ef..e8240f2 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -302,6 +302,8 @@ diff master master^ side
 diff --dirstat master~1 master~2
 # --dirstat does NOT pick up changes that simply rearrange existing lines
 diff --dirstat initial rearrange
+# ...but --dirstat-by-file DOES pick up rearranged lines
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
1.7.5.rc1
