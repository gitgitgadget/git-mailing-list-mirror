Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A571F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeAWSNN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:13:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56665 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeAWSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:13:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88E0EC5454;
        Tue, 23 Jan 2018 13:13:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sdNdEg1ERk0QafdiM9pJsWz5MyM=; b=i+G4Wd
        eQ8F0gXgy9jp6Ic8z0tA4dfoBj+29u9OOsC6lwfFfNGAL+8UJqgJqsE60nfR2UbZ
        9P4Zy3hXZ64MtSdO6ZGkq7RC1L9BE70RcHBcns9elx5WYi57w2pi6G2YZzMndFOG
        SEzrfkgVCp2pA+feOnOj0cXUZXBvp4L9fcCao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OGR4N9PsNgn+K6sLSZYZFmpUWSTrJrSQ
        uAWrd9OtNt9yuLfQEeVUzfw5U+LRUOv4rFsyujl0LoKH3ortnSXgeqtK+6v3jlp/
        8mak3e+ZOEGVUIi8+oTVG7EDBWCrN5gvIsF140XbCn3X5H823brQ5Z0HIkufOryk
        jA6qHyW1LXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FC63C5453;
        Tue, 23 Jan 2018 13:13:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E90BDC5451;
        Tue, 23 Jan 2018 13:13:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'Torsten_B=C3=B6gershausen'?= <tboegi@web.de>,
        <randall.s.becker@rogers.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
        <20180120111012.GA26459@tor.lan>
        <xmqqshaxjzcc.fsf@gitster.mtv.corp.google.com>
        <001401d393d2$73458ef0$59d0acd0$@nexbridge.com>
Date:   Tue, 23 Jan 2018 10:13:09 -0800
In-Reply-To: <001401d393d2$73458ef0$59d0acd0$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 22 Jan 2018 17:43:34 -0500")
Message-ID: <xmqqtvvcigui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12150508-0069-11E8-A26C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> IOW, I do not see it explained clearly why this change is needed on any single
>> platform---so "that issue may be shared by others, too"
>> is a bit premature thing for me to listen to and understand, as "that issue" is
>> quite unclear to me.
>
> v4 might be a little better. The issue seems to be specific to
> NonStop that it's PIPE mechanism needs to have setbuf(pipe,NULL)
> called for git to be happy.  The default behaviour appears to be
> different on NonStop from other platforms from our testing. We get
> hung up waiting on pipes unless this is done.

I am afraid that that is not a "diagnosis" enough to allow us moving
forward.  We get hung up because...?  When the process that has the
other end of pipe open exits, NonStop does not close the pipe
properly?  Or NonStop does not flush the data buffered in the pipe?
Would it help if a compat wrapper that does setbuf(fd, NULL)
immediately before closing the fd, or some other more targetted
mechanism, is used only on NonStop, for example?  Potentially
megabytes of data can pass thru a pipe, and if the platform bug
affects only at the tail end of the transfer, marking the pipe not
to buffer at all at the beginning is too big a hammer to work it
around.  With the explanation given so far, this still smells more
like "we have futzed around without understanding why, and this
happens to work."  It may be good enough for your purpose of making
progress (after all, I'd imagine that you'd need to work this around
one way or another to hunt for and fix more issues on the platform),
but it does not sound like "we know what the problem is, and this is
the best workaround for that", which is what we want if it wants to
become part of the official codebase.
