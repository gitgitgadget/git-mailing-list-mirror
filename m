Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E28C001B0
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 22:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGKWJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGKWI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 18:08:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050FF1999
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 15:08:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F89D1AECE7;
        Tue, 11 Jul 2023 18:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GKo1nnplNAk4VeXlvZdXguXS4qUI0eYHNAEkyv
        UoQTs=; b=qE9s2bwzI+78ut8Gn7AxMd8FLuEVJ8yyndhAvYlfqeuTyi9lMbMpd2
        3ym0D2FVCcd3dV2r1JkFsFiYI/4cIzetfoWOJLLoO2ctdJHAHfuQPCHZDL55WxBu
        nFOu6WAY1EP6tO17wRUUVculcY84uaxj7SeR5Um9onkm6wXKBPR5s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 690441AECE6;
        Tue, 11 Jul 2023 18:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA5C91AECE4;
        Tue, 11 Jul 2023 18:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v3 1/3] attr.c: read attributes in a sparse directory
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-2-cheskaqiqi@gmail.com>
        <xmqqjzv6w3o2.fsf@gitster.g>
Date:   Tue, 11 Jul 2023 15:08:43 -0700
In-Reply-To: <xmqqjzv6w3o2.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 Jul 2023 14:15:25 -0700")
Message-ID: <xmqqfs5uw178.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A1A55A-2037-11EE-8318-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -	if (!path_in_cone_mode_sparse_checkout(path, istate))
>> -		return NULL;
>> +	pos = index_name_pos_sparse(istate, path, strlen(path));
>> +	pos = - pos - 2;
>>  
>> -	buf = read_blob_data_from_index(istate, path, &size);
>> -	if (!buf)
>> -		return NULL;
>> -	if (size >= ATTR_MAX_FILE_SIZE) {
>> -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
>> -		return NULL;
>> -	}
>> +	if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <= pos) {
>> +		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
>> +			return NULL;

Another thing I forgot to ask.  When we are asked to read
".gitattributes" at the top level, does this code work correctly?
As ".gitattributes" is at the root level, it won't be hidden inside
a sparsified directory in the index, and we do not have to search
for its parent.  I just wanted to see if the relative_path computation
and other things we see below will safely be skipped in such a case.

Thanks.
