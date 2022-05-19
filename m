Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304CC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiESSoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiESSo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:44:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB35C856
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:44:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A853D11B6CB;
        Thu, 19 May 2022 14:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=54SGIzdqgHClEpYyCW3xHL3kfYh8GebtxYa7Q9
        W+U+k=; b=SS0ns0BbyLdAluWvMR9Od7D6G4V638+1fWeJuWMh1wB9xfPjja/3Xv
        K+2ZlDkkh80IgD/a+RQOJOnW1BTEba8tzMh4Sy1SoyMnPsUxHh/9fqXLnhDUM6H+
        giKpbZ2yxDslkan3VUqcRLGMdI5QpbhQdlitH5qaUFGXSrjUDmXpQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A06E411B6CA;
        Thu, 19 May 2022 14:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FB2A11B6C9;
        Thu, 19 May 2022 14:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/7] archive --add-file-with-contents: allow paths
 containing colons
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com>
        <xmqqmtfp6ohc.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205192004490.352@tvgsbejvaqbjf.bet>
Date:   Thu, 19 May 2022 11:44:24 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205192004490.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 19 May 2022 20:09:40 +0200 (CEST)")
Message-ID: <xmqqh75lnz07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B52B8B8E-D7A3-11EC-9577-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >  	git archive --format=zip >with_file_with_content.zip \
>> > +		--add-file-with-content=\"$QUOTED\": \
>> >  		--add-file-with-content=hello:world $EMPTY_TREE &&
>> >  	test_when_finished "rm -rf tmp-unpack" &&
>> >  	mkdir tmp-unpack && (
>> >  		cd tmp-unpack &&
>> >  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>> >  		test_path_is_file hello &&
>> > +		test_path_is_file $QUOTED &&
>>
>> Looks OK, even though it probably is a good idea to have dq around
>> $QUOTED, so that future developers can easily insert SP into its
>> value to use a bit more common but still a bit more problematic
>> pathnames in the test.
>
> I actually decided against this because reading
>
> 	"$QUOTED"
>
> would mislead future me to think that the double quotes that enclose
> $QUOTED are the quotes that the variable's name talks about. But the
> quotes are actually the escaped ones that are passed to `git archive`
> above.

>
> So, to help future Dscho should they read this code six months from now or
> even later, I wanted to specifically only add quotes to the `git archive`
> call to make the intention abundantly clear.

If you find "$QUOTED" misleads any reader to think QUOTED may have
some quote characters in there, you could rename it, of course, to
signal what the value is (e.g. $PATHNAME) better.

But I think you misunderstood my comment completely.

What I meant was to write these lines like:

	--add-file-with-content=\""$QUOTED"\":
	test_path_is_file "$QUOTED"

Because the value in QUOTED can have $IFS whitespaces in it (after
all, allowing random letters like colon, quotes and whitespaces is
why we are adding this unquote_c_style() call), and without the
extra double quotes to protect the parameter expansion of $QUOTED,
the command line is broken.

So, don't decide against it; the reasoning behind that decision is
simply wrong.

Thanks.

