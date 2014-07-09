From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Wed, 09 Jul 2014 18:09:33 +0530
Message-ID: <53BD3805.40504@gmail.com>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>	<1404903454-10154-2-git-send-email-tanayabh@gmail.com> <vpq61j6d92z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4rAF-0007Z7-LN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 14:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbaGIMjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 08:39:43 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48527 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbaGIMjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 08:39:40 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so9049325pac.25
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2TQx3DU1kNcG4jQkkxuU9Oj7qHm/xdHLg+TtqMDZmLQ=;
        b=wUgCyd4dQLPHtjBxsPo3m356ix+76/0zvyr47x31W4vkZzakqb9/lOy4SUPSop4Cly
         lEAigqlwR2DF+zE/kk3NcOIaPnI5TAl9ASS716pRdN1wX39+3uIaM/xc3gnnMb4h/sqn
         RdintUgcDpSwcbQHX9aOj8+y/q1b5Qkknsrrz1+wGQhh/x6L6mTrrqqVDDR/AUkXeck3
         mdtTYUgrywMpfvJo8j/Y82qklMEVnJLqJem/sSxHbtsBv0gsHJgLiZ0BJwsoFl8DXeVR
         c0BQg/dF6H6OVcuGlgER2md+672nWZopAX/uucl6efupNnwNSXAgnr4PpX2nYPsd9rO8
         Jkmw==
X-Received: by 10.66.142.73 with SMTP id ru9mr40950862pab.41.1404909579826;
        Wed, 09 Jul 2014 05:39:39 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.59])
        by mx.google.com with ESMTPSA id oy3sm6019501pdb.79.2014.07.09.05.39.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 05:39:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq61j6d92z.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253123>



