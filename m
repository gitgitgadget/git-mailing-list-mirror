From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 5/6] config: add `git_die_config()` to the config-set
 API
Date: Mon, 28 Jul 2014 11:55:22 +0100
Message-ID: <53D62C1A.5000203@ramsay1.demon.co.uk>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com> <1406543635-19281-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiaZ-0007IL-Dp
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaG1Kz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:55:27 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:46822 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbaG1Kz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:55:27 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 64406A0C08E;
	Mon, 28 Jul 2014 10:47:52 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 06B2AA0C086;
	Mon, 28 Jul 2014 10:47:52 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Mon, 28 Jul 2014 10:47:51 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1406543635-19281-6-git-send-email-tanayabh@gmail.com>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254303>

On 28/07/14 11:33, Tanay Abhra wrote:
> Add `git_die_config` that dies printing the line number and the file name
> of the highest priority value for the configuration variable `key`.
> 
> It has usage in non-callback based config value retrieval where we can
> raise an error and die if there is a semantic error.
> For example,
> 
> 	if (!git_config_get_value(key, &value)) {
> 		/* NULL values not allowed */
> 		if (!value)
> 			git_config_die(key);
> 		else
> 			/* do work */
> 	}
> 
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> Note: git_config_get_string() calls git_config_get_string_const(),
> so no need to check for whether to die or not, as it is done by
> git_config_get_string_const().
> 
>  Documentation/technical/api-config.txt |  5 +++++
>  cache.h                                |  1 +
>  config.c                               | 24 ++++++++++++++++++++++--
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 815c1ee..e7ec7cc 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -155,6 +155,11 @@ as well as retrieval for the queried variable, including:
>  	Similar to `git_config_get_string`, but expands `~` or `~user` into
>  	the user's home directory when found at the beginning of the path.
>  
> +`void git_die_config(const char *key)`::
> +
> +	Dies printing the line number and the file name of the highest
> +	priority value for the configuration variable `key`.
> +
>  See test-config.c for usage examples.
>  
>  Value Parsing Helpers
> diff --git a/cache.h b/cache.h
> index 93bdbab..8512225 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1406,6 +1406,7 @@ extern int git_config_get_bool(const char *key, int *dest);
>  extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
>  extern int git_config_get_maybe_bool(const char *key, int *dest);
>  extern int git_config_get_pathname(const char *key, const char **dest);
> +extern void git_die_config(const char *key);
>  
>  extern int committer_ident_sufficiently_given(void);
>  extern int author_ident_sufficiently_given(void);
> diff --git a/config.c b/config.c
> index 2ce3318..136ee9c 100644
> --- a/config.c
> +++ b/config.c
> @@ -1505,8 +1505,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
>  
>  int git_config_get_string_const(const char *key, const char **dest)
>  {
> +	int ret;
>  	git_config_check_init();
> -	return git_configset_get_string_const(&the_config_set, key, dest);
> +	ret = git_configset_get_string_const(&the_config_set, key, dest);
> +	if (ret < 0)
> +		git_die_config(key);
> +	return ret;
>  }
>  
>  int git_config_get_string(const char *key, char **dest)
> @@ -1547,10 +1551,26 @@ int git_config_get_maybe_bool(const char *key, int *dest)
>  
>  int git_config_get_pathname(const char *key, const char **dest)
>  {
> +	int ret;
>  	git_config_check_init();
> -	return git_configset_get_pathname(&the_config_set, key, dest);
> +	ret = git_configset_get_pathname(&the_config_set, key, dest);
> +	if (ret < 0)
> +		git_die_config(key);
> +	return ret;
>  }
>  
> +void git_die_config(const char *key)
> +{
> +	const struct string_list *values;
> +	struct key_value_info *kv_info;
> +	values = git_config_get_value_multi(key);
> +	kv_info = values->items[values->nr - 1].util;
> +	if (!kv_info->linenr)
> +		die("unable to parse command-line config");
> +	else
> +		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);

How about including the 'key' string in the error message?
Similar comment applies to an earlier patch in this series.

> + }
> +
>  /*
>   * Find all the stuff for git_config_set() below.
>   */
> 

ATB,
Ramsay Jones
