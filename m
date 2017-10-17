Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37C11FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761111AbdJQVIN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:08:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760969AbdJQVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:08:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ACF69AA0B;
        Tue, 17 Oct 2017 17:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CDUaCWirAKTiBpThr0s011WU850=; b=ta5vbg
        HCoFSHy1V8MJub+Sev9+AnH6C0JSSGydnWJEaGPK8UINi7Sy8BzWpzuvS+bUshAh
        zFb1SvQKftz3ytRFiAkPLB6Z70gO9Yqt0v2UsYJdR9xHnGkHObPy/9/s09IwADzv
        r6AEU4VRrT3WqRlP0QCQBzBGhbDI5ytgj8l0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OI0BEF5CWqWJqUxl/l1h7dwG998eXhKe
        q3cwV/zhOXG1Xad8yqe7InOpszQAWU3i2fuISc4C8KXdjaVbsAgH3SBrO85yf6O6
        7D/S99Jplg6oaIi6snMusRaf8Qx+T3CVP63fJ9WmnHtAriHIo1XBDKxPBlR1fI6n
        abzejA5CzVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 240669AA0A;
        Tue, 17 Oct 2017 17:08:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A06B99AA09;
        Tue, 17 Oct 2017 17:08:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Nikolay Yakimov <root@livid.pp.ru>, git@vger.kernel.org,
        Anders Kaseorg <andersk@mit.edu>
Subject: Re: Multiple paths in GIT_EXEC_PATH
References: <CA+A=rXEyQ4aQL=p55f_+kbbrnDyDr9ULSq9gqBE2YE9y6+oJ3w@mail.gmail.com>
        <20171017155625.GE19335@alpha.vpn.ikke.info>
Date:   Wed, 18 Oct 2017 06:08:10 +0900
In-Reply-To: <20171017155625.GE19335@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Tue, 17 Oct 2017 17:56:25 +0200")
Message-ID: <xmqqo9p5mqit.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4880F908-B37F-11E7-AE5A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> The commit that changed what you described is 1073094f3 (git-sh-setup:
> be explicit where to dot-source git-sh-i18n from., 2016-10-29). That
> commit claims there were already scripts that assumed GIT_EXEC_PATH is
> just a single entry. That commit was included in v2.11.
>
> There was also a recent thread[0] about it that discussed this issue,
> where someone stated that indeed treating GIT_EXEC_PATH with the same
> semantics as PATH has been broken for a while, but it seems there are no
> real plans to fix it.

The variable was never meant to have more than one path concatenated
with ':' from day one.

In C code we've used it as a leading directory path to tack a
command name to form a path to give to exec(3), without any
intention to have it a list of paths, which is split at ':'.
sh-setup was doing "PATH=$GIT_EXEC_PATH:$PATH" without rejecting a
value in GIT_EXEC_PATH with a colon in it but that was merely being
lazy and made it "work" by accident.

