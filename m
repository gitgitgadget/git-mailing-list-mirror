From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 14:40:56 +0200
Message-ID: <vpqlhrc8hif.fsf@anie.imag.fr>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
	<1406633302-23144-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:41:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC6iK-0008ON-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 14:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbaG2MlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 08:41:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51124 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaG2MlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 08:41:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6TCet1Z021317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2014 14:40:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6TCeurh029185;
	Tue, 29 Jul 2014 14:40:57 +0200
In-Reply-To: <1406633302-23144-4-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 29 Jul 2014 04:28:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jul 2014 14:40:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6TCet1Z021317
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407242458.2311@EnheUIDmzwOYuLM0xoTOpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254426>

Tanay Abhra <tanayabh@gmail.com> writes:

> +static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
> +{
> +	int i, value_index;
> +	struct string_list *values;
> +	struct config_set_element *entry;
> +	struct configset_list *list = &cs->list;
> +	struct key_value_info *kv_info;
> +
> +	for (i = 0; i < list->nr; i++) {
> +		entry = list->items[i].e;
> +		value_index = list->items[i].value_index;
> +		values = &entry->value_list;
> +		if (fn(entry->key, values->items[value_index].string, data) < 0) {
> +			kv_info = values->items[value_index].util;
> +			if (!kv_info->linenr)
> +				die("unable to parse '%s' from command-line config", entry->key);
> +			else
> +				die("bad config variable '%s' at file line %d in %s",
> +					entry->key,
> +					kv_info->linenr,
> +					kv_info->filename);
> +		}
> +	}
> +	return 0;
> +}

configset_iter unconditionnally returns 0 (or it dies). Since it is more
or less the equivalent of the old git_config(), I understand why we
never encounter the situation where git_config() would return -1 (syntax
error, weird permission issue => cannot happen when reading from
memory).

But then, do we really want this return value, and not just return void?

> +static void git_config_check_init(void);
> +
> +int git_config(config_fn_t fn, void *data)
> +{
> +	git_config_check_init();
> +	return configset_iter(&the_config_set, fn, data);
> +}

Here too, git_config now unconditionnally returns 0.

Most callers of git_config already ignore the return value. Actually,
there's only one exception in branch.c, but git still compiles with
this:

diff --git a/branch.c b/branch.c
index 660097b..92c3ff2 100644
--- a/branch.c
+++ b/branch.c
@@ -161,10 +161,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
        strbuf_addf(&name, "branch.%s.description", branch_name);
        cb.config_name = name.buf;
        cb.value = NULL;
-       if (git_config(read_branch_desc_cb, &cb) < 0) {
-               strbuf_release(&name);
-               return -1;
-       }
+       git_config(read_branch_desc_cb, &cb);
        if (cb.value)
                strbuf_addstr(buf, cb.value);
        strbuf_release(&name);
diff --git a/cache.h b/cache.h
index 40b4ef3..23bfc67 100644
--- a/cache.h
+++ b/cache.h
@@ -1266,7 +1266,7 @@ extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern int git_config(config_fn_t fn, void *);
+extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
                                   struct git_config_source *config_source,
                                   int respect_includes);
diff --git a/config.c b/config.c
index 0346681..3d033c9 100644
--- a/config.c
+++ b/config.c
@@ -1223,9 +1223,9 @@ int git_config_with_options(config_fn_t fn, void *data,
        return ret;
 }
 
-int git_config(config_fn_t fn, void *data)
+void git_config(config_fn_t fn, void *data)
 {
-       return git_config_with_options(fn, data, NULL, 1);
+       git_config_with_options(fn, data, NULL, 1);
 }
 
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)

I do not see any difference between the git_config() call in branch.c
and the others.

So, I think it's time to make it official that git_config() does not
return an error code, and make it return void. I would do that in a
patch before the git_config() -> git_config_raw() rewrite.

My preference would be to get the return value from
git_config_with_options and die() if it's negative, but I can also live
with a solution where the return value from git_config_with_options() is
ignored. It's the same discussion we already had about the call to
git_config() in git_config_check_init() actually, but I now think a
die() statement should be within git_config(), not after, so that every
callers benefit from it.

In any case, doing this in a separate patch means the commit message
(and possibly a comment next to the git_config() call) should explain
the situation clearly and justify the choice.

The current situation looks like someone tried to get good error
recovery, but the error code is lost in the way between
git_config_with_options() and the caller of git_config(), without a
clear justification of why an error code was once returned, nor a
justification of why it was later ignored.

So, in summary, my advice (but not the only option) would be: take my
patch above, add a die() statement and a comment, write a good commit
message and insert this before this patch.

>  static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
>  {
>  	struct config_set_element k;
> @@ -1268,6 +1296,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>  {
>  	struct config_set_element *e;
>  	struct string_list_item *si;
> +	struct configset_list_item *l_item;
>  	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
>  
>  	e = configset_find_element(cs, key);
> @@ -1283,6 +1312,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>  		hashmap_add(&cs->config_hash, e);
>  	}
>  	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
> +
> +	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
> +	l_item = &cs->list.items[cs->list.nr++];
> +	l_item->e = e;
> +	l_item->value_index = e->value_list.nr - 1;

I would spell this

	l_item = &cs->list.items[cs->list.nr];
	l_item->e = e;
	l_item->value_index = e->value_list.nr;
	cs->list.nr++;

to avoid having to wonder why the "- 1" is needed. But I'm OK with the
current code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
