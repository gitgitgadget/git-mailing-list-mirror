Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70387C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbiAFWxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:53:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52238 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245250AbiAFWxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:53:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDE2D109780;
        Thu,  6 Jan 2022 17:53:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TWWShFsqdim34aeseE6zPGoZSQoHC+ppmARw4q
        ktjLg=; b=ZlpkHEr7MMax27K5EgaF+Op6ZDTpdi7urSqSRtt5L8krc5QDaAUEjv
        P1uBGxf/zG+EynD1/hlQskbZ/c9MtEp2GB7LkEG+zaTRsQMHgVoTnNuFDvIkA9ZD
        pmmN54Tffsz6ouTceod+2GbSGrmXrgaU37GXd0I1/QYiKhRrb0CYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E9B10977F;
        Thu,  6 Jan 2022 17:53:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5505010977E;
        Thu,  6 Jan 2022 17:53:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for
 CHERI/Arm's Morello
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
Date:   Thu, 06 Jan 2022 14:53:51 -0800
In-Reply-To: <20220105132310.6600-1-jrtc27@jrtc27.com> (Jessica Clarke's
        message of "Wed, 5 Jan 2022 13:23:10 +0000")
Message-ID: <xmqqczl4bhmo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84D412B2-6F43-11EC-A0B5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

> On CHERI, and thus Arm's Morello prototype, pointers are implemented as
> hardware capabilities which, as well as having a normal integer address,
> have additional bounds, permissions and other metadata in a second word.
> In order to preserve this metadata, uintptr_t is also implemented as a
> capability, not a plain integer, which causes problems for binary
> operators, as the metadata preserved in the output can only come from
> one of the inputs. In most cases this is clear, as normally at least one
> operand is provably a plain integer, but if both operands are uintptr_t
> and have no indication they're just plain integers then it is ambiguous,
> and the current implementation will arbitrarily, but deterministically,
> pick the left-hand side, due to empirical evidence that it is more
> likely to be correct.

What's left-hand side in the context of the code you changed?
Between "what" vs "ent->util" you take "what"?  That cannot be
true.  Are you referring to the (usually hidden and useless when we
use it as an integer) "hardware capabilities" word as "left" vs the
value of the pointer as "right"?

>  static uintptr_t register_symlink_changes(struct apply_state *state,
>  					  const char *path,
> -					  uintptr_t what)
> +					  size_t what)
>  {
>  	struct string_list_item *ent;
>  
> @@ -3823,7 +3823,7 @@ static uintptr_t register_symlink_changes(struct apply_state *state,
>  		ent = string_list_insert(&state->symlink_changes, path);
>  		ent->util = (void *)0;
>  	}
> -	ent->util = (void *)(what | ((uintptr_t)ent->util));
> +	ent->util = (void *)((uintptr_t)what | ((uintptr_t)ent->util));
>  	return (uintptr_t)ent->util;
>  }

I actually wonder if it results in code that is much easier to
follow if we did:

 * Introduce an "enum apply_symlink_treatment" that has
   APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
   possible values;

 * Make register_symlink_changes() and check_symlink_changes()
   work with "enum apply_symlink_treatment";

 * (optional) stop using string_list() to store the symlink_changes;
   use strintmap and use strintmap_set() and strintmap_get() to
   access its entries, so that the ugly implementation detail
   (i.e. "the container type we use only has a (void *) field to
   store caller-supplied data, so we cast an integer and a pointer
   back and forth") can be safely hidden.

