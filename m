From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Thu, 12 Jul 2012 10:14:00 -0700
Message-ID: <7vtxxcc36v.fsf@alter.siamese.dyndns.org>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
 <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpMy4-00005M-AY
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 19:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161419Ab2GLROJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 13:14:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161399Ab2GLROF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 13:14:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B3A86BE;
	Thu, 12 Jul 2012 13:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ebYZno39Wg2Di9f4ZYGktrnY+EI=; b=Q8YO+f
	9lvAMUmH1wxNF2g7oQJvu4eCYhTcN16dUu9077pAIxecH3SDW9yWT7Yr2Zo5k0sR
	h4cvCr/d6CRCwzQbxGRCL1+Z47A5xLGwM04jPn8yRfDfCUvdyqDyHFoh3l/eBRf5
	zpbdfAx8gZpDwhu6WAjxsgrtQXFJ4SmtgjTKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fn3QOuw/9wL+aDLUEk/tMGV8g6W0CWJs
	CdFoOP4J/LDBBGCwbMAigQPYGlbw6gYooJMYbmNtjMpnblrJT37ySdZRTXznEtKT
	o3jsavSnU5J9IHtQ/QhFLPDvcaqFo62HyG36UmOreyx3OkS04pO7AUrRv1Nz42hV
	2soHheGGuaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D5086BA;
	Thu, 12 Jul 2012 13:14:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A30E86B2; Thu, 12 Jul 2012
 13:14:02 -0400 (EDT)
In-Reply-To: <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu, 12 Jul 2012 14:04:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA9BF908-CC44-11E1-ADA1-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201367>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> When $HOME is unset, home_config_paths fails and returns NULL pointers
> for user_config and xdg_config. Valgrind complains with Syscall param
> access(pathname) points to unaddressable byte(s).
>
> Don't call blindly access() on these variables, but test them for
> NULL-ness before.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> This patch causes valgrind warnings in t1300.81 (get --path copes with
>> unset $HOME) about passing NULL to access():
>
> Indeed. The following patch should fix it.
>
>  builtin/config.c | 3 ++-
>  config.c         | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index e8e1c0a..67945b2 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -387,7 +387,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  
>  		home_config_paths(&user_config, &xdg_config, "config");
>  
> -		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
> +		if (user_config && access(user_config, R_OK) &&
> +		    xdg_config && !access(xdg_config, R_OK))
>  			given_config_file = xdg_config;

Shouldn't we be using xdg_config, if user_config is NULL and
xdg_config is defined and accessible?

In other words, isn't the objective of this "fix" is to replace any
call to access(PATH, PERM) whose PATH can potentially be NULL with

	(PATH ? access(PATH, PERM) : -1)

because we want to pretend access(PATH, PERM) returned an error,
saying "The variable PATH holds a path to the file that is not
accessible", when PATH is NULL?

And that is equivalent to

	(!PATH || access(PATH, PERM))

in the context of boolean.  The original

	if (access(user_config, R_OK) && !access(xdg_config, R_OK))

becomes 

	if ((!user_config || access(user_config, R_OK)) &&
	    !(!xdg_config || access(xdg_config, R_OK)))

and the latter half of it is the same as

	    (xdg_config && !access(xdg_config, R_OK))

but the former half is not. Shouldn't it be

	if ((!user_config || access(user_config, R_OK)) &&
	    (xdg_config && !access(xdg_config, R_OK)))

Confused.

> diff --git a/config.c b/config.c
> index d28a499..6b97503 100644
> --- a/config.c
> +++ b/config.c
> @@ -940,12 +940,12 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  		found += 1;
>  	}
>  
> -	if (!access(xdg_config, R_OK)) {
> +	if (xdg_config && !access(xdg_config, R_OK)) {
>  		ret += git_config_from_file(fn, xdg_config, data);
>  		found += 1;
>  	}
>  
> -	if (!access(user_config, R_OK)) {
> +	if (user_config && !access(user_config, R_OK)) {
>  		ret += git_config_from_file(fn, user_config, data);
>  		found += 1;
>  	}
