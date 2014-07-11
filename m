From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] test-config: add tests for the config_set API
Date: Fri, 11 Jul 2014 11:18:27 -0700
Message-ID: <xmqq8unz4v4c.fsf@gitster.dls.corp.google.com>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
	<1405049655-4265-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:18:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fPC-0000MG-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbaGKSSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:18:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54365 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbaGKSSl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:18:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7757C27DE5;
	Fri, 11 Jul 2014 14:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yTJu7rBle0oaHbRballXOooV0ZI=; b=YE9no3
	LCKg6nJQtTk0slR3uwxv24keAciw52jSY0xXPUqE8TgK902d/0+ezmhTFdLaBqXB
	tV61mXw9F1spcdNMqbrr9ODSGrw74rf7kf0rxFpe2hR4lqWtYYfdFDiQDEs/1PjA
	o55PNNts98Lv4W+0IMf14x3ok7J9Ng9UKOZqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E47pj3kcD9e9fdzeVhiEzsMoZWyZAU65
	j3gcBZjxe+XDpoLsi5572XpYHliUT7lb7K/IiAVHkLq22W4rb2+vn1ql4RyH5ss0
	jMTO1b3ZgOdm8dGKln/4Q2NvEsh+tt/gGtmLreJGp2wZi0Q0907U6NmnhFbQiZ6/
	kqY89JAcNoU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BDF327DE4;
	Fri, 11 Jul 2014 14:18:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB26427DD4;
	Fri, 11 Jul 2014 14:18:13 -0400 (EDT)
In-Reply-To: <1405049655-4265-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 10 Jul 2014 20:34:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8FA8C86-0927-11E4-9BCD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253308>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> new file mode 100755
> index 0000000..87a29f1
> --- /dev/null
> +++ b/t/t1308-config-set.sh
> @@ -0,0 +1,170 @@
> +#!/bin/sh
> +
> +test_description='Test git config-set API in different settings'
> +
> +. ./test-lib.sh
> +
> +# 'check section.key value' verifies that the entry for section.key is
> +# 'value'
> +check() {

(style) SP around both sides of ().

More importantly, will we ever have different kind of check in this
script, perhaps checking if all values for a multi-valued variables
appear in the output, checking if get_bool works, etc. in the
future?  I would imagine the answer is yes, and in that case this
should be renamed to be a bit more specific (i.e. no "too generic"
helper called "check" would exist in the final result).  Perhaps
call it "check_single", "check_get_value" or "check_value" (the last
one assumes that all your future checks are mostly about various
forms of "get")?

> +	echo "$2" >expected &&
> +	test-config get_value "$1" >actual 2>&1 &&
> +	test_cmp expected actual
> +}
> +
> +test_expect_success 'setup default config' '
> +	cat >.git/config << EOF

 - No SP after redirection operator.

 - If you are not using variable substition in the here-doc, it is
   more friendly to quote the end-of-here-doc token to tell the
   reader that they do not have to worry about them.

 - There may be core.* variables that are crucial for correct
   operation of the version of Git being tested, so wiping and
   replacing .git/config wholesale is not a good idea.  Appending
   your config items is sufficient for the purpose of these tests.

i.e.

	cat >>.git/config <<\EOF
        ...
	EOF

> +	[core]

I'd feel safer if you did not abuse [core] like this.  All you care
about is the config parsing, and you do not want future versions of
Git introducing core.MixedCase to mean something meaningful that
affects how "git config" and other commands work.

> +		penguin = very blue
> +		Movie = BadPhysics
> +		UPPERCASE = true
> +		MixedCase = true
> +		my =
> ...
> +	EOF
> +'
> +
> +test_expect_success 'get value for a simple key' '
> +	check core.penguin "very blue"
> +'
> +
> +test_expect_success 'get value for a key with value as an empty string' '
> +	check core.my ""
> +'
> +
> +test_expect_success 'get value for a key with value as NULL' '
> +	check core.foo "(NULL)"
> +'
> +
> +test_expect_success 'upper case key' '
> +	check core.UPPERCASE "true"
> +'
> +
> +test_expect_success 'mixed case key' '
> +	check core.MixedCase "true"
> +'

You would also need to see how

	check core.uppercase
        check core.MIXEDCASE

behave (after moving them out of "core." hierarchy, of course), like
the following checks for case insensitivity of the first token.  The
first and the last token are both supposed to be case insensitive,
no?

> +test_expect_success 'key with case insensitive section header' '
> +	check cores.baz "ball" &&
> +	check Cores.baz "ball" &&
> +	check CORES.baz "ball" &&
> +	check coreS.baz "ball"
> +'
> +
> +test_expect_success 'find value with misspelled key' '
> +	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
> +	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&

