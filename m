From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Missing blobs after pruning dangling commits
Date: Tue, 23 Aug 2011 11:29:09 +0200
Message-ID: <4E5372E5.1070509@drmicha.warpmail.net>
References: <CAC9GOO-cAKTvUyKvrijA8H8z4uRFkTjzJ_dqS_-aO1MYB-yaTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?TWFyY2luIFdpxZtuaWNraQ==?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 11:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvnIL-000502-LG
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 11:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab1HWJ3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 05:29:13 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33946 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754956Ab1HWJ3M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 05:29:12 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D285B20B5E;
	Tue, 23 Aug 2011 05:29:11 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 23 Aug 2011 05:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KWy94bpmC2S5KNA7cmZk8R
	ULpsw=; b=UWwr80hkl2q4z431IJr+V6btHn+AI6xHO+HRNYX3tWisT0oP2ZaVgi
	vPiOTYaw5NBQDXEGP3OeE2fcCakoe26cTW+fj7z1Ncah8PIdufV3jyG+MhHC7hl9
	s89XnEHotTnuHD/HkiCqTBhn9iYxtNxTlFfCUXJ95kQcy10nD1JHI=
X-Sasl-enc: EiARJF0en/4wJQhSXSC78KtVWmS6QlUtMHfLnUoFK5rk 1314091751
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5847F7C00B7;
	Tue, 23 Aug 2011 05:29:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAC9GOO-cAKTvUyKvrijA8H8z4uRFkTjzJ_dqS_-aO1MYB-yaTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179930>

Marcin Wi=C5=9Bnicki venit, vidit, dixit 22.08.2011 16:29:
> Hello,
>=20
> recently I had git-fsck report some dangling references:
>=20
> $ git fsck
> dangling commit 9275ee571ead7a75ba57e16ba23155a178459918
> dangling commit 047bd63ae82b7540098515467f50562e374edada
> dangling commit 839cee3c8e16231e6523ecf8b855ef0863787990
> dangling commit f7cb119ea71cb3cc739331f2e26bf3e9fdbba24a
> dangling commit 68d41b28f320aff303c5a89b25e2243ad2e526f2
> dangling commit effcf50a636d2f08e21706f41eb8ae3c4c577166
>=20
> This is completely local (isolated) repository.
> Based on related FAQ entry ("remove old objects after filter-branch")=
,
> I did this:
>=20
> $ git reflog expire --expire=3D0 --all
> $ git repack -ad
> $ git prune
>=20
> Unfortunately, now fsck complains:
>=20
> $ git fsck
> missing blob 6d2ddd86d4594f8c756cc31b72d61653255a3161
> missing blob 6c537408f0b2226c0b6dae9b0ef0f92710fb25ed
> missing blob 2db55c1e39fd80e39eccefc617b852d3ac93abe9
> $ git --version
> git version 1.7.6.msysgit.0
>=20
> Is this a bug ?
>=20
> Also, how can I find where this blob came from. I've tried grepping
> all commits in original repo (from backup):
>=20
> $ gitwhich() {
>   git log --all --pretty=3Dformat:'%T %H' | while read tree commit; d=
o
>     git ls-tree -r $tree | grep -q $1 && echo $commit;
>   done
> }
> $ gitwhich 2db55c1e39fd80e39eccefc617b852d3ac93abe9
>=20
> but nothing was found.

Suggestions:

Try git fsck --unreachable.
There may be tree objects which reference those blobs but are not
referenced by a tree or commit. (They should have been pruned, but coul=
d
have been stuck in a pack.)

Try repacking again after the prune step.

Could you share that repo or is it private?

Michael
