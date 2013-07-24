From: =?iso-8859-1?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 11:59:01 +0200
Message-ID: <F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de> <CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Joern Hees <dev@joernhees.de>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 11:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1vqr-0001DR-8P
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 11:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab3GXJ7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 05:59:17 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:50062 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab3GXJ7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 05:59:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 37BC6E8C2B4;
	Wed, 24 Jul 2013 11:59:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OF68VKsl4xov; Wed, 24 Jul 2013 11:59:01 +0200 (CEST)
Received: from [192.168.83.24] (dfki-098.dfki.uni-kl.de [131.246.194.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id 757ECE8C2B3;
	Wed, 24 Jul 2013 11:59:01 +0200 (CEST)
In-Reply-To: <CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231090>

Hi,

On 24.07.2013, at 10:52, Antoine Pelisse <apelisse@gmail.com> wrote:
> I think the best way would be to create the shared repository in
> .git/hg/$share, with $share being a path that can't be a remote name
> (so that it doesn't conflict with remote directories),
> and then apply the following patch (copied in gmail)

Maybe ".git/hg/.share"?


> diff --git a/contrib/remote-helpers/git-remote-hg
> b/contrib/remote-helpers/git-remote-hg
> index 0194c67..21c8091 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -390,7 +390,7 @@ def get_repo(url, alias):
>         if not os.path.exists(dirname):
>             os.makedirs(dirname)
>     else:
> -        shared_path =3D os.path.join(gitdir, 'hg')
> +        shared_path =3D os.path.join(gitdir, 'hg', $share)
>         if not os.path.exists(shared_path):
>             try:
>                 hg.clone(myui, {}, url, shared_path, update=3DFalse, =
pull=3DTrue)
>=20
> That way, the share can be created even if .git/hg already exists
> (because of a previous import, before the shared machinery existed, o=
r
> because you already have a local remote).

I like the idea of having independent remotes (fetching one, doesn't up=
date another). http://mercurial.selenic.com/wiki/ShareExtension warns a=
bout this, and i wasn't sure it wouldn't cause intricate bugs. This is =
why I opted for the explicit cloning, no shared history for several rem=
otes.

I'd really like some feedback on this one as he probably knows the hg i=
nternals well enough that he can make a more educated guess on this tha=
n I can: when you import several hg remotes and fetch them / push to on=
e, wouldn't such a shared repo cause problems?
If unsure i still opt for my version as it keeps things isolated at the=
 cost of some optimization.


>> Changing gitdir to dirname causes shared_path =3D=3D
>> .git/hg/<remote_name>/hg. The call to hg.share with local_path =3D=3D
>> .git/hg/<remote_name>/clone works again.
>=20
> I think that will be a problem, because then the shared_path will no
> longer be shared, will it ?

Yupp, the shared_paths won't be shared, so it's not as optimal as possi=
ble, but it will work at least ;)

Cheers,
J=F6rn
