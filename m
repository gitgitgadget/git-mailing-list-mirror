Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6DC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhK2UuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:50:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62982 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhK2UsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 15:48:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B1CE16E221;
        Mon, 29 Nov 2021 15:44:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K0Pr7oU25C8dOlpV2MSLAcgM1P9J4FlUxIcUQP
        fDsbs=; b=UQYF2J6rePfH6QMEaxy+MsHoax/y7UFdvtTRHRZlFj/8FywcgaLt+f
        pbyVk/YRKhWbnUSJYLn5QRvbqLFiOqzq1UNDjF4RGRDqRxdT/XfHDxIJmtPanzJN
        4bZzqYK2h94QhOXxSu8Jk8JCPgq/nc3SFSJy4FsLoD8+UTXLMfLWk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B72B16E220;
        Mon, 29 Nov 2021 15:44:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A2B516E21F;
        Mon, 29 Nov 2021 15:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v3 2/5] object-file.c: handle undetermined oid in
 write_loose_object()
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
        <20211122033220.32883-3-chiyutianyi@gmail.com>
        <47b3e2ad-4fa1-040a-24c1-6da0445bd1a5@gmail.com>
Date:   Mon, 29 Nov 2021 12:44:43 -0800
In-Reply-To: <47b3e2ad-4fa1-040a-24c1-6da0445bd1a5@gmail.com> (Derrick
        Stolee's message of "Mon, 29 Nov 2021 10:10:39 -0500")
Message-ID: <xmqqsfve669w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F183E22-5155-11EC-82BF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> My first reaction is to not write into .git/objects/ directly, but
> instead make a .git/objects/tmp/ directory and write within that
> directory. The idea is to prevent leaving stale files in the
> .git/objects/ directory if the process terminates strangely (say,
> a power outage or segfault).

Even if we know the name of the object we are writing beforehand, I
do not think it is a good idea to open-write-close the final object
file.  The approach we already use everywhere is to write into a
tmpfile/lockfile and rename it to the final name 

object-file.c::write_loose_object() uses create_tmpfile() to prepare
a temporary file whose name begins with "tmp_obj_", so that "gc" can
recognize stale ones and remove them.

> If this was an interesting idea to pursue, it does leave a question:
> should we clean up the tmp/ directory when it is empty? That would
> require adding a check in finalize_object_file() that is probably
> best left unchecked (the lstat() would add a cost per loose object
> write that is probably too costly). I would rather leave an empty
> tmp/ directory than add that cost per loose object write.

I am not sure why we want a new tmp/ directory.
