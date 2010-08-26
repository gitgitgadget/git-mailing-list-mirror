From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: How to handle a git repository with multiple branches
Date: Fri, 27 Aug 2010 09:03:01 +1000
Message-ID: <AANLkTi=fn1YmK8WW-wfx2Eba8x8RQv3gZ56PU=T7=fLW@mail.gmail.com>
References: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 01:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OolTU-0007hu-9C
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab0HZXDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 19:03:05 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44399 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0HZXDE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 19:03:04 -0400
Received: by qwh6 with SMTP id 6so2152593qwh.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k17l7KBjYZqSBCGHWa499regKpdM4PcPvO56paVIFxQ=;
        b=rI71iPp4tJ27tg2hc1N0EqIWwgw7OL0IRxCk1iLdjCaT5kaNuXMiYIcfcpehasD+Gf
         tLEz/yhEo65xexq7I6/ZRYnCuQvUcrA67gtTbNPTFobmpzXlY20rrMQoyujCZLvgUkZK
         kKmnt3pqV+g0y1wNiI9BLfEKmGXy/aG5WtP00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WllDpsdv6xEB9nuEjEVk5IMbYe5bcDJru7fA3P6B1PDYvnlK3X6InyxhZGND8dLo+m
         6YfaSHYFHRcGY6rfnc7pf1w0O/NnY0qs3AlqtemW7nnpSD1xomILwNjBGj4qjERSZg3y
         /MgJoENq6AMOoZGDn5e3InBZL8U7sH769VPqw=
Received: by 10.229.61.86 with SMTP id s22mr6361921qch.204.1282863781786; Thu,
 26 Aug 2010 16:03:01 -0700 (PDT)
Received: by 10.229.114.222 with HTTP; Thu, 26 Aug 2010 16:03:01 -0700 (PDT)
In-Reply-To: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154568>

On Thu, Aug 26, 2010 at 9:53 PM, Erez Zilber <erezzi.list@gmail.com> wr=
ote:
> Hi,
>
> My repository has several branches. Each branch is for a separate cod=
e
> release. Let's assume that I have a branch for V1.0 (branch_1) and a
> branch for V2.0 (branch_2).
>
> Some commits are relevant only for branch_1, some are relevant only
> for branch_2 and some are relevant for both. For the commits that are
> relevant for both branches, I thought about the following solutions:
> 1. Put these common commits in branch_1 and merge branch_1 into
> branch_2. This is bad because it will also merge commits that are
> relevant only for branch_1.
> 2. Cherry-pick the common commits from branch_1 to branch_2. This is
> also bad because the commit ID changes, and in case of conflicts, git
> is unable to tell that these 2 commits are actually the same commit.
> This makes it very difficult to track the changes between branches.
>
> Since there are several other developers and sub-maintainers in this
> project which are rebased on both these branches, I don't want to
> change the git history of my branches because when I do that,
> sub-maintainers and developers lose the reference to their base.
>
> I'm looking for a better solution. Is there any best-practice solutio=
n?
>

As Josh pointed out in another post, the key to sharing commits across
branches is to ensure that the commits that you intend to share
between branches should always be based on a commit that both branches
have in common. That way, when you eventually merge the commit into
the branch the only history it drags in is the history associated with
the patch itself.

This requires a slight shift in mind set - don't automatically assume
the right thing to do is develop a patch is on the tip of branch_1. If
the branch_1 does contain other stuff that you are not intending to
merge into branch_2, this is probably the wrong thing to do.

What I tend to do (as described here
http://permalink.gmane.org/gmane.comp.version-control.git/153168), is
to
develop my fixes on  the tip of private integration branch (which I
never share), then rebase them onto a suitable base common to all
potential delivery targets later. This works for me, because there
isn't typically much divergence in the files I touch between branches.
 It might not work so well in cases where there is significant
divergence.

jon.

> Thanks,
> Erez
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
