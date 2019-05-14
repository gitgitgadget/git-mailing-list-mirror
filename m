Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDDF1F461
	for <e@80x24.org>; Tue, 14 May 2019 10:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfENKhW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 06:37:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57680 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfENKhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 06:37:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A44F262CC1;
        Tue, 14 May 2019 06:37:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eo3PTZBTePk9xwJdvIdTNJrTIm0=; b=leQEcA
        Rh0A/ZY6MvkzL2xME4Jajq6sJnHg4ZgAhBGfh2ye0GF37/NgVJY3MBkuZH3UXe8A
        cE5ao3uKK97ZA/jUkeRnMVSwTIe2rtmbS28eSDdsMv8TUIitSsn4Cygaov05+N+R
        uAKsX5EihzRWd/aMdDvNPqmEDFyw7WQnCqJLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QwITG01z4+2Ml91/tTuWWsMMvmM+2Pw7
        6CcJLrKmOXVXh2DdNyjCUPV3CMb6l6b4ejk3181OKC6G5HsxW9N0Dwt8qYQygOdT
        Ehm+Tq69bGXoaf8A1A1g4/a7VACRniPYf8WxYltGZs8ED6dZwh1NoUsCAtgsd+1b
        OPt0f0Z6ZQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AE7B62CC0;
        Tue, 14 May 2019 06:37:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BF18162CBF;
        Tue, 14 May 2019 06:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Is git-checkout's restoring d/f conflict really sane?
References: <CACsJy8Bew3i6AL_XWfhLhCvdSFYVCGoEQepi9KLmSDPVmDu5Zg@mail.gmail.com>
Date:   Tue, 14 May 2019 19:37:15 +0900
In-Reply-To: <CACsJy8Bew3i6AL_XWfhLhCvdSFYVCGoEQepi9KLmSDPVmDu5Zg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 14 May 2019 16:41:23 +0700")
Message-ID: <xmqq8sv99vac.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EF263A8-7634-11E9-9DDF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> $ echo data > one
> $ git add one
> $ rm one
> $ mkdir one
> $ echo two > one/two
> $ echo three > one/three
> $ git checkout one
> $ ls -l one
> -rw-r--r-- 1 pclouds pclouds 5 May 14 16:36 one
>
> Replacing a file is one thing. In this case we're deleting a directory
> and unknown number of files inside (in this case 'two' and 'three').
> Is this really a good thing to do?
>
> If it's not but too late to do anything about git-checkout, could
> git-restore do something better (and exactly what)?

The user said "I do not want whatever I have under name 'one' in the
working tree, and I want what I have as 'one' in the index instead",
so I tend to think that failing the request would be a disservice.

I suspect that this will become even more right thing to do, in the
new world where the no-overlay mode becomes the default.  Unlike
"checkout HEAD ."  that only adds to the set of paths in the working
tree, "restore HEAD ." will remove what's in the working tree and in
the index but not in the HEAD, no?

