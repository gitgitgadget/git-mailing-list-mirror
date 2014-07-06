From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v5 1/2] add `config_set` API for caching config-like files
Date: Sun, 06 Jul 2014 12:15:51 +0100
Message-ID: <53B92FE7.6010707@ramsay1.demon.co.uk>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com> <1404631162-18556-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 13:16:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3kQO-0003BP-VF
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 13:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbaGFLP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 07:15:58 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:51369 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751015AbaGFLP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 07:15:57 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 4145B18CC22;
	Sun,  6 Jul 2014 12:16:06 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id E589118CE36;
	Sun,  6 Jul 2014 12:16:05 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Sun,  6 Jul 2014 12:16:04 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1404631162-18556-2-git-send-email-tanayabh@gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252932>

On 06/07/14 08:19, Tanay Abhra wrote:
> Currently `git_config()` uses a callback mechanism and file rereads for
> config values. Due to this approach, it is not uncommon for the config
> files to be parsed several times during the run of a git program, with
> different callbacks picking out different variables useful to themselves.
> 
> Add a `config_set`, that can be used to construct an in-memory cache for
> config-like files that the caller specifies (i.e., files like `.gitmodules`,
> `~/.gitconfig` etc.). Add two external functions `git_configset_get_value`
> and `git_configset_get_value_multi` for querying from the config sets.
> `git_configset_get_value` follows `last one wins` semantic (i.e. if there
> are multiple matches for the queried key in the files of the configset the
> value returned will be the last entry in `value_list`).
> `git_configset_get_value_multi` returns a list of values sorted in order of
> increasing priority (i.e. last match will be at the end of the list). Add
> type specific query functions like `git_configset_get_bool` and similar.
> 
> Add a default `config_set`, `the_config_set` to cache all key-value pairs
> read from usual config files (repo specific .git/config, user wide
> ~/.gitconfig and the global /etc/gitconfig). `the_config_set` uses a
> single hashmap populated using `git_config()`.
> 
> Add two external functions `git_config_get_value` and 
> `git_config_get_value_multi` for querying in a non-callback manner from
> `the_config_set`. Also, add type specific query functions that are
> implemented as a thin wrapper around the `config_set` API.
> 
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  Documentation/technical/api-config.txt | 134 +++++++++++++++
>  Makefile                               |   1 +
>  cache.h                                |  34 ++++
>  config-hash.c                          | 297 +++++++++++++++++++++++++++++++++
>  config.c                               |   3 +
>  5 files changed, 469 insertions(+)
>  create mode 100644 config-hash.c
> 
> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 230b3a0..bdf86d0 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -77,6 +77,81 @@ To read a specific file in git-config format, use
>  `git_config_from_file`. This takes the same callback and data parameters
>  as `git_config`.
>  
> +Querying For Specific Variables
> +-------------------------------
> +
> +For programs wanting to query for specific variables in a non-callback
> +manner, the config API provides two functions `git_config_get_value`
> +and `git_config_get_value_multi`. They both read values from an internal
> +cache generated previously from reading the config files.
> +
> +`int git_config_get_value(const char *key, const char **value)`::
> +
> +	Finds the highest-priority value for the configuration variable `key`,
> +	stores the pointer to it in `value` and returns 0. When the
> +	configuration variable `key` is not found, returns 1 without touching
> +	`value`. The caller should not free or modify `value`, as it is owned
> +	by the cache.
> +
> +`const struct string_list *git_config_get_value_multi(const char *key)`::
> +
> +	Finds and returns the value list, sorted in order of increasing priority
> +	for the configuration variable `key`. When the configuration variable
> +	`key` is not found, returns NULL. The caller should not free or modify
> +	the returned pointer, as it is owned by the cache.
> +
> +`void git_config_clear(void)`::
> +
> +	Resets and invalidate the config cache. 
> +
> +The config API also provides type specific API functions which do conversion
> +as well as retrieval for the queried variable, including:
> +
> +`int git_config_get_int(const char *key, int *dest)`::
> +
> +	Finds and parses the value to an integer for the configuration variable
> +	`key`. Dies on error; otherwise, stores pointer to the parsed integer in

... stores the value of the parsed integer in `dest` ...

> +	`dest` and returns 0. When the configuration variable `key` is not found,
> +	returns 1 without touching `dest`.
> +
> +`int git_config_get_ulong(const char *key, unsigned long *dest)`::
> +
> +	Similar to `git_config_get_int` but for unsigned longs.
> +
> +`int git_config_get_int(const char *key, int *dest)`::
-----------------------^^^

git_config_get_bool

> +
> +	Finds and parses the value into a boolean value, for the configuration
> +	variable `key`respecting keywords like "true" and "false". Integer
> +	values are converted into true/false values (when they are non-zero or
> +	zero, respectively). Other values cause a die(). If parsing is successful,
> +	stores the pointer to the parsed result in `dest` and returns 0. When the

... stores the value of the parsed result in `dest` ...

> +	configuration variable `key` is not found, returns 1 without touching
> +	`dest`.
> +
> +`int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)`::
> +
> +	Similar to `git_config_get_bool`, except that integers are copied as-is,
> +	and `is_bool` flag is unset.
> +
> +`int git_config_get_maybe_bool(const char *key, int *dest)`::
> +
> +	Similar to `git_config_get_bool`, except that it returns -1 on error
> +	rather than dying.
> +
> +`int git_config_get_string(const char *key, const char **dest)`::
> +
> +	Allocates and copies the retrieved string into the `dest` parameter for
> +	the configuration variable `key`; if NULL string is given, prints an
> +	error message and returns -1. When the configuration variable `key` is
> +	not found, returns 1 without touching `dest`.
> +
> +`int git_config_get_pathname(const char *key, const char **dest)`::
> +
> +	Similar to `git_config_get_string`, but expands `~` or `~user` into
> +	the user's home directory when found at the beginning of the path.
> +
> +See test-config.c for usage examples.
> +

Sorry, I didn't have time to do more than squint at the code, but at first
glance it looks good.

ATB,
Ramsay Jones
