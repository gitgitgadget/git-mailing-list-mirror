From: Daniel Trebbien <dtrebbien@gmail.com>
Subject: Re: Why does git-svn redownload revisions?
Date: Wed, 8 Sep 2010 15:36:56 -0700
Message-ID: <AANLkTinOTgB7HkeVdB-+ttvVMT1HFg91nt6pdD6Y_uML@mail.gmail.com>
References: <loom.20100908T181056-819@post.gmane.org>
	<B1E94440-DDCA-4C10-A0EE-E08A66DF3D7E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 00:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtTGS-0002YN-GZ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 00:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab0IHWg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 18:36:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47008 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab0IHWg6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 18:36:58 -0400
Received: by ewy23 with SMTP id 23so503432ewy.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tWiVbP4Q+jL5vdqzsMDAvVqFXsQwUfzC2izy5XXCm0g=;
        b=rHU4HCBcxY2s7wLYdwWwKonFM3mvl4Du8H92BR5be3+qbjSBMMeLWDuJhsy1rbA0Js
         y0PmGzHLj4XUOXz5Hgy1XgnX0as8TmzavU7QFiIrLO3RqnGoJGY/8xKza/NLmzDeOOgj
         ULflRvPHGfG01IxZfcCHTdWT2YLZeYah0w9oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fl5rNo+ca2tVsi44vdN7Kd8Km6vHz6TpdWEVs13KUEineA4sAy0lkNXNYFxCQxtCYQ
         /FZZf4mfUzDycMFz6x3+ur4w2hsAgyTjcM6Becr2BGxTEd8RCtzpx5qntXAzW49K+63e
         LRZ8Z75fk78GMhsvZgzE2pdwtfwpiKCWhlZMY=
Received: by 10.213.7.7 with SMTP id b7mr95361ebb.30.1283985416965; Wed, 08
 Sep 2010 15:36:56 -0700 (PDT)
Received: by 10.14.37.70 with HTTP; Wed, 8 Sep 2010 15:36:56 -0700 (PDT)
In-Reply-To: <B1E94440-DDCA-4C10-A0EE-E08A66DF3D7E@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155819>

On Wed, Sep 8, 2010 at 10:19 AM, Brian Gernhardt
<benji@silverinsanity.com> wrote:
> This happens when you have a tag or branch that is a subdirectory of =
trunk. =C2=A0It looks like tags/nano_2_1_1 is a branch off trunk/nano. =
=C2=A0Git-svn doesn't recognize that trunk/nano@4248 is a subdirectory =
of trunk@4248 so it starts downloading the complete history of trunk/na=
no again.
>
> I've encountered the same problem when importing other SVN repos. =C2=
=A0If nano is the only subdirectory in trunk, you can fix this by chang=
ing your .git/config like this:
>
> - =C2=A0 =C2=A0 =C2=A0 fetch =3D trunk:refs/remotes/trunk
> + =C2=A0 =C2=A0 =C2=A0 fetch =3D trunk/nano:refs/remotes/trunk
>
> This will cause issues if nano is not the only directory in trunk (it=
 won't fetch the others) or if you have branches or tags that branch of=
f the full trunk (you get the same problem).
>
> Or you can downloading both trunk and nano as separate branches. =C2=A0=
I think it fetches each revision twice, but it will prevent it from dow=
nloading the entire history for each subdirectory branch.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D trunk:refs/remotes/trunk
> + =C2=A0 =C2=A0 =C2=A0 fetch =3D trunk/nano:refs/remotes/nano
>
> This will make your history look a little odd since trunk will have e=
very commit that nano does but be a completely separate branch. =C2=A0(=
It also seems to confuse `git-svn find-rev`.)
>
> You can also speed imports like this by creating a local mirror with =
svnsync and using `git svn clone --use-svnsync-props file:///local/mirr=
or`. =C2=A0This probably isn't a good long term solution, but can be ve=
ry handy when you're experimenting with getting it right. =C2=A0Once yo=
u have it set up as you like delete svn-remote.svn.useSvnsyncProps, cha=
nge svn-remote.svn.url to the original URL, and delete the local mirror=
=2E
>
> I've been investigating altering the algorithm that finds branch poin=
ts to understand branching off subdirectories, but haven't had the time=
=2E =C2=A0It's good to know that the Minix 3 repo isn't the only one th=
at does it.
>
> ~~ Brian

Looking through the Nano repository, it appears that early tags were
copies of the entire trunk, but later tags (`nano_2_0_8` and onward)
were copies of just `trunk/nano`.

Is there a way that I can inform git-svn that tags `nano_2_0_8`,
`nano_2_0_9`, ... should all be based off of `remotes/trunk/nano`?
