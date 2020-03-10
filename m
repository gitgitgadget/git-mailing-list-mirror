Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD33EC18E5A
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 20:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E06215A4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 20:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kB+/fZe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCJUQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:16:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52765 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCJUQI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 16:16:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E85CBD737;
        Tue, 10 Mar 2020 16:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N1+/tQu2lJBne6zSPHa3f7Kju8g=; b=kB+/fZ
        e9EBLF1tV1C3UBsT/B81tBWXs0OqEGhsMpC582LrYax/p3jUATrZ4P4zcFbTBFCI
        FVck5rsce/h/pZ+OuxEtG4dhQlgaH1msusu/sjaS0Ji9HqnyuVIYbjbR+HdNIlpY
        SI0dmRLwd2i3JWhejylVbGDTkO7lHq/OfIeQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JAKt/TLEmwBmDvEK8zPm2fagckjYNATl
        sQ0ADSYX5lc+PXW81hXpJ/ooRB1x2Oc8r9TgLpCc5hUNQqqGfhXIc7us5mhdmf3V
        80e5iKKDsgiOX308nACPVPO4JEj0t8gT7MJwVKiJ5sWCvQEdSrGxO2VBrnRsvRJY
        GP1WfGGpshU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 566DABD736;
        Tue, 10 Mar 2020 16:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84A09BD735;
        Tue, 10 Mar 2020 16:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, annulen@yandex.ru, tytso@mit.edu
Subject: Re: [PATCH v5] pull: warn if the user didn't say whether to rebase or to merge
References: <20200310035420.1658876-1-alexhenrie24@gmail.com>
Date:   Tue, 10 Mar 2020 13:16:01 -0700
In-Reply-To: <20200310035420.1658876-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Mon, 9 Mar 2020 21:54:20 -0600")
Message-ID: <xmqqk13shsou.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F774197A-630B-11EA-9146-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Often novice Git users forget to say "pull --rebase" and end up with an
> unnecessary merge from upstream. What they usually want is either "pull
> --rebase" in the simpler cases, or "pull --ff-only" to update the copy
> of main integration branches, and rebase their work separately. The
> pull.rebase configuration variable exists to help them in the simpler
> cases, but there is no mechanism to make these users aware of it.
>
> Issue a warning message when no --[no-]rebase option from the command
> line and no pull.rebase configuration variable is given. This will
> inconvenience those who never want to "pull --rebase", who haven't had
> to do anything special, but the cost of the inconvenience is paid only
> once per user, which should be a reasonable cost to help a number of new
> users.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v5:
> - Supress warning when --quiet is given
> - Ensure that pull option tests still test what they're supposed to test
> - Add tests for the new warning

Thanks, will queue.
