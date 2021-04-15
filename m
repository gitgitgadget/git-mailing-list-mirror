Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A40AC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 03:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296C56128E
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 03:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhDODva (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 23:51:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56495 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDODv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 23:51:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA1E4BAA02;
        Wed, 14 Apr 2021 23:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/kp2YxRmQEJI1lr4KsjbLDVEa3g=; b=bZoRg8
        HjlmZzE0GtHZqlzMVYzZOrQvc+oPSTF+MMbfO6I54fNb9AxCs0prdyOkK3dQpH6t
        eU7tuz3qhK7mnacSf6+GYpNgxGM3mc7O8vzIotoXw4h3Di0PkeMT6wz70LGz4CnW
        SbmMA4LAR9x48D9Aj8uheTk8OmsjrkRaf5Ass=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=njzJ9fQ1ZIT/R3igyspMP8P2hZ7dJO5F
        xR8+ura1BXc2mKWJU3+RlS043g6nuWubRsUyG7hLYKRM5LbaQyWgsjIb7PHOEdpJ
        2D8QWARrTw1leHF8hhUtdqMeQ46AlYgfsf6muYk1UZuQ+TCmGkKU0yH4ZrU/k50n
        OlzbNmORhs8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9A13BA9FE;
        Wed, 14 Apr 2021 23:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B331CBA9FC;
        Wed, 14 Apr 2021 23:51:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     rafaeloliveira.cs@gmail.com, git@vger.kernel.org,
        szeder.dev@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
References: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
        <20210415010454.4077355-1-jonathantanmy@google.com>
Date:   Wed, 14 Apr 2021 20:51:02 -0700
In-Reply-To: <20210415010454.4077355-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 14 Apr 2021 18:04:54 -0700")
Message-ID: <xmqqo8egurx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD785C30-9D9D-11EB-A2E8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> When `-A` and `-d` are used together, besides packing all objects (-A)
>> and removing redundant packs (-d), it also unpack all unreachable
>> objects and deletes them by calling `git pruned-packed`.
>
> I still think of these objects as not unreachable, even though I know
> that pack-objects calls them that (the argument is called
> --unpack-unreachable). So I would say "it also loosens all objects that
> were previously packed but did not go into the new pack", but perhaps
> this is OK too.

Hmph, that is puzzling.  I understand that the operation about

 (1) finding all the objects that are still reachable and send them
     into a newly created pack, and

 (2) among the objects that were previously in the packs, eject
     those that weren't made into the new pack with the previous
     point.

Where did I get it wrong?  If all the reachable ones are dealt with
with the first point, what is leftover is not reachable, no?


