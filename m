From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] test-config: Add tests for the config_set API
Date: Wed, 02 Jul 2014 11:29:16 +0200
Message-ID: <vpqzjgskt1v.fsf@anie.imag.fr>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 11:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Gr9-0001Xg-1b
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 11:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbaGBJ3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 05:29:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42650 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbaGBJ33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 05:29:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s629TFv0000493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jul 2014 11:29:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s629TGbV029622;
	Wed, 2 Jul 2014 11:29:16 +0200
In-Reply-To: <1404280905-26763-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 1 Jul 2014 23:01:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Jul 2014 11:29:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s629TFv0000493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404898157.26894@Ut8iF8TzAtTkmd+RvQ7SFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252773>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'clear default config' '
> +	rm -f .git/config
> +'
> +
> +cat > .git/config << EOF

t/README says:

 - Put all code inside test_expect_success and other assertions.

   Even code that isn't a test per se, but merely some setup code
   should be inside a test assertion.

Even these cat > would better be in a test_expect_success 'initialize
config'.

(Not applied everywhere in Git's code essentially because some tests
were written before the guideline was set and never updated).

> +[core]
> +	penguin = very blue
> +	Movie = BadPhysics
> +	UPPERCASE = true
> +	MixedCase = true
> +	my =
> +	foo
> +	baz = sam
> +[Cores]
> +	WhatEver = Second
> +[my "Foo bAr"]
> +	hi = hello

To really stress the "case sensitive middle part" case, you should also
have other sections like

[my "foo bar"]
	hi = lower-case
[my "FOO BAR"]
	hi = upper-case

and check that you get the right value for my.*.hi

Similarly, I'd add a [CORE] and a [CoRe] section to check that their
content is actually merged with [core].

> +test_expect_success 'get value for a key with value as an empty string' '
> +	echo "" >expect &&
> +	test-config get_value core.my >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get value for a key with value as NULL' '
> +	echo "(NULL)" >expect &&
> +	test-config get_value core.foo >actual &&
> +	test_cmp expect actual
> +'
> +test_expect_success 'upper case key' '

Keep the style consistent, if you separate tests with a single blank
line, do it everywhere.

> +cat > expect << EOF

See above, should be in test_expect_success.

Also, >expect, not > expect.

There are other instances.

> +1
> +0
> +1
> +1
> +1
> +EOF
> +
> +test_expect_success 'find bool value for the entered key' '
> +	test-config get_bool goat.head >>actual &&

The first one should be a single >, or you should clear actual before
the test.

> +int main(int argc, char **argv)
> +{
> +	int i, no_of_files;
> +	int ret = 0;
> +	const char *v;
> +	int val;
> +	const struct string_list *strptr;
> +	struct config_set cs = CONFIG_SET_INIT;



> +	if (argc == 3 && !strcmp(argv[1], "get_value")) {
> +		if (!git_config_get_value(argv[2], &v)) {
> +			if (!v)
> +				printf("(NULL)\n");
> +			else
> +				printf("%s\n", v);
> +			return 0;
> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return -1;
> +		}
> +	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
> +		strptr = git_config_get_value_multi(argv[2]);
> +		if (strptr) {
> +			for (i = 0; i < strptr->nr; i++) {
> +				v = strptr->items[i].string;
> +				if (!v)
> +					printf("(NULL)\n");
> +				else
> +					printf("%s\n", v);
> +			}
> +			return 0;
> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return -1;
> +		}
> +	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
> +		if (!git_config_get_int(argv[2], &val)) {
> +			printf("%d\n", val);
> +			return 0;
> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return -1;
> +		}
> +	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
> +		if (!git_config_get_bool(argv[2], &val)) {
> +			printf("%d\n", val);
> +			return 0;
> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return -1;
> +		}
> +	} else if (!strcmp(argv[1], "configset_get_value")) {
> +		no_of_files = git_config_int("unused", argv[2]);

Why ask the user to give a number of files on the command-line. With a
syntax like

test-config configset_get_value <key> <files>...

you could just use argc to iterate over argv. Here, you trust the user
to provide the right value, and most likely segfault otherwise (and this
is not really documented). I know this is only test code, but why not do
it right anyway ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
