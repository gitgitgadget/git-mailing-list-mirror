Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C074620372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755758AbdJJAQS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:16:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63726 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755566AbdJJAQS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:16:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BE85A8043;
        Mon,  9 Oct 2017 20:16:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2j+5dO1YISIGoPBKo8IEFZ4AyrY=; b=ZeVRfW
        EehlzMxbwOG2Y51ImoCtW/0IoQYlR0DNCFQ/KTlQLehjueOYvsveSbf4A5USRQ7y
        ngwt/uCh+NY8FkDA2YY14lflRFK0Pxm/aNMrlouXjy1dsB2IY/6BTF5VfXBEZe0z
        AK2M4ijtdJ7kDKM9bX5Ad+uGQEgVaQ1OtL4BY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nytrKX4MOqLseB+tumqZ8+ybvH5qfE5+
        r6f4WWp5EP0gmYn+5wLZ20JPYWnA863zI/s8bY7SJlqlPXjfocK4qOF2HcA08WQK
        9FRBMDVlqvpf8pYyb0Oc1TC92WgOyKMUp9c/HA2p/Dp+FovzR41S32HnOkXkRS69
        zkhC8zViyl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1A8A8041;
        Mon,  9 Oct 2017 20:16:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3500A803F;
        Mon,  9 Oct 2017 20:16:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] submodule: spell out API of submodule_move_head
References: <20171009220615.27541-1-sbeller@google.com>
Date:   Tue, 10 Oct 2017 09:16:15 +0900
In-Reply-To: <20171009220615.27541-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Oct 2017 15:06:15 -0700")
Message-ID: <xmqqtvz7rh68.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BB573E6-AD50-11E7-B648-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +/**
> + * Move the HEAD and content of the active submodule at 'path' from object id
> + * 'old' to 'new'.
> + *
> + * Updates the submodule at 'path' and files in its work tree to commit
> + * 'new'. The commit previously pointed to by the submodule is named by
> + * 'old'. This updates the submodule's HEAD, index, and work tree but
> + * does not touch its gitlink entry in the superproject.
> + *
> + * If the submodule did not previously exist, then 'old' should be NULL.
> + * Similarly, if the submodule is to be removed, 'new' should be NULL.
> + *
> + * If updating the submodule would cause local changes to be overwritten,
> + * then instead of updating the submodule, this function prints an error
> + * message and returns -1.

This is not a new issue (the removed comment did not mention this at
all), but is it correct to say that updates to "index and work tree"
was as if we did "git -C $path checkout new" (and of course, HEAD in
the $path submodule must be at 'old')?

What should happen if 'old' does not match reality (i.e. old is NULL
but HEAD does point at some commit, old and HEAD are different,
etc.)?  Should the call be aborted?

> + * If the submodule is not active, this does nothing and returns 0.
> + */
>  #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
>  #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
>  extern int submodule_move_head(const char *path,
