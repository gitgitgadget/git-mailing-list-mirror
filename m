Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F6C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiBQWMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiBQWMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:12:38 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2C4A3E8
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:12:24 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6346179C49;
        Thu, 17 Feb 2022 17:12:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D8H/i1K6bthQOU91W37kdBRxJW768H1WLW5N57
        IeotU=; b=ixsbDIHVVEemtZw8Omi0eXwhf2U0T/ikS9rrljoG0UBPFXZtJaoU+0
        HzAdZ6TlKZWiAuivv4VF0VnxLd7ZwDVKexV3ZzrqUsIYAW2QRfj9C5dNP3bfs891
        RE8WTLfLWieU53dAPuzZ5y93+5xzwPvVDKZdBLthy7SnLXw3D4cdk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF046179C48;
        Thu, 17 Feb 2022 17:12:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46BB9179C46;
        Thu, 17 Feb 2022 17:12:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/7] fetch: control lifecycle of FETCH_HEAD in a
 single place
References: <cover.1645102965.git.ps@pks.im>
        <0b9d04622d095f97246ae2603e2cb5312a68def3.1645102965.git.ps@pks.im>
Date:   Thu, 17 Feb 2022 14:12:20 -0800
In-Reply-To: <0b9d04622d095f97246ae2603e2cb5312a68def3.1645102965.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 17 Feb 2022 14:04:24 +0100")
Message-ID: <xmqqv8xd6t2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD64807E-903E-11EC-A352-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> There are two different locations where we're appending to FETCH_HEAD:
> first when storing updated references, and second when backfilling tags.
> Both times we open the file, append to it and then commit it into place,
> which is essentially duplicate work.
>
> Improve the lifecycle of updating FETCH_HEAD by opening and committing
> it once in `do_fetch()`, where we pass the structure down to the code
> which wants to append to it.

OK.  Each call to store_updated_refs() used to be responsible for
opening, appending, committing, and closing FETCH_HEAD.  We now make
do_fetch() responsible for opening, committing, and closing, and let
the direct and indirect callers of fetch_and_consume_refs() only
worry about appending to it.  Makes sense.
