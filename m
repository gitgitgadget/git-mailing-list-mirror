From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 19:26:41 +0530
Message-ID: <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com> <vpqppxvoqsc.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 15:57:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URjuS-0004Rj-7k
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 15:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab3DON5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 09:57:23 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53316 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3DON5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 09:57:23 -0400
Received: by mail-ie0-f181.google.com with SMTP id as1so1311175iec.40
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AcL7MyBIcHYYSHZh56HlDnEnOvslY4Bd5BdjE2V9uGc=;
        b=mjvo1Wepign36oO4ODwYSBvyVbZV4CCMdkr4QoDJypYGXFGnGw5Yy7ULGRZQIvhuB9
         0fBXUf37MBgWyeBlCljybok5UgUFs7gCXYOzsKEV+fOLhqZdsImhG4ldwU/59ZG5fLuK
         WWGGKfny1hmTN4s6QdtsfMwD4m0mxyAELV4hF4T8NMb+8MtxoLQRFW+6d5O1TRJO4Rio
         ooDu/jj6SWHUuYz62VmFrp/UDz4b56QgduWKL17CVthRXnZtr7bOXw/kNdL4h7xzmYXO
         U6PR2ie0FcwpiGVDz9FUYIAUZ9caVf01rmPVu4CnK2IVeQnCt7dwdPSvjjgsmcfChDQ1
         lKng==
X-Received: by 10.50.108.235 with SMTP id hn11mr5174110igb.107.1366034242450;
 Mon, 15 Apr 2013 06:57:22 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 06:56:41 -0700 (PDT)
In-Reply-To: <vpqppxvoqsc.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221231>

Matthieu Moy wrote:
> AFAICT, "git merge --abort" is an alias for "git reset --merge"

Yes, that is correct.

> which
> was precisely designed to reset only modifications comming from a merge,
> and not the local changes that were present before the merge was
> started. The man pages are relatively obscure on the subject, but I'd
> call that a documentation bug.

I see.  Either way, we need a clean worktree for it to work, no?

> It does. stashing means the user will have to "stash pop" later. One
> extra step, one extra opportunity to forget something important.

That's only if there are conflicts.  If there are conflicts, you'll
have to stash anyway if:
- You're doing a pull-merge and want merge --abort to work.
- You're doing a pull-rebase.

In the case when there are no conflicts, what is the problem?

> A minor annoyance is that it will touch files that have no reason to be
> touched, hence may trigger extra rebuilds with "make", disturbing text
> editors that have the file open, etc.

Okay, I need to ask you something at this point: do you ever run merge
on a dirty worktree unless you're absolutely sure that your local
changes won't conflict with the changes introduced by the merge?  I
_never_ run merge on a dirty worktree myself.

> The fact that "git pull" just works on dirty trees with non-overlapping
> changes is an important feature of Git.

That's only a pull-merge.  Unfortunately, making git-pull.sh uniform
means that we have to fall back to the least-common-denominator of
functionality (which is currently pull-rebase).

> I think you're taking it the wrong way. You seem to insist that
> autostash should be a pull feature. I think it should be a feature of
> merge and rebase, and the convenience script "git pull" should expose
> them to the user.
>
> I see no reason to prevent users running fetch and then merge or rebase
> to use the autostash feature.

Okay, so you're proposing a uniform --autostash feature for both merge
and rebase.  Sorry, I didn't get it last time due to the typos in your
email; yeah, this is worth investigating.

> As a user, when I run "git rebase --continue" and it tells me it's done,
> I expect the work to actually be done. This is the case today. This
> won't be the case after autostash is introduced if the user has to
> remember to run "stash pop" afterwards.

And how will you implement that for merge, since there is no merge
--continue to execute stash pop from?  Do you propose to make commit
do the stash pop'ing?
