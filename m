From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: crash when checking with non-exist HEAD
Date: Wed, 22 Jul 2015 13:30:00 -0700
Message-ID: <xmqqr3o0q6k7.fsf@gitster.dls.corp.google.com>
References: <CANYiYbE3Vy_gtFMKTMw1wHLDhU758nXaJnKaNy6WMNRz0fjUnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI0ea-0002Vz-4B
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 22:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbGVUaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 16:30:05 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33972 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbbGVUaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 16:30:04 -0400
Received: by pdbbh15 with SMTP id bh15so98360700pdb.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=h7tf/CArhW7518263FUZoA/kzSEI7Kn2Dp45ltXJhUY=;
        b=0xYhlX8o+Rh5vFPNLFUDkEglgklJDLW2uGBGokqfF9F7XoyW/qc+YCLBA8vlQPH0KZ
         ItQYNEHsW1ECHtGwiYNgaTU7hzi6/EtH1+7nVb07coV8bkvMyqPtfNFl81UH3DY3sTYv
         QC8dtzrKDpmcNjAtRH68SmkbIavZ0smyZSUblZMtqkHDUCCYuh0Mz/SJfeVhe0DkdCNF
         WWfROuyZAxeR6A8X4f8o84X3WuKQGhoxXYOdPDhu63D1znsXffwWZJoX1dd4WgSB3vnW
         UVQ4Il1urjtu8zEypKqaG4tBtK2W3Ls095dBI3x7Oj18N/7kcJJ5aBsMyG98n+4cNtXT
         rwGA==
X-Received: by 10.70.44.199 with SMTP id g7mr9641412pdm.152.1437597003321;
        Wed, 22 Jul 2015 13:30:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id s1sm4866929pda.54.2015.07.22.13.30.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 13:30:01 -0700 (PDT)
In-Reply-To: <CANYiYbE3Vy_gtFMKTMw1wHLDhU758nXaJnKaNy6WMNRz0fjUnw@mail.gmail.com>
	(Jiang Xin's message of "Wed, 22 Jul 2015 09:49:40 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274465>

Jiang Xin <worldhello.net@gmail.com> writes:

> If HEAD of a repository points to a conflict reference, such as:
>
> * There exist a reference named 'refs/heads/jx/feature1', but HEAD
>   points to 'refs/heads/jx', or
>
> * There exist a reference named 'refs/heads/feature', but HEAD points
>   to 'refs/heads/feature/bad'.
>
> When we push to delete a reference for this repo, such as:
>
>         git push /path/to/bad-head-repo.git :some/good/reference
>
> The git-receive-pack process will crash.

I see a similar "if head_name is NULL, don't bother." check in
is_ref_checked_out() so in that sense this is a correct fix to the
immediate problem.  That check came from 986e8239 (receive-pack:
detect push to current branch of non-bare repo, 2008-11-08).

This is a tangent, but if HEAD points at an unborn branch that
cannot be created, wouldn't all other things break?  

For example, in order to "git commit" from such a state to create
the root commit on that branch, existing unrelated branches whose
names collide with the branch must be removed, which would mean one
of two things, either (1) you end up losing many unrelated work, or
(2) the command refuses to work, not letting you to record the
commit.  Neither is satisfactory, but we seem to choose (2), which
is at least the safer of the two:

    $ git checkout master
    $ git checkout --orphan master/1
    $ git commit -m foo
    fatal: cannot lock ref 'HEAD': 'refs/heads/master' exists;
    cannot create 'refs/heads/master/1'

We may want to avoid putting us in such a situation in the first
place.  Giving "checkout --orphan" an extra check might be a simple
small thing we can do, i.e.

    $ git checkout master
    $ git checkout --orphan master/1
    fatal: 'master' branch exists, cannot create 'master/1'

But I suspect it would not protect us from different avenues that
can cause this kind of thing; e.g. to prevent this:

    $ git branch -D next
    $ git checkout --orphan next/1
    $ git fetch origin master:refs/heads/next

creation of a ref "refs/heads/next" here must notice HEAD points
at "refs/heads/next/1" (that does not yet exist) and do something
intelligent about it.

>  builtin/receive-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 94d0571..04cb5a1 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -911,7 +911,7 @@ static const char *update(struct command *cmd,
> struct shallow_info *si)
>       return "deletion prohibited";
>     }
>
> -   if (!strcmp(namespaced_name, head_name)) {
> +   if (head_name && !strcmp(namespaced_name, head_name)) {
>       switch (deny_delete_current) {
>       case DENY_IGNORE:
>         break;
