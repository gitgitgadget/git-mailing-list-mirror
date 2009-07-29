From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: [PATCH v2] Demonstrate bugs when a directory is replaced with a
 symlink
Date: Wed, 29 Jul 2009 10:48:11 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:50:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWDGO-0005Lh-0Y
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 19:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbZG2RsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 13:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZG2RsR
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 13:48:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:33031 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZG2RsQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 13:48:16 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 29 Jul 2009 10:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,289,1246863600"; 
   d="scan'208";a="536963542"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2009 10:47:51 -0700
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx601.amr.corp.intel.com ([10.2.121.193]) with mapi; Wed, 29 Jul 2009
 10:48:13 -0700
Thread-Topic: [PATCH v2] Demonstrate bugs when a directory is replaced with
 a symlink
Thread-Index: AcoQJ0ZwApSLgiTtTISb1ql6yzXO4AARkt9AAAGD0dA=
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124375>

This test creates two directories, a/b and a/b-2, then replaces a/b with
a symlink to a/b-2, then merges that change into another branch that
contains an unrelated change.

There are two bugs:
1. 'git checkout' wrongly deletes work tree file a/b-2/d.
2. 'git merge' wrongly deletes work tree file a/b-2/d.

The test goes on to create another branch in which a/b-2 is replaced
with a symlink to a/b (i.e., the reverse of what was done the first
time), and merge it with the "unrelated changes" branch.

There's another bug:
3. Since the changes are unrelated, the merge should be clean, but git
   reports a conflict.

Note that using the resolve strategy instead of recursive makes the
second bug go away, but not the third one.

Signed-off-by: James Pickens <james.e.pickens@intel.com>
---
This version combines the two tests into one, and cleans up between steps
so that the early failures don't affect the later tests.

This time I include the bare minimum commands inside the
test_expect_failure calls, which seems like the right thing to do, since
the other commands are expected to "succeed" (exit code of 0).

BTW I'm sending this patch using 'git format-patch' + Outlook instead of
'git send-email'; apologies if it gets botched.

 t/t6035-merge-dir-to-symlink.sh |   49 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100755 t/t6035-merge-dir-to-symlink.sh

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
new file mode 100755
index 0000000..94a9f32
--- /dev/null
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='merging when a directory was replaced with a symlink'
+. ./test-lib.sh
+
+test_expect_success 'setup a merge where dir a/b changed to symlink' '
+       mkdir -p a/b/c a/b-2/c &&
+       > a/b/c/d &&
+       > a/b-2/c/d &&
+       > a/x &&
+       git add -A &&
+       git commit -m base &&
+       rm -rf a/b &&
+       ln -s b-2 a/b &&
+       git add -A &&
+       git commit -m "dir to symlink" &&
+       git checkout -b temp HEAD^
+'
+
+test_expect_failure 'checkout should not have deleted a/b-2/c/d' '
+       test -f a/b-2/c/d
+'
+
+test_expect_success 'clean the work tree and do the merge' '
+       git reset --hard &&
+       test -f a/b-2/c/d &&
+       echo x > a/x &&
+       git add a/x &&
+       git commit -m x &&
+       git merge master
+'
+
+test_expect_failure 'merge should not have deleted a/b-2/c/d' '
+       test -f a/b-2/c/d
+'
+
+test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
+       git checkout -f -b temp2 master^ &&
+       rm -rf a/b-2 &&
+       ln -s b a/b-2 &&
+       git add -A &&
+       git commit -m "dir a/b-2 to symlink"
+'
+
+test_expect_failure 'merge should not have conflicts' '
+       git merge temp
+'
+
+test_done
--
1.6.2.5
