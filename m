From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 07:27:11 -0400
Message-ID: <CAPig+cTR5SdDF0QnKN8GFEKFkNEK_HoCDHj_vTnAbp37HK3kDA@mail.gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
	<1402318146-5062-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 13:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuKCz-0001lP-Pp
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 13:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbaFJL1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 07:27:14 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:32843 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaFJL1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 07:27:12 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so1939437yha.41
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eWfyRTb7t+Pw+ldT1+JanVtaLFOSCK1VWh8i7HWiucQ=;
        b=xYe9ncCxuvBDdAT4vyNoOw79XCm3KTmScesR6p5z6Gnqrfx5kOhE7sCYrZ7ewA3n9S
         KS5iWfBbqCoUYnUDg/lRkFxoPkHBW8lnaJPLVewCMjhsvD+NevdfVxaCTRi7psjbpLg/
         AGYgw3ppNvH1fFl6HUEmvNrOiVxbckGwkwISM3M18YiGj58C7nFjwnMdM0NurWHRAplg
         sEzWSJSTXcAgOq68TE2+psWgY0ZpNdHhma0JaE5VqPc41IE+ttszLAg/SxZk4di/CCPL
         cRbEM3wJML//64W2zu4ffd6kIDt+Vt8Gxeg38XJlFnRx+6EL+lZyGcjlj8kyi93pGr6F
         PYWA==
X-Received: by 10.236.66.139 with SMTP id h11mr22122016yhd.30.1402399631960;
 Tue, 10 Jun 2014 04:27:11 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 04:27:11 -0700 (PDT)
In-Reply-To: <1402318146-5062-2-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: 9mJ5Q4OdHHlJ7Mfv1kh3lQKEJEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251178>

On Mon, Jun 9, 2014 at 8:49 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Add a hash table to cache all key-value pairs read from config files
> (repo specific .git/config, user wide ~/.gitconfig and the global
> /etc/gitconfig). Add two external functions `git_config_get_string` and
> `git_config_get_string_multi` for querying in a non-callback manner from the
> hash table.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 230b3a0..5b6e376 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -77,6 +77,24 @@ To read a specific file in git-config format, use
>  `git_config_from_file`. This takes the same callback and data parameters
>  as `git_config`.
>
> +Querying For Specific Variables
> +-------------------------------
> +
> +For programs wanting to query for specific variables in a non-callback
> +manner, the config API provides two functions `git_config_get_string`
> +and `git_config_get_string_multi`. They both take a single parameter,
> +
> +- a key string in canonical flat form for which the corresponding values
> +  will be retrieved and returned.

It's strange to have a bulleted list for a single item. It can be
stated more naturally as a full sentence, without the list.

More below.

