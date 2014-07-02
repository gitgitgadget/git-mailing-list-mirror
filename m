From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Wed, 02 Jul 2014 11:14:10 +0200
Message-ID: <vpqoax8m8bh.fsf@anie.imag.fr>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 11:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2GcV-0008Gv-W3
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 11:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbaGBJOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 05:14:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42045 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbaGBJOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 05:14:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s629E9IV026501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jul 2014 11:14:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s629EAqx029233;
	Wed, 2 Jul 2014 11:14:10 +0200
In-Reply-To: <1404280905-26763-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 1 Jul 2014 23:01:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Jul 2014 11:14:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s629E9IV026501
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404897252.26766@WdzglRM9qGyn0Y6elCU6xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252772>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add a `config_set` construct that points to an ordered set of config files
> specified by the user, each of which represents what was read and cached
> in core as hashmaps. Add two external functions `git_configset_get_value`
> and `git_configset_get_value_multi` for querying from the config sets,
> which follow `last one wins` semantic(i.e. if there are multiple matches

Space before (

> for the queried key in the files of the configset the value returned will
> the last value in the last matching file of the configset) Add type

will _be_ ?

Does this remark also apply to git_configset_get_value_multi? My
understanding was that "last one wins" applied only to
git_configset_get_value.

> Add a default `config_set`, `the_config_set` to cache all key-value pairs

I don't like the name "the_config_set". It's not the only one. Perhaps
repo_config_set? (not totally satisfactory as it does not contain only
the repo, but the repo+user+system)

What do others think?

> read from usual config files(repo specific .git/config, user wide

(You always forget space before '('...)

> ~/.gitconfig and the global /etc/gitconfig). `the_config_set` uses a
> single hashmap populated using git_config(). The reason for doing so is
> twofold, one is to honour include directives, another is to guarantee O(1)
> lookups for usual config values, as values are queried for hundred of
> times during a run of a git program.

What is the reason to deal with `the_config_set` and other config sets
differently? You're giving arguments to store `the_config_set` as a
single hashmap, but what is the reason to store others as multiple
hashmaps?

And actually, I don't completely buy your arguments: having 3 or 4
hashmaps (.git/config, ~/.gitconfig, ~/.config/git/config and
/etc/gitconfig) would be a O(4) lookup, which is still O(1), and you
could deal with include directives by having ".git/config and included
files" in a hashmap, "~/.gitconfig and included files" in a second
hashmap, ...

My guess is that the real argument is "git_config already does what I
want and I'm too lazy to change it". And I do consider lazyness as a
quality for a computer-scientist ;-).

I would personally find it much simpler to have a single hashmap. We'd
lose the ability to invalidate the cache for only a single file, but I'm
not sure it's worth the code complexity.

> +Querying For Specific Variables
> +-------------------------------
> +
> +For programs wanting to query for specific variables in a non-callback
> +manner, the config API provides two functions `git_config_get_value`
> +and `git_config_get_value_multi`.They both read values from an internal

Space after .

> +`git_config_iter` gives a way to iterate over the keys in cache. Existing
> +`git_config` callback function signature is used for iterating.

"Existing" refers to the old state. It's OK in a commit message, but
won't make sense in the future, when your non-callback API and the old
callback API will live side by side.

> +The config API also provides type specific API functions which do conversion
> +as well as retrieval for the queried variable, including:
> +
> +`git_config_get_int`::
> +Parse the retrieved value to an integer, including unit factors. Dies on
> +error; otherwise, allocates and copies the integer into the dest parameter.
> +Returns 0 on success, or 1 if no value was found.

It seems strange to me to return 1 here, and -1 in git_config_get_value
to mean the same thing.

> +`git_config_bool`::

Isn't it git_config_get_bool?

> +/* config-hash.c */

You may point to the documentation in the comment too.

