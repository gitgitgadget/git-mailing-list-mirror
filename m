From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/2] add `config_set` API for caching config-like files
Date: Fri, 11 Jul 2014 10:25:46 -0700
Message-ID: <xmqqfvi74xk5.fsf@gitster.dls.corp.google.com>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
	<1405049655-4265-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eaA-0004YW-He
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbaGKRZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:25:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52635 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbaGKRZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:25:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93CC126630;
	Fri, 11 Jul 2014 13:25:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x1u0H1CZL0bObH4dnGLNSoZgV6s=; b=jrDpCA
	d+jZp+uMLp5VXMvuT1phuMPi5wqXZlhhyHDqOUQeWQjqVpfK1r4W6k/RTEw9GORb
	tOgzJlUTA8JsuKr3EG+7CZforvpn/KCE/fSU5SmBjI2hcTWNl6WmsSoh5+1uh8E4
	4AHr3pUtNhviqU0kS1XqBxSSD5N0yf4YH20f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RaWcakDRiM+6GpmsjeXflS8xL6UqW6lv
	HfMNq0pdZZbqASVzUwZNcun9f9tp2ombSTwli9LhZcTsvO44vBtcXHclc5Sm8baM
	0Cw5GfXhurY1vfC5x/ojA/+tZDbMqWZYqcIQ7looK1OGYJiKgcgjJTMCeGlTssm6
	nUyDwmh1TkY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89AFE2662F;
	Fri, 11 Jul 2014 13:25:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A60126626;
	Fri, 11 Jul 2014 13:25:32 -0400 (EDT)
In-Reply-To: <1405049655-4265-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 10 Jul 2014 20:34:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5CEC51A6-0920-11E4-BB0E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253299>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/config.c b/config.c
> index ba882a1..aa58275 100644
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
> @@ -33,10 +35,23 @@ struct config_source {
>  	long (*do_ftell)(struct config_source *c);
>  };
>  
> +struct config_hash_entry {
> +	struct hashmap_entry ent;
> +	char *key;
> +	struct string_list value_list;
> +};
> +
>  static struct config_source *cf;
>  
>  static int zlib_compression_seen;
>  
> +/*
> + * Default config_set that contains key-value pairs from the usual set of config
> + * config files (i.e repo specific .git/config, user wide ~/.gitconfig, XDG
> + * config file and the global /etc/gitconfig)
> + */
> +static struct config_set the_config_set;
> +
>  static int config_file_fgetc(struct config_source *conf)
>  {
>  	return fgetc(conf->u.file);
> @@ -1212,6 +1227,284 @@ int git_config(config_fn_t fn, void *data)
>  	return git_config_with_options(fn, data, NULL, 1);
>  }
>  
> +static int config_hash_add_value(const char *, const char *, struct hashmap *);

This is a funny forward declaration.  If you define add-file and
friends that modify the config-set _after_ you define find-entry and
friends that are used to look-up, would you still need to do a
forward declaration?

In any case, please give names to these first two parameters as what
they are for can be unclear; because they are of the same type,
there is one less clue than there usually are.

The function signature makes it sound as if this is not specific to
"config"; what takes a hashmap, a key and a value and is called "add"
is a function to add <key, value> pair to a hashmap.  Why doesn't it
take "struct config_set"?  In other words, I would have expected

static int config_set_add(struct config_set *, const char *key, const char *value)

instead.  Not a complaint, but is puzzled why you chose not to do
so.

I suspect almost everywhere in this patch, you would want to do
s/config_hash/config_set/.  s/config_hash_entry/config_set_element/
might be a good idea, too.  You have the concept of the "config
set", and each element of that set is a "config-set element", not a
"config-hash entry", isn't it?

> +static int config_hash_entry_cmp(const struct config_hash_entry *e1,
> +				 const struct config_hash_entry *e2, const void *unused)
> +{
> +	return strcmp(e1->key, e2->key);
> +}
> +
> +static void configset_init(struct config_set *cs)
> +{
> +	if (!cs->hash_initialized) {
> +		hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
> +		cs->hash_initialized = 1;
> +	}
> +}

Have uninitializer here, immediately after you defined the initializer.

