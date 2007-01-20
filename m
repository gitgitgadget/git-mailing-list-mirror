From: Yann Dirson <ydirson@altern.org>
Subject: Re: [BUG] Problem with "stgit push" causing data loss
Date: Sat, 20 Jan 2007 16:09:49 +0100
Message-ID: <20070120150949.GB4684@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070120150113.GB4665@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 20 16:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8HrR-0003Ew-1U
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 16:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbXATPKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 10:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXATPKM
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 10:10:12 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37687 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965284AbXATPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 10:10:10 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 19D1F9B64F;
	Sat, 20 Jan 2007 16:10:09 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id E53F41F07A; Sat, 20 Jan 2007 16:09:49 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070120150113.GB4665@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37274>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 20, 2007 at 04:01:13PM +0100, Yann Dirson wrote:
>  The test patch is my previous work on "pull --to", now superceded
>  by "rebase".  Patch to reproduce attached to this mail

Well... to *this* mail indeed :}

--G4iJoqBmSsgzjUCe
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="pull-to.patch"

commit 9abaec589753ab190d378b534ceaa6a5af5d0dd3
Author: Yann Dirson <ydirson@altern.org>
Date:   Wed Jan 17 22:11:58 2007 +0100

    Pull to arbitrary commit

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 7c5db22..865bfd6 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -42,7 +42,9 @@ options = [make_option('-n', '--nopush',
                        action = 'store_true'),
            make_option('-m', '--merged',
                        help = 'check for patches merged upstream',
-                       action = 'store_true')]
+                       action = 'store_true'),
+           make_option('--to', metavar = 'COMMITID',
+                       help = 'move the stack base to COMMITID')]
 
 def func(parser, options, args):
     """Pull the changes from a remote repository
@@ -78,10 +80,15 @@ def func(parser, options, args):
         crt_series.pop_patch(applied[0])
         print 'done'
 
-    # pull the remote changes
-    print 'Pulling from "%s"...' % repository
-    git.pull(repository, refspec)
-    print 'done'
+    # FIXME: check git_id/rev_parse(options.to) first and maybe try to fetch if not found
+    if options.to:
+        print 'Rebasing to "%s"...' % options.to
+        git.move_branch(options.to)
+    else:
+        # pull the remote changes
+        print 'Pulling from "%s"...' % repository
+        git.pull(repository, refspec)
+        print 'done'
 
     # push the patches back
     if not options.nopush:
diff --git a/t/t2100-pull-to.sh b/t/t2100-pull-to.sh
new file mode 100755
index 0000000..0bf5f16
--- /dev/null
+++ b/t/t2100-pull-to.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Yann Dirson
+#
+
+test_description='Test the "pull --to" command.'
+
+. ./test-lib.sh
+
+# don't need this repo, but better not drop it, see t1100
+#rm -rf .git
+
+# Need a repo to clone
+test_create_repo foo
+
+test_expect_success \
+    'Setup and clone tree, and setup changes' \
+    'cd foo &&
+      stg init && stg new patch -m . &&
+      printf "a\nb\n" > file && stg add file && stg refresh &&
+      cd .. &&
+     stg clone foo bar &&
+     cd bar &&
+      stg new p1 -m p1 &&
+      echo "c" > file2 && stg add file2 && stg refresh &&
+      cd .. &&
+     cp -a bar bar2
+'
+
+test_expect_success \
+    'Modify original stack' \
+    '(cd foo && echo "c" >> file && stg refresh)'
+
+#test_debug bash
+#test_done
+
+#test_debug "cd foo && gitk --all && cd .."
+
+test_expect_success \
+    'Pull without --to' \
+    '(cd bar &&
+     a=$(git rev-parse HEAD) &&
+     stg pull &&
+     test "$a" == $(git rev-parse HEAD))'
+
+#test_debug "cd bar && gitk --all && cd .."
+
+test_expect_success \
+    'Pull with --to' \
+    '(cd bar2 &&
+     a=$(git rev-parse HEAD) &&
+     git fetch origin +refs/heads/master:refs/heads/origin &&
+     stg pull --to origin &&
+     test "$a" != $(git rev-parse HEAD) )'
+
+test_debug "cd bar2 && gitk --all && cd .."
+
+test_done

--G4iJoqBmSsgzjUCe--
