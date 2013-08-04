From: =?iso-8859-1?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 15:51:27 +0200
Message-ID: <668358E0-3483-4DA0-92DD-D72B02C9FBE8@joernhees.de>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de> <1375612683-9104-1-git-send-email-apelisse@gmail.com> <478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de> <CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 15:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5yie-0006QU-9p
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 15:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab3HDNvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 09:51:32 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:48770 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab3HDNvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 09:51:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id DAA53E810D2;
	Sun,  4 Aug 2013 15:51:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2E3R3epr040l; Sun,  4 Aug 2013 15:51:28 +0200 (CEST)
Received: from [192.168.2.12] (xdsl-89-0-67-44.netcologne.de [89.0.67.44])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id F3664E810D1;
	Sun,  4 Aug 2013 15:51:27 +0200 (CEST)
In-Reply-To: <CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231628>

On 4 Aug 2013, at 15:31, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:
> git config --get-regexp '^remote.*.url' is probably more appropriate.
>=20
> Either way, I don't see why such a change should be in the same patch=
=2E

+1


> This is my solution:
>=20
> --- a/contrib/remote-helpers/git-remote-hg.py
> +++ b/contrib/remote-helpers/git-remote-hg.py
> @@ -391,11 +391,22 @@ def get_repo(url, alias):
>             os.makedirs(dirname)
>     else:
>         shared_path =3D os.path.join(gitdir, 'hg')
> -        if not os.path.exists(shared_path):
> -            try:
> -                hg.clone(myui, {}, url, shared_path, update=3DFalse,=
 pull=3DTrue)
> -            except:
> -                die('Repository error')
> +
> +        # check and upgrade old organization
> +        hg_path =3D os.path.join(shared_path, '.hg')
> +        if os.path.exists(shared_path) and not os.path.exists(hg_pat=
h):
> +            repos =3D os.listdir(shared_path)
> +            for x in repos:
> +                local_hg =3D os.path.join(shared_path, x, 'clone', '=
=2Ehg')
> +                if not os.path.exists(local_hg):
> +                    continue
> +                shutil.copytree(local_hg, hg_path)
> +
> +        # setup shared repo (if not there)
> +        try:
> +            hg.peer(myui, {}, shared_path, create=3DTrue)

Didn't look this up, this will raise the error below when it exists alr=
eady?


> +        except error.RepoError:
> +            pass
>=20
>         if not os.path.exists(dirname):
>             os.makedirs(dirname)
>=20
> It should also work in all the cases, but there would not be an extra
> unnecessary clone while upgrading, and it doesn't sneak in any other
> changes.

+1
Seems to be the best fix until now.

Cheers,
J=F6rn