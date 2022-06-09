Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED440C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 23:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiFIX4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 19:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFIXz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 19:55:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0EC220EA
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 16:55:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31ADD19B547;
        Thu,  9 Jun 2022 19:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0AImTkOefTejtGQoN826U86CgNzGyGRutM3hizAGVoQ=; b=MR2o
        72px0ISssuapUuzHioH9jgjet/fGfM9gv9tLTsxE320uSTzJnDKVDnNJ6x6UAOVi
        TGu6YVqAA4ZtzVgJuB4fsIgbNA7WVld/Ic+JDRq0bu3KqQstP7xIf4Yur6zeHt+D
        6jn0IE4RZQzYNv8FDgaCVfTRmDIsRFh47IuQuik=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2995519B546;
        Thu,  9 Jun 2022 19:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1803319B544;
        Thu,  9 Jun 2022 19:55:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v2] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
        <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 16:55:50 -0700
Message-ID: <xmqqilp9gznd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B197129C-E84F-11EC-A36E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Li Linchao <lilinchao@oschina.cn>
>
> Git server end's ability to accept Accept-Language header was introduced
> in f18604bbf2(http: add Accept-Language header if possible), but this is

Pleaes refer to the commit like so:

    f18604bb (http: add Accept-Language header if possible, 2015-01-28)

(cf. Documentation/SubmittingPatches::commit-reference)

"git show -s --pretty=reference f18604bb" is one way to format a
commit name in that format.

> only used by very early phase of the transfer, that's HTTP GET request to

"that's" -> "which is", probably.

> discover references. For other phases, like POST request in the smart HTTP
> the server side don't know what language the client speaks.

"HTTP the server side don't" -> "HTTP, the server does not" 

>  http.c                      |  4 ++--
>  http.h                      |  3 +++
>  remote-curl.c               | 16 ++++++++++++++++
>  t/t5541-http-push-smart.sh  | 19 +++++++++++++++++++
>  t/t5550-http-fetch-dumb.sh  | 10 +++++-----
>  t/t5551-http-fetch-smart.sh | 10 ++++++++--
>  6 files changed, 53 insertions(+), 9 deletions(-)

What is curious is that without any of changes to the *.[ch] files,
updated test 5550 and 5551 pass already.

In other words, these updated tests in 5550 and 5551 probably are
not testing the behaviour the updated code intends to show.  Of
course, if we revert the code that taught the Accept-Language to the
GET requests in f18604bb, these tests will fail.  There is no reason
to touch these two tests to "prove" that the code change in this
patch does not break existing support, either.

> diff --git a/http.h b/http.h
> index ba303cfb372..3c94c479100 100644
> --- a/http.h
> +++ b/http.h
> @@ -178,6 +178,9 @@ int http_fetch_ref(const char *base, struct ref *ref);
>  int http_get_info_packs(const char *base_url,
>  			struct packed_git **packs_head);
>  
> +/* Helper for getting Accept-Language header */
> +const char *http_get_accept_language_header(void);

OK.

> @@ -932,6 +933,10 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
>  	headers = curl_slist_append(headers, needs_100_continue ?
>  		"Expect: 100-continue" : "Expect:");
>  
> +	/* Add Accept-Language header */
> +	if (rpc->hdr_accept_language)
> +		headers = curl_slist_append(headers, rpc->hdr_accept_language);

curl_slist_append() makes a copy of .hdr_accept_language, so rpc
struct is still responsible to release the resource used for the
member when it goes out of scope.

> +	accept_language = http_get_accept_language_header();
> +	if (accept_language) {
> +		strbuf_addstr(&buf, accept_language);
> +		rpc->hdr_accept_language = strbuf_detach(&buf, NULL);

That looks like a roundabout way to say xstrdup().  The whole thing
can be done like so:

	rpc->hdr_accept_language = xstrdup_or_null(http_get_accept_language_header());

And by doing so we kill another bug.  "struct rpc" is allocated on
the stack without any initialization, so the new code leaves the
hdr_accept_language member uninitialized.  Rather, we want to
explicitly set NULL to the member when the new header is not in use.

> +	}
> +

The memory ownership model for this new .hdr_accept_language member
in the RPC struct seems to be that the struct owns the resource of
the member.

>  	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
>  	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
>  
> @@ -1400,6 +1412,7 @@ static int stateless_connect(const char *service_name)
>  	struct discovery *discover;
>  	struct rpc_state rpc;
>  	struct strbuf buf = STRBUF_INIT;
> +	const char *accept_language;
>  
>  	/*
>  	 * Run the info/refs request and see if the server supports protocol
> @@ -1418,6 +1431,9 @@ static int stateless_connect(const char *service_name)
>  		printf("\n");
>  		fflush(stdout);
>  	}
> +	accept_language = http_get_accept_language_header();
> +	if (accept_language)
> +		rpc.hdr_accept_language = xstrfmt("%s", accept_language);

And this is in line with that memory ownership model.

>  	rpc.service_name = service_name;
>  	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);

I however do not see anybody that actually freeing when rpc is
done.

Are we adding a new memory leak?  Shouldn't we be releasing the
resources held in rpc.hdr_accept_language when rpc goes out of
scope?

> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 2f09ff4fac6..4288a279e9e 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -80,6 +80,25 @@ test_expect_success 'push to remote repository (standard)' '
>  	 test $HEAD = $(git rev-parse --verify HEAD))
>  '
>  
> +test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
> +	cat >exp <<-\EOF &&
> +	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
> +	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
> +	EOF

As I already asked, do we need to use a language code that has never
been used in our existing test to test this new codepath, or is it
sufficient to reuse what we already know that will not cause problems
in developers' testing environment, like those used in other
existing tests, like ko_KR, en_US, etc.  If the latter, I strongly
do not want to see a new language added to the test.  We are *not*
in the business of testing the system locale support on the user's
platform.

> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	: >path_lang &&
> +	git add path_lang &&
> +	test_tick &&
> +	git commit -m path_lang &&
> +	HEAD=$(git rev-parse --verify HEAD) &&
> +	GIT_TRACE_CURL=true LANGUAGE="zh_CN:en" git push -v -v 2>err &&

If this test, or existing tests in other scripts, do not actually
require the LANGUAGE specified in the environment variable to be
"installed" on the user's platform, then it might be an acceptable
alternative to use a locale (like "tlh_AQ") that is implausible to
exist on the user's system, but using what we already use in other
tests would be the safest thing to do.

Use ko_KR.UTF8 (and nothing else) like 5550 does with its first use
of check_language helper.  Or using en_US is also fine, as that is
also used over there.

> +	! grep "Expect: 100-continue" err &&
> +
> +	grep "=> Send header: Accept-Language:" err >err.language &&
> +	test_cmp exp err.language
> +'
> +
>  test_expect_success 'push already up-to-date' '
>  	git push
>  '

As I already said, I do not think changes to the following two tests
are warranted.

> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh


Thanks.