> +They both read values from an internal cache generated previously from
> +reading the config files. `git_config_get_string` returns the value with
> +the highest priority(i.e. for the same variable value in the repo config
> +will be preferred over value in user wide config).
> +
> +`git_config_get_string_multi` returns a `string_list` containing all the
> +values for that particular key, sorted in order of increasing priority.
> +
>  Value Parsing Helpers
>  ---------------------
>
> diff --git a/config.c b/config.c
> index a30cb5c..6f6b04e 100644
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
>         struct config_source *prev;
> @@ -37,6 +39,120 @@ static struct config_source *cf;
>
>  static int zlib_compression_seen;
>
> +struct config_cache_entry {
> +       struct hashmap_entry ent;
> +       char *key;
> +       struct string_list *value_list;

Same question as in my v1 and v2 reviews [1][2], and reiterated by
Matthieu [3]: Why is 'value_list' a pointer to a structure rather than
just a structure?

This is a genuine question. As a reviewer, I'm not sure how to
interpret your lack of response. I can't tell if you merely overlook
or forget the question multiple times; if you don't understand the
inquiry; or if you have a strong reason to prefer making this a
pointer. If you don't understand the question, it's okay to ask for
clarification. If there is a strong reason for this to be a pointer,
it should be explained. Without feedback from you, reviewers will
continue asking the same question(s) upon each submission.

> +};
> +
> +static int hashmap_is_init;
> +
> +static int config_cache_set_value(const char *key, const char *value);
> +
> +static int config_cache_entry_cmp_case(const struct config_cache_entry *e1,
> +                                const struct config_cache_entry *e2, const void *unused)
> +{
> +       return strcmp(e1->key, e2->key);

As suggested by Peff [4], this comparison is now case-sensitive,
instead of case-insensitive as in the previous version. Rather than
changing the appended '_icase' to '_case', a more typical function
name would be simply config_cache_entry_cmp().

> +}
> +
> +static void config_cache_init(struct hashmap *config_cache)
> +{
> +       hashmap_init(config_cache, (hashmap_cmp_fn) config_cache_entry_cmp_case, 0);

In his review [4], Peff suggested giving config_cache_entry_cmp_case()
the correct hashmap_cmp_fn signature so that this cast can be dropped.
It's not clear whether you disagree with his advice or overlooked or
forgot about it. If you disagree with his suggestion, it's okay to say
so and explain why you feel the way you do, but without feedback from
you, he or another reviewer is going to continue suggesting the same
change.

> +}
> +
> +static int config_cache_callback(const char *key, const char *value, void *unused)
> +{
> +       config_cache_set_value(key, value);
> +       return 0;
> +}
> +
> +static struct hashmap *get_config_cache(void)
> +{
> +       static struct hashmap config_cache;
> +       if (!hashmap_is_init) {
> +               config_cache_init(&config_cache);
> +               hashmap_is_init = 1;
> +               git_config(config_cache_callback, NULL);
> +               return &config_cache;

Why do you 'return' here rather than just falling through to the
'return' outside the conditional?

> +       }
> +       return &config_cache;
> +}
> +
> +static void config_cache_free(void)
> +{
> +       struct hashmap *config_cache;
> +       struct config_cache_entry *entry;
> +       struct hashmap_iter iter;
> +       config_cache = get_config_cache();
> +       hashmap_iter_init(config_cache, &iter);
> +       while ((entry = hashmap_iter_next(&iter))) {
> +               free(entry->key);
> +               string_list_clear(entry->value_list, 0);
> +       }
> +       hashmap_free(config_cache, 1);
> +       hashmap_is_init = 0;
> +}
> +
> +static struct config_cache_entry *config_cache_find_entry(const char *key)
> +{
> +       struct hashmap *config_cache;
> +       struct config_cache_entry k;
> +       char *normalized_key;
> +       int baselength = 0, ret;
> +       config_cache = get_config_cache();
> +       ret = git_config_parse_key(key, &normalized_key, &baselength);

Since you neither care about nor ever reference 'baselength', you
should just pass NULL as the third argument.

> +       if (ret)
> +               return NULL;
> +
> +       hashmap_entry_init(&k, strhash(normalized_key));
> +       k.key = (char*) key;

This looks fishy. You're hashing based upon 'normalized_key' but then
comparing against the unnormalized 'key'. Peff's suggestion [4] was to
store the normalized key in the hash, which means that you should use
'normalized_key' for both hashing and comparing. (See additional
commentary about this issue below in config_cache_set_value().)

Style: (char *)key

> +       return hashmap_get(config_cache, &k, NULL);

You're leaking 'normalized_key', which git_config_parse_key()
allocated on your behalf.

> +}
> +
> +static struct string_list *config_cache_get_value(const char *key)
> +{
> +       struct config_cache_entry *e = config_cache_find_entry(key);
> +       return e ? e->value_list : NULL;
> +}
> +
> +
> +static int config_cache_set_value(const char *key, const char *value)
> +{
> +       struct hashmap *config_cache;
> +       struct config_cache_entry *e;
> +
> +       config_cache = get_config_cache();
> +       e = config_cache_find_entry(key);
> +       if (!e) {
> +               e = xmalloc(sizeof(*e));
> +               hashmap_entry_init(e, strhash(key));

The hash computed to store the key should be the same as the hash to
look it up. In config_cache_find_entry(), you're correctly computing
the hash based upon the normalized key, but here you're doing so from
the unnormalized key.

> +               e->key = xstrdup(key);

Likewise. Normalized keys should be stored in the hash, not unnormalized.

You should be invoking git_config_parse_key() to normalize the key
both for hashing and storing.

Note, also, that call git_config_parse_key() allocates the normalize
key on your behalf, so you do *not* want to xstrdup() it here.

> +               e->value_list = xcalloc(sizeof(struct string_list), 1);
> +               e->value_list->strdup_strings = 1;

This code is perhaps too intimate with the implementation of
string_list. It may work today (because it is safe to initialize all
string_list fields to 0 via xcalloc()), but a future change to the
string_list implementation may invalidate that assumption. The
initialization macros in string-list.h exist to preserve the
abstraction, so you don't have to know the details of initialization.
The macros are not suitable for your use-case, but an initialization
function, such as string_list_init(), would be suitable, and it would
be appropriate to add such a function in a preparatory patch (as
already suggested by [1]).

> +               string_list_append(e->value_list, value);
> +               hashmap_add(config_cache, e);
> +       } else {
> +               string_list_append(e->value_list, value);
> +       }
> +       return 0;
> +}
> +
> +extern const char *git_config_get_string(const char *key)

Drop the 'extern'. The header already declares it such.

> +{
> +       struct string_list *values;
> +       values = config_cache_get_value(key);
> +       if (!values)
> +               return NULL;
> +       assert(values->nr > 0);
> +       return values->items[values->nr - 1].string;
> +}
> +
> +extern const struct string_list *git_config_get_string_multi(const char *key)

Drop the 'extern'. The header already declares it such.

> +{
> +       return config_cache_get_value(key);
> +}
> +
>  static int config_file_fgetc(struct config_source *conf)
>  {
>         return fgetc(conf->u.file);
> @@ -1700,6 +1816,12 @@ int git_config_set_multivar_in_file(const char *config_filename,
>         lock = NULL;
>         ret = 0;
>
> +       /* contents of config file has changed, so invalidate the
> +        * config cache used by non-callback based query functions.
> +        */
> +       if (hashmap_is_init)
> +               config_cache_free();
> +
>  out_free:
>         if (lock)
>                 rollback_lock_file(lock);
> --
> 1.9.0.GIT

[1]: http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html#a7611860
[2]: http://thread.gmane.org/gmane.comp.version-control.git/250566/focus=251058
[3]: http://thread.gmane.org/gmane.comp.version-control.git/251073/focus=251079
[4]: http://thread.gmane.org/gmane.comp.version-control.git/250566/focus=250618
