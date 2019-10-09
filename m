Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDB01F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfJIBTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:19:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53307 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfJIBTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:19:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29EC682B93;
        Tue,  8 Oct 2019 21:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rnAzjk+3Uz37y1Lt4A9OJK7QD80=; b=r8cbHC
        BS22xwZO8cuj5Ya312br8FOKFHLdiqyXYYYRKM8AH8Uyy0PJ3kepTF6ZGCV+Q2ov
        7zDWP3GvlGJSRAXyAOE3c3I2A5fZz+sDOsjUcb2PUI5gXuCUMTHtehv7Miz4y6WA
        vAQ8DsC3UoAi8Bx1V6MCX0xM9wdpg4/AYstAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NVWq+UD1IQ4bRdIvCcmgr6F81Mbni4in
        cdZdIOyFZZYzgkLsy1bTHu7xhhuKAgXVuy/Rj6hA7aKgb4BM2ZWd7Y6hdJBqRxLX
        x9MgPLVHYqpwGV5lkEhELiDp4zyT8HAtNQ6xKZAnA9ZVoSSWRvgrW3o14Ddn+sGx
        yQU3cLh6N6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 225D982B91;
        Tue,  8 Oct 2019 21:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E51382B90;
        Tue,  8 Oct 2019 21:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
References: <pull.378.git.gitgitgadget@gmail.com>
        <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com>
        <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org>
Date:   Wed, 09 Oct 2019 10:19:44 +0900
In-Reply-To: <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org> (Johannes Sixt's
        message of "Tue, 8 Oct 2019 23:03:35 +0200")
Message-ID: <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E175D44E-EA32-11E9-8AE9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> We do not want to have it for *all* cases, where we return -1 - pos, but
> only for those cases, where the result was actually encoded by
> index_pos_to_insert_pos().

Yup, I agree with you that decoder should be fed only the data
emitted by the encoder.

But shouldn't the code that yielded 'pos' that later gets decoded by
computing "-1 -pos" without using the encoding helper be corrected
to use the encoder instead?  After all, the primary purpose of
inventing the encoder was to catch the arith overflow, wasn't it?

> That excludes all cases where the argument is
> derived from index_name_pos(), and leaves just...
>
>> --- a/rerere.c
>> +++ b/rerere.c
>> @@ -154,7 +154,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
>>  		rr_dir->status = NULL;
>>  		rr_dir->status_nr = 0;
>>  		rr_dir->status_alloc = 0;
>> -		pos = -1 - pos;
>> +		pos = insert_pos_to_index_pos(pos);
>
> ... this one...
>
>>  
>>  		/* Make sure the array is big enough ... */
>>  		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
>> diff --git a/sha1-name.c b/sha1-name.c
>> index 49855ad24f..bee7ce39ee 100644
>> --- a/sha1-name.c
>> +++ b/sha1-name.c
>> @@ -98,7 +98,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>>  		loose_objects = odb_loose_cache(odb, &ds->bin_pfx);
>>  		pos = oid_array_lookup(loose_objects, &ds->bin_pfx);
>>  		if (pos < 0)
>> -			pos = -1 - pos;
>> +			pos = insert_pos_to_index_pos(pos);
>
> ... and this one.
>
>>  		while (!ds->ambiguous && pos < loose_objects->nr) {
>>  			const struct object_id *oid;
>>  			oid = loose_objects->oid + pos;
>
> -- Hannes
