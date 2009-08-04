From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: Building GIT on HP-UX: "make test" fails
Date: Tue, 04 Aug 2009 08:39:50 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <4A77F3D9.4170.5574656@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <4A76DDEE.6699.119A5FD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <81b0412b0908030754l553ddac2y4c2e7f9fe606e67a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDhS-0006FC-0v
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbZHDGk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbZHDGkW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:40:22 -0400
Received: from rrzmta5.rz.uni-regensburg.de ([194.94.155.56]:47732 "EHLO
	rrzmta5.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755117AbZHDGkV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 02:40:21 -0400
Received: from rrzmta5.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 44D76A59;
	Tue,  4 Aug 2009 08:40:16 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta5.rz.uni-regensburg.de (Postfix) with ESMTPS id 0C6FC9D3;
	Tue,  4 Aug 2009 08:40:15 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n746e3T9017555;
	Tue, 4 Aug 2009 08:40:10 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    4 Aug 09 08:40:07 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 4 Aug 09 08:39:52 +0100
In-reply-to: <81b0412b0908030754l553ddac2y4c2e7f9fe606e67a@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.41.0+V=4.41+U=2.07.230+R=04 May 2009+T=732387@20090804.064003Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124758>

On 3 Aug 2009 at 16:54, Alex Riesen wrote:

> Try:
> 
>   $ cd t && ./t0100-previous.sh -d -v -i
> 
> Look at the output and if you can't make anything out of it,
> just post it here.

Hi!

Thanks for that. It seems the basic problem is:
fatal: your vsnprintf is broken

However from my own programming I realized that HP-UX and Linux vsnprintf return 
different values. Here's how I deal with it:

My comment says:
Define ``C99_LIBRARY'' fixes incompatible return value of
 * ``snprintf()'' that causes memory corruption on error with C99-compliant
 * C library. 
[...]
 * Handle negative return value of ``snprintf()'' properly.
[...]
        csp[cap] = '\0';
        d = snprintf(csp, cap, "%s", base);
#ifdef  C99_LIBRARY
        if ( d > cap )
                d = cap;
#else
        if ( d > 0 )
#endif
                csp += d, cap -= d;
--------
Back to the test output; here it is:
./t0100-previous.sh -d -v -i
Initialized empty Git repository in /home/windl/GNU/git-1.6.2.5/t/trash 
directory.t0100-previous/.git/
* expecting success:
        test_commit A &&
        git checkout -b junk &&
        git checkout - &&
        test "$(git symbolic-ref HEAD)" = refs/heads/master &&
        git branch -d @{-1} &&
        test_must_fail git rev-parse --verify refs/heads/junk

[master (root-commit) 0ddfaf1] A
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 A.t
Switched to a new branch 'junk'
Switched to branch 'master'
Deleted branch junk (was 0ddfaf1).
fatal: Needed a single revision
*   ok 1: branch -d @{-1}

* expecting success:
        git reflog expire --expire=now &&
        git checkout -b junk2 &&
        git checkout - &&
        test "$(git symbolic-ref HEAD)" = refs/heads/master &&
        test_must_fail git branch -d @{-12} &&
        git rev-parse --verify refs/heads/master

Switched to a new branch 'junk2'
Switched to branch 'master'
error: branch '@{-12}' not found.
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050
*   ok 2: branch -d @{-12} when there is not enough switches yet

* expecting success:
        git checkout A &&
        test_commit B &&
        git checkout A &&
        test_commit C &&
        git branch -f master B &&
        git branch -f other &&
        git checkout other &&
        git checkout master &&
        git merge @{-1} &&
        git cat-file commit HEAD | grep "Merge branch 'other'"

Note: moving to 'A' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 0ddfaf1... A
[detached HEAD d9df450] B
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 B.t
Previous HEAD position was d9df450... B
fatal: your vsnprintf is broken
* FAIL 3: merge @{-1}

                git checkout A &&
                test_commit B &&
                git checkout A &&
                test_commit C &&
                git branch -f master B &&
                git branch -f other &&
                git checkout other &&
                git checkout master &&
                git merge @{-1} &&
                git cat-file commit HEAD | grep "Merge branch 'other'"
