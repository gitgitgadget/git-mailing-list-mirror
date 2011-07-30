From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: allow partial commits with relative paths
Date: Sat, 30 Jul 2011 18:45:40 +0200
Message-ID: <4E343534.8000604@drmicha.warpmail.net>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com> <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <20110729133551.GA8707@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jul 30 18:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCff-0001Oh-AE
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 18:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab1G3Qpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 12:45:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39017 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443Ab1G3Qpp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 12:45:45 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3498520606;
	Sat, 30 Jul 2011 12:45:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 30 Jul 2011 12:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=X0FWQGkMkefRcBvk0J7lYm
	Hio58=; b=XGVVy5gxTYnkZ3TdMjrHWbHw7QQ6jgiODQ8Sb39gwdqOlkQZh+zG1j
	e8vjAIsXe4wF8Lxu3Ll3GPG6+fnqSR3xZpp53+FvYkXrgQrRyu8zrHG4p7hJRxO6
	7qNarQyRvB5/LgFtbmHiy7ffRl6mT/UjRVd46k+0y8apH49AhHjUc=
X-Sasl-enc: S4IYy3tCB+cj2zxY2Na3s4+TyQYljbBW/UmGx3nWjsFl 1312044343
Received: from localhost.localdomain (p54ACFC54.dip.t-dialin.net [84.172.252.84])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE3E14159E4;
	Sat, 30 Jul 2011 12:45:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <20110729133551.GA8707@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178212>

Clemens Buchacher venit, vidit, dixit 29.07.2011 15:35:
> In order to do partial commits, git-commit overlays a tree on the
> cache and checks pathspecs against the result. Currently, the overlaying
> is done using "prefix" which prevents relative pathspecs with ".." and
> absolute pathspec from matching when they refer to files not under
> "prefix" and absent from the index, but still in the tree (i.e. files
> staged for removal).
> 
> Instead, determine the maximal common prefix for all specified
> paths using the pathspec_prefix() routine from ls-files.c.  Any use
> of global variables is removed from pathspec_prefix() so that it
> can be called from commit.c.
> 
> Reported-by: Reuben Thomas <rrt@sc3d.org>
> Analyzed-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> 
> On Mon, Jul 25, 2011 at 09:42:10AM +0200, Michael J Gruber wrote:
>>
>> Overlay the full tree instead.
> 
> That is one option. On the other hand, ls-files already provides
> the function we need to do this properly.
> 

How is this huge patch more "proper" then what I proposed?

> With your permission I am stealing your commit message.

I don't care about the message but don't see the point of this patch.
Using the same message certainly won't explain the difference...

> 
> Clemens
> ---
>  builtin/commit.c   |    6 ++++--
>  builtin/ls-files.c |   38 ++------------------------------------
>  cache.h            |    1 +
>  setup.c            |   32 ++++++++++++++++++++++++++++++++
>  4 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a16d00b..c2db12a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -256,8 +256,10 @@ static int list_paths(struct string_list *list, const char *with_tree,
>  		;
>  	m = xcalloc(1, i);
>  
> -	if (with_tree)
> -		overlay_tree_on_cache(with_tree, prefix);
> +	if (with_tree) {
> +		const char *max_prefix = pathspec_prefix(prefix, pattern);
> +		overlay_tree_on_cache(with_tree, max_prefix);
> +	}
>  
>  	for (i = 0; i < active_nr; i++) {
>  		struct cache_entry *ce = active_cache[i];
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 72b986f..fef5642 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -276,41 +276,6 @@ static void prune_cache(const char *prefix)
>  	active_nr = last;
>  }
>  
> -static const char *pathspec_prefix(const char *prefix)
> -{
> -	const char **p, *n, *prev;
> -	unsigned long max;
> -
> -	if (!pathspec) {
> -		max_prefix_len = prefix ? strlen(prefix) : 0;
> -		return prefix;
> -	}
> -
> -	prev = NULL;
> -	max = PATH_MAX;
> -	for (p = pathspec; (n = *p) != NULL; p++) {
> -		int i, len = 0;
> -		for (i = 0; i < max; i++) {
> -			char c = n[i];
> -			if (prev && prev[i] != c)
> -				break;
> -			if (!c || c == '*' || c == '?')
> -				break;
> -			if (c == '/')
> -				len = i+1;
> -		}
> -		prev = n;
> -		if (len < max) {
> -			max = len;
> -			if (!max)
> -				break;
> -		}
> -	}
> -
> -	max_prefix_len = max;
> -	return max ? xmemdupz(prev, max) : NULL;
> -}
> -
>  static void strip_trailing_slash_from_submodules(void)
>  {
>  	const char **p;
> @@ -581,7 +546,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		strip_trailing_slash_from_submodules();
>  
>  	/* Find common prefix for all pathspec's */
> -	max_prefix = pathspec_prefix(prefix);
> +	max_prefix = pathspec_prefix(prefix, pathspec);
> +	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
>  
>  	/* Treat unmatching pathspec elements as errors */
>  	if (pathspec && error_unmatch) {
> diff --git a/cache.h b/cache.h
> index 86518fb..dd3edaa 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -441,6 +441,7 @@ extern void set_git_work_tree(const char *tree);
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
>  extern const char **get_pathspec(const char *prefix, const char **pathspec);
> +extern const char *pathspec_prefix(const char *prefix, const char **pathspec);
>  extern void setup_work_tree(void);
>  extern const char *setup_git_directory_gently(int *);
>  extern const char *setup_git_directory(void);
> diff --git a/setup.c b/setup.c
> index 5ea5502..2c51a9a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -264,6 +264,38 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
>  	return pathspec;
>  }
>  
> +const char *pathspec_prefix(const char *prefix, const char **pathspec)
> +{
> +	const char **p, *n, *prev;
> +	unsigned long max;
> +
> +	if (!pathspec)
> +		return prefix ? xmemdupz(prefix, strlen(prefix)) : NULL;
> +
> +	prev = NULL;
> +	max = PATH_MAX;
> +	for (p = pathspec; (n = *p) != NULL; p++) {
> +		int i, len = 0;
> +		for (i = 0; i < max; i++) {
> +			char c = n[i];
> +			if (prev && prev[i] != c)
> +				break;
> +			if (!c || c == '*' || c == '?')
> +				break;
> +			if (c == '/')
> +				len = i+1;
> +		}
> +		prev = n;
> +		if (len < max) {
> +			max = len;
> +			if (!max)
> +				break;
> +		}
> +	}
> +
> +	return max ? xmemdupz(prev, max) : NULL;
> +}
> +
>  /*
>   * Test if it looks like we're at a git directory.
>   * We want to see:
