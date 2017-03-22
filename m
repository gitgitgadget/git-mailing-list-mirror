Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110CC20323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbdCVV0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:26:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65419 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751309AbdCVV0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:26:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 712657C888;
        Wed, 22 Mar 2017 17:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/et0dq9w9sBJu6DTlF/bxugeYhM=; b=O78CMW
        NbUzr4FytPLMP6gAmD6PvvHUcgabth8uxD7yeSRNNiCeV6wxuTwDT5DR9D0/H85+
        PwsIqEZlt4/dvU8S23pVsMjBZqjEQi6PhNBd2ZJdYinpTJGTdSe6KYz6fVCDpX9E
        8X5/bPTdhRAwdxCdrfdqWFZGTtRz1PG8L+HkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rsrmDUmamSZZMYXR7ZECCSEiM2lXrKlK
        9AmfcsX+Fb9irLaNoS4PYnNI0bg4hLdtjrOVXYmZZuUT9erQN1HQuTUjsh0o37ym
        J5pOYcICeBNeMi9GGL4ARv5hGfM2xrXmWTB/sJG4fEhrnkJdsk8w3RxzOh4IbuRy
        WBj1Za5yyZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69F0D7C887;
        Wed, 22 Mar 2017 17:26:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF8647C886;
        Wed, 22 Mar 2017 17:26:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl: allow push options
References: <20170322195102.165314-1-bmwill@google.com>
        <20170322195102.165314-3-bmwill@google.com>
Date:   Wed, 22 Mar 2017 14:26:04 -0700
In-Reply-To: <20170322195102.165314-3-bmwill@google.com> (Brandon Williams's
        message of "Wed, 22 Mar 2017 12:51:02 -0700")
Message-ID: <xmqqo9wthukz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28665D3A-0F46-11E7-B63C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Teach remote-curl to understand push options and to be able to convey
> them across HTTP.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

An earlier 438fc684 ("push options: pass push options to the
transport helper", 2017-02-08) said:

    ...
    Fix this by propagating the push options to the transport helper.

    This is only addressing the first issue of
       (1) the helper protocol does not propagate push-option
       (2) the http helper is not prepared to handle push-option

    Once we fix (2), the http transport helper can make use of push options
    as well, but that happens as a follow up. (1) is a bug fix, whereas (2)
    is a feature, which is why we only do (1) here.

and this is the step (2) to complete what it started?

>  builtin/send-pack.c     |  5 +++++
>  remote-curl.c           |  8 ++++++++
>  t/t5545-push-options.sh | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 1ff5a6753..6796f3368 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -152,6 +152,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	int progress = -1;
>  	int from_stdin = 0;
>  	struct push_cas_option cas = {0};
> +	struct string_list push_options = STRING_LIST_INIT_DUP;
>  
>  	struct option options[] = {
>  		OPT__VERBOSITY(&verbose),
> @@ -171,6 +172,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
>  		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
>  		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
> +		OPT_STRING_LIST('o', "push-option", &push_options,
> +				N_("server-specific"),
> +				N_("option to transmit")),
>  		{ OPTION_CALLBACK,
>  		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>  		  N_("require old value of ref to be at this value"),
> @@ -199,6 +203,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	args.use_thin_pack = use_thin_pack;
>  	args.atomic = atomic;
>  	args.stateless_rpc = stateless_rpc;
> +	args.push_options = push_options.nr ? &push_options : NULL;
>  
>  	if (from_stdin) {
>  		struct argv_array all_refspecs = ARGV_ARRAY_INIT;
> diff --git a/remote-curl.c b/remote-curl.c
> index 34a97e732..e953d06f6 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -22,6 +22,7 @@ struct options {
>  	unsigned long depth;
>  	char *deepen_since;
>  	struct string_list deepen_not;
> +	struct string_list push_options;
>  	unsigned progress : 1,
>  		check_self_contained_and_connected : 1,
>  		cloning : 1,
> @@ -139,6 +140,9 @@ static int set_option(const char *name, const char *value)
>  		else
>  			return -1;
>  		return 0;
> +	} else if (!strcmp(name, "push-option")) {
> +		string_list_append(&options.push_options, value);
> +		return 0;
>  
>  #if LIBCURL_VERSION_NUM >= 0x070a08
>  	} else if (!strcmp(name, "family")) {
> @@ -943,6 +947,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
>  		argv_array_push(&args, "--quiet");
>  	else if (options.verbosity > 1)
>  		argv_array_push(&args, "--verbose");
> +	for (i = 0; i < options.push_options.nr; i++)
> +		argv_array_pushf(&args, "--push-option=%s",
> +				 options.push_options.items[i].string);
>  	argv_array_push(&args, options.progress ? "--progress" : "--no-progress");
>  	for_each_string_list_item(cas_option, &cas_options)
>  		argv_array_push(&args, cas_option->string);
> @@ -1028,6 +1035,7 @@ int cmd_main(int argc, const char **argv)
>  	options.progress = !!isatty(2);
>  	options.thin = 1;
>  	string_list_init(&options.deepen_not, 1);
> +	string_list_init(&options.push_options, 1);
>  
>  	remote = remote_get(argv[1]);
>  
> diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
> index 9a57a7d8f..ac62083e9 100755
> --- a/t/t5545-push-options.sh
> +++ b/t/t5545-push-options.sh
> @@ -102,7 +102,9 @@ test_expect_success 'two push options work' '
>  	test_cmp expect upstream/.git/hooks/post-receive.push_options
>  '
>  
> -test_expect_success 'push option denied properly by http remote helper' '\
> +test_expect_success 'push option denied properly by http server' '
> +	test_when_finished "rm -rf test_http_clone" &&
> +	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
>  	mk_repo_pair &&
>  	git -C upstream config receive.advertisePushOptions false &&
>  	git -C upstream config http.receivepack true &&
> @@ -113,6 +115,32 @@ test_expect_success 'push option denied properly by http remote helper' '\
>  	git -C test_http_clone push origin master
>  '
>  
> +test_expect_success 'push options work properly across http' '
> +	test_when_finished "rm -rf test_http_clone" &&
> +	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
> +	mk_repo_pair &&
> +	git -C upstream config receive.advertisePushOptions true &&
> +	git -C upstream config http.receivepack true &&
> +	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
> +	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
> +
> +	test_commit -C test_http_clone one &&
> +	git -C test_http_clone push origin master &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
> +	git -C test_http_clone rev-parse --verify master >actual &&
> +	test_cmp expect actual &&
> +
> +	test_commit -C test_http_clone two &&
> +	git -C test_http_clone push --push-option=asdf --push-option="more structured text" origin master &&
> +	printf "asdf\nmore structured text\n" >expect &&
> +	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options &&
> +	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/post-receive.push_options &&
> +
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
> +	git -C test_http_clone rev-parse --verify master >actual &&
> +	test_cmp expect actual
> +'
> +
>  stop_httpd
>  
>  test_done
