Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD9C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351978AbiD1UzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351995AbiD1UzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:55:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F0C0E5F
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:51:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6DA819FD56;
        Thu, 28 Apr 2022 16:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jzLNXOpejTPY4SQ9g/ODCUk+Os06Z/tMr6Wr44
        sc7FA=; b=DE9vn4hernRjJlnUBLqAk8WGVn8V4zrjUUrtAR3IEDVUa0bGABBebt
        MEsOnOera/rupIalQs0XgZ2/IHQkAaZ5VjTATHAPMTA+Pj6ZRSUa3yqLS8VEmiWJ
        Xv3j22cU1dKvyvrfw7VIe+t6gmSAYgJ/8X4e85KhrhNv8g+LW1Tvc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD23319FD55;
        Thu, 28 Apr 2022 16:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B4CB19FD54;
        Thu, 28 Apr 2022 16:51:37 -0400 (EDT)
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
Date:   Thu, 28 Apr 2022 13:51:36 -0700
In-Reply-To: <000801d85b40$ac11ec80$0435c580$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 28 Apr 2022 16:43:47
        -0400")
Message-ID: <xmqqzgk5dj8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF11D6D8-C734-11EC-8303-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>I actually made sure that is_root was posix shell compatible, but got a little carried
>>away when refactoring it to accomodate for reuse; eitherway it is gone in v3.
>
> I tried to find is_root in POSIX but could not. Do you have a reference? It is not in bash 4.3.48, which is on our older system.

What he meant was the implementation of is_root shell function he
wrote in the patch uses construct from POSIX.

        is_root() {
                test -n "$1" && CMD="sudo -n"
                test $($CMD id -u) = $(id -u root)
        }

Besides, as somebody else already pointed out, this will run random
command that is in $CMD (perhaps from tester's environment) when it
is run without $1 or an empty string in $1.  But other than that,
"id" being in POSIX.1, that looks fairly safe.  Of course, sudo and
sudo -n would not be in POSIX, but that is what this one is testing
availablity for, so it is to be expected ;-)
