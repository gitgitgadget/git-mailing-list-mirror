From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 1/2] config: Add hashtable for config parsing &
 retrieval
Date: Tue, 3 Jun 2014 03:58:53 -0400
Message-ID: <20140603075853.GA32249@sigill.intra.peff.net>
References: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
 <1401720460-6525-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 09:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrjca-00014v-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 09:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbaFCH65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 03:58:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:36448 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932225AbaFCH64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 03:58:56 -0400
Received: (qmail 10010 invoked by uid 102); 3 Jun 2014 07:58:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jun 2014 02:58:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2014 03:58:53 -0400
Content-Disposition: inline
In-Reply-To: <1401720460-6525-2-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250618>

On Mon, Jun 02, 2014 at 07:47:39AM -0700, Tanay Abhra wrote:

> +static int config_cache_entry_cmp_icase(const struct config_cache_entry *e1,
> +				 const struct config_cache_entry *e2, const char* key)
> +{
> +	return strcasecmp(e1->key, key ? key : e2->key);
> +}
> +
> +static void config_cache_init(void)
> +{
> +	hashmap_init(&config_cache, (hashmap_cmp_fn)config_cache_entry_cmp_icase, 0);
> +}

It looks like this is meant to treat config keys like "diff.renames" as
case-insensitive. That's OK for two-part names, but longer names with a
middle section, like "remote.Foo.url", should have their middle sections
be case-sensitive.

Also, please avoid casting function ptrs. Give your function the correct
hashmap_cmp_fn signature, and cast from "void *" internally if you need
to.

> +static void config_cache_free(void)
> +{
> +	struct config_cache_entry* entry;
> +	struct hashmap_iter iter;
> +	hashmap_iter_init(&config_cache, &iter);
> +	while (entry = hashmap_iter_next(&iter)) {

Please wrap assignment inside a loop condition with an extra (), like:

  while ((entry = hashmap_iter_next(&iter)))

This suppresses gcc's "did you mean ==" warning. If you are not
compiling with "-Wall -Werror" for development, you probably should be.

> +static struct config_cache_entry *config_cache_find_entry(const char *key)
> +{
> +	struct hashmap_entry k;
> +	hashmap_entry_init(&k, strihash(key));
> +	return hashmap_get(&config_cache, &k, key);
> +}

As above, strihash isn't quite right here. It needs a custom function
that takes into account the case-sensitivity of the middle section of
the key name.

An alternative is to only feed already-normalized names into the hash
code, and then tell the hash to be case-sensitive.

> +static void config_cache_set_value(const char *key, const char *value)
> +{
> +	struct config_cache_entry *e;
> +
> +	e = config_cache_find_entry(key);
> +	if (!e) {
> +		e = malloc(sizeof(*e));
> +		hashmap_entry_init(e, strihash(key));
> +		e->key=xstrdup(key);

Style: please keep whitespace around "=".

> +	} else {
> +		if (!unsorted_string_list_has_string(e->value_list, value))
> +			string_list_append(e->value_list, value);
> +	}

I don't think we want to suppress duplicates here. If a caller reads the
value with git_config_get_string(), then the duplicates do not matter
(we show only the one with precedence). If they use the "multi()" form,
then they _should_ see each version. It is not up to the config code to
decide that duplicate values for the same key are not interesting; only
the caller knows that.

> +static void config_cache_remove_value(const char *key, const char *value)
> +{
> +	struct config_cache_entry *e;
> +	int i;
> +
> +	e = config_cache_find_entry(key);
> +	if(!e)

Style: if (!e)

> +	/* If value == NULL then remove all the entries for the key */
> +	if(!value) {

Ditto (and elsewhere, but I'll stop noting each).

> +extern const char *git_config_get_string(const char *name)
> +{
> +	struct string_list *values;
> +	values = config_cache_get_value(name);
> +	if (!values)
> +		return NULL;
> +	return values->items[values->nr - 1].string;
> +}

The assumption here is that values->nr is never 0. I think that is true,
because we do not create the cache entry until we get a value (and
remove it if we drop the last value). However, it might be worth
documenting that with an assertion.

> @@ -333,6 +441,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>               if (!value)
>                       return -1;
>       }
> +     config_cache_set_value(name->buf, value);
>       return fn(name->buf, value, data);
>  }

The function get_value gets called for each entry from a parsed config
file. However, it does not get called for command-line config from "git
-c". You'd need to update git_config_parse_parameter for that.

However, I wonder if this is the right place to hook into the cache at
all. The cache should be able to sit _atop_ the existing callback
system. So you could easily implement it as a separate layer, and just
lazily initialize it like:

  static int config_cache_callback(const char *key, const char *val, void *cache)
  {
	config_cache_set_value(cache, key, val);
	return 0;
  }

  static struct hashmap *get_config_cache(void)
  {
	static int initialized;
	static struct hashmap cache;
	if (!initialized) {
		hash_map_init(&cache, 
		git_config(config_cache_callback, &cache);
		initialized = 1;
	}
  }

and then teach config_cache_get_value and friends to access the cache
through "get_config_cache".

> @@ -1570,6 +1684,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  		if (!store_write_section(fd, key) ||
>  		    !store_write_pair(fd, key, value))
>  			goto write_err_out;
> +		else config_cache_set_value(key, value);
>  	} else {
>  		struct stat st;
>  		char *contents;
> @@ -1673,6 +1788,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  			}
>  			if (!store_write_pair(fd, key, value))
>  				goto write_err_out;
> +			else config_cache_set_value(key, value);
> +		} else {
> +			config_cache_remove_value(key, NULL);
>  		}
>  
>  		/* write the rest of the config */

These two seem suspect to me. How do we know that config_filename that
we are manipulating is even referenced by the config cache? When we
remove an entry, how do we know we are getting the entry from that file,
and not a similar entry in another file?

Stepping back, though, do we need to keep the cache up to date here with
micro-changes at all? If we have updated the config files on disk, then
the simplest thing would be to just invalidate the whole cache (and then
lazily re-read it if we actually need it again). This should be a rare
case (I suspect that "git init" and "git clone" might want this, but
that's about it).

-Peff