Is test_must_fail suffice here?  git_config_get_value() has two
kinds of non-zero return values (one for "error", the other for "not
found").  Shouldn't test-config let the caller tell these two kinds
apart in some way?  It would be reasonable to do so with its exit
status, I would imagine, and in that case, test_expect_code may be
more appropriate here.

> +	test_cmp expect actual

Are you sure the expect and actual should match here?

Oh by the way, in "check()" helper shell function you spelled
the correct answer "expected" but here you use "expect" (like almost
all the other existing tests).  Perhaps s/expected/expect/ while we
fix the helper function?

> +'
> +
> +test_expect_success 'find value with the highest priority' '
> +	check core.baz "hask"
> +'
> +
> +test_expect_success 'find integer value for a key' '
> +	echo 65 >expect &&
> +	test-config get_int lamb.chop >actual &&
> +	test_cmp expect actual
> +'

Perhaps

	check_config () {
		op=$1 key=$2 &&
                shift &&
                shift &&
                printf "%s\n" "$@" >expect &&
                test-config "$op" "$key" >actual &&
		test_cmp expect actual
	}

and use it like so?

	check_config get_value core.mixedcase true
        check_config get_int lamb.chop 65
        check_config get_bool goat.head 1
        check_config get_value_multi core.baz sam bat hask

> +test_expect_success 'find integer if value is non parse-able' '
> +	echo 65 >expect &&
> +	test_must_fail test-config get_int lamb.head >actual &&
> +	test_must_fail test_cmp expect actual

Do not use test_must_fail on anything other than "git" command.
Worse yet, you are not just interested in seeing expect and actual
differ.  When get_int finds something that is not an integer, you do
not just expect the output from the command to be any random string
that is not the correct answer.  You expect it to be empty, no?

	>expect &&
	test_expect_code 1 test-config get_int lamb.head >actual &&
        test_cmp expect actual

or something (assuming that you chose to exit with 1 when you get an
error, but I didn't check).

Extending the check_config helper a bit more, perhaps

	check_config () {
		case "$1" in
                fail)
			>expect &&
                        test_expect_code 1 test-config "$2" "$3" >actual
                	;;
		*)
                	op=$1 key=$2 &&
                        shift &&
                        shift &&
	                printf "%s\n" "$@" >expect &&
	                test-config "$op" "$key" >actual
			;;
		esac &&
                test_cmp expect actual
	}

or something like that?

> diff --git a/test-config.c b/test-config.c
> new file mode 100644
> index 0000000..dc313c2
> --- /dev/null
> +++ b/test-config.c
> @@ -0,0 +1,125 @@
> +#include "cache.h"
> +#include "string-list.h"
> +
> +/*
> + * This program exposes the C API of the configuration mechanism
> + * as a set of simple commands in order to facilitate testing.
> + *
> + * Reads stdin and prints result of command to stdout:
> + *
> + * get_value -> prints the value with highest priority for the entered key
> + *
> + * get_value_multi -> prints all values for the entered key in increasing order
> + *		     of priority
> + *
> + * get_int -> print integer value for the entered key or die
> + *
> + * get_bool -> print bool value for the entered key or die
> + *
> + * configset_get_value -> returns value with the highest priority for the entered key
> + * 			from a config_set constructed from files entered as arguments.
> + *
> + * configset_get_value_multi -> returns value_list for the entered key sorted in
> + * 				ascending order of priority from a config_set
> + * 				constructed from files entered as arguments.
> + *
> + * Examples:
> + *
> + * To print the value with highest priority for key "foo.bAr Baz.rock":
> + * 	test-config get_value "foo.bAr Baz.rock"
> + *
> + */
> +
> +
> +int main(int argc, char **argv)
> +{
> +	int i, val;
> +	const char *v;
> +	const struct string_list *strptr;
> +	struct config_set cs;
> +	git_configset_init(&cs);
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "Please, provide a command name on the command-line\n");
> +		return 1;
> +	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
> +		if (!git_config_get_value(argv[2], &v)) {
> +			if (!v)
> +				printf("(NULL)\n");

This one is dubious.  Is this for things like

	(in .git/config)
	[receive]
        	fsckobjects

and asking with

	$ git config receive.fsckobjects

which I think gives an empty string?  We may want to be consistent.

> +			else
> +				printf("%s\n", v);
> +			return 0;
> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return 1;

So "not found" is signalled with exit code 1.  die() coming from
other errors will give us something like 128, and you exit with 2
when add-file fails (below), so the caller indeed can tell these
cases apart.

The tests that use test_must_fail in your test scripts should be
updated to use test_expect_code then.

> +		}
> +	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
> +...
> +	}
> +
> +	fprintf(stderr, "%s: Please check the syntax and the function name\n", argv[0]);
> +	return 1;

This is an error of different kind, no?  Use a different exit code
for it.  Instead of fprintf/return, using die() is fine here.

> +}
