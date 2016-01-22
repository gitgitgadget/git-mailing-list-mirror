From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Fri, 22 Jan 2016 11:09:35 -0800
Message-ID: <xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
	<cover.1452585382.git.johannes.schindelin@gmx.de>
	<05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
	<56A279DA.8080809@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:09:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMh5b-0006Ha-4H
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbcAVTJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:09:39 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753758AbcAVTJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:09:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5319F3DD7F;
	Fri, 22 Jan 2016 14:09:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2KE35lTpRmVEniSf4JIAsDo7lwk=; b=Pz1ZEf
	0S7sYYZI2ZDb5sPiYeFYevrm8U0/+VIH/CdLw12aAz9VI+12BQ7uQJyOXQRW2z0g
	1Na6G2S9iV2crFZRpA2JBO9U35JDNceQS2eDkxoi0lLedwvhAiOQqlnFc5rkaZa7
	zyu+7kncNTNcmFcXyBTTo3JEM+plhtXqpDCCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DvbvZY/3ryVAfuoJxKVP0ffXUIJ5RGmY
	jEBbAkh9aZyMa1QZgySndYhp7nHmIOTbNOVIQcZnnSCVGTK4/b/+pdzBTdpOIxbb
	2hjZyb/27g4niTd5JUec82Rnvwk6RpvZSL0milglCjX1sJ+8SiBVyB+kDtj0X/nl
	1AZ95BsaWpY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A3973DD7E;
	Fri, 22 Jan 2016 14:09:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CA1F3DD71;
	Fri, 22 Jan 2016 14:09:36 -0500 (EST)
In-Reply-To: <56A279DA.8080809@kdbg.org> (Johannes Sixt's message of "Fri, 22
	Jan 2016 19:50:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADB0890C-C13B-11E5-8A03-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284586>

Johannes Sixt <j6t@kdbg.org> writes:

> I suggest to move the function definition out of line:
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 10a51c0..0cebb61 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1915,6 +1915,13 @@ pid_t waitpid(pid_t pid, int *status, int options)
>  	return -1;
>  }
>  
> +int mingw_skip_dos_drive_prefix(char **path)
> +{
> +	int ret = has_dos_drive_prefix(*path);
> +	*path += ret;
> +	return ret;
> +}
> +
>  int mingw_offset_1st_component(const char *path)
>  {
>  	char *pos = (char *)path;
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 9b5db4e..2099b79 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -360,12 +360,7 @@ HANDLE winansi_get_osfhandle(int fd);
>  
>  #define has_dos_drive_prefix(path) \
>  	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
> -static inline int mingw_skip_dos_drive_prefix(char **path)
> -{
> -	int ret = has_dos_drive_prefix(*path);
> -	*path += ret;
> -	return ret;
> -}
> +int mingw_skip_dos_drive_prefix(char **path);
>  #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
>  #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
>  static inline char *mingw_find_last_dir_sep(const char *path)

This sounds good to me.  Dscho?
