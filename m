From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] setup: convert setup_git_directory_gently_1 et al. to strbuf
Date: Mon, 18 Aug 2014 09:50:06 -0700
Message-ID: <xmqqk365yc75.fsf@gitster.dls.corp.google.com>
References: <53D694A2.8030007@web.de> <53D695E0.2050209@web.de>
	<53EFBB8D.20600@web.de> <53EFD1B1.4000909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQ8X-0000uR-F0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 18:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaHRQuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2014 12:50:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51746 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbaHRQuR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2014 12:50:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F0433020A;
	Mon, 18 Aug 2014 12:50:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aVYwW/NkSkEU
	KvtzbXLBTbgCrkM=; b=ooRLXzyTycnSjOmWi1r0vd1NM4uWVlX562vEIDCSGsG7
	3CcPWJG05bxscdzNB4kXL9wOr6dr+XH+vdL/3/Nlk0AOIhwlyRpfvVBkOtLYjjiC
	6e+lWh6l5vKc0QvXSHoBL/ZmTyJwDltO0IiMwJiVNto4yP36UnKBdm5U2o6/oHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mnz8Xa
	mxE0pEc/Cch2XKKZGb26YWjqFg3H5zjmU2Y4TgM3YZ6I/8RS8+EOZsmX2aogqP0/
	ebU3kDhRunz+jH+xFpsPfoj/Ugv0dYJx+2hVLK0MqxCldnll0g3aWiHa9QyFNGce
	wAZPKqWaEfT/rRio7Mq4SkZTOyUXnVsn01u9U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7286630208;
	Mon, 18 Aug 2014 12:50:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 962B730202;
	Mon, 18 Aug 2014 12:50:08 -0400 (EDT)
In-Reply-To: <53EFD1B1.4000909@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 16
	Aug 2014 23:48:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B65CBE02-26F7-11E4-B442-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255398>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Is there a chance to squueze this in:
>>=20
>>=20
>> $ git diff
>> diff --git a/setup.c b/setup.c
>> index 526cdf6..fb61860 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -734,7 +734,7 @@ static const char *setup_git_directory_gently_1(=
int *nongit_ok)
>>                  string_list_clear(&ceiling_dirs, 0);
>>          }
>>=20
>> -       if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
>> +       if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
>>                  ceil_offset =3D 1;
>>=20
>>=20
>
> Ouch, thanks for catching this.

Let me squash it in to the original change when rebuilding 'next'
sometime this week, since we have tagged 2.1 now.

> Perhaps the following patch should go in as well.

Nice; it catches the above, and shows there isn't any similar gotcha
at least for me (meaning: parts inside e.g. "#ifdef WINDOWS" that I
do not compile are not covered by "at least for me" test I did).

Thanks.

> -- >8 --
> Subject: [PATCH] turn path macros into inline function
>
> Use static inline functions instead of macros for has_dos_drive_prefi=
x,
> offset_1st_component, is_dir_sep and find_last_dir_sep in order to le=
t
> the compiler do type checking.
>
> The definitions of offset_1st_component and is_dir_sep are switched
> around because the former uses the latter.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  git-compat-util.h | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f587749..0b6c13a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -264,19 +264,35 @@ extern char *gitbasename(char *);
>  #endif
> =20
>  #ifndef has_dos_drive_prefix
> -#define has_dos_drive_prefix(path) 0
> +static inline int git_has_dos_drive_prefix(const char *path)
> +{
> +	return 0;
> +}
> +#define has_dos_drive_prefix git_has_dos_drive_prefix
>  #endif
> =20
> -#ifndef offset_1st_component
> -#define offset_1st_component(path) (is_dir_sep((path)[0]))
> +#ifndef is_dir_sep
> +static inline int git_is_dir_sep(int c)
> +{
> +	return c =3D=3D '/';
> +}
> +#define is_dir_sep git_is_dir_sep
>  #endif
> =20
> -#ifndef is_dir_sep
> -#define is_dir_sep(c) ((c) =3D=3D '/')
> +#ifndef offset_1st_component
> +static inline int git_offset_1st_component(const char *path)
> +{
> +	return is_dir_sep(path[0]);
> +}
> +#define offset_1st_component git_offset_1st_component
>  #endif
> =20
>  #ifndef find_last_dir_sep
> -#define find_last_dir_sep(path) strrchr(path, '/')
> +static inline char *git_find_last_dir_sep(const char *path)
> +{
> +	return strrchr(path, '/');
> +}
> +#define find_last_dir_sep git_find_last_dir_sep
>  #endif
> =20
>  #if defined(__HP_cc) && (__HP_cc >=3D 61000)
