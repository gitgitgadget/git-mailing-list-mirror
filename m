Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0702CA0EC6
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 00:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjILA2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjILA2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 20:28:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667EACC7
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 17:26:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9368738FC7;
        Mon, 11 Sep 2023 19:31:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=FVAw6e5lRGdZTyJCx4tqPuKL9dwyr9DZaLtvb9
        sRkDE=; b=FVMWd1ZX7/AQvEK1MMNhDrLABWlUQ5UzA4Fzd1MaX0ZF2juGnT7O5p
        /Yy4mF7SD/o6SHqDXb2AFf7rsfm/tVjNYk7KrUP5zBTs3os+apCoK56E8DLZUZuH
        GmgxUGlhHjhV5brzxVLqcYgru1dAr9Xw2FCL/9TA6HGuP+GCF2kXY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BF5F38FC6;
        Mon, 11 Sep 2023 19:31:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1307838FC5;
        Mon, 11 Sep 2023 19:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roger Light <roger@atchoo.org>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: Commit dates on conflict markers
In-Reply-To: <CAH7zdydYgSf+21GB70=gRhEcupv4e1ix==7LWCeQYgpD-1Rcmw@mail.gmail.com>
        (Roger Light's message of "Mon, 11 Sep 2023 22:02:47 +0100")
References: <CAH7zdydYgSf+21GB70=gRhEcupv4e1ix==7LWCeQYgpD-1Rcmw@mail.gmail.com>
Date:   Mon, 11 Sep 2023 16:31:06 -0700
Message-ID: <xmqq8r9cs2x1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48A662AE-50FB-11EE-95D4-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roger Light <roger@atchoo.org> writes:

> When I carry out a merge with conflicts, it's not always clear when
> resolving the conflicts which is the correct part of code to use. I
> sometimes use git blame to guide me as to the age of the different
> chunks of code and hence what to choose.
>
> I was wondering if there might be a way to help include that sort of
> information directly into the conflict.
>
> If you had a single line conflict it would be straightforward to
> display by including the date the line was last modified alongside the
> conflict marker:
>
> <<<<<<< HEAD date:yesterday
> print("please")
> ======= date:10 years ago
> print("help")
> >>>>>>> main
>
> With a more realistic change with multiple lines and context from
> different commits, it's not immediately obvious to me that it's
> possible to do in a way that isn't completely horrible.

Our conflict marker lines do get human readable labels but the
format used by merge_3way() both in merge-ort and merge-recursive
backends is hardcoded to be <branchname> ':' <pathname> and it is
sufficient to let you tell which commit involved in the merge and
which path in that commit the contents came from.

A change that only shows the commit date without allowing end user
configuration will *not* be worth doing, but allowing them to use
placeholders like '%h %s' in "git log --format='%h %s'" (check
pretty.c for the catalog) would be a good exercise; it should not
take somebody with an ultra-deep knowledge of how the code works.
