From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Mon, 16 Nov 2009 14:49:26 -0800
Message-ID: <7v3a4enkzt.fsf@alter.siamese.dyndns.org>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 16 23:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAAON-0001rq-CA
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 23:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbZKPWtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 17:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbZKPWtd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 17:49:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbZKPWtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 17:49:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA7880C63;
	Mon, 16 Nov 2009 17:49:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AufBk+gLO3fDbZ/qTIEQqQNeIFU=; b=UqEYeC
	Hq6t/Og+q+ddvKkfuIF9bneWIXRRb1Oy4SbuYSqmlmL3PyW8vQMJQGegP1idG8Ma
	q5US79/RVwG1k1VNP1AnX/fK0AuJKJ74T/PBkG4DxG+imyHzn/4fyO62mOx1f003
	OO5UzqOpp22Y2FqMsb91CUnuHIsruxE1Qjc5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ylAG+NttsojqWFsLzUXH2aTCoc+Hx88I
	279sXx6xX+JN109X1A99dVq1AGP+bk6YF4gQlcc2+ngh0Nght6wCfe9nV/kZ+Htb
	CHCrvuWlF1X5p9cdCjJNuoaiv1fefOSJiB40l1qsycLnKMD62mMT6R99A6+v9Nyw
	vqD1wa7/ehs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01FF480C62;
	Mon, 16 Nov 2009 17:49:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7F9D80C5E; Mon, 16 Nov
 2009 17:49:27 -0500 (EST)
In-Reply-To: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon\, 16 Nov 2009 11\:07\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E00E034-D302-11DE-9F5C-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133032>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> My version is made a bit simpler by using strbuf for string
> manipulation in expand_user_path.

Nice to see people keeping track of issues that we tried to address but
didn't complete.

> I'm not sure I fully adressed Junio's point here:

We'll see ;-)

> I'm just copying back into the static buffer to let enter_repo() do
> the same string manipulation as it used to do (concatenate with .git
> suffixes). I think the whole enter_repo could use strbuf instead of
> static buffers, but that's a different point (probably made easier by
> my patch).

> diff --git a/config.c b/config.c
> index c644061..0fcc4ce 100644
> --- a/config.c
> +++ b/config.c
> @@ -351,6 +351,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
>  	return 0;
>  }
>  
> +int git_config_pathname(const char **dest, const char *var, const char *value) {
> +	if (!value)
> +		return config_error_nonbool(var);
> +	*dest = expand_user_path(value);
> +	if (!*dest)
> +		die("Failed to expand user dir in: '%s'", value);
> +	return 0;
> +}
> +

> @@ -207,43 +208,49 @@ int validate_headref(const char *path)
>  	return -1;
>  }
>  
> -static char *user_path(char *buf, char *path, int sz)
> +static inline struct passwd *getpw_str(const char *username, size_t len)
>  {
> +	if (len == 0)
> +		return getpwuid(getuid());
> +
>  	struct passwd *pw;

Decl-after-statement.

Do you need this special case of passing a zero-length string (not NULL
pointer as a string) to getpw_str() to grab the current user?  Which
codepath is this needed?

> +	char *username_z = xmalloc(len + 1);
> +	memcpy(username_z, username, len);
> +	username_z[len] = '\0';
> +	pw = getpwnam(username_z);
> +	free(username_z);
> +	return pw;
> +}

> +/*
> + * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL, then
> + * it is a newly allocated string. Returns NULL on getpw failure or if
> + * path is NULL.
> + */
> +char *expand_user_path(const char *path)
> +{
> +	struct strbuf user_path = STRBUF_INIT;
> +	char * first_slash = strchrnul(path, '/');
> +	char * to_copy;

Style: "char *first_slash"

Should't "to_copy" be initialized to "path" here?  What do you copy when
path[0] is '/'?

> +	if (path == NULL)
> +		goto return_null;
> +
> +	if (path[0] == '~') {
> +		const char *username = path + 1;
> +		size_t username_len = first_slash - username;
> +		struct passwd *pw = getpw_str(username, username_len);
> +		if (!pw)
> +			goto return_null;
> +		strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
> +		to_copy = first_slash;
> +	} else if (path[0] != '/') {
> +		to_copy = path;
>  	}
> -	return buf;
> +	strbuf_add(&user_path, to_copy, strlen(to_copy));
> +	return strbuf_detach(&user_path, NULL);
> +return_null:
> +	strbuf_release(&user_path);
> +	return NULL;
>  }



>  /*
> @@ -291,8 +298,17 @@ char *enter_repo(char *path, int strict)
>  		if (PATH_MAX <= len)
>  			return NULL;
>  		if (path[0] == '~') {
> -			if (!user_path(used_path, path, PATH_MAX))
> +			char *newpath = expand_user_path(path);
> +			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
> +				if (path != newpath)
> +					free(newpath);

Your expand_user_path() never returns the original, no?

>  				return NULL;
> +			}
> +			/* Copy back into the static buffer. A pity
> +			   since newpath was not bounded, but other
> +			   branches of the if are limited by PATH_MAX
> +			   anyway. */
> +			strcpy(used_path, newpath); free(newpath);
>  			strcpy(validated_path, path);
>  			path = used_path;
>  		}

Heh, in a sense you _did_ address my point by punting, but that is Ok.  As
you said earlier that would be a good topic of a separate patch.

	/*
         * By the way, we write our
         * multi-line comments like
         * this.
         */
