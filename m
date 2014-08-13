From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] ll-merge.c: refactor `read_merge_config()` to use `git_config_string()`
Date: Wed, 13 Aug 2014 10:07:29 -0700
Message-ID: <xmqqd2c448tq.fsf@gitster.dls.corp.google.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<1407918122-29973-2-git-send-email-tanayabh@gmail.com>
	<vpqfvh0vd4a.fsf@anie.imag.fr> <53EB5D58.7000300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHc1k-0006Ax-FW
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 19:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbaHMRHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 13:07:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55794 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbaHMRHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 13:07:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DC1E3076E;
	Wed, 13 Aug 2014 13:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6xWLJKiLntHPYTS+HY0CW+jj6hQ=; b=h2aZ2U
	7XS41R/QjlHDnlb0fRRP7Gcqf622f+7tyUDr2xmvZTUXzwOrSk7OWqHfSSgZC6ik
	dluPraEAIdeNK3Zeq8O0Dvc34cSVQqlY/P6TQcAt4YDRsMQRpHsZVZr4JS73f7ft
	/g0wqL2EOeU53euMVOrQZIU5eHXPk72V5qdLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ttyj3X3OK9ZguBWHLfPI3TfY4FBDMUI8
	v1HHLA+fOLK2WSJ/mxoBE4arT8jTYELAutLXHb+80GeKW1/oknHZh8dtUEA3BeHN
	/PxAOKOkqqcXs4ruC9bNqsz9QXQEmPyd2zWTRJ7v2AwbN5US1q9qhPCVrCgKkjPe
	Dk2aAYX8N60=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80D1D3076D;
	Wed, 13 Aug 2014 13:07:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B24F30764;
	Wed, 13 Aug 2014 13:07:31 -0400 (EDT)
In-Reply-To: <53EB5D58.7000300@gmail.com> (Tanay Abhra's message of "Wed, 13
	Aug 2014 18:13:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4FD458E6-230C-11E4-8137-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255217>

Tanay Abhra <tanayabh@gmail.com> writes:

> There is one slight behavior change, previously "merge.default"
> silently ignored a NULL value and didn't raise any error. But,
> in the same function, all other values raise an error on a NULL
> value. So to conform with other call sites in Git, a NULL value
> for "merge.default" raises an error.

Better explained than v1 ;-)

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> We cannot easily use the new config-set API here, because
> much of the function is dedicated to processing
> "merge.<name>.variable" which does not easily translate to
> the new API. If it were for variables like,
> "merge.summary", "merge.tool", and "merge.verbosity", we
> could use the new API.

I think this comment belongs to the log message, if only to serve as
a reminder for us that the API needs to be made more usable when the
caller wants to use these three-level names, which are quite common.
This code path knows the name of a low-level merge driver and wants
to learn everything about that driver.  Another code path may know
the name of the branch and may want to scan "branch.<name>.*".

>  ll-merge.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/ll-merge.c b/ll-merge.c
> index fb61ea6..8ea03e5 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -225,11 +225,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
>  	const char *key, *name;
>  	int namelen;
>
> -	if (!strcmp(var, "merge.default")) {
> -		if (value)
> -			default_ll_merge = xstrdup(value);
> -		return 0;
> -	}
> +	if (!strcmp(var, "merge.default"))
> +		return git_config_string(&default_ll_merge, var, value);
>
>  	/*
>  	 * We are not interested in anything but "merge.<name>.variable";
> @@ -254,12 +251,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
>  		ll_user_merge_tail = &(fn->next);
>  	}
>
> -	if (!strcmp("name", key)) {
> -		if (!value)
> -			return error("%s: lacks value", var);
> -		fn->description = xstrdup(value);
> -		return 0;
> -	}
> +	if (!strcmp("name", key))
> +		return git_config_string(&fn->description, var, value);
>
>  	if (!strcmp("driver", key)) {
>  		if (!value)
> @@ -285,12 +278,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>
> -	if (!strcmp("recursive", key)) {
> -		if (!value)
> -			return error("%s: lacks value", var);
> -		fn->recursive = xstrdup(value);
> -		return 0;
> -	}
> +	if (!strcmp("recursive", key))
> +		return git_config_string(&fn->recursive, var, value);
>
>  	return 0;
>  }
