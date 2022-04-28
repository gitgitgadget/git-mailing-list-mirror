Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B8C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 22:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiD1WZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiD1WZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 18:25:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E67DE21
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 15:21:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06CE9110BC1;
        Thu, 28 Apr 2022 18:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOHp/FcG2YVQAuTjArOYJskAsQ1H9s7n2fNNDG
        y1bEA=; b=gykKn/0+w2KKZZr60O7+yRpjylPRP7DwAMLBVlSc3huyLzBvQyGHxc
        CD7+DVo+OFO1lo/S9lkOmMIexkCf61pKm5xJONrJlsLIgnWi2zNbIZZkMrwHNVKr
        A93fuFWljiKKJGVtKVEB0BLk2VM24rjznpgJeWaWVudot+K8CBAYM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1398110BC0;
        Thu, 28 Apr 2022 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B744110BBF;
        Thu, 28 Apr 2022 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Carlo Arenas'" <carenas@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
        <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
        <000801d85b40$ac11ec80$0435c580$@nexbridge.com>
        <CAPUEspgcd1CYTfL=ug3WtnOrJscWbyQXeF-2SQ_24KcCTkuRkA@mail.gmail.com>
        <000f01d85b4a$af8c3aa0$0ea4afe0$@nexbridge.com>
Date:   Thu, 28 Apr 2022 15:21:46 -0700
In-Reply-To: <000f01d85b4a$af8c3aa0$0ea4afe0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 28 Apr 2022 17:55:28
        -0400")
Message-ID: <xmqqczh0etmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97B88006-C741-11EC-8AD1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>is_root() {
>>  id -u >u
>>  id -u root >r
>>  cmp u r
>>}
>
> This is about as portable as I can find and works even in ksh. It could be optimized.
>
> is_root() {
>   id -u >u
>   id -u root >r
>   cmp -s u r
>   if [ $? -ne 0 ]; then
>     echo 0
>   else
>     echo 1
>   fi
> }
>
> if [ `is_root` -ne 0 ]; then
>         echo root
> else
>         echo Not root
> fi

The above looks very roundabout way.  With the first three in
is_root that ends with "cmp", we already know from its exit status
if "id -u" output for ourselves matches that for root, i.e. if we
are root then cmp would have exited with 0.

So with the first one I quoted from your quote, the caller can say

	if is_root
	then
		echo root
	else
		echo not root
	fi

without turning the exit status into string "0" or "1" and comparing
that string with "[ `cmd` -ne 0 ]".  And the first one is just as
portable.  I agree that running cmp with "-s" is probably a good
idea.

What I used to often use in my previous life (in previous century)
is technically incorrect, but is a lot more succinct and works well
in practice on any sanely installed systems.  Just see if the root
directory is writable.  No sane system makes it writable by anybody
but root.

I.e.

	if test -w /
	then
		... we are running as root ...
	else
		... we are not running as root ...
	fi