On 7/9/2014 5:42 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
>> index 230b3a0..65a6717 100644
>> --- a/Documentation/technical/api-config.txt
>> +++ b/Documentation/technical/api-config.txt
> 
>> +`int git_config_get_bool(const char *key, int *dest)`::
>> +
>> +	Finds and parses the value into a boolean value, for the configuration
>> +	variable `key`respecting keywords like "true" and "false". Integer
> 
> Missing space after ` => badly formatted in HTML.
> 
> I didn't find any other formatting error, but you may double-check with
> 
> cd Documentation/ && make technical/api-config.html && firefox technical/api-config.html
> 

Sorry for the wrong version number on the cover letter.
Thanks, for the review, I will check it ASAP.

Also, I tried implementing Junio's request about saving the line number and the file name for each
key-value pair. I had some success, but with some changes,

1. config-hash.c had to be shifted to config.c entirely.
2. string_list util pointer had to be used for each value.

I am appending the diff below, the only changes from version 7 is that, a new struct 'key_source'
has been added and `config_hash_add_value` has been altered a little.

For debugging `git_configset_get_value` prints the line number and file name for each value.
What are your views about it, too late for inclusion? too hackey or contrived?
I has started on a fresh page for it, but I soon saw that I was reimplementing what was already
available in git_config(), so I took this path.

One more thing, Karsten's string-intern API can be used for saving file names as they are repeated a
lot.

-- 8< --
diff --git a/config.c b/config.c
index a1aef1c..697ec1c 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,8 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "string-list.h"
+#include "hashmap.h"

 struct config_source {
 	struct config_source *prev;
@@ -33,10 +35,314 @@ struct config_source {
 	long (*do_ftell)(struct config_source *c);
 };

+struct config_hash_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+struct key_source {
+	const char *filename;
+	int linenr;
+};
+
 static struct config_source *cf;

 static int zlib_compression_seen;

+/*
+ * Default config_set that contains key-value pairs from the usual set of config
+ * config files (i.e repo specific .git/config, user wide ~/.gitconfig, XDG
+ * config file and the global /etc/gitconfig)
+ */
+static struct config_set the_config_set;
+
+static int config_hash_add_value(const char *, const char *, struct hashmap *);
+
+static int config_hash_entry_cmp(const struct config_hash_entry *e1,
+				 const struct config_hash_entry *e2, const void *unused)
+{
+	return strcmp(e1->key, e2->key);
+}
+
+static void configset_init(struct config_set *cs)
+{
+	if (!cs->hash_initialized) {
+		hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
+		cs->hash_initialized = 1;
+	}
+}
+
+static int config_hash_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set *cs = cb;
+	config_hash_add_value(key, value, &cs->config_hash);
+	return 0;
+}
+
+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	int ret = 0;
+	configset_init(cs);
+	ret = git_config_from_file(config_hash_callback, filename, cs);
+	if (!ret)
+		return 0;
+	else {
+		hashmap_free(&cs->config_hash, 1);
+		cs->hash_initialized = 0;
+		return -1;
+	}
+}
+
+static struct config_hash_entry *config_hash_find_entry(const char *key,
+							struct hashmap *config_hash)
+{
+	struct config_hash_entry k;
+	struct config_hash_entry *found_entry;
+	char *normalized_key;
+	int ret;
+	/*
+	 * `key` may come from the user, so normalize it before using it
+	 * for querying entries from the hashmap.
+	 */
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+
+	if (ret)
+		return NULL;
+
+	hashmap_entry_init(&k, strhash(normalized_key));
+	k.key = normalized_key;
+	found_entry = hashmap_get(config_hash, &k, NULL);
+	free(normalized_key);
+	return found_entry;
+}
+
+static struct string_list *configset_get_list(const char *key, struct config_set *cs)
+{
+	struct config_hash_entry *e = config_hash_find_entry(key, &cs->config_hash);
+	return e ? &e->value_list : NULL;
+}
+
+static int config_hash_add_value(const char *key, const char *value, struct hashmap *config_hash)
+{
+	struct config_hash_entry *e;
+	struct string_list_item *si;
+	struct key_source *ks = xmalloc(sizeof(*e));
+	e = config_hash_find_entry(key, config_hash);
+	/*
+	 * Since the keys are being fed by git_config*() callback mechanism, they
+	 * are already normalized. So simply add them without any further munging.
+	 */
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		memset(&e->value_list, 0, sizeof(e->value_list));
+		e->value_list.strdup_strings = 1;
+		hashmap_add(config_hash, e);
+	}
+	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	ks->filename = xstrdup(cf->name);
+	ks->linenr = cf->linenr - 1;
+	si->util = ks;
+
+	return 0;
+}
+
+void git_configset_init(struct config_set *cs)
+{
+	cs->hash_initialized = 0;
+}
+
+int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+{
+	struct string_list *values = NULL;
+	struct key_source *ks;
+	/*
+	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
+	 * queried key in the files of the configset, the value returned will be the last
+	 * value in the value list for that key.
+	 */
+	values = configset_get_list(key, cs);
+
+	if (!values)
+		return 1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	ks = values->items[values->nr - 1].util;
+	printf("the value is in line %d of %s \n", ks->linenr, ks->filename);
+	return 0;
+}
+
+const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+{
+	return configset_get_list(key, cs);
+}
+
+void git_configset_clear(struct config_set *cs)
+{
+	struct config_hash_entry *entry;
+	struct hashmap_iter iter;
+	if (!cs->hash_initialized)
+		return;
+
+	hashmap_iter_init(&cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		free(entry->key);
+		string_list_clear(&entry->value_list, 0);
+	}
+	hashmap_free(&cs->config_hash, 1);
+}
+
+int git_configset_get_string(struct config_set *cs, const char *key, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_string(dest, key, value);
+	else
+		return 1;
+}
+
+int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_int(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_ulong(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_bool(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
+				int *is_bool, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_bool_or_int(key, value, is_bool);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_maybe_bool(key, value);
+		if (*dest == -1)
+			return -1;
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_pathname(dest, key, value);
+	else
+		return 1;
+}
+
+static int git_config_check_init(void)
+{
+	int ret = 0;
+	if (the_config_set.hash_initialized)
+		return 0;
+	configset_init(&the_config_set);
+	ret = git_config(config_hash_callback, &the_config_set);
+	if (ret >= 0)
+		return 0;
+	else {
+		hashmap_free(&the_config_set.config_hash, 1);
+		the_config_set.hash_initialized = 0;
+		return -1;
+	}
+}
+
+int git_config_get_value(const char *key, const char **value)
+{
+	git_config_check_init();
+	return git_configset_get_value(&the_config_set, key, value);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	git_config_check_init();
+	return git_configset_get_value_multi(&the_config_set, key);
+}
+
+void git_config_clear(void)
+{
+	if (!the_config_set.hash_initialized)
+		return;
+	git_configset_clear(&the_config_set);
+	the_config_set.hash_initialized = 0;
+}
+
+int git_config_get_string(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_string(&the_config_set, key, dest);
+}
+
+int git_config_get_int(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_int(&the_config_set, key, dest);
+}
+
+int git_config_get_ulong(const char *key, unsigned long *dest)
+{
+	git_config_check_init();
+	return git_configset_get_ulong(&the_config_set, key, dest);
+}
+
+int git_config_get_bool(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_bool_or_int(&the_config_set, key, is_bool, dest);
+}
+
+int git_config_get_maybe_bool(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_maybe_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_pathname(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_pathname(&the_config_set, key, dest);
+}
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -1708,6 +2014,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	lock = NULL;
 	ret = 0;

+	/* Invalidate the config cache */
+	git_config_clear();
+
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-- 8< --
