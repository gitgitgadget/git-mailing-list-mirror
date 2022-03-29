Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFDC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 15:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiC2QBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbiC2QBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:01:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62581DA73
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 08:59:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60D0619A5F7;
        Tue, 29 Mar 2022 11:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GiLOtE6DIkuPQEqtpg0eOcUscH64n9qX1mNEbP
        AW8hs=; b=AK+fDsqNayBcYnAdLtnxSOVTPt9waRKBGlzISqnTR5sz4jj5qooWOF
        AbG8Q5/Y7Zfe/KUlWxHlg1wN7I4F510UGqfMUCsRQaQBF4fPQj5TMrDcCPxZK7wE
        zXRhThuKygEavbfiwF/elWtE0dRxtIS1s/YJOFjNf9asrJIxEMKXQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5982419A5F6;
        Tue, 29 Mar 2022 11:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9BED19A5F5;
        Tue, 29 Mar 2022 11:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        tytso@mit.edu, derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
References: <cover.1646266835.git.me@ttaylorr.com>
        <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
        <YiZI99yeijQe5Jaq@google.com> <YjkjaH61dMLHXr0d@nand.local>
        <YjpDbHmKY9XA2p0K@google.com> <YjpHbaBspUasDdEy@nand.local>
        <YjpWFZ95OL7joFa4@google.com> <Yjpxd8qhwnAIJJma@nand.local>
        <YkICkpttOujOKeT3@nand.local> <xmqq8rst23w0.fsf@gitster.g>
        <YkIm7lnQsUT0JnvS@nand.local>
Date:   Tue, 29 Mar 2022 08:59:24 -0700
In-Reply-To: <YkIm7lnQsUT0JnvS@nand.local> (Taylor Blau's message of "Mon, 28
        Mar 2022 17:21:50 -0400")
Message-ID: <xmqqa6d8yckj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 350F7250-AF79-11EC-B446-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I'm not sure... if we did:
>
> --- 8< ---
>
> diff --git a/setup.c b/setup.c
> index 04ce33cdcd..fa54c9baa4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -565,2 +565,4 @@ static enum extension_result handle_extension(const char *var,
>  		return EXTENSION_OK;
> +	} else if (!strcmp(ext, "cruftpacks")) {
> +		return EXTENSION_OK;
>  	}
>
> --- >8 ---
>
> but nothing more, then a hypothetical `extensions.cruftPacks` could be
> used to prevent older writers in a mixed version environment. But if you
> don't have or care about older versions of Git, you can avoid setting it
> altogether.

Smells like "unsafe by default, but you can opt into safety", which
is backwards, isn't it?

>> I do not quite see how it helps.  After hearing "... will lose
>> information about the mtimes ...", what concrete action can a user
>> take?  Or a sys-admin?
>>
>> It's not like use of cruft-pack is mandatory when you upgrade the
>> new version of Git, right?  Perhaps use of cruft-pack should be
>> guarded behind a configuration variable so that users who might want
>> to use mixed versions of Git will be protected against accidental
>> use of new version of Git that introduces the forever-renewing
>> untracked objects problem?
>
> I don't think we would have much to offer a user in that case; if the
> mtimes are gone, then I couldn't think of anything to bring them back
> outside of setting them manually.

Yes, so rambling about losing mtimes in documentation or release
notes would not help users all that much.  Let's not do that.

> But cruft packs are already guarded in two places:
>
>   - `git repack` won't write a cruft pack unless given the `--cruft`
>     flag (i.e., `git repack -A` doesn't suddenly start generating cruft
>     packs upon upgrade).
>
>   - `git gc` won't write cruft packs unless the `gc.cruftPacks`
>     configuration is set, or `--cruft` is given as a flag.

Hmph, OK.  So individuals can sort-of protect from hurting
themselves by refraining from running these with --cruft or writing
--cruft in their maintenance scripts.  An organization that wants to
let the more adventurous types to early opt-in can prepare two
versions of the maintenance scripts they distribute to their users,
one with and the other without --cruft, and use the mechanism they
use for gradual rollouts to control the population.  Perhaps that
would make sufficient protection?  I dunno.

Jonathan, what do you think?

> I'd be curious what Jonathan and others think of that approach (which,
> to be clear, is what this series already implements). We could make it
> clear to say:
>
>     If you have mixed versions of Git which both repack a repository
>     (either manually or by auto-GC / background maintenance), consider
>     leaving `gc.cruftPacks` unset and avoiding passing `--cruft` as a
>     command-line argument to `git repack` and `git gc`, since doing so
>     can lead to [...]

That message is (depending on what comes in [...]) much more helpful
than just throwing a word "mtime" out and letting the reader figure
out the rest ;-)
