From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Sun, 7 Jun 2009 18:31:38 +0800
Message-ID: <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
	 <m3vdnda9f7.fsf@localhost.localdomain>
	 <7vmy8p8947.fsf@alter.siamese.dyndns.org>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
	 <20090604160152.GA13984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 07 12:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDFfG-0003BJ-IZ
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 12:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbZFGKbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbZFGKbh
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 06:31:37 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43512 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbZFGKbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 06:31:36 -0400
Received: by pzk1 with SMTP id 1so1671858pzk.33
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=paC8+2DgmMJBlLkVRhLviUJpBeoadqh+Sirj1Vj2r7c=;
        b=HwvEeaFgCxIe5r/Ddk+yssRD4iwi6WGrEL9J+E8+00sGOZTLf5pEJDVuWQZatZKUcn
         v6FNkhNVcPEDJ5gC8ujVLS+cR31X8DAmQMvKWZGox106/cmHlDu1TfBZdmHJwlPPuWcG
         N0rv2izzgdSFKLF0i0eX8eqDxtwwu3Vd3VW48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mNBkIsWFFb3YbNIZNNMzE1ltdS3LLbSbjR24yU+pPjIOfwe1RISvIUFaHkW6+xn7/y
         kmcZohDUPXv/N8uxqEZkfc93rx2wexYDm4dnrnzsAei2765KEl/nzj+p6sNhlfflGUkc
         aySYwOnDjXHdyesti9ywoeOoEN3h71XZjFgeg=
Received: by 10.142.82.6 with SMTP id f6mr2012860wfb.182.1244370698268; Sun, 
	07 Jun 2009 03:31:38 -0700 (PDT)
In-Reply-To: <20090604160152.GA13984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120962>

Hi,

On Fri, Jun 5, 2009 at 12:01 AM, Jeff King<peff@peff.net> wrote:
> Thanks, I took a look at starting on a progress meter yesterday, but =
I
> do think it makes sense to integrate with the work you are doing.
>
> I tried your http-progress-indicators branch. A few comments:
>
> =A01. You still end up with a lot of lines of output. Some of those a=
re
> =A0 =A0 "Getting pack $x" which we can probably get rid of in non-ver=
bose
> =A0 =A0 mode. But we still get a different progress indicator line fo=
r each
> =A0 =A0 fetched item, which can add up to quite a lot. I was thinking=
 of
> =A0 =A0 something like
>
> =A0 =A0 =A0 =A0Fetching %s (got %d packs, %d loose): (%d/%d)
>
> =A0 =A0 with the substitutions:
>
> =A0 =A0 =A0 %s =3D "pack", "index", or "loose object"
> =A0 =A0 =A0 %d packs, %d loose =3D a running count of how much we've =
gotten
> =A0 =A0 =A0 %d/%d =3D current and total byte counts for what we are g=
etting now
>
> =A0 =A0 and then you could keep everything on a single line. I don't =
think
> =A0 =A0 is possible with the current progress code (it doesn't let yo=
u
> =A0 =A0 restart the counter), but it should be easy with some tweakin=
g.

Hmm, just wondering, is this is the intended display for "-q" or "-v"?
Or should I do isatty(), like builtin-pack-objects.c does for the
"Writing objects" progress indicator?

--=20
Cheers,
Ray Chuan
