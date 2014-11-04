From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Bug in log for path in case of identical commit
Date: Tue, 4 Nov 2014 11:21:29 -0500
Message-ID: <CABURp0qZ5Ba3EFhqF0LfoEz7J4Vq2DiStqcDc_bpK62XT7s7eQ@mail.gmail.com>
References: <CAFFOgCUeqcEPdjUyri0bivCj-Ofzp_9GhH3mR7UTzD-8PY9tGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Alexandre Garnier <zigarn+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 17:22:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlgrm-0001wt-1F
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 17:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbaKDQVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 11:21:53 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38902 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaKDQVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 11:21:50 -0500
Received: by mail-ie0-f169.google.com with SMTP id tr6so7941478ieb.28
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=39yGHQwFkgmdW6hB9jXLAYUjCNeuK3cl2oS0ZfJUFys=;
        b=b8M/GCxFi286GSvwubonwBk3357W4kDA0fLWpt0Y85biNj2hFJGdI9vR7isVHZmY2u
         ZtUm9lGfznT84pKQn9XswETJEifuMv+Q5s5iEhN78QC3mlqPSrRgKiGCYgbV67vFuuyB
         gG/WlwIdNvOEuPg8oBYqwKd8ii2fc4zVr3wc4ofa31VUxdMFLvJxTOS5zzyVc7eAoP+2
         nSmBaj0f7ziFzYBbpzkJP5wBhNo/zNIyIE7+RNlaG1T3AgAv4LSOFFu9fXgYabtRe0PC
         eo4DrEthewgljx4JIb6P64pnEnI434mU7xLOnQ/p0l4j06drLn59UcGLrw1mwuJxNhDz
         GytQ==
X-Received: by 10.50.112.165 with SMTP id ir5mr25000779igb.44.1415118109692;
 Tue, 04 Nov 2014 08:21:49 -0800 (PST)
Received: by 10.107.137.11 with HTTP; Tue, 4 Nov 2014 08:21:29 -0800 (PST)
In-Reply-To: <CAFFOgCUeqcEPdjUyri0bivCj-Ofzp_9GhH3mR7UTzD-8PY9tGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 31, 2014 at 4:40 AM, Alexandre Garnier <zigarn+git@gmail.com> wrote:
> When merging 2 branches with the same modifications on the both sides,
> depending the merge side, one branch disappear from the file history.
>
> To be more clear, there is a script in attachment to reproduce, but
> here is the result :
> $ git log --graph --oneline --all --decorate --name-status
> *   63c807f (HEAD, master) Merge branch 'branch' into 'master'
> |\
> | * 5dc8785 (branch) Change line 15 on branch
> | | M   file
> | * d9cd3ce Change line 25 on branch
> | | M   file
> * | 7220d52 Change line 15 on master
> |/
> |   M   file
> * 7566672 Initial commit
>   A     file
>
> $ git log --graph --oneline --all --decorate --name-status -- file
> * 5dc8785 (branch) Change line 15 on branch
> | M     file
> * d9cd3ce Change line 25 on branch
> | M     file
> * 7566672 Initial commit
>   A     file
>
> => The commit 7220d52 modified the file but is not shown in file
> history anymore.
> The expected result would be:
> * 5dc8785 (branch) Change line 15 on branch
> | M     file
> * d9cd3ce Change line 25 on branch
> | M     file
> | * 7220d52 Change line 15 on master
> |/
> |   M   file
> * 7566672 Initial commit
>   A     file
>
> The order between the 2 commits on the branch is not important.
> If you do a 'cherry-pick 7220d52' or a 'merge --squash master' instead
> of applying the same modification for commit 5dc8785, you get the same
> result (cherry-picking was my initial use-case).
> If you do not create the commit d9cd3ce, then the file history show all commits.
> If you merge 'master' into 'branch', then the file history show all commits.

This last line was confusing to me.  But I think you've misinterpreted
the results a bit.  There is no difference between "merge master into
branch" and "merge branch into master" in this case.  The real reason
the "extra" commit is shown in the former case is that you used
'--all' (include all refs as commandline arguments) and the commit
which was being omitted was directly referenced by a ref, 'master'.

When I remove the "--all" from your test script, I get consistent logs
for the two merges.

Maybe this has misled your other tests as well.  Read the "History
Simplification" section of "git help log".
