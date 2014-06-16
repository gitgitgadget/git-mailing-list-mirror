From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] config: Add hashtable for config parsing & retrieval
Date: Mon, 16 Jun 2014 19:11:22 +0200
Message-ID: <vpqy4ww230l.fsf@anie.imag.fr>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
	<1402907232-24629-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:11:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwaRQ-00081U-M4
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbaFPRL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:11:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46158 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbaFPRL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 13:11:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5GHBKNb007821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jun 2014 19:11:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5GHBMa4026470;
	Mon, 16 Jun 2014 19:11:22 +0200
In-Reply-To: <1402907232-24629-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 16 Jun 2014 01:27:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jun 2014 19:11:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251735>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add a hash table to cache all key-value pairs read from config files
> (repo specific .git/config, user wide ~/.gitconfig and the global
> /etc/gitconfig). Add two external functions `git_config_get_string` and
> `git_config_get_string_multi` for querying in a non-callback manner from the
> hash table.

This describes rather well _what_ your patch does, but the most
important part of a commit message is to justify _why_ the change is
good, and why the way you implemented it is good.

Think of it as an way to convince reviewers to accept your patch.

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  Documentation/technical/api-config.txt |  17 +++++
>  cache.h                                |   2 +
>  config.c                               | 123 +++++++++++++++++++++++++++++++++
>  3 files changed, 142 insertions(+)

I'm still concerned about the fact that there is no test. At this point,
git_config_get_string_multi and git_config_get_string are basically dead
code.

I'm sure you did experiments to test these functions, run them through
valgrind, ... Now, you need to let other people reproduce these
experiments. "other people" can be reviewers, now, or anyone looking for
bugs or regressions in the future.

> +static int config_cache_callback(const char *key, const char *value, void *unused)
> +{
> +	config_cache_set_value(key, value);
> +	return 0;
> +}
> +
> +static struct hashmap *get_config_cache(void)
> +{
> +	static struct hashmap config_cache;
> +	if (!hashmap_initialized) {
> +		config_cache_init(&config_cache);
> +		hashmap_initialized = 1;
> +		git_config(config_cache_callback, NULL);
> +	}
> +	return &config_cache;
> +}

Good, just enough code for the job :-).

> +static struct config_cache_entry *config_cache_find_entry(const char *key)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry k;
> +	struct config_cache_entry *found_entry;
> +	char *normalized_key;
> +	int ret;
> +	config_cache = get_config_cache();
> +	ret = git_config_parse_key(key, &normalized_key, NULL);
> +
> +	if (ret)
> +		return NULL;
> +
> +	hashmap_entry_init(&k, strhash(normalized_key));
> +	k.key = (char *)normalized_key;

No need to cast.

> +static int config_cache_set_value(const char *key, const char *value)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry *e;
> +
> +	config_cache = get_config_cache();
> +	e = config_cache_find_entry(key);
> +	if (!e) {
> +		e = xmalloc(sizeof(*e));
> +		hashmap_entry_init(e, strhash(key));
> +		e->key = xstrdup(key);
> +		string_list_init_dup(&e->value_list);
> +		string_list_append(&e->value_list, value);
> +		hashmap_add(config_cache, e);
> +	} else {
> +		string_list_append(&e->value_list, value);
> +	}
> +	return 0;
> +}

I find the function name a bit confusing, as it does not "set" in the
sense "override any previous value". Wouldn't this be better named
config_cache_add_value? Or perhaps a comment would help.

> @@ -1714,6 +1830,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  	lock = NULL;
>  	ret = 0;
>  
> +	/*
> +	 *contents of config file has changed, so invalidate the
> +	 *config cache used by non-callback based query functions.
> +	 */

Spaces after stars:

/*
 * Contents of config file has changed, so invalidate the
 * config cache used by non-callback based query functions.
 */

(I think the "s" of "contents" should be dropped too).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
