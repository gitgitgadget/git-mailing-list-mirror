Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A7C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 21:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGOVuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGOVuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 17:50:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313B51A29
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 14:50:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F29E41381FB;
        Fri, 15 Jul 2022 17:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tLzGpCizkovUqbOHlDZCCBdQhoifbgZbDSorx4
        ngClY=; b=ahadPM7kQY32EIRfqeUbCl0+rMpYFWVTh/1Ukrztr+pg/VgqdtIByE
        FLocttRlF8p/y72KeBvOsT43HZLy1bbIPUlySYp5gljC+zgim3BqYeqTgW66By4c
        rhMX3tDXHVCRuippN3xj3LHRAIxspK878lS73bzN9mvjSu+bSUWSI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E97561381FA;
        Fri, 15 Jul 2022 17:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 583121381F4;
        Fri, 15 Jul 2022 17:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthias Beyer <mail@beyermatthias.de>,
        Konstantin Khomoutov <kostix@bswap.ru>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] Add note that conflict resolution is still performed
References: <xmqq35f6fe0j.fsf@gitster.g>
        <20220715092527.1567837-1-mail@beyermatthias.de>
        <xmqq35f2ysd9.fsf@gitster.g>
Date:   Fri, 15 Jul 2022 14:50:12 -0700
In-Reply-To: <xmqq35f2ysd9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Jul 2022 14:32:18 -0700")
Message-ID: <xmqqv8ryxcyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B06117A-0488-11ED-8323-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A tangent that may be worth thinking about, that does not have to be
> part of this topic (as it probably will involve code change).
>
> It makes sense that "--no-rerere-autoupdate" does not disable the
> "rerere" mechanism (when it is enabled, of course), because it makes
> sense to reuse recorded resolution without updating the index with
> the result.
>
> However, it may make sense to have "--rerere-autoupdate" option to
> enable the "rerere" mechanism when it is disabled, because with
> "rerere" disabled, there is nothing to auto-update.

I think the damage to the code to implement the above may not be too
bad.  Here is an illustration (not even compile tested) of the idea:

 - Earlier, after reading the config, we asked is_rerere_enabled()
   and let its logic decide if rerere is to be used, giving no
   influence to the incoming "flags" parameter.  Then the value of
   rerere_autoupdate read from the config is further adjusted by the
   value in "flags" parameter that relays --[no-]rerere-autoupdate
   from the command line.

 - Instead, after reading the config, we can tweak it with the
   "flags", and flip rerere_enabled to true if autoupdate is
   enabled, before making a call to is_rerere_enabled().

I do not think we have a test that insists that rerere does not kick
in in a repository where rerere is disabled and the command line
asks for "--rerere-autoupdate", so I suspect that with this patch, I
would not be surprised if no test breaks.  If we think this takes us
in a good direction, we should add a few tests to make sure at least
the following two:

 - In a repository with rerere disabled, running a command with the
   "--rerere-autoupdate" option will enable rerere for that single
   invocation of the command.

 - In a repository with rerere enabled, running a command with the
   "--no-rerere-autoupdate" option does not disable rerere for that
   single invocation of the command.

---

 rerere.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/rerere.c w/rerere.c
index 876ab435da..16d3e865e6 100644
--- c/rerere.c
+++ w/rerere.c
@@ -872,11 +872,13 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 	int fd;
 
 	git_rerere_config();
+	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
+		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
+	if (rerere_autoupdate)
+		rerere_enabled = 1;
 	if (!is_rerere_enabled())
 		return -1;
 
-	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
-		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	if (flags & RERERE_READONLY)
 		fd = 0;
 	else
