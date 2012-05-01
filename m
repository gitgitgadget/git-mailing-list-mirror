From: David Aguilar <davvid@gmail.com>
Subject: Re: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Mon, 30 Apr 2012 22:32:50 -0700
Message-ID: <CAJDDKr778t=CufdtitbrhB-vJ3F=xSpSJ_G8e-VK8qCy8Fcfmg@mail.gmail.com>
References: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
	<87mx5tyy2a.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 01 07:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP5ho-0004cO-AK
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 07:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab2EAFcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 01:32:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62703 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab2EAFcv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 01:32:51 -0400
Received: by yenl12 with SMTP id l12so1829175yen.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 22:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fu7iULciEeV8I1+QAwFf2l9Tl5OnKtrBuccK3/tV3yU=;
        b=XtdzzLXpJGoTZTBmSTnNum1mCNGaiJOZyu7J5FRHDjR6dw1n8nODPtKyiTY4+TWsK1
         l61NNbWCdSqqb94h9obQJYbrr27WL2wBj5pwhw3swcefYx5WnQ3lKbFPB0PnxDajUZov
         +woLT078T5FBd9m/pd2sql4qUoHMyEEVlk7lH4v+BXNrwhps0rWdQJ4P2QELBHLUQf9V
         tOWv3Z/RIY/oUY6qVUxSO1uN708K2OFkjgT9OtwSqW7ON7bRP0+IY/3UiZncw4RQWrPt
         APvkAGGNXcGaUXDQvlhQDzXzRyFPMCO/y4yT7xux+9FvO/qPkfQwaS1rf4QST6mGXebs
         VYDw==
Received: by 10.236.144.134 with SMTP id n6mr24523876yhj.45.1335850371051;
 Mon, 30 Apr 2012 22:32:51 -0700 (PDT)
Received: by 10.146.153.6 with HTTP; Mon, 30 Apr 2012 22:32:50 -0700 (PDT)
In-Reply-To: <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196659>

On Mon, Apr 30, 2012 at 9:38 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Hi Brian
>
> I can reproduce this. =C2=A0The problem is that __WORDSIZE is not def=
ined,
> either because it's Darwin or because the GCC is too old. =C2=A0It wi=
nds up
> compiling the 32-bit case, which of course doesn't work for 64-bit
> builds.
>
> Perhaps we can rewrite it in terms of sizeof(long) like this?
>
> diff --git i/xdiff/xutils.c w/xdiff/xutils.c
> index e05b5c9..1b3b471 100644
> --- i/xdiff/xutils.c
> +++ w/xdiff/xutils.c
> @@ -290,39 +290,33 @@ static inline unsigned long has_zero(unsigned l=
ong a)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ((a - ONEBYTES) & ~a) & HIGHBITS;
> =C2=A0}
>
> -#if __WORDSIZE =3D=3D 64
> -
> -/*
> - * Jan Achrenius on G+: microoptimized version of
> - * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
> - * that works for the bytemasks without having to
> - * mask them first.
> - */
> =C2=A0static inline long count_masked_bytes(unsigned long mask)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return mask * 0x0001020304050608 >> 56;
> -}
> -
> -#else =C2=A0/* 32-bit case */
> -
> -/* Modified Carl Chatfield G+ version for 32-bit */
> -static inline long count_masked_bytes(long mask)
> -{
> - =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* (a) gives us
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 -1 (0, ff), 0 (ffff) or 1 (ffff=
ff)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* (b) gives us
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 0 for 0, 1 for (ff ffff ffffff)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* (a+b+1) gives us
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 correct 0-3 bytemask count resu=
lt
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 long a =3D (mask - 256) >> 23;
> - =C2=A0 =C2=A0 =C2=A0 long b =3D mask & 1;
> - =C2=A0 =C2=A0 =C2=A0 return a + b + 1;
> + =C2=A0 =C2=A0 =C2=A0 if (sizeof(long) =3D=3D 8) {


Isn't the whole point of this code to be fast?

This should be a compile-time check... conditionals hurt perf.
--=20
David
