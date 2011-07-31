From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Cleaning up history with git rebase
Date: Sun, 31 Jul 2011 20:21:50 -0000
Message-ID: <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
Cc: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>,
	git@vger.kernel.org
To: Ricky Egeland <rickyegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Sun Jul 31 23:18:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QndP6-0000rP-WF
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 23:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab1GaVS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 17:18:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51026 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1GaVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 17:18:28 -0400
Received: by vws1 with SMTP id 1so4043315vws.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=fkFi/HdyA2ozpaYzHCXyH5YpE8Bioy+H0+P8bmwgOmc=;
        b=T9nJA0Mdo1rB8v9x4i+lEyZOefa/rP06SsgyONTrXGiB4ziUiaAn2L41Ge47fOjBSS
         iBHoJFnsS8TQX1AEDEPIA58qbRvJ4VXTLtahWmOxWiacnbRekwwzHSjIcYaFfhHnPY99
         k1YnmE3Q0R21OLBhoWxRR6lM1Gct8Lk+ZMScY=
Received: by 10.220.9.204 with SMTP id m12mr944268vcm.159.1312147107003;
        Sun, 31 Jul 2011 14:18:27 -0700 (PDT)
Received: from gmail.com (bouazizi.torservers.net [74.120.13.132])
        by mx.google.com with ESMTPS id z6sm1626172vcv.18.2011.07.31.14.18.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 14:18:26 -0700 (PDT)
In-Reply-To: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178279>

On Sun, 31 Jul 2011 14:20:37 -0300, Ricky Egeland wrote:

> I've succeeded at breaking apart this big repository using
> `git filter-branch`, but where I am failing is the cleanup of
> the history of these new sub-repositories. The original big
> repository was used for years in a CVS-like fashion, with about
> 20 or so developers doing a pull/edit/pull/push workflow using a
> centralized shared repository. Most developers were working on
> unrelated components, so merge conflicts were rare, but there are
> some exceptions to that. The end result is that there are a lot
> of merge commits in big-repo.git, and in the case of my split
> sub-repositories these merge commits still appear in the history,
> even for merges which did not involve files that end up in a
> given repository. In most cases, there are more merge commits in
> the history than there are commits that actually affected the
> code that is left in these sub-repositires. I really want to
> clean this up.


Maybe you could use a more sophisticated filter-branch script to
examine merge commits and split them up or throw them out as
necessary.


> git rebase $(git rev-list --reverse HEAD | head -n 1)


As an aside, I would have expected to be able to limit the
`rev-list' output directly as in the following:

  git rebase $(git rev-list -1 --reverse HEAD)

but it doesn't work; when `-1' is passed, rev-list ignores
`--reverse', which I think is a bug.


> Which I take to mean "rebase this repository from the root to the
> current HEAD". In many cases it works perfectly, resulting in
> a short, clean history that only pertains to the files left in
> the new sub-repository. But some of the more actively developed
> components are problematic, as `git rebase` starts runs into
> conflicts and becomes interactive, and it is simply too tedious
> to use the interactive mode to resolve these problems. I've found
> a recipe for resolving these conflicts:


I don't understand why there would even be conflicts; can you give
a concrete example so that I might be able to understand the
scenario better?


>
>  - git status
>  - # look for files with problems like "both modified", or
>    "both added", set $CONFLICTFILE
>  - git checkout --theirs $CONFLICTFILE
>  - git add $CONFLICTFILE
>  - git commit -m 'Fixing conflict during rebase' $CONFLICTFILE


As an aside, putting `$CONFLICTFILE' on the `git commit' command
line seems to be redundant; from `git help commit':
  
  When files are given on the command line, the command commits
  the contents of the named files, without recording the changes
  already staged. The contents of these files are also staged for
  the next commit on top of what have been staged before.


>  - git rebase --continue
>  - # look for message like "did you forget to add..." if so, use --skip
>  - git rebase --skip
>  - # repeat as often as necessary
>
> For some of my sub-repositories this recipe did exactly what I
> wanted after repeating only a couple times. However, some of my
> sub-repositories have been forcing me to repeat this more than 50
> times, and I grew tired and started to look for ways to automate
> this. In essence, I want a non-interactive `git rebase`.
>
> To that end I upgraded my version of git to 1.7.4 and tried
> (without really understanding what these were doing):
>
> 1. git rebase -s recursive -X theirs \
>      $(git rev-list --reverse HEAD | head -n 1)
>
> 2. git rebase -s recursive -X ours \
>      $(git rev-list --reverse HEAD | head -n 1)
>
> 3. git rebase -s ours $(git rev-list --reverse HEAD | head -n 1)
>
> Method 1 and 2 were still interactive and stopped at conflicts.
> Method 3 was automatic but left me with the sub-repository at the
> state of the root commit... the opposite of what I want.

The results of Method 3 are predicted by `git help rebase' page:

  Because git rebase replays each commit from the working branch
  on top of the <upstream> branch using the given strategy, using
  the ours strategy simply discards all patches from the <branch>,
  which makes little sense.

In any case, how would you know which side to take in general?
It seems to me that you need to do something different at the
filter-branch step. Why are there conflicts anyway?

Sincerely,
Michael Witten
