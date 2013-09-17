From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] relative_path should honor DOS and UNC paths
Date: Tue, 17 Sep 2013 09:12:20 -0700
Message-ID: <xmqqli2v1l7f.fsf@gitster.dls.corp.google.com>
References: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
	<2c56935842ceef4d5933c299dd2d55286eb0ba3a.1379406453.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:12:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLxt7-0005as-DM
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab3IQQMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:12:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab3IQQMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:12:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9706442A02;
	Tue, 17 Sep 2013 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iRZqe61e4aoRcpOkZXwLAXfztHg=; b=hnEZFg
	U7dMIID1kU1UcCD7zfMf9n1LXNtowYqJuuuGm8gdlT93G1jlxEV/c6kDVr0EquX+
	Sj6RHqqFICU4OwVjo/SESPQm68r0yQnZ3awTLCGfo9VBxq2aDQUf4coiORbUAE0r
	GzKH44Ema3SvCnLSNVkRgkyToZ+bPBHIiJtVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SvB0rVDMJMjEqK3WC1AwW4e8tZSahFDI
	caWwsarPg96JkUJKiV4gsg62Xh5rPistNlyAedzLPS11KbTWRJ3/j/wHBqHzYS5r
	QxCbuySGnWoCUbmkynQIgkZwwOTnSxMyNK2ArGndJ/y9+VMT04vgjIAn5mc5euPy
	jffP3zKrj+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8133842A01;
	Tue, 17 Sep 2013 16:12:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7C50429F6;
	Tue, 17 Sep 2013 16:12:22 +0000 (UTC)
In-Reply-To: <2c56935842ceef4d5933c299dd2d55286eb0ba3a.1379406453.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 17 Sep 2013 16:30:23 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF6CD1C4-1FB3-11E3-940B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234880>

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/compat/mingw.h b/compat/mingw.h
> index bd0a88b..06e9f49 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -311,6 +311,15 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
>  
>  #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
>  #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
> +static inline int is_unc_path(const char *path)
> +{
> +	if (!is_dir_sep(*path) || !is_dir_sep(*(path+1)) || is_dir_sep(*(path+2)))
> +		return 0;

If path[1] == '\0', it would be !is_dir_sep() and we end up
inspecting past the end of the string?
