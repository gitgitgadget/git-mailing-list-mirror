Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE34A20323
	for <e@80x24.org>; Tue, 14 Mar 2017 05:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750771AbdCNFwG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 01:52:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50306 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750752AbdCNFwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 01:52:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC0BA66BEE;
        Tue, 14 Mar 2017 01:52:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6n+ZfSsJPkpVaw2phZG2QFcH85Q=; b=uJ56Zj
        NKRHgxC8Az6hNuo2/jNHZpsjlJkbfDWcSpr8qgP+km7pJ0DYY7ho2cWkttvR2Uqq
        zKHvXDgSVc+qaRoOjd639drHgdEryAsHLuU8naA916UPRo0PHvgw7deRiu5OEr23
        mmIoT0/fwurEFcCgUJoO4gyTZtUXcSKvEuI30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d9rZAftwoySoXwAGSIZR+XqkEVnVI469
        xfKar0YiRB9VBMSBYM0zu7EuCTdjC8OGO1dmKj9yq9XYgbEToocg1fLt15U3BhqR
        TUPvQRYx2ctyxWA3v00aelakhcqxzWaVw3BpFEv8W7y0ISy453vP9YV4uQHXz2AF
        Y953rj/9otM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5EFD66BED;
        Tue, 14 Mar 2017 01:52:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 535F966BEC;
        Tue, 14 Mar 2017 01:52:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
        <20170313175640.14106-1-davvid@gmail.com>
        <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703132204410.3767@virtualbox>
        <xmqqinncrhey.fsf@gitster.mtv.corp.google.com>
        <20170314022030.pqqgtaavttzb7rhq@gmail.com>
Date:   Mon, 13 Mar 2017 22:52:00 -0700
In-Reply-To: <20170314022030.pqqgtaavttzb7rhq@gmail.com> (David Aguilar's
        message of "Mon, 13 Mar 2017 19:20:30 -0700")
Message-ID: <xmqqwpbsjthb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 589966DC-087A-11E7-A40A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Reading the code again, the point of add_left_or_right()
> is to populate the worktree (done later in the loop) with
> the stuff we read from Git.  Thus, if we changed just this
> section to call get_symlink() then we should not even try
> to checkout any symlink entries in !use_wt_file(...)
> block where checkout_entry() / create_symlink_file() are called.
> 
> Since the symlinks2 hashmap already populates the worktree
> then that code should instead simply skip symlinks.

OK, that would simplify things, certainly.

> I'll take a stab at adding a get_symlink() helper, adjust
> the code so that add_left_or_right() is populated, and
> special-case the checkout_entry() code path to simply skip
> over null SHA1s.

Did you mean s/null SHA1s/S_ISLNK()s/?

> One minor thing I noticed is that I had to use "echo -n"
> for the stuff coming out of strbuf_readlink(), and
> plain "echo" for entries that come in via read_sha1_file()
> content passed to add_left_or_right().
>
> That suggests that maybe I should append a newline to the
> output from strbuf_readlink() so that it matches Git.
> Does that sound right?  Does Git store symlink entries
> with a terminating newline?

Do not append a newline.  Unless the pathname of the target you are
symlinking to ends with LF, readlink() won't end with LF, and the
stand-in file shouldn't, either.

By the way, avoid "echo -n"; use "printf '%s'" instead.

Thanks.

