From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Git automatic stashing?
Date: Tue, 9 Nov 2010 07:02:22 -0500
Message-ID: <AANLkTi=L7WUPP_9ZmUmNKqYvQzpZFau4F0nWNxdLy1sZ@mail.gmail.com>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com>
	<AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
	<vpqlj53j5rv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Casey McGinty <casey.mcginty@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFmuC-0000bZ-62
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288Ab0KIMCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 07:02:23 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53275 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab0KIMCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 07:02:23 -0500
Received: by vws13 with SMTP id 13so3117718vws.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 04:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Fjh6ked2nDsvFGNxNH4/ITnBBOiX/Ala/Jez3g7ZMnY=;
        b=MRruWisjM+e45XNDwo1x9SLm234OfrsLVt8rozLDceRIpUi9fOBMvE4Q/DudP22fva
         o0j0hnIjl7y2ODTOTdgCylNodRE1KHBLScxkFn0SPSg4gBZojOUC7q9vUAG8xLK1G1qS
         U2AtlMPEwKu60fYLBaJdm7VBlPaPU13xKAt6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Hu0HIZTgukD+05yXmafJQg91ux26M1ZUygTSfYnXop7W2Koa/Gs7uUjx5l/z3MC84g
         /6MhvrkSvM7Nlltvxen8ndENFIB4yZ+AUTPwVjt8Q5xYQGn/S/FZi6c39FjsR8/fi6y4
         d93kaAMfnjKABquS0vdhkFhjidQ3sja4efvwk=
Received: by 10.224.3.3 with SMTP id 3mr5211331qal.90.1289304142247; Tue, 09
 Nov 2010 04:02:22 -0800 (PST)
Received: by 10.224.20.82 with HTTP; Tue, 9 Nov 2010 04:02:22 -0800 (PST)
In-Reply-To: <vpqlj53j5rv.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161037>

On Tue, Nov 9, 2010 at 2:49 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Casey McGinty <casey.mcginty@gmail.com> writes:
>
>> Is there any feature in git to perform and auto stash apply/pop when
>> trying to do a merge/rebase in a dirty working dir? This would save
>> some keystrokes from time-to-time, and make it easier for new users
>> unfamiliar with git.
>
> I agree with the keystrokes part, but not with the fact that it would
> make it easier in general. In the sequence
>
> git stash
> git merge
> git stash pop
>
> conflicts can occur in 2 distinct places. [...]

Correct me if I'm wrong, but I think git will only stop you from
performing a merge if it would involve touching any of your dirty files,
so in the case of merge, I agree with Matthieu that temporarily stashing
your changes would probably just increase the risk of confusing the
user.

However, in the case of rebase, git will not let you rebase if *any*
file is dirty. So, in this case of rebase, there are often cases where
git prevents a rebase that could have been a stash + rebase + stash pop
without any conflicts in the pop step.

I know that the fact that 'git rebase' (usually in the form of a
'git pull' configured for rebase on the current branch) forces the user
to temporarily stash his changes has been somewhat annoying to some of
my colleagues.

I actually implemented support for stashing changes using 'stash create'
and 'stash apply', but only for non-interactive rebase. The implentation
supports a '--stash' argument and a 'rebase.stash' configuration. I am
currently working on refactoring git-rebase.sh and
git-rebase--interactive.sh, but once that's done, I will post an updated
version of the 'git rebase --stash' patch(es).

I later found out that this seems to have been attempted at least twice
before. The first time by Junio in 6c9ad16 (rebase: allow starting from
a dirty tree., 2007-07-09). This was later reverted. I think it was
reverted because the stashing was not optional.

Some months later, Simon Sasburg sent some patches on the same subject,
see http://thread.gmane.org/gmane.comp.version-control.git/63007/. These
patches don't see to have been accepted, but I'm not sure why.
