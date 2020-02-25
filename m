Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B3C35E04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F8820CC7
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TmrrP8vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgBYUKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:10:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50536 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgBYUKY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 15:10:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38621A26C3;
        Tue, 25 Feb 2020 15:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AdmRMzkSFGCI7X/as5uO8THb/WI=; b=TmrrP8
        vhrffL89Y/aoojKKc0C9/DwrkUmokk9/DsOvfB9xJVeNA8uHh+dclmtztNBFe1lG
        gFWHvxtZ8jO76RNrbxgA1s979lugQuPbx3ACx6rE7qeVcoNAS14UguFoHQe3EA/9
        JE8duSFodakJ7zpafDWR+49HrgUskV/CoWAhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S5r4VW/2rnAFdEDvTV5axuGcGNEIpyw2
        7IV7uL21Q+so2LRD0IngRY7jEDwOW7vf3Kin9VW4YjEQGCKa8LKJNFXhEkYKNClc
        XAjCAN+0L8U8pPujFjjgyWHfZKqzusJ1vRic+8EggVfmwY+tFGaG3DK7hj2c1RnY
        V3RN5H8VgGk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 304DAA26C2;
        Tue, 25 Feb 2020 15:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5C3E5A26C1;
        Tue, 25 Feb 2020 15:10:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     benno@bmevers.de
Cc:     junio@pobox.com, git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH] describe: dont abort too early when searching tags
References: <xmqq4kvfpv17.fsf@gitster-ct.c.googlers.com>
        <20200225190751.5898-1-benno@bmevers.de>
Date:   Tue, 25 Feb 2020 12:10:17 -0800
In-Reply-To: <20200225190751.5898-1-benno@bmevers.de> (benno@bmevers.de's
        message of "Tue, 25 Feb 2020 20:07:51 +0100")
Message-ID: <xmqq7e0amnrq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D887E0CA-580A-11EA-9C94-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

benno@bmevers.de writes:

> From: Benno Evers <benno@bmevers.de>
>
>> How much, if any, does this change hurt the performance by forcing
>> the code to dig further if there aren't multiple roots?  If there is
>> such an unnecessary overhead that degrades performance for the more
>> common case, can we improve it further to avoid it?
>
> If there aren't multiple roots, then this should be visiting exactly
> the same number of commits as before. This is because in this case, if
> we're down to a single branch, the current commit must be an ancestor
> of *all* tag candidates so the stopping condition is always true.

Sounds good.  Can some of that analysis go in the proposed log
message text, so that other people do not have to ask the same
question later?

Thanks.
