From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command 
	line
Date: Thu, 9 Jul 2009 10:01:45 +0200
Message-ID: <81b0412b0907090101x7c8aa182o36687d67be3c5fb0@mail.gmail.com>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
	 <200907081558.51767.johan@herland.net>
	 <4A54B755.4090100@viscovery.net>
	 <200907081801.36901.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOoZl-0008On-QP
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbZGIIBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2009 04:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbZGIIBr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:01:47 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36206 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZGIIBr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:01:47 -0400
Received: by fxm18 with SMTP id 18so6220423fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nl1cNZ8oJcw+1IDF+1bXggQZFe+ZGN7qj12l7/BPI5c=;
        b=toi4udsue5eTndYHJPjRaPI601aPuJ7t2xWFuuKdj7WHwbHlS+nB0pNz8R5bBX8fx6
         whdwbr1FaOZKt2ncqCv3KE2Qt8xoEJrQ9+gWa2DJe0Pu6GedbqWoAoW9TNRr05YhouBI
         oXq1AniPSBjT2enIraop55sn6e6P/YaaS88cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GTtxRtna3snpW/rae8DxG7ya+NnVaGmsAJPUsTE1GE40DotMQtbOa/YEtRY3lEeQLO
         p7aL0NQv3mxC1FFqjgSAQXyUh7xDp24LZtgUXzfCs6dC1AOHzLPRYUq0OFX3LPbytUjU
         xgLvbEdtLiWPuVk3MnpV/c64P/vJnBLuzL934=
Received: by 10.204.117.20 with SMTP id o20mr480551bkq.1.1247126505479; Thu, 
	09 Jul 2009 01:01:45 -0700 (PDT)
In-Reply-To: <200907081801.36901.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122940>

On Wed, Jul 8, 2009 at 18:01, Johan Herland<johan@herland.net> wrote:
> On Wednesday 08 July 2009, Johannes Sixt wrote:
>> ... don't you get this error message with errno set to EPIPE?
>> Previously, there was no error message.
>
> Indeed, you are correct. I guess the following should be added to the
> patch:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write_in_full(revlist.in, sha1_to_hex(=
ref->old_sha1), 40) < 0 ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_in_full(revlist.in, "\=
n", 1) < 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("failed writ=
e to rev-list");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D errno;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D EPI=
PE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 error("failed write to rev-list");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 err =3D errno;

You'll loose errno this way: error() does not save it.
