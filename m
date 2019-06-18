Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980931F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfFRUcw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:32:52 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:18113 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfFRUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:32:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45T0Bm5p9sz5tlC;
        Tue, 18 Jun 2019 22:32:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D5DAB2148;
        Tue, 18 Jun 2019 22:32:47 +0200 (CEST)
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
Date:   Tue, 18 Jun 2019 22:32:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617165450.81916-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.06.19 um 18:54 schrieb Boxuan Li:
> The userdiff.c has been rewritten to avoid hard-coded built-in
> driver patterns. Now we ship
> $(sharedir)/git-core/templates/userdiff that can be read using
> git_config_from_file() interface, using a very narrow callback
> function that understands only diff.*.xfuncname,
> diff.*.wordregex, and diff.*.regIcase.
> 
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> A few notes and questions:
> 1. In [diff "tex"] section, \x80 and \xff cannot be parsed by git config parser.
> I have no idea why this is happening. I changed them to \\x80 and \\xff as a workaround, which
> resulted in t4034 failure (See https://travis-ci.org/li-boxuan/git/jobs/546729906#L4679).

I guess, the idea is to catch bytes of UTF-8 encoded characters as
regular words.

The problem is to write such bytes literally into a git-config file and
still keep the file editable in a portable. Perhaps it is necessary to
declare the file as CP1252 encoded via .gitattributes, write that part
of the regexp as [a-zA-Z0-9€-þ], and hope that your text editor writes
the file acutally as CP1252. ISO8859-1 does not work because \x80 is not
occupied.

> 2. I am not sure how and where I can free the memory allocated to "builtin_drivers".
> 3. When I run `git format-patch HEAD~1`, core dump happens occasionally. Seems
> no test case caught this problem. Till now, I have no luck finding out the reason.

I admit that haven't tested the driver beyond running t4018 and t4034.

> 
> Any hint or review would be appreciated.
> ---
>  templates/this--userdiff | 164 ++++++++++++++++++++++
>  userdiff.c               | 284 +++++++++++++++------------------------
>  2 files changed, 275 insertions(+), 173 deletions(-)
>  create mode 100644 templates/this--userdiff
> 
> diff --git a/templates/this--userdiff b/templates/this--userdiff
> new file mode 100644
> index 0000000000..85114a7229
> --- /dev/null
> +++ b/templates/this--userdiff

Why place this file in .git? To have per-repository diff drivers, we can
already specify them via 'git config'. This file should be installed in
the system.

> @@ -0,0 +1,164 @@
> +[diff "ada"]

etc... Please be aware that there are a few changes in 'next' that
affect this patch, in particular, the matlab pattern and new rust patterns.

> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..3e7052e13c 100644
> --- a/userdiff.c
> +++ b/userdiff.c

>  static struct userdiff_driver *drivers;
>  static int ndrivers;
>  static int drivers_alloc;
> +static struct config_set gm_config;
> +static int config_init;
> +struct userdiff_driver *builtin_drivers;
> +static int builtin_drivers_size;

Why do you not merge the builtin drivers with the other drivers? If
there is a reason to separate the two classes, please follow the
existing pattern to use ALLOC_GROW to reallocate the array.

> +static int userdiff_config_init(void)
> +{
> +	int ret = -1;
> +	if (!config_init) {

Please make this an early return to reduce the indentation of the
subsequent code.

> +		git_configset_init(&gm_config);
> +		if (the_repository && the_repository->gitdir)
> +			ret = git_configset_add_file(&gm_config, git_pathdup("userdiff"));
> +
> +		// if .git/userdiff does not exist, set config_init to be -1

Please do not use C++ style comments.

> +		if (ret == 0)
> +			config_init = 1;
> +		else
> +			config_init = -1;

After having done the initialization, it should be irrelevant whether
the driver list was not found. So, config_init = 1; should be the only
relevant case. Am I missing something?

> +
> +		builtin_drivers = (struct userdiff_driver *) malloc(sizeof(struct userdiff_driver));

Please do not use a cast here. It is unnecessary.
Please use xmalloc, which checks for an allocation failure.
I'm not going to repeat this for all other occurrences.

> +		*builtin_drivers = (struct userdiff_driver) { "default", NULL, -1, { NULL, 0 } };

I don't think we use this modern (GNU?) form of struct constants
anywhere already.

> +		builtin_drivers_size = 1;
> +	}
> +	return 0;
> +}
> +
> +static char* join_strings(const struct string_list *strings)
> +{
> +	char* str;
> +	int i, len, length = 0;
> +	if (!strings)
> +		return NULL;
> +
> +	for (i = 0; i < strings->nr; i++)
> +		length += strlen(strings->items[i].string);
> +
> +	str = (char *) malloc(length + 1);
> +	length = 0;
> +
> +	for (i = 0; i < strings->nr; i++) {
> +		len = strlen(strings->items[i].string);
> +		memcpy(str + length, strings->items[i].string, len);
> +		length += len;
> +	}
> +	str[length] = '\0';
> +	return str;
> +}

If you use the strbuf API instead of raw strings and
for_each_string_list_item, I'm sure you can boil this down to just a
handful of lines.

> +
> +static struct userdiff_driver *userdiff_find_builtin_by_namelen(const char *k, int len)
> +{
> +	int i, key_length, word_regex_size, ret, reg_icase, cflags;
> +	char *xfuncname_key, *word_regex_key, *ipattern_key;
> +	char *xfuncname_value, *word_regex_value, *word_regex, *name;
> +	struct userdiff_driver *builtin_driver;
> +	char word_regex_extra[] = "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+";

Aha! Have a look at 664d44ee7fb1 ("userdiff: simplify word-diff
safeguard", 2011-01-11). Perhaps the special part in the TeX pattern
should just be removed (in a preparatory patch). It would change the
meaning because it would treat runs of digits and letters as separate
words, but I don't think that will hurt.

> +	userdiff_config_init();
> +	name = (char *) malloc(len + 1);
> +	memcpy(name, k, len);
> +	name[len] = '\0';

xmemdupz?

> +
> +	// look up builtin_driver
> +	for (i = 0; i < builtin_drivers_size; i++) {
> +		struct userdiff_driver *drv = builtin_drivers + i;
> +		if (!strncmp(drv->name, name, len) && !drv->name[len])
> +			return drv;
> +	}
> +
> +	// if .git/userdiff does not exist and name is not "default", return NULL
> +	if (config_init == -1) {
> +		return NULL;
> +	}

I wonder why you look up a driver before initialization.

> +
> +	// load xfuncname and wordRegex from userdiff config file
> +	key_length = len + 16;
> +	xfuncname_key = (char *) malloc(key_length);
> +	word_regex_key = (char *) malloc(key_length);
> +	ipattern_key = (char *) malloc(key_length - 1);
> +	snprintf(xfuncname_key, key_length, "diff.%s.xfuncname", name);
> +	snprintf(word_regex_key, key_length, "diff.%s.wordRegex", name);
> +	snprintf(ipattern_key, key_length - 1, "diff.%s.regIcase", name);
> +
> +	xfuncname_value = join_strings(git_configset_get_value_multi(&gm_config, xfuncname_key));
> +	word_regex_value = join_strings(git_configset_get_value_multi(&gm_config, word_regex_key));

I'm not familiar with the git_config API. Can't comment on what this is
all about.

> +
> +	ret = git_configset_get_bool(&gm_config, ipattern_key, &reg_icase);
> +	// if "regIcase" is not found, do not use REG_ICASE flag
> +	if (ret == 1)
> +		reg_icase = 0;
> +	cflags = reg_icase ? REG_EXTENDED | REG_ICASE : REG_EXTENDED;
> +
> +	free(xfuncname_key);
> +	free(word_regex_key);
> +	free(ipattern_key);
> +
> +	if (!xfuncname_value || !word_regex_value)
> +		return NULL;
> +
> +	word_regex_size = strlen(word_regex_value) + strlen(word_regex_extra) + 1;
> +	word_regex = (char *) malloc(word_regex_size);
> +	snprintf(word_regex, word_regex_size,
> +			"%s%s", word_regex_value, word_regex_extra);
> +
> +	builtin_drivers_size++;
> +	builtin_drivers = realloc(builtin_drivers, builtin_drivers_size * sizeof(struct userdiff_driver));

This is where you should use ALLOC_GROW.

> +	builtin_driver = builtin_drivers + builtin_drivers_size - 1;
> +	*builtin_driver = (struct userdiff_driver) {
> +			name, NULL, -1, { xfuncname_value, cflags }, word_regex };
> +	return builtin_driver;
> +}

So, after having read through the whole patch, I understand that you are
using the builtin_drivers just as cache.

That is not how I initially thought it would work. IMO, you should just
slurp in all of the builtin drivers and stash them away once during
initialization. Then it is not necessary to parse the file more than once.

>  
>  static struct userdiff_driver driver_true = {
>  	"diff=true",
> @@ -197,12 +140,7 @@ static struct userdiff_driver *userdiff_find_by_namelen(const char *k, int len)
>  		if (!strncmp(drv->name, k, len) && !drv->name[len])
>  			return drv;
>  	}
> -	for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
> -		struct userdiff_driver *drv = builtin_drivers + i;
> -		if (!strncmp(drv->name, k, len) && !drv->name[len])
> -			return drv;
> -	}
> -	return NULL;
> +	return userdiff_find_builtin_by_namelen(k, len);
>  }

I hate functions with this layout:

fun()
{
    loop {
       stuff;
    }
    something_else();
}

The preferred layout is, IMO:

do_stuff()
{
    loop {
       stuff;
    }
}
fun()
{
     do_stuff();
     something_else();
}

Or (less preferable) expand something_else() in the function.

In this case, the goal could be:

static struct userdiff_driver *userdiff_find_by_namelen1(...)
{
	...lookup loop comes here...
}

static struct userdiff_driver *userdiff_find_by_namelen(const char *k,
int len)
{
	struct userdiff_driver *drv;
	drv = userdiff_find_by_namelen1(drivers, drivers_alloc);
	if (drv)
		return drv;
	if (!config_init)
		userdiff_config_init();
	return userdiff_find_by_namelen1(builtin_drivers, builtin_drivers_size);
}

Needless to say that userdiff_config_init() should parse the file and
stash away all the drivers it finds.

-- Hannes
