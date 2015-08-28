From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Bug with worktrees...
Date: Thu, 27 Aug 2015 22:55:33 -0400
Message-ID: <CAPig+cTkeOywRH1-_4Zi9jOd5r1cXa9vJhYAYXhF3E+SSE_GeA@mail.gmail.com>
References: <CAEBDL5UQSvS=t1dUKYqK6R=xHU6RU3bS72w-i02ey-Y_VB9KMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 04:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV9pL-0003Lp-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 04:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbbH1Czf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 22:55:35 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33816 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbbH1Cze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 22:55:34 -0400
Received: by ykdt205 with SMTP id t205so41405018ykd.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 19:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nRQnrRNrepEspI8usaBKA6HpEjBp6ifS8U9XEfj8xjc=;
        b=oGFh8WOUjYy9dIDrRiRBk1GxCBhVubPf+8vAo32RsHcrYzzfZvC/3k+y+Cj82I6BJ8
         ReBhp6Ogsz/KpHLyGhIA47nmMUa4fwNhdIiyxZx8JNubllEv2PYaFeOJ7O2EvmLRKXUl
         bTKhVdgRYG8bCe02DSOEnpTKWCPVuphz09ViVZmVoWlYCc/NO1CKgRYA+nLKZTGZzmwF
         dwA0G7OrP4ecs2ZlHV6nbvRo5mBqG6VS+b0wtmRjL6EKwHv5iHYtlCAjhWMAcLBlslx6
         6ElIZvecgidBg46ulsfXQHb1SjIBauSPLGL0nHY2QVtBbrFn3wNC9N/isffmXhFtw1Rf
         +4uQ==
X-Received: by 10.129.76.151 with SMTP id z145mr6718978ywa.17.1440730533834;
 Thu, 27 Aug 2015 19:55:33 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 27 Aug 2015 19:55:33 -0700 (PDT)
In-Reply-To: <CAEBDL5UQSvS=t1dUKYqK6R=xHU6RU3bS72w-i02ey-Y_VB9KMQ@mail.gmail.com>
X-Google-Sender-Auth: hipJUcDQziSm1T3IWjITNfu90VM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276703>

On Thu, Aug 27, 2015 at 3:03 PM, John Szakmeister <john@szakmeister.net> wrote:
> My apologies if this has already been reported, but I ran into an
> interesting bug with worktrees.  In particular, I have an alias 'st'
> that maps to 'status -sb'.  When running this under a subdirectory of
> a worktree created with 'git worktree add', it fails complaining that
> the work tree has already been set.
>
> Here's a script to reproduce the problem:
>     git init test-repo
>     cd test-repo
>     git config --local alias.st 'status -sb'
>     mkdir subdir
>     echo file > subdir/file.txt
>     git add subdir/file.txt
>     git commit -m 'add file'
>     git branch foo
>     git worktree add ../new-worktree foo
>     cd ../new-worktree/subdir
>     echo "new line" >> file.txt
>     echo "this will work"
>     git status -sb
>     echo "this fails"
>     git st
>
> When I run it, I see this:
> [...]
> fatal: internal error: work tree has already been set
> Current worktree: /home/jszakmeister/tmp/test-case/new-worktree
> New worktree: /home/jszakmeister/tmp/test-case/new-worktree/subdir

I can reproduce with 2.5.0 but not 'master'. Bisection reveals that
this was fixed by d95138e (setup: set env $GIT_WORK_TREE when work
tree is set, like $GIT_DIR, 2015-06-26), and was reported previously
here [1].

[1]: http://git.661346.n2.nabble.com/Linked-workdirs-break-typo-correction-td7634347.html
