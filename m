Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16EC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E95206F5
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OOhOIj2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgC3RM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:12:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57053 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3RM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 13:12:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20A17435E3;
        Mon, 30 Mar 2020 13:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ry1uYsxGuxKpX+eDq+OQyF/R96c=; b=OOhOIj
        2S70bnXBSh632PDiUHbfSZnTm1oimrdI4JLXmx/vkzEBL7OQnrzMKvUbCYuB+NFi
        B3Q+jeZ7a8w9ZPBboUfVIaxLpO6er7TI4ZoOUKTanfCGrHIzcqWLvrbe2m1d8tfw
        579CdCNTjvPl7IDkUc8uK02+WymiJoEORqK+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fUwAb8JY42hYc0k7HipIZm8u638HY67c
        Q7bJvniB/EwbpTUt07zZc+qb2XRm1IcQkW4vkAoatdvrb0w/IO8Fm+rYWtgUR4qL
        lFNOTk+KHyCZH9QoULPphXoqDEdyb7YBde5JtYzQVlErx1b8P7HBy5KeWUdmsqLV
        wUEVUXhurzY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 183B7435E1;
        Mon, 30 Mar 2020 13:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F4A9435E0;
        Mon, 30 Mar 2020 13:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/9] strbuf: provide function to append whole lines
References: <cover.1585129842.git.ps@pks.im>
        <4b0a963ea5c47a951b95aa0a03966315b3e8299d.1585129842.git.ps@pks.im>
        <xmqqpncxfr1p.fsf@gitster.c.googlers.com>
        <20200330132509.GA1344694@ncase.pks.im>
Date:   Mon, 30 Mar 2020 10:12:56 -0700
In-Reply-To: <20200330132509.GA1344694@ncase.pks.im> (Patrick Steinhardt's
        message of "Mon, 30 Mar 2020 15:25:09 +0200")
Message-ID: <xmqqo8sd936v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B389A5CE-72A9-11EA-A955-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Unfortunately it's not that easy for the HAVE_GETDELIM case, though, as
> we cannot call getdelim(3P) to append to an already populated buffer. So
> we'd have to call getdelim(3P) either on a NULL line and append manually
> or on an empty line in case the strbuf doesn't have any contents. While
> doable, I wanted to keep out this additional complexity for now.

Ahh, I see.  Thanks for a clarification.
