From: Anton <Anton.Sharonov@gmail.com>
Subject: rebase failure if commit message looks like a patch
Date: Tue, 27 Jan 2009 17:50:43 +0000 (UTC)
Message-ID: <loom.20090127T173025-125@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 18:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsAx-0003Lp-J8
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZA0RzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbZA0RzI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:55:08 -0500
Received: from main.gmane.org ([80.91.229.2]:53820 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbZA0RzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:55:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LRs9O-00081d-7t
	for git@vger.kernel.org; Tue, 27 Jan 2009 17:55:02 +0000
Received: from cpe90-146-243-234.liwest.at ([90.146.243.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:55:02 +0000
Received: from Anton.Sharonov by cpe90-146-243-234.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 90.146.243.234 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107372>

I have found a strange behaviour of "git rebase", present in following versions:

git 1.6.1, linux,
git 1.6.0.4, cygwin

if the commit message of one of revisions on local branch
containing something, what looks like patch:

------------------ bad-commit-message { ---------------
changeset a1 - feature added

--- a0  2009-01-25 10:09:05.953125000 +0100
+++ ./r/a       2009-01-25 10:15:20.093750000 +0100
@@ -1,5 +1,5 @@
-1
+1 - upstream
 2
 3
 4
-5
+5 - feature
------------------ bad-commit-message } ---------------

Following shell script reproduces the bug for me:

------------------ show-bug.sh { ---------------
#!/bin/bash
rm -rf r # clean-up
mkdir r # repo dir
cd r
git init
cd ..
cp a0 r/a
cd r
git add a
git ci -m "initial addition of a0"
git br feature
git co feature
cd ..
cp a1 r/a
cd r
git add a
## no bug
#git ci -m "changeset a1 - feature added"
# bug
git ci -F ../bad-commit-message
git co master
cd ..
cp a2 r/a
cd r
git add a
git ci -m "changeset a2 - upstream revision"
git co feature
git rebase master
------------------ show-bug.sh } ---------------

produces the error on final rebase attempt:

First, rewinding head to replay your work on top of it...
Applying: changeset a1 - feature added
error: r/a: does not exist in index
fatal: sha1 information is lacking or useless (r/a).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

In case one uses
# no bug
git ci -m "changeset a1 - feature added"
instead of
# bug
git ci -F ../bad-commit-message

The final rebase succeded !

Content of other files:

---------------- a0 { -------------------
1
2
3
4
5
---------------- a0 } -------------------

---------------- a1 { -------------------
1
2
3
4
5 - feature
---------------- a1 } -------------------

---------------- a2 { -------------------
1 - upstream
2
3
4
5
---------------- a2 } -------------------

-- 
Anton
