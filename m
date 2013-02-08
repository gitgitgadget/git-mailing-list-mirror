From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Fri, 08 Feb 2013 12:04:54 -0800
Message-ID: <7v8v6y1sih.fsf@alter.siamese.dyndns.org>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:05:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uCd-00067s-R4
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946971Ab3BHUFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:05:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946980Ab3BHUE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:04:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A2ECBF3;
	Fri,  8 Feb 2013 15:04:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dZbgiBxa7L1gitpXK3q3FErlnmA=; b=iZLIRc
	NsZ4lb6dduCNwJRnOlzO5Kxc3Y+d7XvmxtcKaAxG6jAue4MFuSX3wQUVy6DN5t9O
	TnCA3oKEDiriqwuSwODT/n6JRGKwC+HImuk0DnUVxHaqR2QuZyQfrcdmr2by3RSJ
	q81dqiw3AzG7An9xbX7BBZb/vpgY25LeF/fCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yh8xCPxHOxl28o5As4skOqm8h/DzMIiU
	hejRPZLXujjdJ16iG4nEz5CRRpRzBDpPeFS/a2KqOO1BN/18od7NFe+3eAdXUxH+
	ULLn2yP1p8Lk0/B/vqI+yLAtVx2hqdpFXglhnhzcEIGu28j8jw9GXTcb1zC6XFDR
	kYRIZjU9lq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D453DCBF2;
	Fri,  8 Feb 2013 15:04:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D643CBEE; Fri,  8 Feb 2013
 15:04:56 -0500 (EST)
In-Reply-To: <1360307982-20027-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 8 Feb 2013 12:49:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF052300-722A-11E2-9F1C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215809>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9b11597..0b3b1f8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -727,6 +727,12 @@ branch.<name>.remote::
>  	remote to fetch from/push to.  It defaults to `origin` if no remote is
>  	configured. `origin` is also used if you are not on any branch.
>  
> +branch.<name>.pushremote::
> +	When in branch <name>, it tells 'git push' which remote to
> +	push to.  It falls back to `branch.<name>.remote`, and
> +	defaults to `origin` if no remote is configured. `origin` is
> +	also used if you are not on any branch.

Sounds sensible (modulo the missing "default location to push to
that is not per remote" bit, obviously).  I think "When _on_ branch"
is more correct, to match "if you are not on any branch" at the end,
though.

> diff --git a/remote.c b/remote.c
> index e53a6eb..d6fcfc0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -48,6 +48,7 @@ static int branches_nr;
>  
>  static struct branch *current_branch;
>  static const char *default_remote_name;
> +static const char *pushremote_name;
>  static int explicit_default_remote_name;
>  
>  static struct rewrites rewrites;
> @@ -363,6 +364,12 @@ static int handle_config(const char *key, const char *value, void *cb)
>  				default_remote_name = branch->remote_name;
>  				explicit_default_remote_name = 1;
>  			}
> +		} else if (!strcmp(subkey, ".pushremote")) {
> +			if (!value)
> +				return config_error_nonbool(key);
> +			branch->pushremote_name = xstrdup(value);

Perhaps use git_config_string()?

I also notice that git_config_string() should free (*dest) if there
already is some value, and that has to be done after auditing all
existing callers.

> +			if (branch == current_branch)
> +				pushremote_name = branch->pushremote_name;

Why is this global only when current_branch is involved?

In other words, does it make sense to read branch.$name.pushremote
for all the other irrelevant branches?  

In yet other words, perhaps adding pushremote_name to the branch
structure is unneeded, and you only need this single global
variable?

(The remainder of the patch unsnipped for others' reference.)

> @@ -700,6 +707,40 @@ struct remote *remote_get(const char *name)
>  	return ret;
>  }
>  
> +struct remote *pushremote_get(const char *name)
> +{
> +	struct remote *ret;
> +	int name_given = 0;
> +
> +	read_config();
> +	if (name)
> +		name_given = 1;
> +	else {
> +		if (pushremote_name) {
> +			name = pushremote_name;
> +			name_given = 1;
> +		} else {
> +			name = default_remote_name;
> +			name_given = explicit_default_remote_name;
> +		}
> +	}
> +
> +	ret = make_remote(name, 0);
> +	if (valid_remote_nick(name)) {
> +		if (!valid_remote(ret))
> +			read_remotes_file(ret);
> +		if (!valid_remote(ret))
> +			read_branches_file(ret);
> +	}
> +	if (name_given && !valid_remote(ret))
> +		add_url_alias(ret, name);
> +	if (!valid_remote(ret))
> +		return NULL;
> +	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
> +	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
> +	return ret;
> +}
> +
>  int remote_is_configured(const char *name)
>  {
>  	int i;
> diff --git a/remote.h b/remote.h
> index 251d8fd..aa42ff5 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -51,6 +51,7 @@ struct remote {
>  };
>  
>  struct remote *remote_get(const char *name);
> +struct remote *pushremote_get(const char *name);
>  int remote_is_configured(const char *name);
>  
>  typedef int each_remote_fn(struct remote *remote, void *priv);
> @@ -130,6 +131,7 @@ struct branch {
>  	const char *refname;
>  
>  	const char *remote_name;
> +	const char *pushremote_name;
>  	struct remote *remote;
>  
>  	const char **merge_name;
