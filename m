From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: BUG: git rebase -i -p silently looses commits
Date: Mon, 2 Nov 2009 19:18:07 +0300
Message-ID: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4zcI-00017B-DO
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 17:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbZKBQSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755749AbZKBQSG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:18:06 -0500
Received: from mail-qy0-f174.google.com ([209.85.221.174]:49006 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbZKBQSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 11:18:03 -0500
Received: by qyk4 with SMTP id 4so2544977qyk.33
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=jFv2eJVcKgM9vjk+wEUrxwijux1deaZzvdYgJyKRHwg=;
        b=RbkdTwV3x2uETbZNdnc+fMWNJZaccEUd8FsiqQSAVj6ncsfQc7kjo+/YupYsKV/9b+
         5rO83yeLZZJ7cJEV7q41vnZkYhlUs9i7fzHXLK37arrG4EnoThN0Sh1MDAP/05QVGv4Q
         7Hju6MHh3+SNI7ghuHGsjsh+OBAAvHe+RcSwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=riCEE4zEeLhV9C20L/r4vJViXPaoUcfQwvwr2TEZbsGmJwUwAJHVHJ13CAFPxMuqYV
         I2L/ygbG912oU3y4pVV/DvWiwSGqBC9XOt2GO+NFhKQ0YIf4MgHsy6ERn9kVT20oMyc2
         YN72yGeDDpfprdtGZoDyZL+G6C9HRAxRypRHY=
Received: by 10.239.139.158 with SMTP id t30mr593325hbt.94.1257178687446; Mon, 
	02 Nov 2009 08:18:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131921>

I have encountered what looks like critical bugs in the git rebase -i
-p (it can be reproduced on mingw and cygwin, I have not tried other
platforms).

Let's create a git repository with

git init
# the next line is for mingw
git config core.autocrlf input
echo a >a.txt
echo b >b.txt
git add a.txt b.txt
git commit -m "init commit"
echo aa >a.txt
git add a.txt
git commit -m "aa commit"
echo bb >b.txt
git add b.txt
git commit -m "bb commit"
echo aaa >a.txt
git add a.txt
git commit -m "aaa commit"

Now let's use the following rebase command:

git rebase -i -p HEAD~3

When the editor will appear, just move the commit "bb commit" to the
end of the list. The rebase process will complete successfully, but
commit "aaa commit" will be missing from the history and working tree
will not be affected by that commit.

Other bug is that if we move "bb commit" to the top of the list in the
editor, the rebase process will apply "bb commit", but instead of
applying "aa commit" and than "aaa commit", the rebase process fails
with a merge conflict.

This can be reproduced with git 1.6.5.1 (msys) and 1.6.1.2 (cygwin). I
consider these to be a critical bugs that make "-p" option extremely
dangerous for interactive rebase. It might even make sense to disable
it for interactive rebase until the bug is fixed.

Regards,
Constantine
