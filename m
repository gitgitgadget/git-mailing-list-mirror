Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57389C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 23:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383266AbiDTXn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiDTXnz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 19:43:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882742ED6B
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 16:41:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8ED1188982;
        Wed, 20 Apr 2022 19:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uL+XHKYGtKLFPGHd2G5TNdeRii2OteLSRLJb7t
        5dUIU=; b=Cw32+6e17FdFOsxZO6oNGmITN7MRyn8APGhXqsGjAa6C0ma6wPgypL
        PkbBRmRpZ/KM7dgJLknz0v0qyR2whoTyIdeFB3DAG0NEh6beiW4imLf129g2bL2D
        Y9Lu2da9IwyubYewSwosVWr/hn8KPKunZzJHW/MpWpiK4dCWBo5nw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E08C3188980;
        Wed, 20 Apr 2022 19:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B6B418897D;
        Wed, 20 Apr 2022 19:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 23/28] fsmonitor: never set CE_FSMONITOR_VALID on
 submodules
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <5db241f7d2f654d46d4858ce9e9413032705abf3.1650487399.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 16:41:02 -0700
In-Reply-To: <5db241f7d2f654d46d4858ce9e9413032705abf3.1650487399.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 20 Apr 2022
        20:43:13 +0000")
Message-ID: <xmqqv8v3l3w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5740F43E-C103-11EC-8E25-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +create_super () {
> +	super=$1 &&
> +
> +	git init "${super}" &&

It is not wrong per-se, but a simple reference to a shell variable
without magic interpolation like ${parameter-word} is easier to read
without {} around the variable name, i.e.

	git init "$super"

an exception of course is when you want to suffix its value with
alnum, i.e.

	for d in "$super" "${super}1" "$super"2
	do
		...

and writing it as "${super}1" would probably be easier to see what
is going on than "$super"2 notation.

> +	echo x >${super}/file_1 &&
> +	echo y >${super}/file_2 &&
> +	echo z >${super}/file_3 &&

CodingGuidelines still says that these redirection targets with
variable interpolation must be enclosed in double-quotes, i.e.

	echo x >"$super/file_1" &&

> +	mkdir ${super}/dir_1 &&

The double quotes around "${super}" we saw on "git init" indicates
that the helper function wants to be prepared to handle a directory
path with possibly $IFS whitespace characters in it correctly, so
let's make sure we are consistently prepared for such a parameter,
i.e.

	mkdir "$super/dir_1" &&

The same applies to the rest of the script.

Thanks.
