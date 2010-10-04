From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid warning
Date: Mon, 4 Oct 2010 09:47:43 +0000
Message-ID: <AANLkTimBzC7f7teH8Rriykg7o5kwX6mD2g2q-0yOXSiF@mail.gmail.com>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
	<20101004093519.GN24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@netbsd.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 11:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2heB-0006N4-2I
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0JDJrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:47:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45804 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0JDJrp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 05:47:45 -0400
Received: by iwn5 with SMTP id 5so6707826iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K5Pufseivzw/1VwhA5Tnxa5iEny1sUwecQL9iDnuPso=;
        b=xen7AS84pVzbxpix5IemAQDpiEiRnBMnTPYLWoaRxXk8s230Qx9LRjnf1GdYX5Tj1w
         mmpUtGhNlBxxHMrhL9RantYsGVVkIKSw57KeyFInmuTVH0/SlgGnLKZB3uJJd0u9L4O6
         9xoWsXALP2kRr39z8RbnaZ4+2ghqnlN38O6GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RhB1JeZZvmtoDeI9pi5EHyAE+37YHun1iLABB7Fho3JFm82qOagDbHNX032X7dcbtu
         uuSola96M1335aTIVmwa6vuceZ1+VA2Ks1KkFxbNNUwPh5q8dT+D9qVdW/Ir8NsaJCJt
         +4LTkHzSNyEPtdBAyHlWlCNQ9NERFoe+HYDHA=
Received: by 10.231.11.71 with SMTP id s7mr8188176ibs.85.1286185663898; Mon,
 04 Oct 2010 02:47:43 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 02:47:43 -0700 (PDT)
In-Reply-To: <20101004093519.GN24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158021>

On Mon, Oct 4, 2010 at 09:35, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> - =C2=A0 =C2=A0 unsigned mode =3D canon_mode(S_IFREG | 0644);
>> + =C2=A0 =C2=A0 unsigned mode =3D canon_mode((S_IFREG | 0644));
>
> Just curious:
>
> #define canon_mode(mode) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(S_ISREG(mode) ? (S_IFREG | ce_permissions=
(mode)) : \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? =
S_IFDIR : S_IFGITLINK)
>
> #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
>
> Since S_ISREG et al are macros, typically they would put their
> argument in parentheses in the definition. =C2=A0How are they defined
> in NetBSD sys/stat.h? =C2=A0What is canon_mode(S_IFREG | 0644) being
> misinterpreted to mean?

Oh it's a bug in NetBSD, sorry for not being explicit about that:

    $ grep S_ISREG /usr/include/sys/stat.h
    #define S_ISREG(m)      ((m & _S_IFMT) =3D=3D _S_IFREG)     /* regu=
lar file */

    $ grep S_ISREG /usr/include/linux/stat.h
    #define S_ISREG(m)      (((m) & S_IFMT) =3D=3D S_IFREG)

I.e. GCC sees `S_IFREG | 0644 & _S_IFMT' on NetBSD but `(S_IFREG |
0644) & _S_IFMT' on Linux.

Since bitwise AND (&) has precedence over bitwise OR it's probably a
logic error on NetBSD too, not just an annoying warning.
