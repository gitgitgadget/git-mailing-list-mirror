From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Add a config option push.gpgSign for default signed pushes
Date: Mon, 17 Aug 2015 10:13:53 -0700
Message-ID: <xmqqy4h9et2m.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<1439492451-11233-8-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRNyx-0008HH-SA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 19:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbbHQRNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 13:13:55 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36089 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbHQRNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 13:13:55 -0400
Received: by pdbmi9 with SMTP id mi9so17319401pdb.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kS8XcIf29+ScBp9JWSJtVhOEIBC+qMmbAOOcdDD1V0Q=;
        b=qFLSUYx20N2X80NdReM98ol9Szt/7bPeeUQ2tCQLmSWJQcyXH7QH/YcnoKNirwiXEE
         TY6v9Zmb2JwBknBZY9nd2X6BqXEIFqVRcGHnW7XqAQ7rHZanAq6Ya0TDAvAO2UZtGWq/
         S8LNuHmaRVZkoesqXfDh9lx+qyCJ5N3JZVTJ3pdRF1F6A8J9MsJYtK+wvY7NV8FSDDKm
         Ijmct8I5TbOXT98djE+6NJiwaOyFmFF3UczF0q5TtD4AmZ8bknRNf9RSlFdVO9RlGs7B
         Xx1MFJuG6gDyzlwzh0Jq663W/GbkAcX4EG6OGCyKjG6A6f+zBZFs9cnSNj0SI95V8KO1
         eR+g==
X-Received: by 10.70.64.131 with SMTP id o3mr4488069pds.111.1439831634647;
        Mon, 17 Aug 2015 10:13:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id im2sm15254240pbc.34.2015.08.17.10.13.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 10:13:53 -0700 (PDT)
In-Reply-To: <1439492451-11233-8-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Thu, 13 Aug 2015 15:00:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276059>

Dave Borowitz <dborowitz@google.com> writes:

> ---

Does the lack of sign-off indicate something (like "this is just a
'what do people think?' weatherbaloon not yet a serious submission")?

> +push.gpgSign::
> +	May be set to a boolean value, or the string 'if-possible'. A
> +	true value causes all pushes to be GPG signed, as if '--signed'
> +	is passed to linkgit:git-push[1]. The string 'if-possible'
> +	causes pushes to be signed if the server supports it, as if
> +	'--signed-if-possible' is passed to 'git push'. A false value
> +	may override a value from a lower-priority config file. An
> +	explicit command-line flag always overrides this config option.

> diff --git a/builtin/push.c b/builtin/push.c
> index 95a67c5..8972193 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -491,6 +491,26 @@ static int git_push_config(const char *k, const char *v, void *cb)
>  	return git_default_config(k, v, NULL);
>  }
>  
> +static void set_push_cert_flags_from_config(int *flags)
> +{
> +	const char *value;
> +	/* Ignore config if flags were set from command line. */
> +	if (*flags & (TRANSPORT_PUSH_CERT_ALWAYS | TRANSPORT_PUSH_CERT_IF_POSSIBLE))
> +		return;

This looks somewhat strange.  Usually we read from config first and
then from options, so a git_config() callback shouldn't have to
worry about what command line option parser did (because it hasn't
happened yet).  Why isn't the addition to support this new variable
done inside existing git_push_config() callback function?

> +	if (!git_config_get_value("push.gpgsign", &value)) {
> +		switch (git_config_maybe_bool("push.gpgsign", value)) {
> +		case 1:
> +			*flags |= TRANSPORT_PUSH_CERT_ALWAYS;
> +			break;
> +		default:
> +			if (value && !strcmp(value, "if-possible"))
> +				*flags |= TRANSPORT_PUSH_CERT_IF_POSSIBLE;
> +			else
> +				die(_("Invalid value for 'push.gpgsign'"));
> +		}
> +	}
> +}
> +

maybe_bool() returns 0 for "false" (and its various spellings), 1
for "true" (and its various spellings) and -1 for "that's not a
bool".

For "A false value may override a value" to be true, we'd need

		case 0:
			*flags &= ~TRANSPORT_PUSH_CERT_ALWAYS;
			break;

or something?
