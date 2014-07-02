From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Wed, 02 Jul 2014 10:00:00 -0700
Message-ID: <xmqqd2dnitm7.fsf@gitster.dls.corp.google.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:00:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NtH-00080y-6s
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313AbaGBRAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:00:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50044 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbaGBRAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:00:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65DD322BE9;
	Wed,  2 Jul 2014 12:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4z82yvEcIqsdbIUNjaOvNh4GjpM=; b=c6IAS8
	bz5ThlM/H91U9BKTTJF1m8+PG3XeujmZu0zA88dL61zz58uOLNMkT3Ss9k3CkASy
	iHKW9Zx7I7c6YxneOYJduCBYeYaV99no3OosvhKI+tor3ZzFbHBBrq6Hq1wDnslW
	jt/FFAR+V9HroD/sDpXO6FncZy6dyIe1YppZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TiBz21LDmf1sZ22ppU6L2jYPD7eHhnkA
	hdlsssdA89W4XLVAaPuRLSgRGj6b7Q4DrwJXoGEzwOylJS1J1xWfMw9fNU0FtJGg
	pagM/We1pOxzR5fOg88AN1Yb1vtST9lB1Jc4qTdn2Ty+Y+6jsQv3flfHJQfMAZ+6
	2meB5BsrUPo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AE5422BE8;
	Wed,  2 Jul 2014 12:59:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE62722BE3;
	Wed,  2 Jul 2014 12:59:51 -0400 (EDT)
In-Reply-To: <1404280905-26763-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 1 Jul 2014 23:01:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 48A89014-020A-11E4-9F7A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252798>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 230b3a0..2c02fee 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -77,6 +77,75 @@ To read a specific file in git-config format, use
>  `git_config_from_file`. This takes the same callback and data parameters
>  as `git_config`.
>  
> +Querying For Specific Variables
> +-------------------------------
> +
> +For programs wanting to query for specific variables in a non-callback
> +manner, the config API provides two functions `git_config_get_value`
> +and `git_config_get_value_multi`.They both read values from an internal
> +cache generated previously from reading the config files.
> +
> +`git_config_get_value` takes two parameters,
> +
> +- a key string in canonical flat form for which the corresponding value

What is "canonical flat form"?

> +  with the highest priority (i.e. value in the repo config will be
> +  preferred over value in user wide config for the same variable) will
> +  be retrieved.
> +
> +- a pointer to a string which will point to the retrieved value. The caller
> +  should not free or modify the value returned as it is owned by the cache.
> +
> +`git_config_get_value` returns 0 on success, or -1 for no value found.
> +
> +`git_config_get_value_multi` allocates and returns a `string_list`
> +containing all the values for the key passed as parameter, sorted in order
> +of increasing priority (Note: caller has to call `string_list_clear` on
> +the returned pointer and then free it).
> +
> +`git_config_get_value_multi` returns NULL for no value found.
> +
> +`git_config_clear` is provided for resetting and invalidating the cache.
> +
> +`git_config_iter` gives a way to iterate over the keys in cache. Existing
> +`git_config` callback function signature is used for iterating.

Instead of doing prose above and then enumeration below,
consistently using the enumeration-style would make the descriptions
of API functions easier to find and read.  Also show what parameters
each function takes.  E.g.

	`git_config_get_value(const char *key, const char **value)`::
		Find the highest-priority value for the
		configuration variable `key`, store the pointer to
		it in `value` and return 0.  When the configuration
		variable `key` is not found, return -1 without
		touching `value`.
                
A few random thoughts.

 - Are "a value for the variable is found" and "no value for the
   variable is found" the only possible outcome?  Should somebody
   (not necessarily the calling code) be notified of an error---for
   example, if you opened a config file successfully but later found
   that the file could not be parsed due to a syntax error or an I/O
   error, is it possible the caller of this function to tell, or are
   these just some special cases of "variable not found"?

 - The same goes for the "multi" variant but it is a bit more grave,
   as a function that returns an "int" can later be updated to
   return different negative values to signal different kinds of
   errors, but a function that returns a pointer to string-list can
   only return one kind of NULL ;-)

 - For the purpose of "git_config_get_value()", what is the value
   returned for core.filemode when the configuration file says
   "[core] filemode\n", i.e. when git_config() callback would get a
   NULL for value to signal a boolean true?

 - Is there a reason why you need a separate and new "config_iter"?
   What does it do differently from the good-old git_config() and
   how?  It does not belong to "Querying for Specific Variables"
   anyway.

