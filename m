From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: do not set errno to 0 on success
Date: Tue, 23 Nov 2010 16:07:49 -0800
Message-ID: <7v4ob7vb1m.fsf@alter.siamese.dyndns.org>
References: <1290541988-4608-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 01:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL2u9-00010b-P5
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 01:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab0KXAIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 19:08:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab0KXAID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 19:08:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7CB727A4;
	Tue, 23 Nov 2010 19:08:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8JtQDsESnVZPBPB5oy5M3DEey5g=; b=I0UP3x
	8VIbaANmjk3LJxdMM9thWzfiPk44YLjXSvz4LFkd1BQ9kOT6f9npNrSktR3aEPJ8
	C3XRwr5bwQNZmGB6uPhM5/YU68YxL6A+/xTWzvGh3hgBa2Sv5WQtIE5yWIjstCxK
	cNEcApVJvwQQBsrJL6U+F+3oac47OrnAigx7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUdVKTr4oX4kw0Mt/5dcY3NqFOMe6u56
	Sc9cevTnKwVCVquMGrGErhgNVRJJXB22Bt4JMGQ8LGpl447p8L0/+eEmXSufA3Eo
	Yzyly93dal0rqmcI6oFHIR82P+oLz3a8jHQvzXg3vcm4oZikZLLLuhHpNmlPQLI2
	eeNU7i4NYXI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97C5927A3;
	Tue, 23 Nov 2010 19:08:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0A6C27A2; Tue, 23 Nov 2010
 19:08:04 -0500 (EST)
In-Reply-To: <1290541988-4608-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue\, 23 Nov 2010 20\:53\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECC68D32-F75E-11DF-94F6-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162036>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Currently do_lstat always sets errno to 0 on success. This incorrectly
> overwrites previous errors.
>
> Fetch the error-code into a temporary variable instead, and assign that
> to errno on failure.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> A bug I found while hunting down another regression. maint-worthy, perhaps?

I would say so, as long as the error return from get_file_attr() is
trustworthy.

>
>  compat/mingw.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index f2d9e1f..b98e600 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -195,9 +195,10 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
>   */
>  static int do_lstat(const char *file_name, struct stat *buf)
>  {
> +	int err;
>  	WIN32_FILE_ATTRIBUTE_DATA fdata;
>  
> -	if (!(errno = get_file_attr(file_name, &fdata))) {
> +	if (!(err = get_file_attr(file_name, &fdata))) {
>  		buf->st_ino = 0;
>  		buf->st_gid = 0;
>  		buf->st_uid = 0;
> @@ -211,6 +212,7 @@ static int do_lstat(const char *file_name, struct stat *buf)
>  		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
>  		return 0;
>  	}
> +	errno = err;
>  	return -1;
>  }
>  
> -- 
> 1.7.3.2
