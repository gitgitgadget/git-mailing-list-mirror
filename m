From: Toby Allsopp <Toby.Allsopp@navman.co.nz>
Subject: [PATCH] Fix "stg branch --delete" on a nonexistent branch
Date: Thu, 14 Feb 2008 11:25:29 +1300
Message-ID: <87r6fgjwoi.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPQU5-0006oU-6T
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbYBMWxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 17:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYBMWxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:53:09 -0500
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:4320 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753301AbYBMWxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 17:53:07 -0500
Received: from AKLEXVS01.mitacad.com ([10.112.5.35]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 11:53:03 +1300
Received: from nav-akl-pcn-343.mitacad.com.navman.co.nz ([10.112.8.136]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 11:53:03 +1300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-OriginalArrivalTime: 13 Feb 2008 22:53:03.0152 (UTC) FILETIME=[30696300:01C86E93]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15728.000
X-TM-AS-Result: No--5.530200-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73826>

Before this patch, I get the following:

 $ stg branch --delete tmp
 Deleting branch "tmp" ... Traceback (most recent call last):
   File "/usr/bin/stg", line 43, in ?
     main()
   File "/var/lib/python-support/python2.4/stgit/main.py", line 281, in main
     command.func(parser, options, args)
   File "/var/lib/python-support/python2.4/stgit/commands/branch.py", line 190, in func
     __delete_branch(args[0], options.force)
   File "/var/lib/python-support/python2.4/stgit/commands/branch.py", line 100, in __delete_branch
     doomed.delete(force)
   File "/var/lib/python-support/python2.4/stgit/stack.py", line 758, in delete
     except GitException:
 NameError: global name 'GitException' is not defined

After it, I get:

 Deleting branch "tmp" ...
   Warning: Could not delete branch "tmp"
 done

Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>
---
 stgit/stack.py           |    2 +-
 t/t1005-branch-delete.sh |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 7fe9f2b..1f01295 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -661,7 +661,7 @@ class Series(PatchSet):
 
         try:
             git.delete_branch(self.get_name())
-        except GitException:
+        except git.GitException:
             out.warn('Could not delete branch "%s"' % self.get_name())
 
         config.remove_section('branch.%s' % self.get_name())
diff --git a/t/t1005-branch-delete.sh b/t/t1005-branch-delete.sh
index 00fc9eb..e061baf 100755
--- a/t/t1005-branch-delete.sh
+++ b/t/t1005-branch-delete.sh
@@ -19,6 +19,10 @@ test_expect_success 'Create a non-StGIT branch and delete it' '
     stg branch --delete bar
     '
 
+test_expect_success 'Delete a nonexistent branch' '
+   stg branch --delete bar
+   '
+
 test_expect_success 'Make sure the branch ref was deleted' '
     [ -z "$(git show-ref | grep master | tee /dev/stderr)" ]
     '
-- 
1.5.4.1.97.g40aab-dirty
