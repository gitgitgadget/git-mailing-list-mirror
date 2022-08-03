Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E32EC19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiHCV4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCV4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 17:56:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B46353
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 14:56:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDCBE14D57A;
        Wed,  3 Aug 2022 17:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dyOANKqBs9DIjUJFLRUaCnz63m5FlKvSC0Qftp
        dSvgw=; b=aPbvfaw5OzeTMo8yX86w0VBO3Vy/vS7Dlm9/VYujP35wOtwJKjMot0
        tt3wGcOBHdU1MgLZr6/A+U+Qq18+UxxnmEaUVLxpDRSecZaC+6F7L89tuDLvQCCW
        8y8zwZi3kSNqxNYuKbRfnhexeA90TpfUiUuQMwn9vF6dICOGEmvRo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E5D114D578;
        Wed,  3 Aug 2022 17:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCCEE14D577;
        Wed,  3 Aug 2022 17:56:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] gc: add tests for --cruft and friends
References: <20220803205721.3686361-1-emilyshaffer@google.com>
        <20220803205721.3686361-2-emilyshaffer@google.com>
Date:   Wed, 03 Aug 2022 14:56:04 -0700
In-Reply-To: <20220803205721.3686361-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 3 Aug 2022 13:57:20 -0700")
Message-ID: <xmqqr11x800b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12F86A34-1377-11ED-A59E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> In 5b92477f89 (builtin/gc.c: conditionally avoid pruning objects via
> loose, 2022-05-20) gc learned to respect '--cruft' and 'gc.cruftPacks'.
> '--cruft' is exercised in t5329-pack-objects-cruft.sh, but in a way that
> doesn't check whether a lone gc run generates these cruft packs.
> 'gc.cruftPacks' is never exercised.
>
> Add some tests to exercise these options to gc in the gc test suite.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  t/t6500-gc.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index cd6c53360d..e4c2c3583d 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -202,6 +202,42 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
>  	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
>  '
>  
> +test_expect_success 'gc --cruft generates a cruft pack' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +		test_commit base &&
> +
> +		test_commit --no-tag foo &&
> +		test_commit --no-tag bar &&
> +		git reset HEAD^^ &&
> +
> +		git gc --cruft &&
> +
> +		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&

What guarantees that we will have one pack-*.mtimes?  

I do not mind if we reliably diagnosed it as an error when "git gc
--cruft" created two cruft packs, but I do mind if this call to
basename receives two files plus .mtimes suffix and misbehaves.

Is the fact that it is accompanied by a .mtimes file the only clue
that a pack is a "cruft" pack?  Given that the usefulness of mtimes
based expiration approach is doubted, do we want to rely on it (and
having to redesign the test)?

I think the right test would be to

 * make a list of all "in use" objects;

 * see if there is one (or more) packfile that does not contain any
   "in use" objects (look at their .idx file).

If all packfiles are packs with objects that are still in use, then
we did not create a cruft pack.

> +		test_path_is_file .git/objects/pack/$cruft.pack

DQuote the whole thing, i.e.

		test_path_is_file ".git/objects/pack/$cruft.pack"

