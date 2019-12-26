Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE7C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5796F206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="txQWBRP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfLZSXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:23:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64990 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZSXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 13:23:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDBF819728;
        Thu, 26 Dec 2019 13:23:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YJZ2B/XW2ogApaziEvN9U+UIoTs=; b=txQWBR
        P0617yqTOxCrZlVVHyBTMg2WN/rDlzYdWkgj7lWzTiiP0RqWQdB/j++6iQmLyglX
        iNDOm7hqSK38BX9M0z93Gk37Q4JMJiwUlFTTLcp+SYVOUwVFyItSMNoIjkfulPnG
        ovmIKw3hlKK3kWdgplSIMntfHrmKeYJ0al7aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yLzfTBFEJvDT2U3hvy9X712jmZ/cIkDQ
        fN0Uir3o7/vQq2IvTZxGnb5So2MvB4iZx7tKJ9bJeA/fSSSa1KrUT4NGvHMCgOSs
        gthdjHe5m0qhqkQkAFWJQW9A235WhOJg4a1FBZnstQa0e/jLm4gihIimdsVNHydG
        VVmNhzoG49Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61D5919727;
        Thu, 26 Dec 2019 13:23:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9178E19726;
        Thu, 26 Dec 2019 13:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: replace lseek+read with pread
References: <20191226104220.27325-1-e@80x24.org>
        <20191226104220.27325-3-e@80x24.org>
Date:   Thu, 26 Dec 2019 10:23:01 -0800
In-Reply-To: <20191226104220.27325-3-e@80x24.org> (Eric Wong's message of
        "Thu, 26 Dec 2019 10:42:20 +0000")
Message-ID: <xmqqzhffkku2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0B67FCA-280C-11EA-855B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> We already have pread emulation for portability, so there's
> there's no reason to make two syscalls where one suffices.
>
> Furthermore, readers of the packfile will be using mmap
> (or pread to emulate mmap), anyways, so the file description
> offset does not matter in this case.

s/description/descriptor/ probably.

After seeking to the packfile trailer and reading the pack id hash
using lseek+read, this helper function does not read from the file
descriptor, and the sole caller of it closes the file descriptor
immediately after it returns, which means the read file offset after
reading the packfile trailer does not matter.

So this conversion is correct.  Thanks for a careful analysis.

Will queue both patches.

> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  packfile.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 1821cb7a3d..7e7c04e4d8 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -576,9 +576,8 @@ static int open_packed_git_1(struct packed_git *p)
>  			     " while index indicates %"PRIu32" objects",
>  			     p->pack_name, ntohl(hdr.hdr_entries),
>  			     p->num_objects);
> -	if (lseek(p->pack_fd, p->pack_size - hashsz, SEEK_SET) == -1)
> -		return error("end of packfile %s is unavailable", p->pack_name);
> -	read_result = read_in_full(p->pack_fd, hash, hashsz);
> +	read_result = pread_in_full(p->pack_fd, hash, hashsz,
> +					p->pack_size - hashsz);
>  	if (read_result < 0)
>  		return error_errno("error reading from %s", p->pack_name);
>  	if (read_result != hashsz)
