Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813EC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 07:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbjEOHDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbjEOHCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 03:02:55 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 00:02:44 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB610FA
        for <git@vger.kernel.org>; Mon, 15 May 2023 00:02:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34ECC1F19F4;
        Mon, 15 May 2023 03:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HV3djz4MjH9BvaVI3tx6a82zNpYtsdI+7PEgIUU4kPQ=; b=mfup
        FH1uJCHE5gWokHs9fsOtbDCGhwbrS8tccnBh0cqZ6AN0VfJWEWJ6SweLdIUz4kG5
        SdJutObJlH/eFWyWZ26miUKGaSyoFHrSrd7DMChj97JUxT18FaptFRlQQw87pqOS
        VTMmCdWICix9NRoKDVQrDadxtH19M8Zw3pqmWoI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E7C21F19EF;
        Mon, 15 May 2023 03:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DB851F19D8;
        Mon, 15 May 2023 03:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/3] t/t7004-tag: add failing tag message file test
References: <cover.1684067644.git.code@khaugsbakk.name>
        <1f24aa43f70b16381ef0cfb4f1d482706161554d.1684067644.git.code@khaugsbakk.name>
Date:   Mon, 15 May 2023 00:02:39 -0700
Message-ID: <xmqq4joeaxgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B462728-F2EE-11ED-A923-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  t/t7004-tag.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Does this document the current behaviour, i.e. before applying the
patch [3/3]?  Or is this a new test designed to fail until [3/3] is
applied?

If the latter, please don't [*].

Instead, combine this with [3/3] and make it [2/2] that changes the
behaviour of the command and protects the new behaviour from future
breakages in a single step.  Those who are truly curious to see why
the code change in it is necessary can apply the "code change plus
new test" patch, and then temporarily revert only the code change
part in their working tree to see how the test breaks without the
code change.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 550b5b1cce..1e512dbe06 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -2136,4 +2136,14 @@ test_expect_success 'If tag is created then tag message file is unlinked' '
>  	! test -e .git/TAG_EDITMSG
>  '
>  
> +test_expect_success 'If tag cannot be created then tag message file is not unlinked' '
> +	test_when_finished "git tag -d foo/bar" &&
> +	write_script fakeeditor <<-\EOF &&
> +	echo Message >.git/TAG_EDITMSG
> +	EOF
> +	git tag foo/bar &&
> +	! GIT_EDITOR=./fakeeditor git tag -a foo &&

Imitate other tests that expect a controlled failure from our
command, and write something like

	test_must_fail env GIT_EDITOR=./fakeeditor git tag -a foo

so that a segfaulting "git tag" will not count as "failing as
expected".

> +	test -e .git/TAG_EDITMSG

Use "test_path_exists" instead.

Thanks.


[Footnote]

 * Introducing this as a failing test "test_expect_failure" in [2/3]
   and then flip it to "test_expect_success" in [3/3] would make
   tests pass without applying [3/3], but generally it is not a
   recommended practice.

   This is because such a [3/3] patch would only show the line with
   the test title and the behaviour of the test will not be shown in
   the diff context.  That hurts reviewability.
