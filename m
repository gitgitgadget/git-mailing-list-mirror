From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] home_config_path: allow NULL xdg parameter
Date: Fri, 25 Jul 2014 11:06:28 -0700
Message-ID: <xmqqa97x71p7.fsf@gitster.dls.corp.google.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<1406295891-7316-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:06:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjtB-0002nJ-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbaGYSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:06:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56391 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbaGYSGh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 14:06:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BE7629ADF;
	Fri, 25 Jul 2014 14:06:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+nxj288nn66p8ifTjZCZ1lNfbTA=; b=is2Y41
	Gglethidr+IEWgUnq9cZ8tG+SWiJeIabR5kFEUciYXXVgs6KYAoFZ8sooWNxpqL1
	+G1njsKM1eW6r5tKTxCYQXMSNHXnRAWmkADN80CsCeXQa2DD9OH609rvsd1Eygjo
	iEsRGeujD9q1sED4GtUjsO9zAqTJF14eoCe9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uX0A+OgpzbyL1yhrTrpZwKwma2pQP9+f
	ubeZtdNMfDW04eJ2zFfzhEuioVYVK78iuwJESKpUjHKeUtfdMVBJipMQ8/etk587
	FxSCn7fQyZt0SOvYGSzDX3Jre2mo5BBWubcw2nFkcE1Kux1RjdebKBG7Etv9uZex
	6K71+5RFbsA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7190829ADE;
	Fri, 25 Jul 2014 14:06:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 591E829ACF;
	Fri, 25 Jul 2014 14:06:30 -0400 (EDT)
In-Reply-To: <1406295891-7316-2-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Fri, 25 Jul 2014 15:44:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67622582-1426-11E4-A3EA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254254>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This allows a caller to requst the global config file without requesting
> the XDG one.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This is actually not needed, but I wrote this for a previous version,
> and it seems sensible anyway.

I was about to say "Let's not do this until some caller needs it",
implicitly assuming that we do not let global=NULL to signal that
the caller is interested only in XDG, but I checked and we do check
the NULL-ness of global, so it is consistent to do so for xdg.  The
change makes very good sense.

I wouldn't have had to spend the time to dig, if the log message
justified it that way, instead of having "actually not needed"
comment there ;-)

	home_config_paths(): let the caller ignore xdg path

	The caller can signal that it is not interested in learning
	the location of $HOME/.gitconfig by passing global=NULL, but
	there is no way to decline the ptah to the configuration
	file based on $XDG_CONFIG_HOME.

        Allow the caller to pass xdg=NULL to signal that it is not
        interested in the XDG location.

or something, perhaps?

>
>  path.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/path.c b/path.c
> index 3afcdb4..f68df0c 100644
> --- a/path.c
> +++ b/path.c
> @@ -148,10 +148,12 @@ void home_config_paths(char **global, char **xdg, char *file)
>  			*global = mkpathdup("%s/.gitconfig", home);
>  	}
>  
> -	if (!xdg_home)
> -		*xdg = NULL;
> -	else
> -		*xdg = mkpathdup("%s/git/%s", xdg_home, file);
> +	if (xdg) {
> +		if (!xdg_home)
> +			*xdg = NULL;
> +		else
> +			*xdg = mkpathdup("%s/git/%s", xdg_home, file);
> +	}
>  
>  	free(to_free);
>  }
