From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] compat/basename: make basename() conform to POSIX
Date: Fri, 08 Jan 2016 10:45:18 -0800
Message-ID: <xmqqy4bz29mp.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<abd20a9fb53d702cb878b8fa767881e7c1ef2148.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:45:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHc2P-0000JF-MF
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 19:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbcAHSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 13:45:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322AbcAHSpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 13:45:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D63AB39BE3;
	Fri,  8 Jan 2016 13:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9NMnny7/E+wIl+g6vf2XTr3Sovc=; b=BuqjaD
	h3Ql24QFbtPHyXglSyc01EKN2ai0bC1A4O2bx9TtFwH0q6sSgl5sDNCCIdFyKFs3
	hoQG7TnxdZOspfhPDVax0Or6zxmxhc44Zpl7igpOftOPJlZPudKhaTketWYpHNCF
	oAQWJcZEO1iXhpwuEfb/9ozfeCqhSV86x6OCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AE7Yh3oBjsckfpdkvcD/0EILIRtvb+jQ
	Yl/EbejcCy+66Hj5rylQ8WHCT1fa7trFuGiXs7rbWRhKpp+aEC4LdTEBSNxHkv/3
	LCjWEn2AS8cZwsNPEpAF459OBr/ExaNHaaSoJPVb+5omsOzn8XcXKqoidXQZISk3
	xRcOg0oKztc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE72239BE2;
	Fri,  8 Jan 2016 13:45:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A8EA39BE0;
	Fri,  8 Jan 2016 13:45:19 -0500 (EST)
In-Reply-To: <abd20a9fb53d702cb878b8fa767881e7c1ef2148.1452270051.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 8 Jan 2016 17:21:15 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F74DD2A4-B637-11E5-A72B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283574>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> According to POSIX, basename("/path/") should return "path", not
> "path/". Likewise, basename(NULL) and basename("abc") should both
> return ".".

Did you mean basename("abc"), not basename(""), here?  


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/basename.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/compat/basename.c b/compat/basename.c
> index 9f00421..0f1b0b0 100644
> --- a/compat/basename.c
> +++ b/compat/basename.c
> @@ -4,10 +4,24 @@
>  char *gitbasename (char *path)
>  {
>  	const char *base;
> -	skip_dos_drive_prefix(&path);
> +
> +	if (path)
> +		skip_dos_drive_prefix(&path);
> +
> +	if (!path || !*path)
> +		return ".";
> +
>  	for (base = path; *path; path++) {
> -		if (is_dir_sep(*path))
> -			base = path + 1;
> +		if (!is_dir_sep(*path))
> +			continue;
> +		do {
> +			path++;
> +		} while (is_dir_sep(*path));
> +		if (*path)
> +			base = path;
> +		else
> +			while (--path != base && is_dir_sep(*path))
> +				*path = '\0';
>  	}
>  	return (char *)base;
>  }
