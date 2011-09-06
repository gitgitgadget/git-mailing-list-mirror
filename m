From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remove prefix argument from pathspec_prefix
Date: Tue, 06 Sep 2011 12:02:39 -0700
Message-ID: <7vmxeh8pf4.fsf@alter.siamese.dyndns.org>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
 <1315132921-26949-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:02:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R10v6-0002wj-KK
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 21:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1IFTCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 15:02:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771Ab1IFTCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 15:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 952E140B1;
	Tue,  6 Sep 2011 15:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LtQ+AD07a0gozGT9kxpApUz7rAo=; b=r9QwMA
	kpkmDeyO3hJfyU0rMJrtfOwh2CbdQ+yj1+91XSvorvBwfKKwmAq4FYEVmP9/VW3p
	j1nNAb7LnoNWRggPvlxG+pWCmMew300Qqud3ByrQ5Gv7quUp9sbxgrgASs7efxPJ
	7GStzF5DfJ/b1V7TYPk5mAOOOo++U8TLsrGAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hym98klTj6zkSPM9Fh6KXLSTe4CD6OcX
	RSgqBqt9UloQ3vKivxSHoLo1mXboVnLX+idwZA45lP5/R8J42QTLAWpQ4dxyqG4J
	YVRBJhFtZMJC5J9pUhNf0M8ZOxWpsNP8IfJLqsPp5q4V75CRL/i3F48JfA+QhVtE
	3bxRmFJLqro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C76E40B0;
	Tue,  6 Sep 2011 15:02:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0458A40AF; Tue,  6 Sep 2011
 15:02:40 -0400 (EDT)
In-Reply-To: <1315132921-26949-2-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Sun, 4 Sep 2011 12:41:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB782F80-D8BA-11E0-A0E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180821>

Clemens Buchacher <drizzd@aon.at> writes:

> Passing a prefix to a function that is supposed to find the prefix
> is strange. And it's really only used if the pathspec is NULL. Make
> the callers handle this case instead.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

While I find the above rationale a reasonable justification for the
removal of a parameter from the function, it does not seem to justify why
the type of the returned value from the function needed to be changed.

Is it because we no longer ever return "prefix" we pass in which is a
pointer to a constant memory region to begin with?

We also didn't free() in the earlier code (because we do not know if it
can be freed) and leaking xmemdupz() if the function didn't return the
"prefix", but now you plugged the small leak. Isn't it something you
should advertise?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index cbc9613..64fe501 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -255,8 +255,9 @@ static int list_paths(struct string_list *list, const char *with_tree,
>  	m = xcalloc(1, i);
>  
>  	if (with_tree) {
> -		const char *max_prefix = pathspec_prefix(prefix, pattern);
> -		overlay_tree_on_cache(with_tree, max_prefix);
> +		char *max_prefix = pathspec_prefix(pattern);
> +		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
> +		free(max_prefix);
>  	}
>  
>  	for (i = 0; i < active_nr; i++) {
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index e8a800d..a54c2a2 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -545,7 +545,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		strip_trailing_slash_from_submodules();
>  
>  	/* Find common prefix for all pathspec's */
> -	max_prefix = pathspec_prefix(prefix, pathspec);
> +	max_prefix = pathspec_prefix(pathspec);
>  	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
>  
>  	/* Treat unmatching pathspec elements as errors */
> diff --git a/cache.h b/cache.h
> index 607c2ea..0ccc84d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -444,7 +444,7 @@ extern void set_git_work_tree(const char *tree);
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
>  extern const char **get_pathspec(const char *prefix, const char **pathspec);
> -extern const char *pathspec_prefix(const char *prefix, const char **pathspec);
> +extern char *pathspec_prefix(const char **pathspec);
>  extern void setup_work_tree(void);
>  extern const char *setup_git_directory_gently(int *);
>  extern const char *setup_git_directory(void);
> diff --git a/setup.c b/setup.c
> index 27c1d47..0906790 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -236,13 +236,13 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
>  	return pathspec;
>  }
>  
> -const char *pathspec_prefix(const char *prefix, const char **pathspec)
> +char *pathspec_prefix(const char **pathspec)
>  {
>  	const char **p, *n, *prev;
>  	unsigned long max;
>  
>  	if (!pathspec)
> -		return prefix ? xmemdupz(prefix, strlen(prefix)) : NULL;
> +		return NULL;
>  
>  	prev = NULL;
>  	max = PATH_MAX;
