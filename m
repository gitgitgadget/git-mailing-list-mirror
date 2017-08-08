Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE3220899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbdHHUFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:05:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61157 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752153AbdHHUFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:05:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC2E59DDE7;
        Tue,  8 Aug 2017 16:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SUyr3vZ/PKPDtltXjrmSXdXr5Zc=; b=kTLKil
        yvlQna3N/oXvO1oQlVSAdwRw/v1/hp937cYgzZbznQp1L8KD9Z+ph6mfFqfCr3H7
        34GDMcYHNDfib/R3tRinEVS7DI1i1KkjGML9dTRQ1E7fPZqoyWF52oPuO28wMQCs
        DMyXtec/k+HjvFAxbw/d4Pjv5r2bI2CGAwJQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JxqvWh4MfNT3XW3rRbWfkMtneMvrSb/P
        11lNKFPfhGa+YpmpBIMmR/C1dVqbtmeEYYY4TAd6fZbW4zRNcVpfeH4V2xm453cT
        KNpQLw5X8386SEgIc1BExamtF9H5F9MDL8qQ3fkyX7QlbguzZHPl4btJ5BapbAkO
        kDpdr+tReys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E28CA9DDE6;
        Tue,  8 Aug 2017 16:05:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A6D59DDE4;
        Tue,  8 Aug 2017 16:05:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] An attempt to move packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
Date:   Tue, 08 Aug 2017 13:05:05 -0700
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 8 Aug 2017 12:32:30 -0700")
Message-ID: <xmqqd185bzbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF577F4C-7C74-11E7-AF1C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> While investigating annotating packfiles and loose objects to support
> connectivity checks in partial clones [1], I decided to make the effort
> to separate packfile-related code from sha1_file.c into its own file, to
> make it easier to both code such changes and review them. Here is the
> beginning of those efforts.
>
> Is this something worth doing, and if yes, is this in the right
> direction?

Overall I think it is a good idea to slim down sha1_file.c *if* we
can keep the exposed surface area small enough.

I wonder if the names "pack.[ch]" communicate well that these are
"object access layer that is about reading from packfiles".  The
writer side is called "pack-objects.[ch]".

This may have to make some symbols that used to be private to the
"object access" layer, which was what sha1_file.c was about, global
symbols.  After moving things around, do we end up exposing too many
implementation details to the world outside the "object access"
layer?  I'd assume they are limited to the resulting pack.h and it
would be OK as long as nobody other than sha1_file.c and pack.c
would inculde it, though.

Thanks.

>
> [1] https://public-inbox.org/git/20170804145113.5ceafafa@twelve2.svl.corp.google.com/
>
> Jonathan Tan (10):
>   pack: move pack name-related functions
>   pack: move static state variables
>   pack: move pack_report()
>   pack: move open_pack_index(), parse_pack_index()
>   pack: move release_pack_memory()
>   pack: move pack-closing functions
>   pack: move use_pack()
>   pack: move unuse_pack()
>   pack: move add_packed_git()
>   pack: move install_packed_git()
>
>  Makefile                 |   1 +
>  builtin/am.c             |   1 +
>  builtin/clone.c          |   1 +
>  builtin/count-objects.c  |   1 +
>  builtin/fetch.c          |   1 +
>  builtin/merge.c          |   1 +
>  builtin/pack-redundant.c |   1 +
>  cache.h                  |  45 ----
>  connected.c              |   1 +
>  git-compat-util.h        |   2 -
>  pack.c                   | 669 +++++++++++++++++++++++++++++++++++++++++++++++
>  pack.h                   |  51 ++++
>  sha1_file.c              | 667 ----------------------------------------------
>  sha1_name.c              |   1 +
>  streaming.c              |   1 +
>  15 files changed, 730 insertions(+), 714 deletions(-)
>  create mode 100644 pack.c
