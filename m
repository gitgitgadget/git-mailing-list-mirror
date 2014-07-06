From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 1/2] add `config_set` API for caching config-like files
Date: Sun, 06 Jul 2014 19:45:09 +0200
Message-ID: <vpqa98m8jq2.fsf@anie.imag.fr>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
	<1404631162-18556-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 19:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3qVB-00059q-Db
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 19:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbaGFRpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 13:45:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41861 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbaGFRpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 13:45:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s66Hj7P8004483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jul 2014 19:45:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s66Hj9oe020220;
	Sun, 6 Jul 2014 19:45:09 +0200
In-Reply-To: <1404631162-18556-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Sun, 6 Jul 2014 00:19:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Jul 2014 19:45:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s66Hj7P8004483
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405273509.61848@Mnys5AY8iREz5PtNO6eI9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252940>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add a default `config_set`, `the_config_set` to cache all key-value pairs
> read from usual config files (repo specific .git/config, user wide
> ~/.gitconfig and the global /etc/gitconfig). `the_config_set` uses a
> single hashmap populated using `git_config()`.

"uses a single hashmap" is no longer relevant. Any config_set use a
single hashmap.

(The "populated using git_config()" part is still relevant OTOH)

> +`void git_configset_init(struct config_set *cs)`::
> +
> +	Initializes the member variables of config_set `cs`.

I'd say just "initializes the config_set `cs`".

> +/*
> + * Default config_set that contains key-value pairs from the usual set of config
> + * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
> + * global /etc/gitconfig)

To be technically correct, "user wide ~/.gitconfig, XDG config file and
the global ...".

> +static int add_configset_hash(const char *filename, struct config_set *cs)
> +{
> +	int ret = 0;
> +	if (!cs->hash_initialized)
> +		config_hash_init(&cs->config_hash);
> +	cs->hash_initialized = 1;

That would seem more natural to me to have a function config_set_init
instead of config_hash_init, that would set hash_initialized.

config_hash_init is currently a one-liner, so there's no risk of making
it too complex.

> +static int config_hash_add_value(const char *key, const char *value, struct hashmap *config_hash)
> +{
> +	struct config_hash_entry *e;
> +	e = config_hash_find_entry(key, config_hash);
> +
> +	if (!e) {
> +		e = xmalloc(sizeof(*e));
> +		hashmap_entry_init(e, strhash(key));

Nitpick: you're hashing the same string twice. Once for
config_hash_find_entry, and another here. It would be slightly faster to
allow config_hash_find_entry to return the hashcode (as a by-address
parameter).

But you may want to keep the code as it is for simplicity.

It took me some time to understand why you normalize in
config_hash_find_entry and not here. My understanding is that
config_hash_find_entry is used to query the hashmap from the user API
(so you need normalization), but this particular codepath receives
normalized keys (the comment right below states that for values).

It's probably worth a comment here and/or in config_hash_find_entry.

> +	}
> +	/*
> +	 * Since the values are being fed by git_config*() callback mechanism, they
> +	 * are already normalized. So simply add them without any further munging.
> +	 */
> +	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
> +
> +	return 0;
> +}

[...]

> +int git_configset_add_file(struct config_set *cs, const char *filename)
> +{
> +	return add_configset_hash(filename, cs);
> +}

Why have two functions doing the same, with arguments in different
orders?

I guess it's just historical, and you can keep only one.

> +void git_configset_clear(struct config_set *cs)
> +{
> +	struct config_hash_entry *entry;
> +	struct hashmap_iter iter;
> +	if (!cs->hash_initialized)
> +		return;
> +
> +	hashmap_iter_init( &cs->config_hash, &iter);

No space after (.

> +int git_config_get_string(const char *key, const char **dest)
> +{
> +	git_config_check_init();
> +	return git_configset_get_string(&the_config_set, key, dest);
> +}
> +
> +int git_config_get_int(const char *key, int *dest)
> +{
> +	git_config_check_init();
> +	return git_configset_get_int(&the_config_set, key, dest);
> +}

Reading this list, I initially thought it might be worth factoring this
in a macro. But the list isn't that long, and contains several
special-cases (3 parameters instead of 2). So, don't bother.

OK, we're getting close. v6 should be really good :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
