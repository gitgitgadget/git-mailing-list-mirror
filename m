From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Fri, 29 Apr 2011 09:05:46 +0200
Message-ID: <BANLkTikt0CU87maPs65WGi0oopD+g0uVDA@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi> <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 29 09:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFhmU-0003LL-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 09:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab1D2HGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 03:06:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48371 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1D2HGH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 03:06:07 -0400
Received: by bwz15 with SMTP id 15so2896516bwz.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 00:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=yLmPteVXgKGkXmAOGxWkCQ9z93vPZhieDz5iN1p/9DY=;
        b=WqqMur+6uvECN8gVKx1nqxo3N2FtvmUECnLLpyVaovPZHq3nyXz2+Ho+Nt9Z7/tPZw
         eQugop3ch/HbemdUf0aPbCsrkOHOw/w0uOGRogaJxt4R0ghTcYj4m/ttckPmBs8UfWMS
         045baTjqeyoIwR0kgeXxPIGEcxLfLc4JZgOVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VHhx1rXLd0tkMtVFynV1NheMwmuQMKIsqrpxzKxcmmnG2omykxxcVBw+QKEUbkDXV9
         wEKt8kqYKtj+wuCcRAb2vPsh4mZKAPi0iZDOcarkfCJNgKdpgzrViT26th9TeoIOe9gl
         1wcrSsv0yBeL7EteXXMYPMCIop5ucDnwFxwiM=
Received: by 10.204.33.72 with SMTP id g8mr813094bkd.3.1304060766105; Fri, 29
 Apr 2011 00:06:06 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 29 Apr 2011 00:05:46 -0700 (PDT)
In-Reply-To: <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172430>

On Thu, Apr 28, 2011 at 13:59, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> diff --git a/cache.h b/cache.h
> index c730c58..8bc03c6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned char=
 *sha1);
> =C2=A0extern char *sha1_pack_index_name(const unsigned char *sha1);
> =C2=A0extern const char *find_unique_abbrev(const unsigned char *sha1=
, int);
> =C2=A0extern const unsigned char null_sha1[20];
> -static inline int is_null_sha1(const unsigned char *sha1)
> +static inline int hashcmp(const unsigned char *sha1, const unsigned =
char *sha2)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return !memcmp(sha1, null_sha1, 20);
> + =C2=A0 =C2=A0 =C2=A0 /* early out for fast mis-match */
> + =C2=A0 =C2=A0 =C2=A0 if (*sha1 !=3D *sha2)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return *sha1 - *sh=
a2;

Can one take advantage of common expression optimization here?
Like this:

+       if (*sha1 - *sha2)
+               return *sha1 - *sha2;
