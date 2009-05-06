From: Eduardo Habkost <ehabkost@raisama.net>
Subject: Bug: 'git am --abort' can silently reset the wrong branch
Date: Wed, 6 May 2009 16:19:46 -0300
Message-ID: <20090506191945.GG6325@blackpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 21:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1mg3-00051k-6x
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 21:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZEFTVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 15:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZEFTVA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 15:21:00 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:59925 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbZEFTU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 15:20:59 -0400
Received: from homiemail-a4.g.dreamhost.com (caiajhbdcaib.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 43D8C1864A8
	for <git@vger.kernel.org>; Wed,  6 May 2009 12:21:03 -0700 (PDT)
Received: from blackpad.localdomain (201.22.55.145.dynamic.adsl.gvt.net.br [201.22.55.145])
	by homiemail-a4.g.dreamhost.com (Postfix) with ESMTP id DFEB34161C
	for <git@vger.kernel.org>; Wed,  6 May 2009 12:19:51 -0700 (PDT)
Received: by blackpad.localdomain (Postfix, from userid 500)
	id 3588467E7D6; Wed,  6 May 2009 16:19:46 -0300 (BRT)
Content-Disposition: inline
X-Fnord: you can see the fnord
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118373>

Hi,

I've ben bitten by this multiple times, while maintaining a multi-branch
repository. 'git am --abort' can drop the whole history of a branch, if you
switch branches before running it. Below are the steps to reproduce the
problem:

[foo/branch1]$ git --version
git version 1.6.3.rc4.29.g8146

I have two branches, with distinct changes:

[foo/branch1]$ git diff branch1 branch2
diff --git a/file.txt b/file.txt
index e8a7b03..a11bf50 100644
--- a/file.txt
+++ b/file.txt
@@ -1,2 +1,2 @@
 initial content
-branch1 content, version 1
+branch2 content. lots of changes here. version 12345.
[foo/branch1]$ git status
# On branch branch1
nothing to commit (working directory clean)
[foo/branch1]$


I receive a patch and try to apply it to branch1:

[foo/branch1]$ git am /tmp/patch.patch
Applying: patch to be applied
fatal: corrupt patch at line 13
Patch failed at 0001 patch to be applied
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
[foo/branch1]$

(Seeing that solving this conflict will take some time. I go out to grab some
coffee).

(When back to work, somebody asks me to take a look on patch2.patch, that
applies to branch2).

[foo/branch1]$ git checkout branch2
Switched to branch 'branch2'
[foo/branch2]$ git am /tmp/patch2.patch
previous rebase directory /tmp/foo/.git/rebase-apply still exists but mbox given.
[foo/branch2]$


(Oh, I see. There was a pending 'git am' operation. Let's just cancel it, I can
start it again later anyway).

Here is where "git am" silently does the wrong thing:

[foo/branch2]$ git am --abort
[foo/branch2]$ cat file.txt
initial content
branch1 content, version 1
[foo/branch2]$

(Hey! where are the changes from branch2?)

[foo/branch2]$ git diff branch1 branch2
[foo/branch2]$

Ouch.   :(


When that happens, I need to resort to git reflog, and manually git-reset
branch2 to point to the original commit.

I don't know what would be the best approach to avoid this issue. I tested a
similar scenario using 'git rebase' and 'git rebase --abort' switched back to
branch1 before resetting the branch state, instead of resetting branch2. Maybe
'git am' could do the same.

-- 
Eduardo
