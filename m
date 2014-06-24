From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Tue, 24 Jun 2014 16:32:56 +0100
Message-ID: <53A99A28.1090302@ramsay1.demon.co.uk>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com> <1403518300-23053-3-git-send-email-tanayabh@gmail.com> <53A84077.4010200@ramsay1.demon.co.uk> <53A853E9.8060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:33:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzSiZ-0002y4-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 17:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbaFXPdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 11:33:02 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:48921 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753125AbaFXPdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 11:33:00 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5A2FDA64E73;
	Tue, 24 Jun 2014 15:27:01 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 05320A64A19;
	Tue, 24 Jun 2014 15:27:01 +0100 (BST)
Received: from [192.168.254.12] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Tue, 24 Jun 2014 15:27:00 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A853E9.8060801@gmail.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252410>

On 23/06/14 17:20, Tanay Abhra wrote:
> On 06/23/2014 07:57 AM, Ramsay Jones wrote:
>> On 23/06/14 11:11, Tanay Abhra wrote:
[snip]

>>> +static struct hashmap *get_config_cache(void)
>>> +{
>>> +	static struct hashmap config_cache;
>>> +	if (!hashmap_initialized) {
>>> +		config_cache_init(&config_cache);
>>> +		hashmap_initialized = 1;
>>> +		git_config(config_cache_callback, NULL);
>>> +	}
>>> +	return &config_cache;
>>> +}
>>
>> [I have not been following this series at all (sorry I haven't had
>> the time to spare), so take these comments with a very big pinch of
>> salt! ie just ignore me if it's already been discussed etc. ;-) ]
>>
>> The 'git config' command can be used to read arbitrary files (so long
>> as they conform to the config syntax). For example, see the --file and
>> --blob options to git-config. At present, I think only scripted commands
>> use this facility (eg git-submodule). Noting the singleton config_cache,
>> what happens when git-submodule becomes a C builtin, or indeed any other
>> C builtin wants to take advantage of the new code when processing a non-
>> standard config file?
>>
> 
> This series was mainly to replace git_config() invocations around the codebase.
> There are currently 111 git_config() invocations, each of which causes a file
> reread whenever called. git_config() only feeds values from the standard config
> files(i.e repo, user and global config).
> 
> For reading config values from specific files or blobs, there are three functions
> git_config_with_options, git_config_from_file & git_config_from_blob which can be
> easily used inside a C builtin or anywhere in the code.
> 
> The bulk of git_config_api calls are only for git_config(). For example,
> git_config_from_file() has three hits only in entire codebase,
> git_config_with_options() has 5 hits, so I concentrated on generating a cache
> for the usual config files only. For other files, the callers can fall back on older
> API functions like I had mentioned above.
> 
> Forgive me if I inferred your question incorrectly. More below.

Hmm, maybe. The "... take advantage of the new code" refers to the
possibility (or otherwise) of re-using your work to update these
"older API" functions to the new API style. (also, see Junio's response).
[In order to do this, I would have expected to see one hash table
for each file/blob, so the singleton object took me by surprise.]

An "out of scope for this project" is a perfectly acceptable
response (*particularly* since it is very late in the day to be
bringing this up!).

>>> +static struct config_cache_entry *config_cache_find_entry(const char *key)
>>> +{
>>> +	struct hashmap *config_cache;
>>> +	struct config_cache_entry k;
>>> +	struct config_cache_entry *found_entry;
>>> +	char *normalized_key;
>>> +	int ret;
>>> +	config_cache = get_config_cache();
>>> +	ret = git_config_parse_key(key, &normalized_key, NULL);
>>> +
>>> +	if (ret)
>>> +		return NULL;
>>> +
>>> +	hashmap_entry_init(&k, strhash(normalized_key));
>>> +	k.key = normalized_key;
>>> +	found_entry = hashmap_get(config_cache, &k, NULL);
>>> +	free(normalized_key);
>>> +	return found_entry;
>>> +}
>>> +
>>> +static struct string_list *config_cache_get_value(const char *key)
>>> +{
>>> +	struct config_cache_entry *e = config_cache_find_entry(key);
>>> +	return e ? &e->value_list : NULL;
>>> +}
>>> +
>>> +static int config_cache_add_value(const char *key, const char *value)
>>> +{
>>> +	struct hashmap *config_cache;
>>> +	struct config_cache_entry *e;
>>> +	struct string_list_item *item;
>>> +	int *boolean_null_flag;
>>> +
>>> +	config_cache = get_config_cache();
>>> +	e = config_cache_find_entry(key);
>>> +
>>> +	boolean_null_flag = xcalloc(1, sizeof(*boolean_null_flag));
>>> +
>>> +	if (!e) {
>>> +		e = xmalloc(sizeof(*e));
>>> +		hashmap_entry_init(e, strhash(key));
>>> +		e->key = xstrdup(key);
>>
>> config_cache_find_entry() searches for (and hashes the) normalized_key.
>> Should you not be entering the normalized key here?
>>
> 
> config_cache_add_value() is fed key-values pairs through the git_config()
> callback mechanism, which normalises the key beforehand, so no need for
> renormalising.

Ah, yes, I forgot that the parsing code does a tolower() at various
places while accumulating the key string. So the (potentially) non-
normalized keys come from the user via the new API functions and,
rather than putting code to normalize the key in each of those,
just do it once in config_cache_find_entry(). (Although, you could
possibly do that in config_cache_get_value()).  OK.

Hmm, maybe add a short comment to that effect? dunno.

ATB,
Ramsay Jones
