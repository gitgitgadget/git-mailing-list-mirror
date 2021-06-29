Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F7C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B1661D9A
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 21:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhF2VgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 17:36:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhF2VgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 17:36:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C069CDB1E;
        Tue, 29 Jun 2021 17:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uumSdbRp+nMrQJc/pV7lLARfwgdFM9FUhSJB+xnV1cM=; b=nF2X
        zc8Qn0UdW3QS75o/DDPxmI1tlFRMTa3R14TzaiSusnq1Y1wj/DI8fTpNr/NTHnEw
        K4NEf3V265M4AyGAUtZ9eqFT1SW7q0JzAbGp+7EdYhOdnfbEVr9wnp2YxYrPc26G
        IS93jBGGVBJtD+hnVVAhEE61dh4+5+bLu9fKP24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62B05CDB1D;
        Tue, 29 Jun 2021 17:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB1D1CDB1C;
        Tue, 29 Jun 2021 17:33:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [HOLD 3/4] check_packed_git_idx: attempt to handle ENOMEM from
 mmap
References: <20210629081108.28657-1-e@80x24.org>
        <20210629081108.28657-4-e@80x24.org> <20210629202101.GA18279@dcvr>
Date:   Tue, 29 Jun 2021 14:33:49 -0700
Message-ID: <xmqqbl7owe2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B171FCE8-D921-11EB-A0C0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Eric Wong <e@80x24.org> wrote:
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -97,7 +97,11 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
>>  		close(fd);
>>  		return error("index file %s is too small", path);
>>  	}
>> -	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
>> +	do {
>> +		idx_map = xmmap_gently(NULL, idx_size, PROT_READ, MAP_PRIVATE,
>> +					fd, 0);
>> +	} while (idx_map == MAP_FAILED && errno == ENOMEM
>> +		&& unuse_one_window(p));
>
> Oops, I dropped extra error handling here :x
>
>>  	close(fd);
>>  
>>  	ret = load_idx(path, hashsz, idx_map, idx_size, p);


Something like this, perhaps?  You'd also need _() around the error
message you added to object-file.c in [2/4], I would think.

 packfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git c/packfile.c w/packfile.c
index 2904560f52..b31f14ecb7 100644
--- c/packfile.c
+++ w/packfile.c
@@ -102,6 +102,10 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 					fd, 0);
 	} while (idx_map == MAP_FAILED && errno == ENOMEM
 		&& unuse_one_window(p));
+	if (idx_map == MAP_FAILED) {
+		close(fd);
+		return error_errno(_("%s cannot be mapped"), path);
+	}
 	close(fd);
 
 	ret = load_idx(path, hashsz, idx_map, idx_size, p);
