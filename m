From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git Rebase Issue
Date: Tue, 22 Dec 2015 22:02:16 +0100
Message-ID: <CAP8UFD3F6+VRyEF6XuxUcC_qiY7k4a-g8J-NKBZWDk=1=m1=WA@mail.gmail.com>
References: <39E7EE9D306F544FAD3A0D16B7B7CAAD2C1E819D@mtlsvrmxwv02.A2M.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pierre-Luc Loyer <Pierre-Luc.Loyer@bhvr.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBU4c-0007sJ-8P
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 22:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbbLVVCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 16:02:18 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34785 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbbLVVCR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 16:02:17 -0500
Received: by mail-lf0-f50.google.com with SMTP id y184so136251874lfc.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IQ0uVk1oR7fNPufH7aVkg0h9UjytKu4Bl2tE1vidNBM=;
        b=AhBsnRVsMB4pm9nstc47E4ibb3yyGGHfmNjsXJc5CbVyHaNgxX6QSE8J+3xrFoebbh
         kCgij7mQOhRprc/DKkWPgMo6ror2XgllgqP0UeUw/HqQTOjK5SV3xbFT3X/neJANbKAM
         2XpOd/z6g+VtVxk975EHmBVKn6se1G1Alm1s5/T4oCCxodG/IOYEQF7bvmarB2vFzDlT
         nVg8vpritTew+6KBikk4mLhuzTC2XtHjMRKKPBxzUCyoqnBx2yvzxDVU1e5mNAWycCLd
         IbSVcPKad37+9jA0La8P9F/ucNCkIq62GysV9Ge4hjfNCKDByMEfAweWdD5DE8d4lzjT
         9LZQ==
X-Received: by 10.25.207.205 with SMTP id f196mr9488683lfg.124.1450818136393;
 Tue, 22 Dec 2015 13:02:16 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 22 Dec 2015 13:02:16 -0800 (PST)
In-Reply-To: <39E7EE9D306F544FAD3A0D16B7B7CAAD2C1E819D@mtlsvrmxwv02.A2M.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282908>

Hi,

On Tue, Dec 22, 2015 at 6:53 PM, Pierre-Luc Loyer
<Pierre-Luc.Loyer@bhvr.com> wrote:
> Hi,
>
> I've encountered a situation using rebase for which I don't understand the results, even after reading the documentation.
> I'm currently working in my feature branch and then I want to squash commits, thus I use interactive rebase. After successfully completing the rebase, I end up in a detached HEAD state, rather than back on my branch, which is confusing. The command that is causing me to be in detached HEAD mode is: git rebase -i HEAD~2 HEAD
> From the documentation, I read that my second parameter (HEAD) is the <branch> parameter:
>
>    git rebase [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>
>    [<upstream>] [<branch>]
>
>    If <branch> is specified, git rebase will perform an automatic git checkout <branch> before doing anything else. Otherwise it remains on the current branch.
> <branch> Working branch; defaults to HEAD.
>
>    Upon completion, <branch> will be the current branch.
>
> Here is a full example than can be used to easily repro the issue. Go to an empty folder.
> git init
> git echo text > file.txt
> git add .
> git commit -m "Add file.txt"
> git echo text2 > file.txt
> git commit -am "Modify file.txt"
> git echo text3 > file.txt
> git commit -am "Remodify file.txt"
>
> Now the interesting part:
> $ git rebase -i HEAD~2 HEAD
> [detached HEAD 9178b93] Modify file
> 1 file changed, 1 insertion(+), 1 deletion(-)
> Successfully rebased and updated detached HEAD.
>
> From the documentation it says that <branch> (which is HEAD) will be checked out before doing anything and that upon completion, <branch> will be the current branch. However, this doesn't seem to happen. In fact, it seems more like the following is happening during the rebase:
> 1) detach HEAD
> 2) rebase
> 3) reattach to <branch>
>
> If <branch> is HEAD, then is does nothing and remains detached.
> I find this behavior confusing since I would expect it to return to whatever HEAD was pointing to at the start of the command, such as my branch. Also, the documentation says that the <branch> parameter defaults to HEAD, so passing 'HEAD' explicitly should result in the same behavior as not passing it:
> <branch> Working branch; defaults to HEAD.

You are right, it is probably a bug.
I guess usually people just use "git rebase -i HEAD~2" or "git rebase
-i master" and don't give the [<branch>] argument when using -i.

If you are interested in helping us debug this you might first want to
check if older git versions behaved like this.

Thanks,
Christian.
