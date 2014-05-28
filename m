From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 1/2] config: Add cache for config value querying
Date: Wed, 28 May 2014 05:31:11 -0400
Message-ID: <CAPig+cSvrJ0bjuHBaRpUYzi7tX+MEbhmCYv12oiTcexm3+Pd0g@mail.gmail.com>
References: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
	<1401125601-18249-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 11:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpaCb-0002fd-L8
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 11:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbaE1JbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 05:31:14 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:34288 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaE1JbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 05:31:12 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so8583991yhl.9
        for <git@vger.kernel.org>; Wed, 28 May 2014 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bTz+zSSDxOPtus4Frqba3cir5HPbkTp9yEvH6SVxJrI=;
        b=l8EoLi1BkPo5NXqgCIq5ojcSk31cMvIn1vufKgEaXa8UwMLdzbaYeWkR78yOUEEZm7
         W9psWj/vtqCIhSAQGr9N004BWIa14oOEFfl+4cs4+r+8CeyFiY1nRx52JJs8eeunHrEK
         cSI7HUSg+rxjltQBZCWBR1rs29TIZr3wO1kyiC/7/ditw51nZHhalI1c3Chmw8ROqTcv
         VMugpxPlQDH+xhOFvVEITbPWBB2CRMM/QOy+oRDReE+xV9KD+OP+DeX+8mqEXQrmRlTk
         a37uWDLTYBULrafdEqe4OyRrlNy00BCA+XH+e38XOFWqkvMGAjMMhLOUVrWqQ9eKv5MV
         OPvQ==
X-Received: by 10.236.143.229 with SMTP id l65mr55072078yhj.95.1401269471620;
 Wed, 28 May 2014 02:31:11 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Wed, 28 May 2014 02:31:11 -0700 (PDT)
In-Reply-To: <1401125601-18249-2-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: Eo7UpjZlpTXnR7yPzGA3_JbFFls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250277>

