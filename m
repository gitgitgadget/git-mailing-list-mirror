Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C205C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352800AbiEDQL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiEDQLz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 12:11:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C53425EA0
        for <git@vger.kernel.org>; Wed,  4 May 2022 09:08:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9963611C597;
        Wed,  4 May 2022 12:08:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K/n87S304aYcFUiFZ5knVETWH/pZt5uBB2DZxt
        EhIFc=; b=DEjjr/4Ku8RXTJiLcXxR+wGZjLnNCRDT0cGZNOvwG3Z19Viydw/qEF
        MOrT2OB4OPab6eNV/fy7Po087t1OsBiTRterdv1d0eCW31szLKXpUuuWGOZXom4V
        KmDlpAoSJj0OzS2Ih+6BBS6d5D1LHG5u7E4i5ItjMSV3DmodM4EG4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90FB811C594;
        Wed,  4 May 2022 12:08:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFEBD11C593;
        Wed,  4 May 2022 12:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: Git status extremely slow if any file is a multiple of 8GBi
References: <CY4PR16MB1655A1F7DD8B2FABCC30C9DAAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
        <xmqqczgtpfl5.fsf@gitster.g>
Date:   Wed, 04 May 2022 09:08:16 -0700
In-Reply-To: <xmqqczgtpfl5.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        04 May 2022 06:55:34 -0700")
Message-ID: <xmqq4k25nuvj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69292592-CBC4-11EC-A35C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The condition sd_size==0 is used as a signal for "no, we really need
> to compare the contents", and causes the contents to be hashed, and
> if the contents match the object name recorded in the index, the
> on-disk size is stored in sd_size and the entry is marked as
> CE_UPTODATE.  Alas, if the truncated st_size is 0, the resulting
> entry would have sd_size==0 again, so a workaround like what you
> outlined is needed.

This is of secondary importance, but the fact that Jason observed
8GBi files gets hashed over and over unnecessarily means that we
would do the same for an empty file, opening, reading 0-bytes,
hashing, and closing, without taking advantage of the fact that
CE_UPTODATE bit says the file contents should be up-to-date with
respect to the cached object name, doesn't it?

Or do we have "if st_size == 0 and sd_size == 0 then we know what it
hashes to (i.e. EMPTY_BLOB_SHA*) and there is no need to do the
usual open-read-hash-close dance" logic (I didn't check)?
