From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Rebasing with merges and conflict resolutions
Date: Sat, 27 Mar 2010 04:36:24 +1100
Message-ID: <2cfc40321003261036n7bfe402co8084824f6222a841@mail.gmail.com>
References: <20100326031111.GB27737@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tyler@monkeypox.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 18:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvDSR-0002fZ-QY
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 18:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab0CZRg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 13:36:26 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:41871 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab0CZRgZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 13:36:25 -0400
Received: by pzk32 with SMTP id 32so2813336pzk.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q2is/e3miK1ouzBN9T2JKWLKTBO93a7mh8yYPWZva30=;
        b=b/7WDO2RxoVwGE/Z8s7QnGqfAP3To2K7k9BhS9xW6AtOozKfC66rMHV1kuB+sLwbB9
         OsrSDjtgw7aZRmKuSQ/mCDb8i1aZdxXs+uY5gJCgSjPzWLi87poNeBF3XODC+4oZyuke
         2Muo7b9bkWakQ3V+SU8F/Okuv3rlWg+xIkNIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OKdajmtpG7LHK0iTSy0dQFQ0Kk1hYWtgXY85NqETOGE3RsV/f6jcCdF/VdazlOsV2U
         QKPlRQnQNyiGS6ZX6ntkaFSSGnznfkHsN4+XUGyVam/yvoS18/LVMvzCy5sjCsl46O5m
         6d3tR3adLhTgG8hBXS6nXA+dGJlw2987MGFPY=
Received: by 10.115.89.7 with HTTP; Fri, 26 Mar 2010 10:36:24 -0700 (PDT)
In-Reply-To: <20100326031111.GB27737@kiwi.sharlinx.com>
Received: by 10.114.3.7 with SMTP id 7mr1636545wac.86.1269624984735; Fri, 26 
	Mar 2010 10:36:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143261>

You might find this post from a few weeks back interesting:

    http://permalink.gmane.org/gmane.comp.version-control.git/140510

Unfortunately, I haven't had time to reproduce a robust implementation
of the ideas, but I have exercised the algorithm manually a few times
and it works quite well.

The basic idea is that you split the merge history into segments
(where a segment is a single linear series of commits). Then starting
from the oldest you rewrite:

A----B---M
  \---C---/

as:

A---B---e---C'---e'---M'

where e is a compensation that allows e to be automatically rebased
onto B without merge conflicts and e' restores the tree to the point
it was an M so that tree(M) and tree(M') are identical. See the
original post for working out how to construct e and e'. The basic
idea is you find the confllcts that would result if you attempted
rebase C on B, then reset part of the tree in such a way that the
conflicts are removed. e' then is the patch that restores tree(C') to
tree(M)

You have to realise that the trees between e and e' will be
inconsistent because part of the tree is shifted back in time in order
to allow the C to rebase cleanly.

Once the history is linearised in this way, it is often (but not
always) possible to reorder and then squash the commits in  e --- C'
--- e' such away that the consistency of the tree in this region is
restored.

if you repeat this algorithm recursively for each merge in the merge
history you can flatten the entire merge history out into a linear
series of commits. This can be complete and automatic, alhough to
obtain completeness you do lose consistency at certain well-delimited
points in the history. Consistency can be restored, if required, by
manually rebasing the linearised history in a single pass at the end.

I do intend to commit the algorithm to code at some point, but haven't
had a chance to do so yet. See ( http://github.com/jonseymour/hammer)
for a readme that also describes the idea in more detail

jon.

On Fri, Mar 26, 2010 at 2:11 PM, R. Tyler Ballance <tyler@monkeypox.org=
> wrote:
> I am trying to use rebase to straighten out a couple topic branches' =
histories
> and running into nothing but troubles and I'm wondering if:
> =A0 a) I'm doing it wrong (highly likely)
> =A0 b) what I want is not possible
> =A0 c) banana!
>
> Two contributors worked in tandem on a particular project, constantly=
 merging
> back and forth between each other creating a history of 118 commits t=
otal with
> 37 of them being merge commits, 7 of those merge commits having confl=
ict
> resolutions involved.
>
> I would /like/ to rebase those into a more linear revision history, b=
ut I
> can't seem to find any set of commands that doesn't have me:
> =A0 a) Manually re-doing every conflict resolution and merge (git reb=
ase -p master)
> =A0 b) Drastically diverging from the original topic branch and enter=
ing some
> =A0 =A0 =A0sort of mergeless hell (git rebase master)
>
>
> Is it even possible to straighten this out without a massive rework o=
f these
> commits?
>
> In the future, is there a better way for two developers to work in th=
e same
> back-and-forth fashion (code ping pong!) without leading to *heavily*=
 merged
> histories that are unpossible to untangle?
>
>
> Halp!
>
>
> Cheers,
> -R. Tyler Ballance
> --------------------------------------
> =A0Jabber: rtyler@jabber.org
> =A0GitHub: http://github.com/rtyler
> Twitter: http://twitter.com/agentdero
> =A0 Blog: http://unethicalblogger.com
>
>
