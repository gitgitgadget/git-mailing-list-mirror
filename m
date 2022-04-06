Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85757C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiDFUEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiDFUDo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:03:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8616A2571AE
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 10:56:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94AD912C4AF;
        Wed,  6 Apr 2022 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ve3xwtOKo79c
        /gYoeqfB1AzqL+kD4+tiphNLxreBjfA=; b=VpqAcLNatcaMWpFl3KmYT6ZWcaIP
        LSaINa17ZHEvPnSwbqmBb0dh4WocdAUXCc4ycrmNa8CEp4s8x6cpLTuavkZeU8By
        bySP/W3gveMYFPYmJ8eXGu5EpavvfYbgTB9R71qrb+S+IhaJQp+dbwcZpihB14Ef
        82Cju39bPSAMjy8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C4E212C4AE;
        Wed,  6 Apr 2022 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBB8B12C4AC;
        Wed,  6 Apr 2022 13:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2] ls-tree: fix --long implying -r regression in
 9c4d58ff2c3
References: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
        <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
Date:   Wed, 06 Apr 2022 10:56:15 -0700
In-Reply-To: <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Apr
 2022 01:45:30
        +0200")
Message-ID: <xmqqwng2xfi8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB40BC1A-B5D2-11EC-9F6D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Haing written them I guess we could do them post-release, since the
> important thing is to validate the changes. As noted in the commit
> message we're now testing all combinations of the "mode" and "format"
> options.
>
>  builtin/ls-tree.c         |   2 +-
>  t/t3104-ls-tree-format.sh | 126 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 119 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 5dac9ee5b9d..e279be8bb63 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -255,7 +255,7 @@ static int show_tree_long(const struct object_id *o=
id, struct strbuf *base,
>  	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
>  	       find_unique_abbrev(data.oid, abbrev), size_text);
>  	show_tree_common_default_long(base, pathname, data.base->len);
> -	return 1;
> +	return recurse;
>  }

OK, two people by happenstance wrote the same fix is reassuring ;-)

> +	cat >expect &&
> +	cat <&6 >expect.-d &&
> +	cat <&7 >expect.-r &&
> +	cat <&8 >expect.-t &&

Let's not go too cute like this.  This forces the caller to remember
which among 6, 7, and 8 corresponds to which option.  It is too ugly
to live.

>  test_ls_tree_format \
>  	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
> -	""
> +	"" \
> +	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
> +	040000 tree $(git rev-parse HEAD:dir)	dir
> +	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
> +	OUT
> +	040000 tree $(git rev-parse HEAD:dir)	dir
> +	OUT_D
> +	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
> +	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
> +	OUT_R
> +	040000 tree $(git rev-parse HEAD:dir)	dir
> +	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
> +	OUT_T

I do not actually mind if it were more like this:

	test_ls_tree_format \
		"%(objectmode) %(objecttype) %(objectname)%x09%(path)" <<-EXPECT
	git ls-tree HEAD
	040000 tree $(git rev-parse HEAD:dir)	dir
	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
	git ls-tree -d HEAD
	040000 tree $(git rev-parse HEAD:dir)	dir
	git ls-tree -r HEAD
	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
	git ls-tree -t HEAD
	040000 tree $(git rev-parse HEAD:dir)	dir
	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
	EXPECT

that is, we only read from the standard input, each section begins
with "git ls-tree" command invocation that gets tested, followed by
its expected output, and ends at either the end of the input or the
beginning of the next section.
