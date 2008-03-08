From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Sat, 8 Mar 2008 17:36:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081726450.19665@iabervon.org>
References: <20080304115940.GA5260@sigill.intra.peff.net> <alpine.LFD.1.00.0803081417040.5896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7f9-0008Gc-8a
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYCHWg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYCHWg1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:36:27 -0500
Received: from iabervon.org ([66.92.72.58]:37454 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbYCHWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:36:26 -0500
Received: (qmail 16913 invoked by uid 1000); 8 Mar 2008 22:36:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 22:36:25 -0000
In-Reply-To: <alpine.LFD.1.00.0803081417040.5896@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76597>

On Sat, 8 Mar 2008, Linus Torvalds wrote:

> On Tue, 4 Mar 2008, Jeff King wrote:
> >
> > I am tracking down a bug in unpack_trees, but I can't seem to find the
> > exact problem; I'm hoping to get help from people who have touched this
> > code a bit more than I have.
> 
> Ok, so I decided that I should now finally go back and look at the 
> original bug-report that triggered my unpack-trees rewrite, now that it's 
> in a form where I feel like I can actually look at the code and fix the 
> problem..
> 
> I'd love to say that I know what the original bug was, but since I 
> couldn't fix it in the first place because I couldn't read the original 
> code, I can't really say what fixed it.

The original bug was that the position in the index being modified in 
place got messed up by core code that discarded unnecessary REMOVE entries 
for files in a d/f conflicting directory without reporting how many were 
removed so that the iteration could compensate. Cleaning up the code may 
or may not have fixed it, but using separate indices would make it really 
hard to retain the bug.

> Jeff's test-script appended just for people who can't find the original 
> message that started this all.

Here it is as an actual test case:

----------
commit f9eef3140fedaa10842d433e6fbf67f6b914712c
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Wed Mar 5 15:50:36 2008 -0500

    Add a test for read-tree -u --reset working despite df conflicts
    
    From an email by Jeff King <peff@peff.net>
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
new file mode 100755
index 0000000..f1b1216
--- /dev/null
+++ b/t/t1005-read-tree-reset.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='read-tree -u --reset'
+
+. ./test-lib.sh
+
+# two-tree test
+
+test_expect_success 'setup' '
+  git init &&
+  mkdir df &&
+  echo content >df/file &&
+  git add df/file &&
+  git commit -m one &&
+  git ls-files >expect &&
+  rm -rf df &&
+  echo content >df &&
+  git add df &&
+  echo content >new &&
+  git add new &&
+  git commit -m two
+'
+
+test_expect_failure 'reset should work' '
+  git read-tree -u --reset HEAD^ &&
+  git ls-files >actual &&
+  diff -u expect actual
+'
+
+test_done
