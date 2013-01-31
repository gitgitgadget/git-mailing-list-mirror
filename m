From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Thu, 31 Jan 2013 19:33:52 +0100
Message-ID: <510AB910.5050504@lsrfire.ath.cx>
References: <20130131172805.GC16593@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0yxs-0003td-En
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab3AaSeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jan 2013 13:34:01 -0500
Received: from india601.server4you.de ([85.25.151.105]:38844 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab3AaSeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:34:00 -0500
Received: from [192.168.2.105] (p4FFDA9BF.dip.t-dialin.net [79.253.169.191])
	by india601.server4you.de (Postfix) with ESMTPSA id 39E5ADC;
	Thu, 31 Jan 2013 19:33:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130131172805.GC16593@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215141>

Am 31.01.2013 18:28, schrieb Greg KH:
> I tracked this down to commit 22f0dcd9634a818a0c83f23ea1a48f2d620c054=
6
> (archive-tar: split long paths more carefully).  The diff of a hex du=
mp
> of the tar archives shows the following difference:
>=20
> --- old_git_archive	2013-01-31 17:31:24.466343388 +0100
> +++ new_git_archive	2013-01-31 17:32:21.509674417 +0100
> @@ -19239998,8 +19239998,8 @@
>  125943d0:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  125943e0:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  125943f0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> -12594400:0000 0000 0000 0000 0000 0000 0000 0000  ................
> -12594410:0000 0000 0000 0000 0000 0000 0000 0000  ................
> +12594400:7765 7374 6272 6964 6765 2d6f 6d61 7033  westbridge-omap3
> +12594410:2d70 6e61 6e64 2d68 616c 2f00 0000 0000  -pnand-hal/.....
>  12594420:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  12594430:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  12594440:0000 0000 0000 0000 0000 0000 0000 0000  ................
> @@ -19240025,8 +19240025,8 @@
>  12594580:2f61 7374 6f72 6961 2f61 7263 682f 6172  /astoria/arch/ar
>  12594590:6d2f 706c 6174 2d6f 6d61 702f 696e 636c  m/plat-omap/incl
>  125945a0:7564 652f 6d61 6368 2f77 6573 7462 7269  ude/mach/westbri
> -125945b0:6467 652f 7765 7374 6272 6964 6765 2d6f  dge/westbridge-o
> -125945c0:6d61 7033 2d70 6e61 6e64 2d68 616c 0000  map3-pnand-hal..
> +125945b0:6467 6500 0000 0000 0000 0000 0000 0000  dge.............
> +125945c0:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  125945d0:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  125945e0:0000 0000 0000 0000 0000 0000 0000 0000  ................
>  125945f0:0000 0000 0000 0000 0000 0000 0000 0000  ................

This is the only directory in the repository whose path is long enough =
to
make a difference with the patch, 105 characters in total:

drivers/staging/westbridge/astoria/arch/arm/plat-omap/include/mach/west=
bridge/westbridge-omap3-pnand-hal/

=46ive characters less and you wouldn't notice a thing.  It contains
"westbridge" thrice, so I think it's cheating just to reach that
length, though. ;-)

> Interestingly, the output of uncompressing the tar archives is
> identical, so the data is correct, but the binary isn't.

The path is split differently between two header fields, that's all.

> Now keeping binary compatibility of tar archive files isn't really a =
big
> deal, but, the commit to git that causes this seems a bit odd, is it
> really needed?  Or can we just fix the version of tar with NetBSD
> instead?  :)

Apart from Junio's suggestion, I can't think of a practical solution.

You could downgrade your git to a version before the fix.  A downside i=
s
that you won't be able to extract the archive on NetBSD without getting
an error message (but the contents would be intact, except perhaps for
permission bits of the directory above).

You could upgrade the kernel.org version of git, but that might cause t=
he
same problem for other maintainers with long directory paths who in the=
ir
repositories who still use git without the fix.

You could make the path shorter.  Won't help at all with the release yo=
u
just did, of course.

I don't know if other tar implementations freak out when they see an
empty name field.  NetBSD's tar might seem a bit too strict here, but
overall I think it's right in complaining.

What makes the commit odd, by the way?

Thanks,
Ren=E9