On Mon, May 26, 2014 at 1:33 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Add an internal cache with the all variable value pairs read from the usual
> config files(repo specific .git/config, user wide ~/.gitconfig and the global

s/(/ (/

> /etc/gitconfig). Also, add two external functions `git_config_get_string` and
> `git_config_get_string_multi` for querying in an non callback manner from the

s/an/a/
s/non/non-/

More below.

> cache.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  cache.h  |   2 ++
>  config.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 107ac61..2038150 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1271,6 +1271,8 @@ extern int check_repository_format_version(const char *var, const char *value, v
>  extern int git_env_bool(const char *, int);
>  extern int git_config_system(void);
>  extern int config_error_nonbool(const char *);
> +extern const char *git_config_get_string(const char *);
> +extern const struct string_list *git_config_get_string_multi(const char *);
>  #if defined(__GNUC__) && ! defined(__clang__)
>  #define config_error_nonbool(s) (config_error_nonbool(s), -1)
>  #endif
> diff --git a/config.c b/config.c
> index a30cb5c..f6515c2 100644
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
> @@ -37,6 +39,102 @@ static struct config_source *cf;
>
>  static int zlib_compression_seen;
>
> +struct hashmap config_cache;

This should be 'static'.

> +struct config_cache_node {
> +       struct hashmap_entry ent;
> +       struct strbuf key;

Upon reading this, I had the same question as Torsten: Why isn't 'key'
a plain 'char *' allocated when the entry is created? Your answer:

    To maintain consistency with config.c. config.c uses strbuf for
    both key and value throughout. I found the reason by git-blaming
    config.c. Key length is flexible so it would be better to use a
    api construct such as strbuf for it.

doesn't make sense. The existing callback-based code re-uses the
strbuf for each key as it parses the file, however, you are just
storing each key once in the hashmap and never altering it, thus a
strbuf is overkill.

> +       struct string_list *value_list ;

Why isn't this just a plain 'struct string_list'? Why the extra
indirection of a pointer?

Drop space before semicolon.

> +};
> +
> +static int hashmap_init_v = 0;

It's not obvious what "_v" is meant to convey.

> +static int config_cache_node_cmp(const struct config_cache_node *e1,
> +                          const struct config_cache_node *e2, const char *key)
> +{
> +       return strcmp(e1->key.buf, key ? key : e2->key.buf);
> +}
> +
> +static int config_cache_node_cmp_icase(const struct config_cache_node *e1,
> +                                const struct config_cache_node *e2, const char* key)
> +{
> +       return strcasecmp(e1->key.buf, key ? key : e2->key.buf);
> +}
> +
> +static void config_cache_init(const int icase)

'const int' as a function argument is very unusual in this code base.
(I found only a single instance of it in
log-tree.[ch]:parse_decorate_color_config.)

> +{
> +       hashmap_init(&config_cache, (hashmap_cmp_fn) (icase ? config_cache_node_cmp_icase
> +                       : config_cache_node_cmp), 0);
> +}
> +
> +static void config_cache_free(void)
> +{
> +       hashmap_free(&config_cache, 1);
> +}

Doesn't this leak the strbuf 'key' and string_list 'value_list'?

> +static struct config_cache_node *config_cache_find_entry(const char *key)
> +{
> +       struct hashmap_entry k;
> +       hashmap_entry_init(&k, strihash(key));

How does this unconditional use of case-insensitive strihash()
interact with the 'icase' argument of config_cache_init()?

> +       return hashmap_get(&config_cache, &k, key);
> +}
> +
> +static struct string_list *config_cache_get_value(const char *key)
> +{
> +       struct config_cache_node *e = config_cache_find_entry(key);
> +       if (e == NULL)

Rephrase: if (!e)

> +               return NULL;
> +       else
> +               return (e->value_list);

Unnecessary parentheses.

> +}

A purely subject rewrite of the above:

    return e ? e->value_list : NULL;

> +static void config_cache_set_value(const char *key, const char *value)
> +{
> +       struct config_cache_node *e;
> +
> +       if (!value)
> +               return;

Again, I had the same questions as Torsten. ("Is this supposed to
delete the entry?", "Is it a programmer error?", etc.) From a pure
reading, it's not obvious why a NULL 'value' is handled this way. The
intent might be clearer if the caller instead performs the check, and
invokes config_cache_set_value() only if 'value' is non-NULL.

> +       e = config_cache_find_entry(key);
> +       if (!e) {
> +               e = malloc(sizeof(*e));
> +               hashmap_entry_init(e, strihash(key));

Same question as above regarding unconditional case-insensitive
strihash() versus the 'icase' argument of config_cache_init().

> +               strbuf_init(&(e->key), 1024);

Why allocate such a large buffer for each key, especially when most
keys likely are quite short. Since the key is never altered after
being assigned, this seems like considerable waste.

Also, unnecessary parentheses.

> +               strbuf_addstr(&(e->key),key);

Unnecessary parentheses. Add space after comma.

> +               e->value_list = malloc(sizeof(struct string_list));
> +               e->value_list->strdup_strings = 1;
> +               e->value_list->nr = 0;
> +               e->value_list->alloc = 0;
> +               e->value_list->items = NULL;
> +               e->value_list->cmp = NULL;

This string_list initialization code begs for a preparatory patch
which adds a string_list_init() function (akin to strbuf_init()).

> +               string_list_append(e->value_list, value);
> +               hashmap_add(&config_cache, e);
> +       }
> +       else {

Cuddle the else with the braces: } else {

> +               if (!unsorted_string_list_has_string((e->value_list), value))
> +                       string_list_append((e->value_list), value);

Unnecessary parentheses (on both lines).

Since there is only an 'if' statement in this 'else' block, you could
turn it into an 'else if', thus eliminating one level of indentation.

> +       }
> +}
> +
> +extern const char *git_config_get_string(const char *name)
> +{
> +       struct string_list *values;
> +       int num_values;
> +       char *result;
> +       values = config_cache_get_value(name);
> +       if (!values)
> +               return NULL;
> +       num_values = values->nr;
> +       result = values->items[num_values-1].string ;

Add spaces around '-'. Drop space before semicolon.

> +       return result;

Why do you need the 'result' variable if you are returning it
immediately after it's assigned?

    return values->items[num_values - 1].string;

Or, taking Torsten's recommendation into consideration to drop num_values:

    return values->items[values->nr - 1].string;

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
> @@ -333,6 +431,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>                 if (!value)
>                         return -1;
>         }
> +       config_cache_set_value(name->buf, value);
>         return fn(name->buf, value, data);
>  }
>
> @@ -1135,6 +1234,12 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>         char *xdg_config = NULL;
>         char *user_config = NULL;
>
> +       int icase = 1;
> +       if (!hashmap_init_v) {
> +               config_cache_init(icase);
> +               hashmap_init_v = 1;
> +       }
> +
>         home_config_paths(&user_config, &xdg_config, "config");
>
>         if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
> --
> 1.9.0.GIT