> +#define CONFIG_SET_INIT { NULL, 0, 0 }
> +
> +struct config_set {
> +	struct config_set_item *item;
> +	unsigned int nr, alloc;
> +};
> +
> +struct config_set_item {
> +	struct hashmap config_hash;
> +	char *filename;

Perhaps const char *?

> +static struct hashmap *add_config_hash(const char *filename, struct config_set *cs)
> +{
> +	int ret = 0;
> +	struct config_set_item *ct;
> +	struct config_set_cb cb;
> +	ALLOC_GROW(cs->item, cs->nr + 1, cs->alloc);
> +	ct = &cs->item[cs->nr++];
> +	ct->filename = xstrdup(filename);
> +	config_hash_init(&ct->config_hash);
> +	cb.cs = cs;
> +	cb.ct = ct;
> +	/*
> +	 * When filename is "default", hashmap is constructed from the usual set of
> +	 * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
> +	 * global /etc/gitconfig), used in `the_config_set`
> +	 */
> +	if (!strcmp(filename, "default"))

How does one read a file actually called "default" with this API?

More generally, why do you need a special-case here? I think it would be
much better to leave this part unaware of the default, and have a
separate function like create_repo_config_hash (or
create_the_config_hash) that would call git_config(...). There actually
isn't much shared code between the "default" case and the others in your
function.

> +static struct hashmap *get_config_hash(const char *filename, struct config_set *cs)
> +{
> +	int i;
> +	for(i = 0; i < cs->nr; i++) {
> +		if (!strcmp(cs->item[i].filename, filename))
> +			return &cs->item[i].config_hash;
> +	}
> +	return add_config_hash(filename, cs);
> +}
> +
> +static struct config_hash_entry *config_hash_find_entry(const char *key, const char* filename,
> +							struct config_set *cs)

I don't get the logic here.

Either the caller explicitly manages a config_set variable like

  config_set my_set = git_configset_init();
  git_configset_add_file(my_set, "my-file");
  git_configset_get_value(my_set, "some.variable.name");

Or there's an implicit singleton mapping files to hashmaps to allow the
user to say

  git_configset_get_value("my-file", "some.variable.name");

without asking the user to explicitly manipulate config_set variables.

It seems to me that your solution is a bad compromise between both
solutions: you do require the user to manipulate config_set variables,
but you also require a filename to look for the right entry in the list.

Did you miss the end of Junio's message:

  http://thread.gmane.org/gmane.comp.version-control.git/252567

?

If the user explicitly asks for a single entry in the list, then why
group them in a list? I guess the question is the same as above, and the
more I read the patch, the more I think a config_set should contain a
single hashmap.

> +static int config_hash_add_value(const char *key, const char *value,
> +				 struct config_set_item *ct, struct config_set *cs)
> +{
> +	struct hashmap *config_hash = &ct->config_hash;
> +	struct config_hash_entry *e;
> +	e = config_hash_find_entry(key, ct->filename, cs);
> +
> +	if (!e) {
> +		e = xmalloc(sizeof(*e));
> +		hashmap_entry_init(e, strhash(key));
> +		e->key = xstrdup(key);
> +		memset(&e->value_list, 0, sizeof(e->value_list));
> +		e->value_list.strdup_strings = 1;
> +		hashmap_add(config_hash, e);
> +	}
> +	/*
> +	 * Since the values are being fed by git_config*() callback mechanism, they
> +	 * are already normalised.

We usually speak en_US rather than en_UK => normalized.

> +int git_config_get_value(const char *key, const char **value)
> +{
> +	if (!the_config_set_initialised) {
> +		git_configset_add_file(&the_config_set, "default");
> +		the_config_set_initialised = 1;
> +	}
> +	return git_configset_get_value(&the_config_set, key, value);
> +}
> +
> +const struct string_list *git_config_get_value_multi(const char *key)
> +{
> +	if (!the_config_set_initialised) {
> +		git_configset_add_file(&the_config_set, "default");
> +		the_config_set_initialised = 1;
> +	}
> +	return git_configset_get_value_multi(&the_config_set, key);
> +}

These if statements could be refactored, and the_config_set_initialised
could be hidden to the caller. Just make a function get_the_config_set()
that initializes if needed and returns a pointer to the_config_set.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
