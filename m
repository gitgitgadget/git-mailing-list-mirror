From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH] FindBugs: don't use new String(String) in RefDatabase
Date: Mon, 13 Jul 2009 10:07:02 +0200
Message-ID: <551f769b0907130107j51d32e4er54e125f9dc61dd80@mail.gmail.com>
References: <49C20D4E.5020203@gmail.com> <20090319160102.GQ23521@spearce.org>
	 <551f769b0907090147x9b78604i77a095441f232703@mail.gmail.com>
	 <20090710153441.GF11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 10:14:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQGf1-0002Nt-E0
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 10:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZGMINL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 04:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbZGMINK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 04:13:10 -0400
Received: from mail-bw0-f223.google.com ([209.85.218.223]:48548 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZGMINK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 04:13:10 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2009 04:13:09 EDT
Received: by bwz23 with SMTP id 23so683484bwz.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UUe5H1u0M8q0FCCyZ0r5ECvspeZOluzX0H6CjHvdoK0=;
        b=eAKKqkTR6ceJ5pxV2ICp1v5ikl+GXHRJ7pOfrgAYwgi6R/uZRlrJTHqmHyEqktKgGq
         fFR3Fwnk4zSR2JAxAH4DNRaaca3qIzC506kPc4UVB+PxHQDkIaD+KqTE+xsaW5gCmz/5
         tufbWGCtpqmvOaLePHcs/KMRDZGp1sn/oNOp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R+AkIy4UdXyIpRwvAWihpQelAb+kmXFjOUqWscRXLlMJ6ht76F6MFLlLQaCLnvUFsC
         +E4CrcSfg5m5id0ml0jbiqSyzOwNbq46rOrMQlgOOa+3sqq0Juohvz79bcxXXfmhAXRz
         QPRdiJjsFQhTzEH5TyRxMJJK6eIrTlntFNrIc=
Received: by 10.223.126.66 with SMTP id b2mr1816778fas.3.1247472422045; Mon, 
	13 Jul 2009 01:07:02 -0700 (PDT)
In-Reply-To: <20090710153441.GF11191@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123174>

2009/7/10 Shawn O. Pearce <spearce@spearce.org>:
> =C2=A0Yann Simon <yann.simon.fr@gmail.com> wrote:
> =C2=A0>
> =C2=A0> However, using the trick newString =3D new String(aString.sub=
string(),
> =C2=A0> i) does not work on all JVM.
> =C2=A0> With an IBM JVM, the newString will still contain the origina=
l array of chars.
> =C2=A0>
> =C2=A0> Another solution that work on all JVM could be:
> =C2=A0> newString =3D new String(aString.substring(i).toCharArray())
> =C2=A0> Or
> =C2=A0> newString =3D new String(aString.toCharArray(), i, aString.le=
ngth() - i)
> =C2=A0>
> =C2=A0> I like the latter one.
>
> =C2=A0I prefer this. =C2=A0It should always do what we want, and at a=
 lower
> =C2=A0temporary memory footprint (one less copy of the name). =C2=A0I=
IRC Robin
> =C2=A0rejected it earlier because it wasn't obvious what we were doin=
g. I
> =C2=A0say hogwash, its clear as mud.
>
> + =C2=A0 =C2=A0 =C2=A0 private static String copy(final String src, f=
inal int off, final int end) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return new StringB=
uilder(end - off).append(src, off, end).toString();
> + =C2=A0 =C2=A0 =C2=A0 }
> +

This method is quite clear.
One line javadoc would make it even clearer... :p (and maybe make Robin=
 happy)

And you're right: by using a StringBuilder, we need one less arraycopy.

After committing your change, we can remove the entry to silent FindBug=
s.
(commit 21c3d82824075cd1f140b3bcf252dfaffe0fc96c)

Yann
