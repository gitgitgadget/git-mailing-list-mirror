From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 5/6] Allow to use crc32 as a lighter checksum on index
Date: Mon, 6 Feb 2012 19:17:04 -0800
Message-ID: <CAJo=hJvSyhv8EUh=6ROotc3Q=zQo7vbww_ShQJP3tf1T7s889g@mail.gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com> <1328507319-24687-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 04:17:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RubYh-0007Ud-OB
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 04:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab2BGDR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 22:17:27 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60803 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab2BGDR0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 22:17:26 -0500
Received: by daed14 with SMTP id d14so26154dae.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 19:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EGuGiaeT+CZQI8+nNP4qbO+xsAs9v+eNay1oSZtsdgc=;
        b=QRzEVhD5OisETblI/b7mtE7+UFRzesDfKYdka+uwYJWSUcLdTS1zoyCVs2uG7/baeD
         3LR9fOXglhQFtGOt+3+vG/bCuB99M3Vlk+pZNWMAWLUv8wSowvW81Fmz2B3wMrbQjzL9
         whhmgbXjb5doSQEApFBynjlcBoy49P7+WyIdE=
Received: by 10.68.217.67 with SMTP id ow3mr42051022pbc.125.1328584644054;
 Mon, 06 Feb 2012 19:17:24 -0800 (PST)
Received: by 10.68.50.10 with HTTP; Mon, 6 Feb 2012 19:17:04 -0800 (PST)
In-Reply-To: <1328507319-24687-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190133>

2012/2/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hdr->hdr_signature !=3D htonl(CACHE_SI=
GNATURE))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("=
bad signature");
> - =C2=A0 =C2=A0 =C2=A0 if (hdr->hdr_version !=3D htonl(2) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr->hdr_version !=3D htonl(3) &=
&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr->hdr_version !=3D htonl(4))
> + =C2=A0 =C2=A0 =C2=A0 if (hdr->hdr_version =3D=3D htonl(2) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr->hdr_version =3D=3D htonl(3)=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_crc =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 else if (hdr->hdr_version =3D=3D htonl(4)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ext_cache_h=
eader *ehdr =3D (struct ext_cache_header *)hdr;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_crc =3D ntohl(e=
hdr->hdr_flags) & CACHE_F_CRC;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 else

Ick. Ick. Ick. Please $DEITY no.

When it comes to data integrity codes in Git... PICK ONE AND STICK WITH=
 IT.

If CRC-32 is good enough to protect the index content such that disk
corruption is probably detectable with it, lets just switch to CRC-32
in index version 4. Don't make it optional with a new header field
that wasn't there in version 3 and is now only able to accept 32 bits
of flags before we have to go and create index version 5. We already
have a cache extension system available with extension codes in the
footer of the index file. We don't need YET ANOTHER EXTENSION SYSTEM.

If CRC-32 is not good enough, and we don't want to trust it (or
really, YOU don't want to trust it) please do not then go and propose
that a less knowledgeable user should switch to CRC-32 "because it is
faster". If we don't want to rely on the error detection of CRC-32,
then we should be using SHA-1. Or SHA-256.


I haven't really put a lot of thought into this. But I suspect CRC-32
is sufficient on the index file, until it gets so big that the
probability of a bit flip going undetected is too high due to the size
of the file, but then we are into the "huge" index size range that has
you trying to swap out SHA-1 for CRC-32 because SHA-1 is too slow. Uhm
no.

CRC-32 may be good enough, we use it inside of the pack-objects when
doing repacking locally and don't want to inflate objects to check
SHA-1, but do want to try and detect a random bit flip caused by a
broken file copier. Thus far its held up well there. Given the very
transient nature of the index file (and how it can be mostly rebuilt
from a tree object and the working directory), CRC-32 might be good
enough. But please pick one.
