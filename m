Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451FA1F45F
	for <e@80x24.org>; Tue,  7 May 2019 04:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEGE57 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 00:57:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63301 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfEGE57 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 00:57:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3EF113D438;
        Tue,  7 May 2019 00:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tK97q6EDkQeuk6CPRUleEBW7SEQ=; b=OUPBF1
        n+YSG8QshkSX28c4vHHNYqGkLw4Y7hu3i7yr+Ghpa4QozoyOxK08wQUDbN5Ib0Bf
        sUGswvFytgZYax+596UI0ADQ3VIjSad034JYS3RlFR/QztX3uESHB6mM6wF7vEyf
        dob8sbSBwsM8IKW8vA6fARcPKtaPHWP7QDMl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lAEzf8Zo7r5TDvFHp9TRZZXugBq9ErJj
        jJ33EZfNG+Zg2WBLoE7oCVC8evCun6IVvzexkeum9oJkuBPhzlqjq757Nj02VtSu
        oQnKPs5Hnla6b+7Ys8Wc+/vkIA8p3wS1yHdhpecbYOFszJrPd4zDKW3baNLisekr
        r9LNpL/E68o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7C8F13D436;
        Tue,  7 May 2019 00:57:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E83113D435;
        Tue,  7 May 2019 00:57:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 00/16] Add new command 'restore'
References: <20190411131218.19195-1-pclouds@gmail.com>
        <20190425094600.15673-1-pclouds@gmail.com>
        <20190507022127.GA220818@google.com>
Date:   Tue, 07 May 2019 13:57:55 +0900
In-Reply-To: <20190507022127.GA220818@google.com> (Emily Shaffer's message of
        "Mon, 6 May 2019 19:21:27 -0700")
Message-ID: <xmqqd0kun9nw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD90125C-7084-11E9-92AA-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Then, figuring that I only had a few files, I thought I'd type them
> each, with the exception of a .c/.h pair:
>
> g restore --staged builtin/log.c builtin/walken.c revision.*
>
> Because I had build artifacts present, this vomited while trying to
> unstage revision.o, and again left me with all my changes still staged.
> revision.o is validly ignored:
>
> $ g check-ignore revision.o                               
> revision.o

Often a claim "validly ignored" by users needs to be taken with a
grain of salt.  When it is in the index, it is no longer ignored.

Assuming that you do not have revision.o in the index, and if
"restore" is still "checkout -- <pathspec>" in disguise, then I
think you could ask "git" not your shell to expand the asterisk, by
protecting it from the shell, i.e.

	$ git restore --staged revision.\*

and the pathspec should not match untracked revision.o.  And if that
does not work, you found a bug in restore, I think ;-).
