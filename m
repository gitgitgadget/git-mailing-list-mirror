From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Tue, 15 Jun 2010 10:05:20 -0700
Message-ID: <7viq5k6xbj.fsf@alter.siamese.dyndns.org>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 19:05:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZZu-0000TO-HV
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 19:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0FORF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 13:05:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab0FORF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 13:05:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77983BAD29;
	Tue, 15 Jun 2010 13:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HfSXDNk6SAyLRnbIfxq3O7XeQpY=; b=oeAmiU
	QWMe1kvm+KXPtF2uhLJE0IBL5ZANw1xLBHC4msTIYtmF2FIkh41dEPAYpXbxBfus
	9x9s4bV3Herkx6TX93v0KjsJtd/0tQjQ93ks9W9eKSXAPF0NUZ9t07MSWb/8M3Eo
	/qaNqp21DY34WxFRMSGO4uPHAZlXbuSjPvnD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TsWbW6eyUMcTkpPCLZpKAQTNwkwsQapw
	jaGBTiJz6/zNig4ngNelLlW1ySGf3gTxqtae65HVU5CwzaiXZkAZZC1A634HR6/L
	WWBcofhYJvHqkG11Bq3oIQWlhdm6dLvG+C++b0sA9ODu6GVjAI7e1+hNmnihZjLz
	lrPA+MnMKAE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55079BAD28;
	Tue, 15 Jun 2010 13:05:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70F2DBAD26; Tue, 15 Jun
 2010 13:05:22 -0400 (EDT)
In-Reply-To: <1276578039-25023-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon\, 14 Jun 2010 22\:00\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30CC09D2-78A0-11DF-9861-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149209>

Stephen Boyd <bebarino@gmail.com> writes:

> This does modify the original behavior of format-patch a bit. First
> off the version string is now placed in the cover letter by default.

That part is fine; I think it was an oversight of the cover letter
addition.

> Secondly, once the configuration variable format.signature is added
> to the .config file there is no way to revert back to the default
> git version signature. Instead, specifying the --no-signature option
> will remove the signature from the patches entirely.

Hmph.  That is somewhat sad, but it probably is Ok.

> @@ -180,6 +180,12 @@ will want to ensure that threading is disabled for `git send-email`.
>  	containing the shortlog and the overall diffstat.  You can
>  	fill in a description in the file before sending it out.
>  
> +--signature=<signature>::
> +	Add a signature to each patch and, if --cover-letter is specified,
> +	the cover letter. Per RFC 3676 the signature is separated from the
> +	body by '-- '.

Wouldn't "Add a signature to each message produced" be easier to understand?
Also perhaps s/body by '-- '/& a line with '-- ' on it/?

Don't we want either an extra header to this entry ("--no-signature::")
and advertise it as a way to disable signature generation?

> diff --git a/builtin/log.c b/builtin/log.c
> index 976e16f..b78027e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -609,6 +610,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  		do_signoff = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.signature"))
> +		return git_config_string(&signature, var, value);
>  
>  	return git_log_config(var, value, cb);
>  }

This, together with ...

> @@ -703,6 +706,12 @@ static void gen_message_id(struct rev_info *info, char *base)
>  	info->message_id = strbuf_detach(&buf, NULL);
>  }
>  
> +static void print_signature(void)
> +{
> +	if (signature)
> +		printf("-- \n%s\n\n", signature);
> +}
> +

... this, and ...

> @@ -1035,6 +1045,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
>  			    "enable message threading, styles: shallow, deep",
>  			    PARSE_OPT_OPTARG, thread_callback },
> +		OPT_STRING(0, "signature", &signature, "signature",
> +			    "add a signature"),
>  		OPT_END()
>  	};

... this would mean that

 (1) these behave differently:

	format-patch --no-signature -1 HEAD
        format-patch --signature= -1 HEAD

 (2) this behaves like the second one in the above:

	[format]
        	signature = ""

 (3) there is no way to say "no signature, ever" in the configuration.

Perhaps we would want to do this instead?

        static void print_signature(void)
        {
                if (signature && *signature)
                        printf("-- \n%s\n\n", signature);
        }
