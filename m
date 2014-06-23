From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Mon, 23 Jun 2014 09:20:57 -0700
Message-ID: <53A853E9.8060801@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com> <1403518300-23053-3-git-send-email-tanayabh@gmail.com> <53A84077.4010200@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz6zX-0003KB-NT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 18:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbaFWQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 12:21:07 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50368 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbaFWQVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 12:21:06 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so6051867pad.21
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sROIFoLtDU35OEwBeETKDl5iwuH2B+WS2TAvY8eUYiA=;
        b=TlVHO60wQUrELGhDiqKDEdBFrel8q7aZjAtf473bSoxjurrbxZ5zaa2lSVBSn9IKWk
         pkFFmj9zQk5Btbt8Br/EMIY0ijh+He8eRl2EenjLur9To/BYVFzKSmyRh3mH+bulod6e
         n2FfgUVWDcVk/efhNkOUr+Y9cFYbkBTuOlcGuphNYwfk8Kr4m2YqBeAFvdxAY7LOaAJb
         hJ3Qyc7UPBwXB2y40Co0WQXb0+ikcO4hsP/H1+SVV/YjaTD0cKNiQ7E/Sdb6IMnIIpf9
         kwLmcJ6Ef6pBic+2Cw/hK+WED1VymL3FsWv9bOaD4l45HAlivKW9nE9aDfjX50mIVdCO
         CzIg==
X-Received: by 10.69.10.164 with SMTP id eb4mr30554614pbd.35.1403540464808;
        Mon, 23 Jun 2014 09:21:04 -0700 (PDT)
Received: from [192.168.52.170] ([117.254.221.37])
        by mx.google.com with ESMTPSA id y2sm95794425pas.45.2014.06.23.09.20.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 09:21:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <53A84077.4010200@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252349>

On 06/23/2014 07:57 AM, Ramsay Jones wrote:
> On 23/06/14 11:11, Tanay Abhra wrote:
>> diff --git a/config.c b/config.c
>> index a1aef1c..6200f36 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -9,6 +9,8 @@
>>  #include "exec_cmd.h"
>>  #include "strbuf.h"
>>  #include "quote.h"
>> +#include "hashmap.h"
>> +#include "string-list.h"
>>  
>>  struct config_source {
>>  	struct config_source *prev;
>> @@ -37,6 +39,141 @@ static struct config_source *cf;
>>  
>>  static int zlib_compression_seen;
>>  
>> +struct config_cache_entry {
>> +	struct hashmap_entry ent;
>> +	char *key;
>> +	struct string_list value_list;
>> +};
>> +
>> +static int hashmap_initialized;
>> +
>> +static int config_cache_add_value(const char *key, const char *value);
>> +
>> +static int config_cache_entry_cmp(const struct config_cache_entry *e1,
>> +				 const struct config_cache_entry *e2, const void *unused)
>> +{
>> +	return strcmp(e1->key, e2->key);
>> +}
>> +
>> +static void config_cache_init(struct hashmap *config_cache)
>> +{
>> +	hashmap_init(config_cache, (hashmap_cmp_fn)config_cache_entry_cmp, 0);
>> +}
>> +
>> +static int config_cache_callback(const char *key, const char *value, void *unused)
>> +{
>> +	config_cache_add_value(key, value);
>> +	return 0;
>> +}
>> +
>> +static struct hashmap *get_config_cache(void)
>> +{
>> +	static struct hashmap config_cache;
>> +	if (!hashmap_initialized) {
>> +		config_cache_init(&config_cache);
>> +		hashmap_initialized = 1;
>> +		git_config(config_cache_callback, NULL);
>> +	}
>> +	return &config_cache;
>> +}
> 
> [I have not been following this series at all (sorry I haven't had
> the time to spare), so take these comments with a very big pinch of
> salt! ie just ignore me if it's already been discussed etc. ;-) ]
> 
> The 'git config' command can be used to read arbitrary files (so long
> as they conform to the config syntax). For example, see the --file and
> --blob options to git-config. At present, I think only scripted commands
> use this facility (eg git-submodule). Noting the singleton config_cache,
> what happens when git-submodule becomes a C builtin, or indeed any other
> C builtin wants to take advantage of the new code when processing a non-
> standard config file?
> 

This series was mainly to replace git_config() invocations around the codebase.
There are currently 111 git_config() invocations, each of which causes a file
reread whenever called. git_config() only feeds values from the standard config
files(i.e repo, user and global config).

For reading config values from specific files or blobs, there are three functions
git_config_with_options, git_config_from_file & git_config_from_blob which can be
easily used inside a C builtin or anywhere in the code.

The bulk of git_config_api calls are only for git_config(). For example,
git_config_from_file() has three hits only in entire codebase,
git_config_with_options() has 5 hits, so I concentrated on generating a cache
for the usual config files only. For other files, the callers can fall back on older
API functions like I had mentioned above.

Forgive me if I inferred your question incorrectly. More below.


>> +
>> +static void config_cache_free(void)
>> +{
>> +	struct hashmap *config_cache;
>> +	struct config_cache_entry *entry;
>> +	struct hashmap_iter iter;
>> +	config_cache = get_config_cache();
>> +	hashmap_iter_init(config_cache, &iter);
>> +	while ((entry = hashmap_iter_next(&iter))) {
>> +		free(entry->key);
>> +		string_list_clear(&entry->value_list, 1);
>> +	}
>> +	hashmap_free(config_cache, 1);
>> +	hashmap_initialized = 0;
>> +}
>> +
>> +static struct config_cache_entry *config_cache_find_entry(const char *key)
>> +{
>> +	struct hashmap *config_cache;
>> +	struct config_cache_entry k;
>> +	struct config_cache_entry *found_entry;
>> +	char *normalized_key;
>> +	int ret;
>> +	config_cache = get_config_cache();
>> +	ret = git_config_parse_key(key, &normalized_key, NULL);
>> +
>> +	if (ret)
>> +		return NULL;
>> +
>> +	hashmap_entry_init(&k, strhash(normalized_key));
>> +	k.key = normalized_key;
>> +	found_entry = hashmap_get(config_cache, &k, NULL);
>> +	free(normalized_key);
>> +	return found_entry;
>> +}
>> +
>> +static struct string_list *config_cache_get_value(const char *key)
>> +{
>> +	struct config_cache_entry *e = config_cache_find_entry(key);
>> +	return e ? &e->value_list : NULL;
>> +}
>> +
>> +static int config_cache_add_value(const char *key, const char *value)
>> +{
>> +	struct hashmap *config_cache;
>> +	struct config_cache_entry *e;
>> +	struct string_list_item *item;
>> +	int *boolean_null_flag;
>> +
>> +	config_cache = get_config_cache();
>> +	e = config_cache_find_entry(key);
>> +
>> +	boolean_null_flag = xcalloc(1, sizeof(*boolean_null_flag));
>> +
>> +	if (!e) {
>> +		e = xmalloc(sizeof(*e));
>> +		hashmap_entry_init(e, strhash(key));
>> +		e->key = xstrdup(key);
> 
> config_cache_find_entry() searches for (and hashes the) normalized_key.
> Should you not be entering the normalized key here?
> 

config_cache_add_value() is fed key-values pairs through the git_config()
callback mechanism, which normalises the key beforehand, so no need for
renormalising.

Thanks for the review. :)

Cheers,
Tanay Abhra.
