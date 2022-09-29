Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CFC433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiI2TX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiI2TX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:23:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D114FE0B
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:23:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6979B13899B;
        Thu, 29 Sep 2022 15:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2pMlaMSiZG1uNB5ULGc6gWS9B438hYLHHLr1Z7
        9Z4RI=; b=VzMLPzr8ZZLCJ/iQLLu+9p+yqwLcGRmn64ob/C95dw8WutAoFHpD4n
        VDQN40mzM3DLb7SVAIDqg1KhHRXMnCGBBIiJClfdgxD128P1lmZBiIAvQo6Yg7M3
        lFr5pd7e5x4aRFIv/kDJEcVkQGiszypky2GTrdnX7MArgz+ivDDDA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61E6813899A;
        Thu, 29 Sep 2022 15:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7DBE138999;
        Thu, 29 Sep 2022 15:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] promisor-remote: remove a return value
References: <cover.1664316642.git.jonathantanmy@google.com>
        <7cef8088cebe368e66237837eacec71381182ec1.1664316642.git.jonathantanmy@google.com>
Date:   Thu, 29 Sep 2022 12:23:53 -0700
In-Reply-To: <7cef8088cebe368e66237837eacec71381182ec1.1664316642.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 27 Sep 2022 15:12:29 -0700")
Message-ID: <xmqqmtainfw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41FF28FE-402C-11ED-8055-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> No caller of promisor_remote_get_direct() is checking its return value,
> so remove it.

The above is a good explanation why this change will not hurt the
current users, but is it a good thing to do in the first place?

Isn't it an indication that all the existing callers are sloppy?  Or
does it mean that the value returned from this function is not a
useful signal to the caller?

Looking at the implementation, the function seems to want to
indicate if the fetching succeeded (with 0) or failed (with -1).
What is curious is that the function seems to consider it a success
even if some requested objects were never downloaded after
consulting all the promisor remotes.  There is no way for the caller
to obtain the list of objects it wanted to have but the function
failed to deliver, either (other than obviously redoing what
promisor-remote.c::remove_fetched_oids() does itself).

Are these what makes the returned value from the function useless
and the callers ignore it?  If these are fixed, would it make the
indication of error more useful?

Looking at some of the existing callers:

 * builtin/index-pack.c calls it to fill the "gap" and after giving
   the function a chance to download "missing" objects, goes on its
   prosessing as if nothing has happened.  We will properly die if
   any object we need is still missing, so unless we are interested
   in failing early, checking the return value of the function does
   not help all that much.

 * The caller in builtin/pack-objects.c is similar.  We have a list
   of bunch of objects we want to pack, some of which may be
   missing.  We ask all missing ones from the list in bulk before
   doing anything, but we rely on the regular codepath to notice if
   the promisor remote did not give us necessary objects.

I didn't look at others, but the above two are probably OK, unless
we want to get a signal to be cautious about poorly managed promisor
remotes.  Not distinguishing the reason why we do not have objects
between a corrupt repository and a promisor remote that breaks its
earlier promises makes it impossible to say "hey, that promisor
remote is failing its expectation, perhaps we should wean us off
from it".
