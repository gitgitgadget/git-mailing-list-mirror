Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F9C20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDCLIi (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:08:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45423 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfDCLIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:08:38 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:51723)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hBdkx-0001Pi-Rz; Wed, 03 Apr 2019 07:08:35 -0400
Received: from x2f3b1a1.dyn.telefonica.de ([2.243.177.161]:47716 helo=lola)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hBdkv-0002Vq-1Y; Wed, 03 Apr 2019 07:08:34 -0400
From:   David Kastrup <dak@gnu.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
References: <20190402115625.21427-1-dak@gnu.org>
        <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 03 Apr 2019 13:08:30 +0200
In-Reply-To: <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 03 Apr 2019 16:45:09 +0900")
Message-ID: <87ftqz5osx.fsf@fencepost.gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> When a parent blob already has chunks queued up for blaming, dropping
>> the blob at the end of one blame step will cause it to get reloaded
>> right away, doubling the amount of I/O and unpacking when processing a
>> linear history.
>>
>> Keeping such parent blobs in memory seems like a reasonable optimization
>> that should incur additional memory pressure mostly when processing the
>> merges from old branches.
>
> Thanks for finding an age-old one that dates back to 7c3c7962
> ("blame: drop blob data after passing blame to the parent",
> 2007-12-11).
>
> Interestingly, the said commit claims:
>
>     When passing blame from a parent to its parent (i.e. the
>     grandparent), the blob data for the parent may need to be read
>     again, but it should be relatively cheap, thanks to delta-base
>     cache.
>             
> but perhaps you found a case where the delta-base cache is not all
> that effective in the benchmark?

The most relevant contribution is in a linear history where the diff
between commit and parent is followed by the diff between parent and
grandparent.  It seems wasteful to recreate the blobs in this case.  Of
course this is also the case where any close cache layers are more
likely to still be warm, so the savings may be less apparent.  They are
likely more for deep delta chains in long histories where the
delta-chain cache is more thoroughly exercised.

-- 
David Kastrup
