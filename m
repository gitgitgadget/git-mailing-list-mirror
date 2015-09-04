From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment variables
Date: Fri, 4 Sep 2015 12:52:45 +0200
Message-ID: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:53:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXocR-0002IH-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 12:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889AbbIDKxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 06:53:14 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37801 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbbIDKxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 06:53:05 -0400
Received: by wicfx3 with SMTP id fx3so13719386wic.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=N1dnVLLFgbKOKTEIaldCyk73Y7+F4vMs4OASZP+c79g=;
        b=hFhb/j/Wr4DAaV0Ll5QT1vTsHRqUarSkuQPeXrpk7xovAWPUHZW12mtCb6KJXxwI98
         Bx0hRxEzZvBCIEmuw4oslHSA0qOWiQ6NazA6Yd7a6r0waocRL5GgfWX7nFk7sB9EJx/n
         bc0IVePyKbb0/xb2CBVogcisAY7nW+nw7a6+SQ8FH8pZWgl6X/E+m0TMalH9a/huco1F
         jS9EoiTgiuR8oozRlCWqTLXmikD2rIwTdit99Utyib+OAOjwXLPwM5ibRrwpjBB4PqcC
         iHK3r7kRWEIx3nUm5rgJKMXnBe5R611ugILusHUm+qMlkE1RfUgIzZE0omRl/FCzuaUp
         68bQ==
X-Received: by 10.180.74.52 with SMTP id q20mr6370456wiv.94.1441363984505;
 Fri, 04 Sep 2015 03:53:04 -0700 (PDT)
Received: by 10.194.101.100 with HTTP; Fri, 4 Sep 2015 03:52:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277298>

Hello all,


I'm going to tell a tale of the oddest bug I've ever come across in
Git and aks for suggestions on how we can improve the user experience
in a sensible way.

I've been stymied for days trying to solve the following issue, which
I came across every time I tried to push to a specific machine when
using git 2.5 (I'm honestly not sure about which version introduced
this, and I haven't runthe necessary bisection due to lack of time,
sorry).

Trying to push any changes with 2.5 resulted in this kind of failure:

user@clientmachine:~/some/git/workdir $ git push
Counting objects: 6, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 841 bytes | 0 bytes/s, done.
Total 6 (delta 2), reused 0 (delta 0)
fatal: Could not switch to '/home/user/some/git': No such file or directory
error: unpack failed: unpack-objects abnormal exit
fatal: Could not switch to '/home/user/some/git': No such file or directory
To git@remote.machine:remote-repo
! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'git@remote.machine:remote-repo'

Notice two things: the messages refer to the worktree updir of the
CLIENT machine, and even though it's _completely not obvious_ due to
the missing 'remote:' lines, the messages actually come from the
SERVER. The lack of indicator lines _alone_ took me hours of debugging
before I finally understood that they were coming from the other side
(yes, I woud say that it's a bug), but after this I was even more
perplexed: why the heck would the SERVER try to switch to the updir of
the CLIENT worktree?

I still couldn't do much on the SERVER to debug due to a variety of
reasons, but I finally had a suspicion: it was almost as if the SERVER
was getting the GIT_DIR information from the CLIENT. And why the heck
would _that_ be the case?

I then remembered that the server was actually configured to AcceptEnv
GIT_* in sshd_config, for reasons related to git identity preservation
despite single login account (please don't ask). Turning the AcceptEnv
to a stricter GIT_AUTHOR* and GIT_COMMITTER* solved the issue.

Now, a couple of questions:

1. since when have git internals started exporting GIT_* variables
related to the git dir and worktree location?
2. is it worth making sure that these don't get propagated via ssh?

Regarding 2., there are actually webpages around suggesting the
AcceptEnv GIT_* trick, and these setups are _all_ going to break with
the latest git, so this is something that might be worth looking into.


-- 
Giuseppe "Oblomov" Bilotta
