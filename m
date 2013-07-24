From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 16:21:33 +0200
Message-ID: <11280A0C-C7C7-4B26-95FE-5C91EF191276@joernhees.de>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de> <CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com> <F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de> <CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 16:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1zxD-0001Cd-O1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 16:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3GXOWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 10:22:04 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:56117 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab3GXOVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 10:21:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 2D52BE8C2B6;
	Wed, 24 Jul 2013 16:21:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SMu6MdOKKKy; Wed, 24 Jul 2013 16:21:33 +0200 (CEST)
Received: from [192.168.83.24] (dfki-098.dfki.uni-kl.de [131.246.194.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id C0C8BE8C2AE;
	Wed, 24 Jul 2013 16:21:33 +0200 (CEST)
In-Reply-To: <CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231098>


On 24.07.2013, at 15:14, Antoine Pelisse <apelisse@gmail.com> wrote:

> On Wed, Jul 24, 2013 at 11:59 AM, J=F6rn Hees <dev@joernhees.de> wrot=
e:
>> On 24.07.2013, at 10:52, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> I think the best way would be to create the shared repository in
>>> .git/hg/$share, with $share being a path that can't be a remote nam=
e
>>> (so that it doesn't conflict with remote directories),
>>=20
>> Maybe ".git/hg/.share"?
>=20
> According to Documentation/git-check-ref-format.txt, I'm not sure if
> we should start with a dot, or end with it.

I favor starting with a dot as it's nothing the user should fiddle with=
 ;)

>>> That way, the share can be created even if .git/hg already exists
>>> (because of a previous import, before the shared machinery existed,=
 or
>>> because you already have a local remote).
>>=20
>> I like the idea of having independent remotes (fetching one, doesn't=
 update another). http://mercurial.selenic.com/wiki/ShareExtension warn=
s about this, and i wasn't sure it wouldn't cause intricate bugs. > Thi=
s is why I opted for the explicit cloning, no shared history for severa=
l remotes.
>=20
> I think the goal of using sharing here is that Mercurial and Git may
> use different schemes to handle branches. Mercurial may lead you to
> have separate repositories for each branch (They seem to do it for it=
s
> own development [1]). All these branches actually share most of the
> same history, and are fully related, and we usually handle this
> situation in Git with one repository with multiple branches.
> Using "hg share", we allow a smooth transition from Mercurial model t=
o
> Git model by merging all Mercurial repositories into one, and then ma=
p
> this single repository to the Git repository.
> IOW, the goal is to have only one copy of each "hg object" that are
> shared amongst many "remotes" (and potentially import them only once,
> though I don't think it currently works for me).

Alright, i just tested it out by sharing several repos and pushing to o=
ne of them, then fetching all again. Behavior seems as expected, so the=
 remotes and their branches shown are isolated correctly.
Plus the initial fetching is quite a lot faster, less disk space used, =
etc=85
So i think this is the way to go, thanks for the nudge.


>>>> Changing gitdir to dirname causes shared_path =3D=3D
>>>> .git/hg/<remote_name>/hg. The call to hg.share with local_path =3D=
=3D
>>>> .git/hg/<remote_name>/clone works again.
>>>=20
>>> I think that will be a problem, because then the shared_path will n=
o
>>> longer be shared, will it ?
>>=20
>> Yupp, the shared_paths won't be shared, so it's not as optimal as po=
ssible, but it will work at least ;)
>=20
> If we decided to remove the sharing idea, I think we should revert
> Felipe's commit rather than leave the shared_path variable, and call
> hg.share() on repository we don't even mean to share. That would be
> very confusing.

+1

I'll prepare a v2 of the patch.

Cheers,
J=F6rn
