Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F2C47426
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E3C20897
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFpKAi6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbgJARDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 13:03:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59205 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbgJARDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 13:03:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0FFBE107F;
        Thu,  1 Oct 2020 13:03:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bVgXWM2f8GJB
        slAEp7U25qf9e/A=; b=AFpKAi6AFhzlYHSKvSLiCIZPl7hu7GBcqV+nlyma+iHo
        hGySC/YCMkSGNmtwzO5rXYNRkrgg/4xZ0iBCW9eFjV10tCO3Y3jEH68bCjXtZwLQ
        cwWUsJt8jinSkfYih/kcsGfLIc8TxZJkghaWkV995yL1FP3D8MlM/M3v6PVl0PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KHRVmi
        DOzNgKYWT1J9Xhf0oABqCm+T1kK5PTG/F45Gy1Dr6g/ED1hrWrufxQEexgEBj6w2
        vzllV31ogdVs+cnGOmPhlW3SBQ0/WAyRGOo1XJlI5DTRRSCEhGZLrZRcV0taJHZ6
        cKWlEAWb7ua0OIueDIAN1vg211AWn7FCy3jSc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8AA3E107E;
        Thu,  1 Oct 2020 13:03:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1AD4CE1078;
        Thu,  1 Oct 2020 13:03:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
Date:   Thu, 01 Oct 2020 10:02:59 -0700
In-Reply-To: <20201001120606.25773-1-michal@isc.org> (=?utf-8?B?Ik1pY2hh?=
 =?utf-8?B?xYIgS8SZcGllxYQiJ3M=?=
        message of "Thu, 1 Oct 2020 14:06:04 +0200")
Message-ID: <xmqq8scpdgl8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F677B69C-0407-11EB-AD93-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

> This patch series adds a new diff option that enables ignoring changes
> whose all lines (changed, removed, and added) match a given regular
> expression.  This is similar to the -I option in standalone diff
> utilities and can be used e.g. to look for unrelated changes in commits
> containing a large number of automatically applied modifications (e.g. =
a
> tree-wide string replacement).  The difference between -G/-S and the ne=
w
> -I option is that the latter filters output on a per-change basis.

I am uncomfortably excited to see a change to quite a low-level code
of the diff machinery.  It does not happen every day ;-)

