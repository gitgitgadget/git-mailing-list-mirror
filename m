Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C9C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHJVfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJVfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:35:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63FC1B7B4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:35:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 642511B64C2;
        Wed, 10 Aug 2022 17:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7gDqXr2RW3PHeo+i6Qkc0jhAhAVSgOhyqOh1O1
        Op3RQ=; b=PkEmKfZOtEu8weALwOmEfeCz4er7rjJJ4c6Cc7eGjJKoFMNWSN9ibf
        +cBhAnKnLW7tpUIeU9MImUqYNjdVlm8Ru93EL549Az60/SbxkUfEGv8whou2nCL2
        iPjLhkp52oUjKf6L8ZvXut+X0LjLXxuaAJsdaNijDfq119vMxgfSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CB181B64C1;
        Wed, 10 Aug 2022 17:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 043521B64B8;
        Wed, 10 Aug 2022 17:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] fsck: actually detect bad file modes in trees
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
        <YvQc9egGzwFomQbw@coredump.intra.peff.net>
Date:   Wed, 10 Aug 2022 14:35:32 -0700
In-Reply-To: <YvQc9egGzwFomQbw@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Aug 2022 17:02:45 -0400")
Message-ID: <xmqq4jyjkcij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DA1BA5E-18F4-11ED-8399-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We use the normal tree_desc code to iterate over trees in fsck, meaning
> we only see the canonicalized modes it returns. And hence we'd never see
> anything unexpected, since it will coerce literally any garbage into one
> of our normal and accepted modes.

Wow.  I did know canon_mode() deliberately discarding the extra
permission bits on trees and blobs, but it was that bad to mark
whatever it does not understand as a gitlink.  That is simply
horrible.

> -	if (init_tree_desc_gently(&desc, buffer, size, 0)) {
> +	if (init_tree_desc_gently(&desc, buffer, size, TREE_DESC_RAW_MODES)) {
>  		retval += report(options, tree_oid, OBJ_TREE,
>  				 FSCK_MSG_BAD_TREE,
>  				 "cannot be parsed as a tree");

OK, so we'll let desc.entry.mode carry whatever bogus bit pattern we
got out of buffer and the downstream code already knows what to do
with them.  That's a clean and minimum way to do this.

Thanks.

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index ab7f31f1dc..53c2aa10b7 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -364,6 +364,20 @@ test_expect_success 'tree entry with type mismatch' '
>  	test_i18ngrep ! "dangling blob" out
>  '
>  
> +test_expect_success 'tree entry with bogus mode' '
> +	test_when_finished "remove_object \$blob" &&
> +	test_when_finished "remove_object \$tree" &&
> +	blob=$(echo blob | git hash-object -w --stdin) &&
> +	blob_oct=$(echo $blob | hex2oct) &&
> +	tree=$(printf "100000 foo\0${blob_oct}" |
> +	       git hash-object -t tree --stdin -w --literally) &&
> +	git fsck 2>err &&
> +	cat >expect <<-EOF &&
> +	warning in tree $tree: badFilemode: contains bad file modes
> +	EOF
> +	test_cmp expect err
> +'
> +
>  test_expect_success 'tag pointing to nonexistent' '
>  	badoid=$(test_oid deadbeef) &&
>  	cat >invalid-tag <<-EOF &&
