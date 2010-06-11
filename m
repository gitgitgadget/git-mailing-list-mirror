From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH next] fast-import: revert die_nicely() to vsnprintf
Date: Fri, 11 Jun 2010 15:18:10 +0200
Message-ID: <AANLkTikIQeY1ZieEkev_zjDSVI9W1NpfhiyTNCaToeys@mail.gmail.com>
References: <29df1a625a82bd2d3fcee92068b3a15f56435c66.1276199549.git.trast@student.ethz.ch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 11 15:23:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON4Ct-0004gp-29
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 15:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab0FKNSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 09:18:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46537 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab0FKNSP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 09:18:15 -0400
Received: by wyb40 with SMTP id 40so735852wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=X3ZJgbbcvsUDrmKPy3Qq5iqR9A8bcIbs9TkfVtgW0Rs=;
        b=Gm9B04+2sPVM+tVglIV6dvE2To06PHCBCURtDSufGor/VQk8PnMlFbocBDbsMp4GPP
         0/upDnVU5LfPfBhWI674/IFnfxyF/lxN31TtpeCR5pTd0U3K0JjjJIA9CyCsF7mSYR6W
         q4O6W6Gd1UdAKnPfB5zaqhYqRjqrHZCV69DVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=aqKqsssKChKrx3noQgohXidQPRQIl19ii5viE1wZZbMHsxM1OuPPh2mc0JLa41sxAB
         AKrt1xaa6wOQKA1gR15BbWPZfM/F9MN0D4w8VdpuUJoxqxrYhWHH1W0pvcFvte5Efgy2
         e/r/s6ZPYD3UdApbVAZ1JNAEEfhioL667QNL0=
Received: by 10.216.90.211 with SMTP id e61mr1257420wef.1.1276262290646; Fri, 
	11 Jun 2010 06:18:10 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Fri, 11 Jun 2010 06:18:10 -0700 (PDT)
In-Reply-To: <29df1a625a82bd2d3fcee92068b3a15f56435c66.1276199549.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148944>

On Thu, Jun 10, 2010 at 9:55 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> ebaa79f (Make report() from usage.c public as vreportf() and use it.,
> 2010-03-06) changed fast-import's die_nicely() to use vreportf().
>
> This requires some more care though. =A0First it forgot that we also
> need to reformat the message for the crash report. =A0Second, vreport=
f()
> uses vsnprintf(), which does not call va_end(). =A0This leaves the
> va_list passed to it in an undefined state. =A0Therefore we need to m=
ake
> a copy of this va_list so that we can reuse it.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Another valgrind catch. =A0I think that'll be the last one for today.
> Thanks for your attention.
>
>
> =A0fast-import.c | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index c0728c2..1fa5de4 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -483,12 +483,14 @@ static void dump_marks(void);
> =A0static NORETURN void die_nicely(const char *err, va_list params)
> =A0{
> =A0 =A0 =A0 =A0static int zombie;
> + =A0 =A0 =A0 va_list saved_params;
> + =A0 =A0 =A0 va_copy(saved_params, params);

Ugh. We don't use the va_copy for portability reasons; it's C99, and
impossible to implement in a portable way on non-C99 systems.

--=20
Erik "kusma" Faye-Lund
