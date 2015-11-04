From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: Bug: stash save -u removes (some) ignored files
Date: Tue, 3 Nov 2015 22:23:41 -0800
Message-ID: <CA+izobsNJ+Aj6JwFTtZVD_+8m9uXV-iiM7Z2aYWNCnWXFd82Dg@mail.gmail.com>
References: <CAAfdZj8=pqWDB9U3=bPeKXGzsZvzns2xX8WxEzQAy08wgSm=ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Sateler <fsateler@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtrUH-0002gm-EA
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 07:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbbKDGXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 01:23:42 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33164 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbbKDGXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 01:23:41 -0500
Received: by ykft191 with SMTP id t191so56285506ykf.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cyq8UvF5ZwpqyvfTyPwq2ad4rpVmkAS9IQe/Gbxrjx4=;
        b=C1M6uZIQOldzZGf4smFslK/pN8issjvZXQkDwWRsY4HaSU2yFvTKhSOmfr0W71KX5l
         1PJLVaf6O1Q+euay7x13A2QfY7AYhhoiZUbI2f7gZPMa7tklME2FvJ4EldvLYVnENPyB
         L5G+i+0R6iqjLWp6K8YAKAPZ+XXA4XgxHdVblcKv82S2tcv6sAZjnTIGpaClT6mFbEr2
         Z0o7sRvsrkyaCijMKwOJZmiZr8KthyIWVci0ORDkLcgMt0xBNVqUdmS//bP3rB0WZQAa
         zSuDOAPA5p3tar3b7yHfqTVR8n9tJnR4criIY1ZKEqwq+92CIrXuDgVR3pkf1eh7uIM9
         RsyA==
X-Received: by 10.13.200.134 with SMTP id k128mr23451142ywd.62.1446618221344;
 Tue, 03 Nov 2015 22:23:41 -0800 (PST)
Received: by 10.37.91.198 with HTTP; Tue, 3 Nov 2015 22:23:41 -0800 (PST)
In-Reply-To: <CAAfdZj8=pqWDB9U3=bPeKXGzsZvzns2xX8WxEzQAy08wgSm=ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280852>

> felipe@felipe:testgit% git stash save -u

This does the following:
$ GIT_TRACE=1 git stash save -u
[...]
21:59:10.606094 git.c:348               trace: built-in: git 'clean'
'--force' '--quiet' '-d'

git-clean -d removes untracked directories in addition to untracked files.
Should 'git stash save -u' issue a 'git clean -d' or simply a 'git clean'?

Atousa

On Tue, Nov 3, 2015 at 2:37 PM, Felipe Sateler <fsateler@debian.org> wrote:
> I have seen the following problem:
>
> felipe@felipe:testgit% cat .gitignore
> **/notrack/*
> !**/notrack/track/
> notrackfile**
>
> felipe@felipe:testgit% find *
> newfile
> notrack
> notrack/1
> notrackfile1
>
> felipe@felipe:testgit% git status --porcelain
> ?? newfile
>
> felipe@felipe:testgit% git stash save -u
> Saved working directory and index state WIP on master: 523cb39 Initial commit
> HEAD is now at 523cb39 Initial commit
>
> felipe@felipe:testgit% find *
> notrackfile1
>
> So, after a stash save, git decided to keep the untracked file in the
> current directory, but not the ones inside the untracked directory.
> However, the files were "correctly" ignored and did not appear on the stash:
>
> felipe@felipe:testgit% git stash pop
> Already up-to-date!
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         newfile
>
> nothing added to commit but untracked files present (use "git add" to track)
> Dropped refs/stash@{0} (e6508f345af1dd207557ad0291e7e3bce8a89b1e)
>
> felipe@felipe:testgit% find *
> newfile
> notrackfile1
>
> I think the correct behaviour should be to left the ignored files
> untouched in both scenarios.
>
> This is with git 2.6.1 (from debian).
>
> I note that if I add a file inside the notrack/track directory, it is
> correctly kept, but the files in notrack/ are still deleted.
>
> --
>
> Saludos,
> Felipe Sateler
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Atousa Pahlevan, PhD
M.Math. University of Waterloo, Canada
Ph.D. Department of Computer Science, University of Victoria, Canada
Voice: 415-341-6206
Email: apahlevan@ieee.org
Website: www.apahlevan.org