> +The config API also provides type specific API functions which do conversion
> +as well as retrieval for the queried variable, including:
> +
> +`git_config_get_int`::
> +Parse the retrieved value to an integer, including unit factors. Dies on
> +error; otherwise, allocates and copies the integer into the dest parameter.
> +Returns 0 on success, or 1 if no value was found.

"allocates and copies"????  Is a caller forced to do something like
this?

	int *val;

	if (!git_config_get_int("int.one", &val)) {
        	use(*val);
                free(val);
	}

I'd expect it to be more like:

	int val;
        if (!git_config_get_int("int.one", &val))
        	use(val);

Also, is there a reason why the "not found" signal is "1" (as
opposed to "-1" for the lower-level get_value() API)?

> +`git_config_get_ulong`::
> +Identical to `git_config_get_int` but for unsigned longs.

Obviously this is not identical but merely "Similar" to.

> +`git_config_bool`::

git_config_get_bool, perhaps?

> +Custom Configsets
> +-----------------
> +
> +A `config_set` points at an ordered set of config files, each of
> +which represents what was read and cached in-core from a file.

This over-specifies the implementation.  Judging from the list of
API functions below, an implementation is possible without having to
keep track of what source files were fed in what order (i.e. it can
just keep a single hash-table of read values and incrementally parse
the new contents given via configset-add-file into it, without even
recording the origins, and forget about the source files once it
finishes parsing).

As was pointed out during the previous review round, a stack of
<hash, filename> tuples cannot represent the configuration when
config-includes are involved.  Also we would eventually want to be
able to also read from non-file sources (e.g. from a blob, or a
caller-supplied in-core strings).

For the purpose of reporting errors at the point of value being
used, I have a suspicion that you would need to associate the
<file,line> pair with each individual value string you will keep
after configset_add_file() parses the file.  The implementation of
the call-chain may look like:


	git_configset_add_file(cs, filename):
        	file = open filename
                lineno = 0
		while read line from file:
	                git_configset_parse_line(cs, filename, lineno++, line)
		close file

	git_configset_parse_line(cs, filename, lineno, line):
        	... this needs to implement a state machine
                ... that keeps track of what has been read halfway
                ... e.g. we may have seen "[core] crlf =\\\n"
        	... earlier, which is not a complete input yet,
                ... and now we may be looking at "auto" that lets
                ... us finally parse one item.

	        if state in 'cs' and new 'line' gives us a complete input:
			determine key and value
                        record <value, filename, lineno> for 'key' to cs.hash
                update state in 'cs'

For processing "git -c section.variable=value", we probably would
call git_configset_parse_line() on the_configset with filename
set to "command line" or something.

And then when the caller tries to actually use the value, e.g.

         git_configset_get_int(cs, key):
		look up <value, filename, lineno> for 'key' from the cs.hash
		if value is successfully parsed as int:
                	return the parsed result
		else:
                	error("not an int: '%s' (%s:%s)", value, filename, lineno)

perhaps?

> +It can be used to construct an in-memory cache for config files that
> +the caller specifies. For example,

This is almost good to help a reader decide if she might want to use
it in her code, but we probably want to stress the fact that use of
a config_set is done for a namespace separate from the main
configuration system, e.g. ".gitmodules".

> +---------------------------------------
> +struct config_set gm_config = CONFIG_SET_INIT;
> +int b;
> +/* we add config files to the config_set */
> +git_configset_add_file(&gm_config, ".gitmodules");
> +git_configset_add_file(&gm_config, ".gitmodules_alt");
> +
> +if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
> +/* hack hack hack */
> +}
> +
> +/* when we are done with the configset */
> +git_configset_clear(&gm_config);
> +----------------------------------------
> +
> +Configset API provides functions for the above mentioned work flow, including:
> +
> +`git_configset_init`::
> +
> +Returns an allocated and initialized struct `config_set` pointer.

"allocated"???  Is a caller forced to do this, i.e. always have the
config-set on heap?

	struct config_set *config = git_configset_init();
        ... use it ...
        git_configset_clear(config);

I'd expect it be more like this:

	struct config_set config;

	git_configset_init(&config);
        ... use it...
        git_configset_clear(&config);
