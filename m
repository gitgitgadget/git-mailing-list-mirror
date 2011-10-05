From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 15:11:30 -0400
Message-ID: <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 21:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBWsS-0000vp-8z
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 21:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934275Ab1JETLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 15:11:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34552 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933236Ab1JETLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 15:11:30 -0400
Received: by yxl31 with SMTP id 31so1889698yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ivW8ljxh3p5u4shp86sEpkP4Z24giUFHIfSB7SwdYy4=;
        b=czMVEZDEvrm5arX8NCyT0h0UmGWje0u0hKc4asdtMQMUA3J5D8mGd1W10Ha4n4/iW8
         E7bhSGBFU13UmSMv6DFJ8mv/afi0omJD8T9iz7+Kbf6MC/UdO92zd0XfprLgrKnpFafW
         ciKa/SZ+FYs7i/IzAR71ipVt8bzi2cKGBX1B0=
Received: by 10.150.115.13 with SMTP id n13mr2544472ybc.437.1317841890284;
 Wed, 05 Oct 2011 12:11:30 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 12:11:30 -0700 (PDT)
In-Reply-To: <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182876>

On Wed, Oct 5, 2011 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> Careful. Git has survived without your patch series till now, as peop=
le
> learned to be careful when they use separate workdirs and avoid certa=
in
> things, to the point that they are not necessarily aware that they ar=
e
> avoiding them (one good practice is to keep the HEADs of non-primary
> workdirs detached).

I think it's more likely the case that most people have avoided
new-workdir entirely.

Also, while I might recommend new-workdir to my coworkers with the
advice "don't checkout the same branch in multiple workdirs", never in
a million years would I say "use new-workdir, but make sure to only
use a detached HEAD in the workdirs." The latter would make their
actual HEADs explode. :-)

> For example, you checkout branch frotz in a workdir, and then in the
> primary repository that has nitfol branch checked out, you rename the
> frotz branch to xyzzy. The HEAD of workdir still says refs/heads/frot=
z
> that no longer exist. Of course you can break the same way by doing a
> "update-ref -d refs/heads/frotz" from the primary repository.
>
> Because you forgot that the high level operation "branch renaming" ne=
eds
> to be aware of that "this branch is checked out elsewhere" informatio=
n,
> you allowed it to break the workdir. If you hooked into lower level
> machinery that is shared, you wouldn't have caused this breakage.
> Similarly, if delete_ref() were taught about the new requirement, you
> would have covered both "branch -d" and "update-ref -d".

I did not forget, I just hadn't gotten there yet while this was still
an RFC/PATCH.

Another issue to resolve is what happens when the workdir or repo are
moved in the filesystem. And making prune aware of HEAD reflogs in the
alternate workdirs.

> I do not necessarily think that it is a good approach to forbid the s=
ame
> branch to be checked out in two different places, by the way. One rea=
son
> people would want to keep multiple workdirs is so that while they are
> still working on a branch and are not yet at a good "stop point" to e=
ven
> make a temporary commit to get interrupted, they find it sometimes
> necessary to be able to build the tip of that same branch and even ma=
ke a
> small in-working-tree fixes (which later will be carried back to the
> primary branch). The problem arises only when one of the repositories=
 try
> to update or delete the branch while it is checked out in another wor=
king
> tree.

That is not at all my experience of how workdirs are used.

> Can this series be extended/reworked so that:
>
> =C2=A0- Each branch has multi-value configuration record to note the =
workdirs
> =C2=A0 that it is checked out;

This is a good idea in any case for when "checkout --force" is used
(see below), so that we can find all the workdirs for other operations
that may need to.

> =C2=A0- Error out (or warn if forced) upon any attempt to update the =
tip of a
> =C2=A0 branch that is checked out in more than one place; and

I think that's a worse user experience. "Sorry, can't commit your
changes because you've checked out this branch elsewhere." Now the
user's choices are:

1. commit --force (and thus confusing the other workdirs)
2. checkout -b new_branch && commit

Both of which I think are worse than preventing the checkout in the fir=
st place.

> =C2=A0- Similarly for renaming or deleting a branch that is checked o=
ut in more
> =C2=A0 than one place.

Yep.

j.
