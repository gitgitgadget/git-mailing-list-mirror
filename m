Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E7EC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 21:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbiD3VVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiD3VVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 17:21:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CF46E4DF
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 14:17:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C98F6196D37;
        Sat, 30 Apr 2022 17:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9jQon+XmJ8czmomfSnGQJSOK8oibEnwWH43HGg
        Tk++k=; b=ZpwIJu5wbf1aP6FSztc+w1fQL7h9G+7ehK7XVFXQsJp1uHuy0WdcWr
        SZJTNq4o/Ralr8+ytSVFV1B+NCRhqG05RoKA6yUFioanerkrf9q73Z08q1IO++PE
        9UV7TkhJuT5unrLVPoE7kVARF167A+moxCuuGCBKWMUd2LfeAXwOo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0C83196D36;
        Sat, 30 Apr 2022 17:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 725A4196D32;
        Sat, 30 Apr 2022 17:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
References: <pull.1227.git.1651324796892.gitgitgadget@gmail.com>
Date:   Sat, 30 Apr 2022 14:17:46 -0700
In-Reply-To: <pull.1227.git.1651324796892.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Sat, 30 Apr 2022 13:19:56
        +0000")
Message-ID: <xmqqczgy6zk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBC8CF1C-C8CA-11EC-A0A4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  	if (remote->url_nr > 0) {
> +		struct strbuf promisor_config = STRBUF_INIT;
> +		const char *partial_clone_filter = NULL;
> +
> +		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
>  		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
> +		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
> +			strbuf_addf(&url_buf, " [%s]", partial_clone_filter);
> +
> +		strbuf_release(&promisor_config);
>  		string_list_append(list, remote->name)->util =
>  				strbuf_detach(&url_buf, NULL);

Three comments and a half on the code:

 - Is it likely that to new readers it would be obvious that what is
   in the [square brackets] is the list-objects-filter used?  When we
   want to add new kinds of information other than the URL and the
   list-objects-filter, what is our plan to add them?

 - The presentation order is <remote-name> then <direction> (fetch
   or push) and then optionally <list-objects-filter>.

   (a) shouldn't the output format be described in the
       doucmentation?

   (b) does it make sense to append new information like this, or
       is it more logical to keep the <direction> at the end?

 - Now url_buf no longer contains the url of the remote, but it still
   is called url_buf.  It is merely a "temporary string" now.  Is it
   a good idea to either rename it, stop reusing the same thing for
   different purposes, or do something else?

 - By adding this unconditionally, we would break the scripts that
   read the output from this command and expect there won't be extra
   information after the <direction>.  It may be a good thing (they
   are not prepared to see the list-objects-filter, and the breakage
   may serve as a reminder that they need to update these scripts
   when they see breakage), or it may be an irritating regression.

But stepping back a bit.

Why do we want to give this in the "remote -v" output in the first
place?  When a reader really cares, they can ask "git config" for
this extra piece of information.  When you have more than one
remote, "git remote -v" that gives the URL is a good way to remind
which nickname you'd want to give to "git pull" or "git push".  If
it makes sense to add the extra <list-objects-filtrer> information,
that would mean that there are probably two remote nicknames that
refer to the same URL (i.e. "remote -v" readers cannot tell them
apart without extra information), but how likely is that, I wonder?

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
> +
>  test_expect_success 'verify that .promisor file contains refs fetched' '
>  	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
>  	test_line_count = 1 promisorlist &&
>
> base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
