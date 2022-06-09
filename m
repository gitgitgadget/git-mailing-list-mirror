Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFEBC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 18:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbiFIS1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345415AbiFIS1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 14:27:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF35FD36B
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 11:27:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71BC71A974F;
        Thu,  9 Jun 2022 14:27:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sc3RTr09Jcu4jD2OzvD16IG7trKgd2CVoJVwxw
        /wewI=; b=OTMgIixycWo1I4O8Rd7iuBhtylUHnNo7nleN88Ycx+yYHVSN0c23Ye
        cBhZwLR2VOOPXqQohXK4FpQoDdixHab8xaDPbX89z7FsZnjI8ziZHp+YS1Al4ixC
        srzj+jXmmq5yNjfBk09Dldvc+XHfPNgyGU3YbFzv1GtZH/pFrkLZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69FFE1A974E;
        Thu,  9 Jun 2022 14:27:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 094ED1A974D;
        Thu,  9 Jun 2022 14:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v13 1/7] unpack-objects: low memory footprint for
 get_data() in dry_run mode
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
        <xmqqpmjl7i7y.fsf@gitster.g>
        <CAO0brD2s-i2Bp7r2n+TRLs2LckzM-i1-293rr=sgmC2TbLozow@mail.gmail.com>
Date:   Thu, 09 Jun 2022 11:27:42 -0700
In-Reply-To: <CAO0brD2s-i2Bp7r2n+TRLs2LckzM-i1-293rr=sgmC2TbLozow@mail.gmail.com>
        (Han Xin's message of "Thu, 9 Jun 2022 12:10:09 +0800")
Message-ID: <xmqqa6allmjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA975568-E821-11EC-AE63-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

>> I am not sure if this is not loosening the error checking in the
>> dry-run case, though.  In the original code, we set the avail_out
>> to the total expected size so
>>
>>  (1) if the caller gives too small a size, git_inflate() would stop
>>      at stream.total_out with ret that is not STREAM_END nor OK,
>>      bypassing the "break", and we catch the error.
>>
>>  (2) if the caller gives too large a size, git_inflate() would stop
>>      at the true size of inflated zstream, with STREAM_END and would
>>      not hit this "break", and we catch the error.
>>
>> With the new code, since we keep refreshing avail_out (see below),
>> git_inflate() does not even learn how many bytes we are _expecting_
>> to see.  Is the error checking in the loop, with the updated code,
>> catch the mismatch between expected and actual size (plausibly
>> caused by a corrupted zstream) the same way as we do in the
>> non dry-run code path?
>>
>
> Unlike the original implementation, if we get a corrupted zstream, we
> won't break at Z_BUFFER_ERROR, maybe until we've read all the
> input. I think it can still catch the mismatch between expected and
> actual size when "fill(1)" gets an EOF, if it's not too late.

That is only one half of the two possible failure cases, i.e. input
is shorter than the expected size.  If the caller specified size is
smaller than what the stream inflates to, I do not see the new code
to be limiting the .avail_out near the end of the iteration, which
would be necessary to catch such an error, even if we are not
interested in using the inflated contents, no?

