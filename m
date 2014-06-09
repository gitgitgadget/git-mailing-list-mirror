From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH v2 1/2] config: Add hashtable for config parsing & retrieval
Date: Mon, 9 Jun 2014 04:17:47 -0400
Message-ID: <CAPig+cQxp2iAvFqu=C+hvU4mpVHd6rk5tURvi_jrasfBHHwm8g@mail.gmail.com>
References: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
	<1401720460-6525-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 10:32:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv0e-0004vj-MU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbaFIIcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:32:46 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:52640 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbaFIIRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:17:48 -0400
Received: by mail-yk0-f181.google.com with SMTP id 9so854950ykp.26
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nOeTvkaiR6s4cB77GdON0JEfO66M2ZnBcLloTV8Rq1E=;
        b=bw1g5AMWsdl3zVbOZcEmk+z2+m0OAhM95sd+Uilc4vCfPIUrhgM2stht4+PaWKo3os
         ts5zxASpqMl0yffDA7A/40cnBC+rhQl3/GriONbn4c8eVDA2Ehc01Mxg4uEEZ8y8ewS+
         ZZ49YGrJdP9dmB698eZY75jpAEX9s8EzP9o8sxa6Dc2dPHDzepOoUIRjoWs6L6QScc8U
         YRRNxnpPbHLZe6IL2n4hzHlaiAYD7AWt/8JKzHXyQwn/cmhjerYK2mKk/NGfevC/YWYD
         tS+NbJcnXbe+/TWgPOO4jfENqjnANcp4AnMO69wd/4WBlIdb7NMl2cb55Jde6NeQPwQ2
         qa8w==
X-Received: by 10.236.156.170 with SMTP id m30mr11803817yhk.60.1402301867306;
 Mon, 09 Jun 2014 01:17:47 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 9 Jun 2014 01:17:47 -0700 (PDT)
In-Reply-To: <1401720460-6525-2-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: -4cFwSVi4usZ2gMrVCal3Bj3Fu8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251058>

In addition to the valuable review comments by Torsten and Peff, find
more below...

On Mon, Jun 2, 2014 at 10:47 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Add a hash table to cache all key-value pairs read from config files
> (repo specific .git/config, user wide ~/.gitconfig and the global
> /etc/gitconfig). Add two external functions `git_config_get_string` and
> `git_config_get_string_multi` for querying in a non-callback manner from the
> hash table.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> diff --git a/config.c b/config.c
> index a30cb5c..23c9403 100644
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
> @@ -37,6 +39,112 @@ static struct config_source *cf;
>
>  static int zlib_compression_seen;
>
> +static struct hashmap config_cache;
> +
> +struct config_cache_entry {
> +       struct hashmap_entry ent;
> +       char *key;
> +       struct string_list *value_list;

Same question as in my v1 review [1]: Why is this 'struct string_list
*' rather than just 'struct string_list'?

[1]: http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html#a7611860

> +};
> +
> +static int hashmap_is_init = 0;
> +
> +static int config_cache_entry_cmp_icase(const struct config_cache_entry *e1,
> +                                const struct config_cache_entry *e2, const char* key)
> +{
> +       return strcasecmp(e1->key, key ? key : e2->key);

Are you planning on taking advantage of this extra complexity (the
'key ? key : e2->key' stuff)? At present, the lone caller _always_
provides the 'key', so 'e2->key' is never used. If not needed,
dropping it will simplify things for future readers of the code. (But,
see below for more commentary...)

> +}
> +
> +static void config_cache_init(void)
> +{
> +       hashmap_init(&config_cache, (hashmap_cmp_fn)config_cache_entry_cmp_icase, 0);
> +}
> +
> +static void config_cache_free(void)
> +{
> +       struct config_cache_entry* entry;

Style: struct config_cache_entry *entry;

> +       struct hashmap_iter iter;
> +       hashmap_iter_init(&config_cache, &iter);
> +       while (entry = hashmap_iter_next(&iter)) {
> +               free(entry->key);
> +               string_list_clear(entry->value_list, 0);
> +       }
> +       hashmap_free(&config_cache, 1);
> +}

config_cache_free() is never called.

