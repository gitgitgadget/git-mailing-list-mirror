From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Mon, 23 Jun 2014 15:57:59 +0100
Message-ID: <53A84077.4010200@ramsay1.demon.co.uk>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com> <1403518300-23053-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 16:58:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz5hD-0001kb-IG
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 16:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbaFWO6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 10:58:07 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:52245 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbaFWO6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 10:58:05 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C2FC26F8BB5;
	Mon, 23 Jun 2014 14:23:23 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 725B36F8B9B;
	Mon, 23 Jun 2014 14:23:23 +0100 (BST)
Received: from [192.168.254.12] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Mon, 23 Jun 2014 14:23:22 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1403518300-23053-3-git-send-email-tanayabh@gmail.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252347>

On 23/06/14 11:11, Tanay Abhra wrote:

[snip]

> diff --git a/config.c b/config.c
> index a1aef1c..6200f36 100644
> --- a/config.c
> +++ b/config.c
> @@ -9,6 +9,8 @@
>  #include "exec_cmd.h"
>  #include "strbuf.h"
>  #include "quote.h"
> +#include "hashmap.h"
> +#include "string-list.h"
>  
>  struct config_source {
>  	struct config_source *prev;
> @@ -37,6 +39,141 @@ static struct config_source *cf;
>  
>  static int zlib_compression_seen;
>  
> +struct config_cache_entry {
> +	struct hashmap_entry ent;
> +	char *key;
> +	struct string_list value_list;
> +};
> +
> +static int hashmap_initialized;
> +
> +static int config_cache_add_value(const char *key, const char *value);
> +
> +static int config_cache_entry_cmp(const struct config_cache_entry *e1,
> +				 const struct config_cache_entry *e2, const void *unused)
> +{
> +	return strcmp(e1->key, e2->key);
> +}
> +
> +static void config_cache_init(struct hashmap *config_cache)
> +{
> +	hashmap_init(config_cache, (hashmap_cmp_fn)config_cache_entry_cmp, 0);
> +}
> +
> +static int config_cache_callback(const char *key, const char *value, void *unused)
> +{
> +	config_cache_add_value(key, value);
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

[I have not been following this series at all (sorry I haven't had
the time to spare), so take these comments with a very big pinch of
salt! ie just ignore me if it's already been discussed etc. ;-) ]

The 'git config' command can be used to read arbitrary files (so long
as they conform to the config syntax). For example, see the --file and
--blob options to git-config. At present, I think only scripted commands
use this facility (eg git-submodule). Noting the singleton config_cache,
what happens when git-submodule becomes a C builtin, or indeed any other
C builtin wants to take advantage of the new code when processing a non-
standard config file?

> +
> +static void config_cache_free(void)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry *entry;
> +	struct hashmap_iter iter;
> +	config_cache = get_config_cache();
> +	hashmap_iter_init(config_cache, &iter);
> +	while ((entry = hashmap_iter_next(&iter))) {
> +		free(entry->key);
> +		string_list_clear(&entry->value_list, 1);
> +	}
> +	hashmap_free(config_cache, 1);
> +	hashmap_initialized = 0;
> +}
> +
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
> +	k.key = normalized_key;
> +	found_entry = hashmap_get(config_cache, &k, NULL);
> +	free(normalized_key);
> +	return found_entry;
> +}
> +
> +static struct string_list *config_cache_get_value(const char *key)
> +{
> +	struct config_cache_entry *e = config_cache_find_entry(key);
> +	return e ? &e->value_list : NULL;
> +}
> +
> +static int config_cache_add_value(const char *key, const char *value)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry *e;
> +	struct string_list_item *item;
> +	int *boolean_null_flag;
> +
> +	config_cache = get_config_cache();
> +	e = config_cache_find_entry(key);
> +
> +	boolean_null_flag = xcalloc(1, sizeof(*boolean_null_flag));
> +
> +	if (!e) {
> +		e = xmalloc(sizeof(*e));
> +		hashmap_entry_init(e, strhash(key));
> +		e->key = xstrdup(key);

config_cache_find_entry() searches for (and hashes the) normalized_key.
Should you not be entering the normalized key here?

> +		string_list_init_dup(&e->value_list);
> +		hashmap_add(config_cache, e);
> +	}
> +	/*
> +	 * If the variable had no value specified, the value will be NULL
> +	 * (typically this means it should be interpreted as boolean true).
> +	 * For such values, silently convert them to "BOOLEAN_NULL" to
> +	 * store in hashmap and flag that string_list_item as 1.
> +	 */
> +	if (value == NULL) {
> +		value = "BOOLEAN_NULL";
> +		*boolean_null_flag = 1;
> +	}
> +	item = string_list_append(&e->value_list, value);
> +	item->util = boolean_null_flag;
> +
> +	return 0;
> +}
> +

[snip]

ATB,
Ramsay Jones
