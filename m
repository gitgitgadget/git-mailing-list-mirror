Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89BC43219
	for <git@archiver.kernel.org>; Wed,  4 May 2022 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbiEDN7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350949AbiEDN7P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 09:59:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E9B99
        for <git@vger.kernel.org>; Wed,  4 May 2022 06:55:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D233A1A544D;
        Wed,  4 May 2022 09:55:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=UoI4iYJsFCtJue/fsV7+HdrB2RyWJQgem27wmpp36Po=; b=FHqD
        O8198aOZpqbZ02W67ZloEKSn7xe8HboV073Tdkve6w2b0dqT30byjSbdwJnJGmFJ
        5WL8al3h3FY/+mDwVUn3T02Zf0rdZvf5ioHj5eZzQCiHrvOs+gk+CgCUV+jA/Wn2
        DO2rRSDD3CDGrTxhIcMGARIrHjsltHDcq1Jako0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA9E41A544C;
        Wed,  4 May 2022 09:55:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C67B1A544B;
        Wed,  4 May 2022 09:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Hatton <jhatton@globalfinishing.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git status extremely slow if any file is a multiple of 8GBi
References: <CY4PR16MB1655A1F7DD8B2FABCC30C9DAAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
Date:   Wed, 04 May 2022 06:55:34 -0700
Message-ID: <xmqqczgtpfl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF0A0E24-CBB1-11EC-B974-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Hatton <jhatton@globalfinishing.com> writes:

> I have a proposed idea that may or may not help. Would it be possible for any
> file that is a multiple of 2^32 to be adjusted to a file size of 1 instead of
> zero? Git is already functioning with mangling file sizes over 4GB in the
> index, so maybe bumping up the size of 2^32 multiple files would mitigate the
> issue.

Clever.  

The condition sd_size==0 is used as a signal for "no, we really need
to compare the contents", and causes the contents to be hashed, and
if the contents match the object name recorded in the index, the
on-disk size is stored in sd_size and the entry is marked as
CE_UPTODATE.  Alas, if the truncated st_size is 0, the resulting
entry would have sd_size==0 again, so a workaround like what you
outlined is needed.

You'd need to make sure that you tweaked

	if (sd->sd_size != (unsigned int) st->st_size)
		changed |= DATA_CHANGED;

that appears at the end of read-cache.c::match_stat_data() in a way
that is consistent with how you munge the sd_size member in
fill_stat_data(), if you are going to go that route.

Thanks.
