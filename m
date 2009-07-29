From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: [PATCH v3] Demonstrate bugs when a directory is replaced with a
 symlink
Date: Wed, 29 Jul 2009 14:02:39 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 23:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWGIT-00033l-SX
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 23:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbZG2VCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZG2VCl
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 17:02:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:54764 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbZG2VCl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 17:02:41 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 29 Jul 2009 13:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,290,1246863600"; 
   d="scan'208";a="712258895"
Received: from azsmsx602.amr.corp.intel.com ([10.2.121.201])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2009 14:05:54 -0700
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx602.amr.corp.intel.com ([10.2.121.201]) with mapi; Wed, 29 Jul 2009
 14:02:41 -0700
Thread-Topic: [PATCH v3] Demonstrate bugs when a directory is replaced with
 a symlink
Thread-Index: AcoQeu6GEDHhYnYaQDShlUFk1w34TQAFL5ug
In-Reply-To: <7v63dbuyru.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124389>

This test creates two directories, a/b and a/b-2, then replaces a/b with
a symlink to a/b-2, then merges that change into the 'baseline' commit,
which contains an unrelated change.

There are two bugs:
1. 'git checkout' incorrectly deletes work tree file a/b-2/d.
2. 'git merge' incorrectly deletes work tree file a/b-2/d.

The test goes on to create another branch in which a/b-2 is replaced
with a symlink to a/b (i.e., the reverse of what was done the first
time), and merge it into the 'baseline' commit.

There is a different bug:
3. The merge should be clean, but git reports a conflict.

Signed-off-by: James Pickens <james.e.pickens@intel.com>
---

Ok, one more try.  I added Junio's latest feedback, and also added more checks
for correct merge results after each merge.  For the merges that incorrectly
report conflicts, those checks won't be executed since the conflict stops the
test.  If/when the bug causing the merge conflict is fixed, it will become
important to check the merge results, so those checks might as well be there
from the beginning.

 t/t6035-merge-dir-to-symlink.sh |   76 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100755 t/t6035-merge-dir-to-symlink.sh

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
new file mode 100755
index 0000000..89e8e6a
--- /dev/null
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='merging when a directory was replaced with a symlink'
+. ./test-lib.sh
+
+test_expect_success 'create a commit where dir a/b changed to symlink' '
+       mkdir -p a/b/c a/b-2/c &&
+       > a/b/c/d &&
+       > a/b-2/c/d &&
+       > a/x &&
+       git add -A &&
+       git commit -m base &&
+       git tag start &&
+       rm -rf a/b &&
+       ln -s b-2 a/b &&
+       git add -A &&
+       git commit -m "dir to symlink" &&
+       git checkout start^0
+'
+
+test_expect_failure 'checkout should not have deleted a/b-2/c/d' '
+       test -f a/b-2/c/d
+'
+
+test_expect_success 'setup for merge test' '
+       git reset --hard &&
+       test -f a/b-2/c/d &&
+       echo x > a/x &&
+       git add a/x &&
+       git commit -m x &&
+       git tag baseline
+'
+
+test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
+       git reset --hard &&
+       git checkout baseline^0 &&
+       git merge -s resolve master &&
+       test -h a/b &&
+       test -f a/b-2/c/d
+'
+
+test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
+       git reset --hard &&
+       git checkout baseline^0 &&
+       git merge -s recursive master &&
+       test -h a/b &&
+       test -f a/b-2/c/d
+'
+
+test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
+       git reset --hard &&
+       git checkout start^0 &&
+       rm -rf a/b-2 &&
+       ln -s b a/b-2 &&
+       git add -A &&
+       git commit -m "dir a/b-2 to symlink" &&
+       git tag test2
+'
+
+test_expect_failure 'merge should not have conflicts (resolve)' '
+       git reset --hard &&
+       git checkout baseline^0 &&
+       git merge -s resolve test2 &&
+       test -h a/b-2 &&
+       test -f a/b/c/d
+'
+
+test_expect_failure 'merge should not have conflicts (recursive)' '
+       git reset --hard &&
+       git checkout baseline^0 &&
+       git merge -s recursive test2 &&
+       test -h a/b-2 &&
+       test -f a/b/c/d
+'
+
+test_done
--
1.6.2.5
