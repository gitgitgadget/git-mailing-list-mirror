From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid warning
Date: Mon, 04 Oct 2010 13:45:27 +0200
Message-ID: <vpqsk0mp4fc.fsf@bauges.imag.fr>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
	<4CA9B217.6050600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@NetBSD.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 04 13:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2jXh-0003SV-R5
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 13:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab0JDLtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 07:49:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:50047 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab0JDLtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 07:49:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o94BjRZF014591
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Oct 2010 13:45:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P2jTz-0005mQ-EG; Mon, 04 Oct 2010 13:45:27 +0200
In-Reply-To: <4CA9B217.6050600@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of "Mon\, 04 Oct 2010 12\:53\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 04 Oct 2010 13:45:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158035>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> How about something like the following instead?

> diff --git a/cache.h b/cache.h
> index 2ef2fa3..3d5ed51 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -277,9 +277,16 @@ static inline int ce_to_dtype(const struct cache=
_entry *ce)
>  	else
>  		return DT_UNKNOWN;
>  }
> -#define canon_mode(mode) \
> -	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
> -	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
> +static inline unsigned int canon_mode(unsigned int mode)
> +{
> +	if (S_ISREG(mode))
> +		return S_IFREG | ce_permissions(mode);
> +	if (S_ISLNK(mode))
> +		return S_IFLNK;
> +	if (S_ISDIR(mode))
> +		return S_IFDIR;
> +	return S_IFGITLINK;
> +}

That sounds much better to me. I don't know whether it fixes the issue
on NetBSD though.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