> +static int config_hash_callback(const char *key, const char *value, void *cb)
> +{
> +	struct config_set *cs = cb;
> +	config_hash_add_value(key, value, &cs->config_hash);
> +	return 0;
> +}
> +
> +int git_configset_add_file(struct config_set *cs, const char *filename)
> +{
> +	int ret = 0;
> +	configset_init(cs);
> +	ret = git_config_from_file(config_hash_callback, filename, cs);
> +	if (!ret)
> +		return 0;
> +	else {
> +		hashmap_free(&cs->config_hash, 1);
> +		cs->hash_initialized = 0;
> +		return -1;

Does calling configset_clear() do too much for the purpose of this
error path?  In other words, is it deliberate that you do not touch
any string-list items you may have accumulated by calling the
callback?

> +static struct config_hash_entry *config_hash_find_entry(const char *key,
> +							struct hashmap *config_hash)
> +{
> +	struct config_hash_entry k;
> +	struct config_hash_entry *found_entry;
> +	char *normalized_key;
> +	int ret;
> +	/*
> +	 * `key` may come from the user, so normalize it before using it
> +	 * for querying entries from the hashmap.
> +	 */
> +	ret = git_config_parse_key(key, &normalized_key, NULL);
> +
> +	if (ret)
> +		return NULL;
> +
> +	hashmap_entry_init(&k, strhash(normalized_key));
> +	k.key = normalized_key;
> +	found_entry = hashmap_get(config_hash, &k, NULL);
> +	free(normalized_key);
> +	return found_entry;
> +}
> +
> +static struct string_list *configset_get_list(const char *key, struct config_set *cs)
> +{
> +	struct config_hash_entry *e = config_hash_find_entry(key, &cs->config_hash);
> +	return e ? &e->value_list : NULL;
> +}
> +
> +static int config_hash_add_value(const char *key, const char *value, struct hashmap *config_hash)
> +{
> +	struct config_hash_entry *e;
> +	e = config_hash_find_entry(key, config_hash);
> +	/*
> +	 * Since the keys are being fed by git_config*() callback mechanism, they
> +	 * are already normalized. So simply add them without any further munging.
> +	 */
> +	if (!e) {
> +		e = xmalloc(sizeof(*e));
> +		hashmap_entry_init(e, strhash(key));
> +		e->key = xstrdup(key);
> +		memset(&e->value_list, 0, sizeof(e->value_list));
> +		e->value_list.strdup_strings = 1;

Hmph, I thought you invented string_list_init() but perhaps it was
somebody else...

> +		hashmap_add(config_hash, e);
> +	}
> +	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);

Mental note: once "string list" is updated to make it a true
"string" list for whatever reason, we would be broken by such a
change because we throw a NULL in there.  Just something to watch
out for in the future.  Perhaps deserves a new comment in
string-list API to officially declare that such a use is supported
and must continue to work?  I dunno.

> +	return 0;
> +}
> +
> +void git_configset_init(struct config_set *cs)
> +{
> +	cs->hash_initialized = 0;
> +}

This is somewhat strange; as we are preparing cs for use, why not
initialize the config_hash member and flip hash_initialized to true
instead?

> +int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
> +{
> +	struct string_list *values = NULL;
> +	/*
> +	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
> +	 * queried key in the files of the configset, the value returned will be the last
> +	 * value in the value list for that key.
> +	 */
> +	values = configset_get_list(key, cs);
> +
> +	if (!values)
> +		return 1;
> +	assert(values->nr > 0);
> +	*value = values->items[values->nr - 1].string;
> +	return 0;
> +}
> +
> +const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
> +{
> +	return configset_get_list(key, cs);
> +}

This is OK, but I would have expected that configset_get_value(),
knowing that its semantics is "grab all and pick the last one",
would call git_configset_get_value_multi() directly, which in turn
would mean there is no need for configset_get_list() intermediary.

> +void git_configset_clear(struct config_set *cs)
> +{
> +	struct config_hash_entry *entry;
> +	struct hashmap_iter iter;
> +	if (!cs->hash_initialized)
> +		return;
> +
> +	hashmap_iter_init(&cs->config_hash, &iter);
> +	while ((entry = hashmap_iter_next(&iter))) {
> +		free(entry->key);
> +		string_list_clear(&entry->value_list, 0);
> +	}
> +	hashmap_free(&cs->config_hash, 1);
> +}
> +
> +int git_configset_get_string(struct config_set *cs, const char *key, const char **dest)
> +{
> +	const char *value;
> +	if (!git_configset_get_value(cs, key, &value))
> +		return git_config_string(dest, key, value);
> +	else
> +		return 1;
> +}
> +
> +int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
> +{
> +	const char *value;
> +	if (!git_configset_get_value(cs, key, &value)) {
> +		*dest = git_config_int(key, value);
> +		return 0;
> +	} else
> +		return 1;
> +}
> + ...
> +static int git_config_check_init(void)
> +{
> +	int ret = 0;
> +	if (the_config_set.hash_initialized)
> +		return 0;
> +	configset_init(&the_config_set);
> +	ret = git_config(config_hash_callback, &the_config_set);
> +	if (ret >= 0)
> +		return 0;
> +	else {
> +		hashmap_free(&the_config_set.config_hash, 1);
> +		the_config_set.hash_initialized = 0;
> +		return -1;
> +	}
> +}

> +int git_config_get_value(const char *key, const char **value)
> +{
> +	git_config_check_init();
> +	return git_configset_get_value(&the_config_set, key, value);
> +}
> +
> +const struct string_list *git_config_get_value_multi(const char *key)
> +{
> +	git_config_check_init();
> +	return git_configset_get_value_multi(&the_config_set, key);
> +}

> +void git_config_clear(void)
> +{
> +	if (!the_config_set.hash_initialized)
> +		return;
> +	git_configset_clear(&the_config_set);
> +	the_config_set.hash_initialized = 0;
> +}

Move this deinitializer of the cached config system immediately
after git_config_check_init(), which is a lazy initializer.

It is somewhat unfortunate that git_config_get_* functions that are
parallel to git_configset_get_* functions cannot be simple macros
with the fixed &the_config_set parameter due to lazy initialization,
but I think it is OK.  This round mostly looks good to me, except
for the points I mentioned above.

Thanks.