> +static struct config_cache_entry *config_cache_find_entry(const char *key)
> +{
> +       struct hashmap_entry k;
> +       hashmap_entry_init(&k, strihash(key));
> +       return hashmap_get(&config_cache, &k, key);

This feels very dangerous. You've declared
config_cache_entry_cmp_icase() as taking a 'struct config_cache_entry
*' as its second argument, however, you are passing a 'struct
hashmap_entry *'. While it may work correctly in this special case as
you've written it, where config_cache_entry_cmp_icase() never accesses
any members of its second argument beyond 'ent', it is not
transparent. A future programmer may trust the type of the incoming
second argument and change config_cache_entry_cmp_icase() to access
elements beyond 'ent' without realizing that those elements aren't
actually present.

It seems safer to code this as in the example section of
Documentation/api-hashmap.txt:

    struct config_cache_entry k;
    hashmap_entry_init(&k, strihash(key));
    k.key = key; /* maybe cast-away const here */
    return hashmap_get(&config_cache, &k, NULL);

And modify config_cache_entry_cmp_icase() to always access its second
argument and treat the third as unused.

> +}
> +
> +static struct string_list *config_cache_get_value(const char *key)
> +{
> +       struct config_cache_entry *e = config_cache_find_entry(key);
> +       return e ? e->value_list : NULL;
> +}
> +
> +
> +static void config_cache_set_value(const char *key, const char *value)
> +{
> +       struct config_cache_entry *e;
> +
> +       e = config_cache_find_entry(key);
> +       if (!e) {
> +               e = malloc(sizeof(*e));
> +               hashmap_entry_init(e, strihash(key));
> +               e->key=xstrdup(key);
> +               e->value_list = xcalloc(sizeof(struct string_list), 1);
> +               e->value_list->strdup_strings = 1;
> +               string_list_append(e->value_list, value);
> +               hashmap_add(&config_cache, e);
> +       } else {
> +               if (!unsorted_string_list_has_string(e->value_list, value))
> +                       string_list_append(e->value_list, value);
> +       }

Also mentioned in [1]: As there is only a single 'if' statement within
this 'else' clause, you could turn this into an 'else if' and drop one
level of indentation. (Although, as Peff mentioned in his review, you
probably don't want to be folding out duplicate values anyhow, so this
'if' would go away.)

> +}
> +
> +static void config_cache_remove_value(const char *key, const char *value)
> +{
> +       struct config_cache_entry *e;
> +       int i;
> +
> +       e = config_cache_find_entry(key);
> +       if(!e)
> +               return;
> +       /* If value == NULL then remove all the entries for the key */
> +       if(!value) {
> +               string_list_clear(e->value_list, 0);
> +               free(e->value_list);
> +               hashmap_remove(&config_cache, e, NULL);

Isn't this leaking e->key?

> +               return;
> +       }
> +       /* All the occurances of "value" will be deleted */

s/occurances/occurrences/

> +       for (i = 0; i < e->value_list->nr; i++)
> +               if (!strcmp(value, e->value_list->items[i].string))
> +                       unsorted_string_list_delete_item(e->value_list, i, 0);

This loop is broken. It wants to delete all elements matching 'value',
but it will skip some. For instance, if 'value_list' contains items
["foo", "foo"], and you ask it to remove all "foo", it will return
["foo"]. This is because you increment 'i' even though the 'i'th
element has just been removed. To fix, either don't increment 'i' when
an item is removed, or reverse the order of visitation (from back to
front).

> +       if(e->value_list->nr == 0) {
> +               string_list_clear(e->value_list, 0);
> +               free(e->value_list);
> +               hashmap_remove(&config_cache, e, NULL);

Isn't this leaking e->key?

> +       }
> +}
> +
> +extern const char *git_config_get_string(const char *name)
> +{
> +       struct string_list *values;
> +       values = config_cache_get_value(name);
> +       if (!values)
> +               return NULL;
> +       return values->items[values->nr - 1].string;
> +}
> +
> +extern const struct string_list *git_config_get_string_multi(const char *key)
> +{
> +       return config_cache_get_value(key);
> +}
> +
>  static int config_file_fgetc(struct config_source *conf)
>  {
>         return fgetc(conf->u.file);
> @@ -333,6 +441,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>                 if (!value)
>                         return -1;
>         }
> +       config_cache_set_value(name->buf, value);
>         return fn(name->buf, value, data);
>  }
>
> @@ -1135,6 +1244,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>         char *xdg_config = NULL;
>         char *user_config = NULL;
>
> +       if (!hashmap_is_init) {
> +               config_cache_init();
> +               hashmap_is_init = 1;
> +       }
> +
>         home_config_paths(&user_config, &xdg_config, "config");
>
>         if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
> @@ -1570,6 +1684,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                 if (!store_write_section(fd, key) ||
>                     !store_write_pair(fd, key, value))
>                         goto write_err_out;
> +               else config_cache_set_value(key, value);
>         } else {
>                 struct stat st;
>                 char *contents;
> @@ -1673,6 +1788,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                         }
>                         if (!store_write_pair(fd, key, value))
>                                 goto write_err_out;
> +                       else config_cache_set_value(key, value);
> +               } else {
> +                       config_cache_remove_value(key, NULL);
>                 }
>
>                 /* write the rest of the config */
> --
> 1.9.0.GIT
>
