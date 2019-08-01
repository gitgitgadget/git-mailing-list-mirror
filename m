Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B9A1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfHAReR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 13:34:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHAReR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 13:34:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D85E164791;
        Thu,  1 Aug 2019 13:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCop7DPo/90mbTucO+yz2eE1ITI=; b=JFNQ+9
        Qn55LjRA/zOlauV2d5E8ohsyunMcJgzGSVjbQwUQZxQ3xA8q+3AM8AhHjyykKxJ+
        mVQ0vkSSL5A4zg8lGvcxgkl5H5539vgUx/TwP1npY78DNRRc/eBSFzq+XDbWVoEl
        Xx5R+r99YKTfLoVSRYmPnxQCbFnmig+DkYIgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wvx9mOos53M5lsg0HLwkotQ1fRIXPU0I
        8E1E1QTZ0bh3igVMiPfK3E0WIfPKiZAQ8rVqSebVT6BuG/RS2cnBCs1YFfIsKt+Y
        AbdRXOo7cQKbZemVdgYzkhw1XumwKX8P5SNauNYyBToxnmnHWvmqVc+vdVWhpAGc
        VcwRy5K3yM8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65A74164790;
        Thu,  1 Aug 2019 13:34:15 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF8A316478F;
        Thu,  1 Aug 2019 13:34:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] checkout.c: unstage empty deleted ita files
References: <20190726045645.2437-1-vcnaik94@gmail.com>
        <20190801160756.12601-1-vcnaik94@gmail.com>
Date:   Thu, 01 Aug 2019 10:34:13 -0700
In-Reply-To: <20190801160756.12601-1-vcnaik94@gmail.com> (Varun Naik's message
        of "Thu, 1 Aug 2019 09:07:56 -0700")
Message-ID: <xmqq4l30okmi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94EAF0F4-B482-11E9-B2C2-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> It is possible to delete a committed file from the index and then add it
> as intent-to-add. After `git checkout HEAD`, the file should be
> identical in the index and HEAD.

We should write this as `git checkout HEAD <pathspec>`; with the
command without the <pathspec> form, the files changed in various
ways should not be changed with it at all.

	$ echo modified >>file1
	$ rm file2
	$ git rm --cached file3 && git add -N file3
	$ git checkout HEAD
	M	file1
	D	file2
	M	file3

> `git checkout HEAD` calls tree.c:read_tree_1(), with fn pointing to
> checkout.c:update_some(). update_some() creates a new cache entry but
> discards it when its mode and oid match those of the old entry. A cache
> entry for an ita file and a cache entry for an empty file have the same
> oid. Therefore, an empty deleted ita file previously passed both of
> these checks, and the new entry was discarded, so the file remained
> unchanged in the index. After this fix, if the file is marked as ita in
> the cache, then we avoid discarding the new entry and add the new entry
> to the cache instead.

Thanks; the flow of thought above is quite straight-forward to
follow.


