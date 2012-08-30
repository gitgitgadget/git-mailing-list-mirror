From: Jeff King <peff@peff.net>
Subject: Re: git archive --format zip utf-8 issues
Date: Thu, 30 Aug 2012 18:26:03 -0400
Message-ID: <20120830222603.GA20289@sigill.intra.peff.net>
References: <502583F4.8030308@tu-clausthal.de>
 <7vtxwagy9f.fsf@alter.siamese.dyndns.org>
 <5026C649.2090700@lsrfire.ath.cx>
 <5026D081.2040906@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7DBm-0003jR-1f
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 00:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab2H3W0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 18:26:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab2H3W0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 18:26:05 -0400
Received: (qmail 13975 invoked by uid 107); 30 Aug 2012 22:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Aug 2012 18:26:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2012 18:26:03 -0400
Content-Disposition: inline
In-Reply-To: <5026D081.2040906@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204571>

On Sat, Aug 11, 2012 at 11:37:05PM +0200, Sven Strickroth wrote:

> Am 11.08.2012 22:53 schrieb Ren=C3=A9 Scharfe:
> > The standard says we need to convert to CP437, or to UTF-8, or prov=
ide=20
> > both versions. A more interesting question is: What's supported by =
which=20
> > programs?
> >=20
> > The ZIP functionality built into Windows 7 doesn't seem to work wit=
h=20
> > UTF-8 encoded filenames (except for those that only use the ASCII=20
> > subset), and to ignore the UTF-8 part if both are given.
>=20
> I played a bit with the git source code and found out, that
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index f5af81f..e0ccb4f 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -257,7 +257,7 @@ static int write_zip_entry(struct archiver_args *=
args,
>  	copy_le16(dirent.creator_version,
>  		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
>  	copy_le16(dirent.version, 10);
> -	copy_le16(dirent.flags, flags);
> +	copy_le16(dirent.flags, flags+2048);
>  	copy_le16(dirent.compression_method, method);
>  	copy_le16(dirent.mtime, zip_time);
>  	copy_le16(dirent.mdate, zip_date);
> --
> works with 7-zip, however, not with Windows 7 build-in zip.
>=20
> If I create a zip file with 7-zip which contains umlauts and other
> unicode chars like (=E5=9C=8B=E7=AB=8B1-=D0=BA=D0=BA=D0=BA=D0=BA.txt)=
 the Windows 7 build-in zip displays
> them correctly, too.

Ping on this stalled discussion.

It seems like there are two separate issues here:

  1. Knowing the encoding of pathnames in the repository.

  2. Setting the right flags in zip output.

A full solution would handle both parts, but let's ignore (1) for a
moment, and assume we have utf-8 (or can massage into utf-8 from an
encoding specified by the user).

It seems like just setting the magic utf-8 flag would be the only thing
we need to do, according to the standard. But according to discussions
referenced elsewhere in this thread, that flag was invented only in
2007, so we may be dealing with older implementations (I have no idea
how common they would be; that may be the problem with Windows 7's zip
you are seeing). We could re-encode to cp437, which the standard
specifies, but apparently some implementations do not respect that
(and use a local code page instead). And it cannot represent all utf-8
characters, anyway.

It sounds like 7-zip has figured out a more portable solution. Can you
show us a sample of 7-zip's output with utf-8 characters to compare to
what git generates? I wonder if it is using a combination of methods.

-Peff
