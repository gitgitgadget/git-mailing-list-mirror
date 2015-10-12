From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule-config: Untangle logic in parse_config
Date: Mon, 12 Oct 2015 12:24:16 -0700
Message-ID: <xmqqy4f7lwkf.fsf@gitster.mtv.corp.google.com>
References: <1444672738-2944-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlihw-0008Nk-LW
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbbJLTYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:24:24 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34410 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbJLTYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:24:24 -0400
Received: by padhy16 with SMTP id hy16so161230605pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jlbM2yft1VPWLpxOxKkiwP6CEk8MrpUaVjgmQkKCDDY=;
        b=Pek5mRg2p+7uXsPymQc9UG+jkTKGyT+ABzC22xF46kOug4PNtk8UnGa+rbR95Am069
         LeH6kAfBeQhrEeayXCJcvd4/aYNKly+v+qBt28xf8sG9I3Rpa+/Z0BZfsPzalHnTL1hU
         sWChI9Vd7sb2Xa2gCRqZ83m0Zmv3ELTck14LBJGCPQH+1lLgIkUpF+/h9cinYC5IYILm
         beGxP3W7gWAun8TdXSwu2Z7c+xv2R62ILkRnA1YGEt0wWuGcvrHljtsbw3N56HhU6o5O
         M+HEaJtVoVOIoOBbXUQTjUwNoL3IjmkMc4hIT03olARZg9W1lREOAUKqp4gS1hCZw35L
         M+/w==
X-Received: by 10.66.235.42 with SMTP id uj10mr36606278pac.32.1444677863536;
        Mon, 12 Oct 2015 12:24:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id pq1sm19716087pbb.91.2015.10.12.12.24.22
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 12:24:22 -0700 (PDT)
In-Reply-To: <1444672738-2944-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 12 Oct 2015 10:58:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279405>

Stefan Beller <sbeller@google.com> writes:

> This improves readability of the parse_config logic by making it more concise.

This does make it shorter, but "improve readability" is highly
subjective and "untangle logic" is content-free without explaining
what aspect of the logic is being untangled into what other shape.

> @@ -257,78 +257,62 @@ static int parse_config(const char *var, const char *value, void *data)
>  	if (!name_and_item_from_var(var, &name, &item))
>  		return 0;
>  
> -	submodule = lookup_or_create_by_name(me->cache, me->gitmodules_sha1,
> -			name.buf);
> +	submodule = lookup_or_create_by_name(me->cache,
> +					     me->gitmodules_sha1,
> +					     name.buf);

Just a formatting change, which does make it easier to follow, but
does not untangle the logic.

> ...
>  	} else if (!strcmp(item.buf, "ignore")) {
> -		struct strbuf ignore = STRBUF_INIT;
> -		if (!me->overwrite && submodule->ignore != NULL) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else if (!me->overwrite && submodule->ignore != NULL)
>  			warn_multiple_config(me->commit_sha1, submodule->name,
>  					"ignore");
> -			goto release_return;
> -		}
> -		if (!value) {
> -			ret = config_error_nonbool(var);
> -			goto release_return;
> -		}

This is not a faithful conversion, in that we used to complain and
abort when seeing multiple values with or without value but now we
complain about malformed boolean first.  I do not think the
difference matters, but it is worth noting in the log, as it is a
clean-up that makes the order of checks consistent between ignore
and url, if I am reading the patch correctly.

> -		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
> -		    strcmp(value, "all") && strcmp(value, "none")) {
> +		else if (strcmp(value, "untracked") &&
> +			 strcmp(value, "dirty") &&
> +			 strcmp(value, "all") &&
> +			 strcmp(value, "none"))
>  			warning("Invalid parameter '%s' for config option "
>  					"'submodule.%s.ignore'", value, var);
> -			goto release_return;
> +		else {
> +			free((void *) submodule->ignore);
> +			submodule->ignore = xstrdup(value);
>  		}
> -
> -		free((void *) submodule->ignore);
> -		strbuf_addstr(&ignore, value);
> -		submodule->ignore = strbuf_detach(&ignore, NULL);
>  	} else if (!strcmp(item.buf, "url")) {
> -		struct strbuf url = STRBUF_INIT;
>  		if (!value) {
>  			ret = config_error_nonbool(var);
> -			goto release_return;
> -		}
> -		if (!me->overwrite && submodule->url != NULL) {
> +		} else if (!me->overwrite && submodule->url != NULL) {
>  			warn_multiple_config(me->commit_sha1, submodule->name,
>  					"url");
> -			goto release_return;
> +		} else {
> +			free((void *) submodule->url);
> +			submodule->url = xstrdup(value);
>  		}
> -
> -		free((void *) submodule->url);
> -		strbuf_addstr(&url, value);
> -		submodule->url = strbuf_detach(&url, NULL);
>  	}
>  
> -release_return:

So overall, I think there is not much "untangled", but its primary
effect is that a forward "goto" to the clean-up is removed by making
each component in if/else if/... cascade more independently complete.

Generally, a large piece of code is _easier_ to read with forward
"goto"s that jump to the shared clean-up code, as they serve as
visual cues that tell the reader "you can stop reading here and
ignore the remainder of this if/else if/... cascade".  But this
function is no too large and removing them does not make the
result harder to read, so I am not opposed to this change.  If each
individual component in if/else if/... cascade grows too large in
the future, it can easily become its own helper function.

So the patch looks OK to me, except for the "hmm, the order of
checks are made uniform without being documented?" comment above.

Thanks.


>  	strbuf_release(&name);
>  	strbuf_release(&item);
