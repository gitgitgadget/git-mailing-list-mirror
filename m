From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] merge-recursive: cause a conflict if file mode does not
	match
Date: Thu, 13 Mar 2008 20:22:46 +0100
Message-ID: <20080313192246.GA30361@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:23:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZt1b-0005eV-8G
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 20:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYCMTW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 15:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYCMTWz
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 15:22:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1401 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbYCMTWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 15:22:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so531029ugc.16
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 12:22:53 -0700 (PDT)
Received: by 10.67.26.7 with SMTP id d7mr1807660ugj.23.1205436172950;
        Thu, 13 Mar 2008 12:22:52 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.96.248])
        by mx.google.com with ESMTPS id 25sm2392812ugn.23.2008.03.13.12.22.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 12:22:52 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JZt0o-0000Td-OQ; Thu, 13 Mar 2008 20:22:46 +0100
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803131607030.1656@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77132>

Previously, mismatching file modes would be auto-merged by picking the
mode in the remote tree.

This also fixes a bug which caused merge-recursive to fail if the merged
files were empty.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi Dscho,

Your patch certainly fixes a bug in git-merge-file. It does not fix the bug in
git-merge-recursive, however. The test script also fails with your patch.

On Thu, Mar 13, 2008 at 04:19:35PM +0100, Johannes Schindelin wrote:
> On Sat, Mar 08, 2008 at 06:17:26PM +0100, Clemens Buchacher wrote:
> > One could argue that it would be better to mark the mismatching 
> > permissions as a conflict.
> 
> Right you are.  Your whole "it still is xdl_merge()s fault" point was just 
> contradicted by your own analysis.  Calling xdl_merge() when the sha1 does 
> _not_ differ is _a mistake_.  _That_ is the bug.

Alright, fixed in the appended patch.

Regards,
Clemens

 merge-recursive.c          |    9 +++++++--
 t/t6031-merge-recursive.sh |   23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100755 t/t6031-merge-recursive.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 34e3167..01918a7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1028,9 +1028,14 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
 			result.merge = 1;
 
-		result.mode = a->mode == o->mode ? b->mode: a->mode;
+		if (!o->mode) {
+			if (a->mode != b->mode)
+				result.clean = 0;
+			result.mode = b->mode;
+		} else
+			result.mode = a->mode == o->mode ? b->mode: a->mode;
 
-		if (sha_eq(a->sha1, o->sha1))
+		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, o->sha1))
 			hashcpy(result.sha, b->sha1);
 		else if (sha_eq(b->sha1, o->sha1))
 			hashcpy(result.sha, a->sha1);
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
new file mode 100755
index 0000000..7ea371e
--- /dev/null
+++ b/t/t6031-merge-recursive.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='merge-recursive corner cases'
+. ./test-lib.sh
+
+test_expect_success 'merge empty files with different permission flags' '
+	: >dummy &&
+	git add dummy &&
+	git commit -m "initial commit" &&
+	git checkout -b a master &&
+	: >a &&
+	git add a &&
+	git commit -m "branch a" &&
+	git checkout -b b master &&
+	: >a &&
+	chmod +x a &&
+	git add a &&
+	git commit -m "branch b" &&
+	git checkout master &&
+	! (git merge-recursive master -- a b || test $? -ne 1)
+'
+
+test_done
-- 
1.5.4.4.2.gd2fe
