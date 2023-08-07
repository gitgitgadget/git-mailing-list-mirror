Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93966C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjHGU26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGU24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:28:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513310D8
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:28:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54D20242B7;
        Mon,  7 Aug 2023 16:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hDnnQFbxSEaX+NS50Fr4deaa/MTEHBf0/EnJ/3
        DfdS8=; b=cwa22pKaZzet7Pd3VS/6OJrCwj9MkALP5qilb1rrVADj8uqAROmIuf
        iabyc+s3FyPRwSTNMGOPPP3INWFnb0F33WbJYeEJV58z+kjypt16EzBsYQesgZbt
        MarBhuEecDI7hfKYwuV6VHE6Up4t6E8/q074eH87do7LYc/12h9Ys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AE81242B6;
        Mon,  7 Aug 2023 16:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 733D1242B5;
        Mon,  7 Aug 2023 16:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 13:28:50 -0700
In-Reply-To: <20230807170935.2336745-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 19:09:35 +0200")
Message-ID: <xmqqv8dqd2bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0577183A-3561-11EE-966A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>  			if (item->command == TODO_FIXUP) {
>  				if (item->flags & TODO_EDIT_FIXUP_MSG)
>  					strbuf_addstr(buf, " -c");
> -				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
> +				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
>  					strbuf_addstr(buf, " -C");
> -				}
> -			}
> -
> -			if (item->command == TODO_MERGE) {
> +			} else if (item->command == TODO_MERGE) {
>  				if (item->flags & TODO_EDIT_MERGE_MSG)
>  					strbuf_addstr(buf, " -c");
>  				else

This patch as it stands is a strict Meh at least to me, as we know
item->command is not something we will mess with in the loop, so
turning two if() into if/elseif does not add all that much value in
readability.

Having said that.

The code makes casual readers curious about other things.

 * Are FIXUP and MERGE the only two commands that need to be treated
   differently here?

 * Can item->commit be some other TODO_* command?  What is the
   reason why they can be no-op?

 * When one wants to invent a new kind of TODO_* command, what is
   the right way to deal with it in this if/else cascade?

And that leads me to wonder if this is better rewritten with

	switch (item->command) {
	case TODO_FIXUP:
		...
		break;
	case TODO_MERGE:
		...
		break;
	default:
		/*
		 * all other cases:
		 * we can have a brief explanation on why
		 * they do not need anything done here if we want
		 */
		break;
	}

