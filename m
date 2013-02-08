From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Introduce remote.pushdefault
Date: Fri, 08 Feb 2013 12:11:06 -0800
Message-ID: <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org>
 <1360314123-1259-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uII-0001rT-A5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946949Ab3BHULK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:11:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964780Ab3BHULI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:11:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FB00B17B;
	Fri,  8 Feb 2013 15:11:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k1PGA3V2EfzEpncJTNShMFCGWCs=; b=YqcCNf
	57jdnFAorBsfu7slyuLUB7PoM2U8SJsrSaLQjvTd+g/6Xvr2hjCJql8IMiJRq8CM
	r/WexHi8z7iFCweK6KmFlLYwg6Yxhcf+Vh8NcxTJJh4SIBmd/NyJ9WTUB3ZETzJk
	pWetHVrsp9b24x2MsBZwsKiGmKksplPCqdAZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kPDpl7XbRF8gBwCKz3UyiGSPJDDlucyC
	2jpzPMLogPpmrxF3E6CZ0R4TqzguzzJi1xd6sxTMG76n0/TyqxEV2BY99JEFUVbR
	6TIiEeRoVyy0KZihzREbMwXQMtL3I+7LLzOJVSQFKnKLKdQblXHqpiz5Yjc1qOQB
	ZYWumxdFP4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32937B17A;
	Fri,  8 Feb 2013 15:11:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C548B176; Fri,  8 Feb 2013
 15:11:07 -0500 (EST)
In-Reply-To: <1360314123-1259-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 8 Feb 2013 14:32:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC6C908E-722B-11E2-B6EB-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215810>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9b11597..82a4a78 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1884,6 +1884,10 @@ receive.updateserverinfo::
>  	If set to true, git-receive-pack will run git-update-server-info
>  	after receiving data from git-push and updating refs.
>  
> +remote.pushdefault::
> +	The remote to push to by default.  Overrides the
> +	branch-specific configuration `branch.<name>.remote`.

It feels unexpected to see "I may have said while on this branch I
push there and on that branch I push somewhere else, but no, with
this single configuration I'm invalidating all these previous
statements, and all pushes go to this new place".

Shouldn't the default be the default that is to be overridden by
other configuration that is more specific?  That is, "I would
normally push to this remote and unless I say otherwise that is all
I have to say, but for this particular branch, I push to somehwere
else".

> diff --git a/builtin/push.c b/builtin/push.c
> index 42b129d..d447a80 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
>  static int do_push(const char *repo, int flags)
>  {
>  	int i, errs;
> -	struct remote *remote = remote_get(repo);
> +	struct remote *remote = pushremote_get(repo);
>  	const char **url;
>  	int url_nr;
>  
> diff --git a/remote.c b/remote.c
> index e53a6eb..08bb803 100644
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
> @@ -349,6 +350,14 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	const char *subkey;
>  	struct remote *remote;
>  	struct branch *branch;
> +	if (!prefixcmp(key,  "remote.")) {
> +		name = key + 7;
> +		if (!strcmp(name, "pushdefault")) {
> +			if (!value)
> +				return config_error_nonbool(key);
> +			pushremote_name = xstrdup(value);
> +		}
> +	}
>  	if (!prefixcmp(key, "branch.")) {
>  		name = key + 7;
>  		subkey = strrchr(name, '.');
> @@ -388,8 +397,6 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			add_instead_of(rewrite, xstrdup(value));
>  		}
>  	}
> -	if (prefixcmp(key,  "remote."))
> -		return 0;

Why is this no longer needed?

All the remainder of this function is about "remote.*" config and
this rejects other keys, like "user.name", etc.

I'm a bit confused....

>  	name = key + 7;
>  	if (*name == '/') {
>  		warning("Config remote shorthand cannot begin with '/': %s",
