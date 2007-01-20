From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] Problem with "stgit push" causing data loss
Date: Sat, 20 Jan 2007 16:01:13 +0100
Message-ID: <20070120150113.GB4665@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 20 16:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Hiy-0001Bk-1P
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 16:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbXATPBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 10:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbXATPBg
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 10:01:36 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:42260 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965263AbXATPBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 10:01:36 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 713904A077;
	Sat, 20 Jan 2007 16:01:32 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 491D21F07A; Sat, 20 Jan 2007 16:01:13 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37273>

Well, "data loss" is a bit strong, since the data is still available
to find using git-lost-found.

I first tried to reproduce with a simple test-case, but could not, so
here is my way to reproduce it, on a clone of the stgit official
workspace.

stgit$ stg branch --create test origin
Branch "test" created.

 The test patch is my previous work on "pull --to", now superceded
 by "rebase".  Patch to reproduce attached to this mail - I just use
 "pick" since it's easier for me:

stgit$ ./stg pick -n pull-to 9abaec589753ab190d378b534ceaa6a5af5d0dd3
Checking for changes in the working directory... done
Importing commit 9abaec589753ab190d378b534ceaa6a5af5d0dd3... done
Now at patch "pull-to"
stgit$ stg files pull-to
M stgit/commands/pull.py
A t/t2100-pull-to.sh

 Now move the testcase in a new patch below, using my
 stg-fold-files-from already sent to the list:

stgit$ stg pop
Popping patch "pull-to"... done
No patches applied
stgit$ stg new test -m test
stgit$ stg-fold-files-from pull-to 't/*'
Folding patch from stdin... done
stgit$ stg refresh
Refreshing patch "test"... done
stgit$ stg files
A t/t2100-pull-to.sh

 And then push the old file over that:

$ stg push
Pushing patch "pull-to"...
Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in ?
    main()
  File "/var/lib/python-support/python2.4/stgit/main.py", line 261, in main
    command.func(parser, options, args)
  File "/var/lib/python-support/python2.4/stgit/commands/push.py", line 101, in func
    push_patches(patches, options.merged)
  File "/var/lib/python-support/python2.4/stgit/commands/common.py", line 190, in push_patches
    modified = crt_series.push_patch(p)
  File "/var/lib/python-support/python2.4/stgit/stack.py", line 916, in push_patch
    git.merge(bottom, head, top)
  File "/var/lib/python-support/python2.4/stgit/git.py", line 535, in merge
    stages['2'][0], stages['3'][0]) != 0:
  File "/var/lib/python-support/python2.4/stgit/gitmergeonefile.py", line 203, in merge
    print >> sys.stderr, \
TypeError: not all arguments converted during string formatting

 State of things now:

stgit$ stg status
? t/t2100-pull-to.sh.current
? t/t2100-pull-to.sh.patched
M stgit/commands/pull.py
stgit$ diff t/t2100-pull-to.sh.*; echo $?
0
stgit$ stg files pull-to
stgit$ stg top
test

 As you can see, the pull-to patch is now in a situation that's not
 obvious to untangle by hand.  Also "stg push -m" exhibits the same
 issue.

Best regards,
-- 
Yann.
