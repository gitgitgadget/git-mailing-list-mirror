Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416C7C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0591822265
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k87jNmBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDTXXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:23:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57032 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTXXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 19:23:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88F38D345E;
        Mon, 20 Apr 2020 19:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J5WzEjcf0R446mlAUOCUFYJlNHc=; b=k87jNm
        BJO299nacT8G+IMEMmpVI18l7yH+OOddA0yVQB7yP8JTsDcSPlxT09XSsHvCJ3Xd
        Azfhr2OLvOR0xZA/oYfo61s1SFWEDbyM0bWNHDE4w1UfKt3CLrnDdbqji4doCs0r
        kwOF9WzWm1DHKxAXS4og2YmnCB6TyqJFlMXbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yBStqnPc0t8Hb2BRkONDb84HrsK3xhbi
        ++MveNN41cuoSiu2HFX5mdJlcl6U9pG87VXhTD8EEemLHetqa3zYPNwa2268VjL7
        RW+AJIVcIvJ5GV/PY3Zx0p6V4xLHcKaSZSKQabh/hvR/31HyQJTlq2dBN8STSyk1
        jsWVE/zmChk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 818ACD345D;
        Mon, 20 Apr 2020 19:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C99E9D345B;
        Mon, 20 Apr 2020 19:23:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: Re: [PATCH 0/3] commit-graph: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
Date:   Mon, 20 Apr 2020 16:23:13 -0700
In-Reply-To: <cover.1587422630.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 20 Apr 2020 16:50:55 -0600")
Message-ID: <xmqq5zdtrbby.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8C193FE-835D-11EA-9B38-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The first two patches set this up, and the third patch uses it in
> commit-graph.c, and corrects some test fallout. Eventually, we may want
> to take another look at all of this and always create lockfiles with
> permission 0444, but that change is much larger than this one and could
> instead be done over time.

So,... is the problem that this did not follow the common pattern of
creating (while honoring umask) and then call adjust_shared_perm(),
which I thought was the common pattern for files in $GIT_DIR/?
