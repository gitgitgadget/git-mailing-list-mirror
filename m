From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] MSVC: link in invalidcontinue.obj for better POSIX compatibility
Date: Fri, 28 Mar 2014 13:35:52 -0700
Message-ID: <xmqq4n2i9i3b.fsf@gitster.dls.corp.google.com>
References: <xmqqlhvu9m8x.fsf@gitster.dls.corp.google.com>
	<1396037282-26081-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 21:36:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTdVk-0003Rb-6v
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 21:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbaC1Uf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 16:35:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbaC1Uf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 16:35:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BBF477EEE;
	Fri, 28 Mar 2014 16:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RPi2b9o42rdey6RHcM5ND97wcfM=; b=qananv
	WVJoXK4zRbDbZP+5/wgR70/yyNykJxPiwjTpvF7QcVZiddGW8TPaRcMvfjA/YxUo
	AlB/RtPU7HlXjpy7y9EIlUzTYIIYW9lrmHP9qrwAOSW6Idp/aCWTFT8wQLxR0vLH
	dJwTPl7GtxLMx+IDMOGA1eiNGSbkfulnhBtMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Geub6VF1qL44L6TKtR8gcvo3KoVj43ki
	l3ONNlP2NYPIw0+IPfNRX4fXp80D1mTFmgiytSMuarQpBOh8JRyxpPZ6cykdbSTo
	LtoA0ewjVT7L6uCcOjs/vWUAaj23WGcuJhvqFUazPpbfw6e0+qfoOSfecA1v2nZ9
	79ki7hW/1zE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9402D77EED;
	Fri, 28 Mar 2014 16:35:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4C7277EE8;
	Fri, 28 Mar 2014 16:35:53 -0400 (EDT)
In-Reply-To: <1396037282-26081-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Sat, 29 Mar 2014 00:08:02 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8EE413AC-B6B8-11E3-AD84-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245426>

Marat Radchenko <marat@slonopotamus.org> writes:

> By default, Windows abort()'s instead of setting
> errno=EINVAL when invalid arguments are passed to standard functions.
>
> For example, when PAGER quits and git detects it with
> errno=EPIPE on write(), check_pipe() in write_or_die.c tries raise(SIGPIPE)
> but since there is no SIGPIPE on Windows, it is treated as invalid argument,
> causing abort() and crash report window.
>
> Linking in invalidcontinue.obj (provided along with MS compiler) allows
> raise(SIGPIPE) to return with errno=EINVAL.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---

Thanks; will queue.

>  config.mak.uname | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 38c60af..8e7ec6e 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -366,7 +366,7 @@ ifeq ($(uname_S),Windows)
>  		compat/win32/dirent.o
>  	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
>  	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
> -	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
> +	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
>  	PTHREAD_LIBS =
>  	lib =
>  ifndef DEBUG
