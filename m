Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F49C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 17:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349621AbiEDRvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 13:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376257AbiEDRuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 13:50:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559834BB87
        for <git@vger.kernel.org>; Wed,  4 May 2022 10:10:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D93A81982B8;
        Wed,  4 May 2022 13:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e2JXCw0PjfPHv3Y8rvqk8S7kIzMBqLV8bFASaK
        P5sgU=; b=ku205HgMQtFLPKV5V7iKRmMZO/3n5bdOEEx4NR9R+KQ/p7paH6SHV4
        50n/PivvKlkkJT0eO8SO0I7bAmFRwpxukucAGqzC68vAIjajKtAyC4pC16/FvoJt
        OZjVGoysOKGwL1DokyvCXETEzl4dUdsLBzFdKfJJJS8RRxMfd4BTY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0CBD1982B7;
        Wed,  4 May 2022 13:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E8981982B4;
        Wed,  4 May 2022 13:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
References: <pull.1227.git.1651324796892.gitgitgadget@gmail.com>
        <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 10:10:26 -0700
In-Reply-To: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
        (Abhradeep Chakraborty via GitGitGadget's message of "Tue, 03 May 2022
        15:20:53 +0000")
Message-ID: <xmqqr159mdfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 180EEEB8-CBCD-11EC-90B1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index cde9614e362..71a0e85990d 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -35,6 +35,9 @@ OPTIONS
>  -v::
>  --verbose::
>  	Be a little more verbose and show remote url after name.
> +  For promisor remotes it will show an extra information
> +  (wrapped in square brackets) describing which filter
> +  (`blob:none` etc.) that promisor remote use.
>  	NOTE: This must be placed between `remote` and subcommand.

Broken indentation.  You can save embarrassment by double checking
what you committed by sending e-mail to yourself (or checking output
from "git show") before sending it to the list.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5f4cde9d784..d4b69fe7789 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1185,14 +1185,22 @@ static int show_push_info_item(struct string_list_item *item, void *cb_data)
>  static int get_one_entry(struct remote *remote, void *priv)
>  {
>  	struct string_list *list = priv;
> -	struct strbuf url_buf = STRBUF_INIT;
> +	struct strbuf remote_info_buf = STRBUF_INIT;
>  	const char **url;
>  	int i, url_nr;
>  
>  	if (remote->url_nr > 0) {
> -		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
> +		struct strbuf promisor_config = STRBUF_INIT;
> +		const char *partial_clone_filter = NULL;
> +
> +		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
> +		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url[0]);
> +		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
> +			strbuf_addf(&remote_info_buf, " [%s]", partial_clone_filter);
> +
> +		strbuf_release(&promisor_config);
>  		string_list_append(list, remote->name)->util =
> -				strbuf_detach(&url_buf, NULL);
> +				strbuf_detach(&remote_info_buf, NULL);

It is unfortunate that the "we borrow without copying" variant of
git_config_get_string() is called git_config_get_string_tmp(), which
is an utterly misleading name that might confuse readers into
mistaking it may make a temporary copy for the caller to release.
Perhaps we would want to rename it to git_config_peek_string() or
something, but that is totally outside the topic, of course.

In any case, what I wanted to say is that I just made sure that the
value in the partial_clone_filter variable is not leaked.

Looking good.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 4a3778d04a8..bf8f3644d3c 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -49,6 +49,17 @@ test_expect_success 'do partial clone 1' '
>  	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
>  '
>  
> +test_expect_success 'filters for promisor remotes is listed by git remote -v' '
> +	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
> +	git -C pc2 remote -v >out &&
> +	grep "[blob:none]" out &&
> +
> +	git -C pc2 config remote.origin.partialCloneFilter object:type=commit &&
> +	git -C pc2 remote -v >out &&
> +	grep "[object:type=commit]" out &&
> +	rm -rf pc2
> +'

I doubt that these "grep" do what you think it is doing.  It would
say "I am happy" on any line that has one of these characters listed
inside the [].

Do not clean up with an extra "&& clean up" step at the end of
&&-cascade.  Instead use test_when_finished to make sure that after
any failure in the cascade the clean-up step would still trigger.

	test_expect_success 'title' '
		test_when_finished "rm -fr pc2" &&
		git clone ... &&
		...
		grep "srv.bare (fetch) \[object:type=commit\]" out
	'

or something.

Having tests that show how this new feature works is of course
necessary, but we must have negative tests that ensure that it does
*not* trigger when it should not.  E.g. the new [filter-spec] should
not be given for a remote if the user didn't ask for "-v", or the
remote is not a promisor.

Thanks.

