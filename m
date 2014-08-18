From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL values
Date: Mon, 18 Aug 2014 11:18:52 -0700
Message-ID: <xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 20:19:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJRWQ-0004EL-HR
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 20:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbaHRSTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 14:19:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60681 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbaHRSTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 14:19:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A04E31167;
	Mon, 18 Aug 2014 14:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ZIJ0uDzxT8duyDo365yQnYnhsQ=; b=q1odmr
	UzAW5bNDgH6OnZWwy+BIq2wUqLiL/N83HKLWYpzOSElqbPr9U/5DNRM6IfHAu33u
	veTUftbsXmkDKAIxjLl/1zV1E4qcQUu34GzdG2NdMIWNAdOE3ml2Fj47X7i/Kwd2
	1Xh+NDlYgG280lfKu+nzArumtexjFZbKOQLNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iw9FEuotVmJfDrw1lG0uZ/zWXMsoxl2b
	ANO98xzc2l4B2C/9Xj5K7w6KdQWnFsHfeUllsuSP85ragjGpMODD92Foh6Be3oV+
	+Z3a6KlZZdXfEcCM2NhjjrhFo9gmxnGt/upghEz6ZNLiNkJNV+TZGQZQ38pp20tL
	KEq3XvO/oOA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0068E31166;
	Mon, 18 Aug 2014 14:19:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 85B5A31155;
	Mon, 18 Aug 2014 14:18:54 -0400 (EDT)
In-Reply-To: <1408357077-4745-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 18 Aug 2014 03:17:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1CDDCADE-2704-11E4-9828-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255406>

Tanay Abhra <tanayabh@gmail.com> writes:

> Currently if we have a config file like,
> [foo]
>         baz
>         bar =
>
> and we try something like, "git config --add foo.baz roll", Git will
> segfault.

Thanks; this is a good find.

This is a tangent, but people please stop starting their sentence
with a somewhat irritating "Currently"; it does not help both
current and future readers very much without some mention of version
numbers.

I suspect this bug dates back to pretty much day one of "git config"
(dates at least back to 1.5.3).

> The problem lies with the regexp used for simulating --add in
> `git_config_set_multivar_in_file()`, "^$", which in ideal case should
> not match with any string but is true for empty strings. Instead use a
> regexp like "a^" which can not be true for any string, empty or not.

Yuck, but we cannot pass NULL or some other special value that look
more meaningful to signal the fact that we do not want to match
anything, so this seems to be the easiest way out.  

Are we sure that "a^", which cannot be true for any string, will not
be caught by anybody's regcomp() as an error?  I know regcomp()
accepts the expression and regexec() fails to match with GNU libc,
but that is not the whole of the world.

At least, please make it clear for those who read this code later
what is going on with this magic "a^", perhaps with

	#define REGEXP_THAT_NEVER_MATCHES "a^"
	...
        return git_config_set_multivar_in_file(given_config_source.file,
                                              argv[0], value,
                                              REGEXP_THAT_NEVER_MATCHES, 0);
and/or with in-code comment.

	/*
         * set_multivar_in_file() removes existing values that match
         * the value_regexp argument and then adds this new value;
         * pass a pattern that never matches anything, as we do not
         * want to remove any existing value.
         */
	return git_config_set_multivar_in_file(given_config_source.file,
                                              argv[0], value,
                                              REGEXP_THAT_NEVER_MATCHES, 0);

To be honest, I'd rather see this done "right", by giving an option
to the caller to tell the function not to call regcomp/regexec in
matches().

 * Define a global exported via cache.h and defined in config.c

	extern const char CONFIG_SET_MULTIVAR_NO_REPLACE[];

   and pass it from this calling site, instead of an arbitrary
   literal string e.g. "a^"

 * Add a bit to the "store" struct, e.g. "unsigned value_never_matches:1";

 * In git_config_set_multivar_in_file() implementation, check for
   this constant address and set store.value_never_matches to true;

 * in matches(), check this bit and always return "No, this existing
   value do not match" when it is set.

or something like that.

> For removing the segfault add a check for NULL values in `matches()` in
> config.c.

The fact that you do a check is important, but it equally if not
more important what you do with the result.  "Check for a NULL and
consider it as not matching" is probably what you meant, but I'd
like to double check.

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  builtin/config.c        |  2 +-
>  config.c                |  2 +-
>  t/t1303-wacky-config.sh | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index fcd8474..b9e7dce 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -586,7 +586,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		check_argc(argc, 2, 2);
>  		value = normalize_value(argv[0], argv[1]);
>  		return git_config_set_multivar_in_file(given_config_source.file,
> -						       argv[0], value, "^$", 0);
> +						       argv[0], value, "a^", 0);
>  	}
>  	else if (actions == ACTION_REPLACE_ALL) {
>  		check_write();
> diff --git a/config.c b/config.c
> index 058505c..67a7729 100644
> --- a/config.c
> +++ b/config.c
> @@ -1231,7 +1231,7 @@ static int matches(const char *key, const char *value)
>  	return !strcmp(key, store.key) &&
>  		(store.value_regex == NULL ||
>  		 (store.do_not_match ^
> -		  !regexec(store.value_regex, value, 0, NULL, 0)));
> +		  (value && !regexec(store.value_regex, value, 0, NULL, 0))));
>  }
>  
>  static int store_aux(const char *key, const char *value, void *cb)
> diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
> index 3a2c819..3b92083 100755
> --- a/t/t1303-wacky-config.sh
> +++ b/t/t1303-wacky-config.sh
> @@ -111,4 +111,24 @@ test_expect_success 'unset many entries' '
>  	test_must_fail git config section.key
>  '
>  
> +test_expect_success '--add appends new value after existing empty value' '
> +	cat >expect <<-\EOF &&
> +
> +
> +	fool
> +	roll
> +	EOF
> +	cp .git/config .git/config.old &&
> +	test_when_finished "mv .git/config.old .git/config" &&
> +	cat >.git/config <<-\EOF &&
> +	[foo]
> +		baz
> +		baz =
> +		baz = fool
> +	EOF
> +	git config --add foo.baz roll &&
> +	git config --get-all foo.baz >output &&
> +	test_cmp expect output
> +'
> +
>  test_done
