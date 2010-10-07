From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Thu, 7 Oct 2010 08:29:35 +0200
Message-ID: <AANLkTim_3m=YmyVL7eEoWDGwDwmuDJsYkQMgx8ciVPH0@mail.gmail.com>
References: <1286431561-24126-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 08:30:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jzR-0005Sd-Es
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 08:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446Ab0JGGaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 02:30:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41057 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0JGG37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 02:29:59 -0400
Received: by gye5 with SMTP id 5so157077gye.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j3OfgofVbqMXIDv1d87HMBLUGXdRcMdq6x1kbKQkSJo=;
        b=UPrrgcXsYXVkpTl2PARxtxkpMJ2U8UlIrR3i1O/NGUxlyu3vIpkvCdUDgHX11JwpBd
         DUEpdl0RpHJcgHE8PjgagdMW9HTFcbuDA7tNB/G+8QT6lATeW2bBttr4Kc0sgVPKAX7r
         uY3zKHh0DyKGz31NXLprhnJ6dc/70uHlacSSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FNCpvWkAA7gElD5H4v0Wvw587YcZm+zjHjCKCXzIgx4G2yW0PwlWg8cK/WE184L57i
         Xj3z6Pe9Wk0LBUmGF/BpUd8ZlwveM+ZEz25SVIG33P87Rind5vtaDuNaZOqmyupplyvj
         pnXbvNdghG7TAi1RHsN+AR/1xNBcIzMihfnOw=
Received: by 10.151.127.28 with SMTP id e28mr499907ybn.158.1286432996114; Wed,
 06 Oct 2010 23:29:56 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Wed, 6 Oct 2010 23:29:35 -0700 (PDT)
In-Reply-To: <1286431561-24126-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158377>

Heya,

On Thu, Oct 7, 2010 at 08:06, David Barr <david.barr@cordelta.com> wrot=
e:
> This python script walks the commit sequence imported by svn-fe.
> For each commit, it tries to identify the branch that was changed.
> Commits are rewritten to be rooted according to the standard layout.
> A basic heuristic of matching trees is used to find parents for the
> first commit in a branch and for tags.

Nice, how easy would it be to extend it to deal with other layouts?

> diff --git a/fast-import.c b/fast-import.c
> index 2317b0f..8f68a89 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1454,6 +1454,15 @@ static int tree_content_set(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D slash1 -=
 p;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D strlen(p=
);
> + =C2=A0 =C2=A0 =C2=A0 if (!slash1 && !n) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!S_ISDIR(mode)=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("Root cannot be a non-directory");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hashcpy(root->vers=
ions[1].sha1, sha1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (root->tree)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 release_tree_content_recursive(root->tree);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 root->tree =3D sub=
tree;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!n)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("Empty pat=
h component found in input");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!slash1 && !S_ISDIR(mode) && subtree)

What is this hunk about?

--=20
Cheers,

Sverre Rabbelier
