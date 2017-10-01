Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF5920A10
	for <e@80x24.org>; Sun,  1 Oct 2017 23:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbdJAX3n (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 19:29:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62645 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJAX3n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 19:29:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADC52B58BD;
        Sun,  1 Oct 2017 19:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gkqECCWDtQSdFmd8ESbNdlIk/y4=; b=JF9KU2
        wNoplC1paFYZoA5KS0o7uN0toSesx2M3cZ+F3EwwRHwhcfKuvZ99I1KfJTkFbyXE
        rpsrRJFCGhTJ1OjZ11F5wg+FrhnEUftwnS9WjmKeROBS9YZtn/2ZoJwFmPX71Zo1
        7Kwk32b8VWlSBJ/5qv6f+PsY+h98ViM4e3xX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=imDCUoEvjWjaB+q+IJlXCkG9BT/1Ogwx
        lrry5hNBq4aVUxxoP95HNGhaF/yvp6oMi2rCyNJl/nVYjeCsW4Q3LN20lH5KPeKX
        YUSENFRXfhIHcSSRPqHEtWCNx0oUgHEvTlpSfvJ+XZr36nrcCr1PUd/aK5kziY0e
        T62jRaGklPs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A39BCB58BC;
        Sun,  1 Oct 2017 19:29:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27376B58BB;
        Sun,  1 Oct 2017 19:29:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-stash" explanation of "--include-untracked" and "--all" seems ambiguous
References: <alpine.LFD.2.21.1709290650530.1446@localhost.localdomain>
        <20171001201604.GA30301@hank>
Date:   Mon, 02 Oct 2017 08:29:40 +0900
In-Reply-To: <20171001201604.GA30301@hank> (Thomas Gummerer's message of "Sun,
        1 Oct 2017 21:16:04 +0100")
Message-ID: <xmqqtvzitpjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66A0A9B4-A700-11E7-A8B9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> This is fine when --include-untracked is specified first, as --all
> implies --include-untracked, but I guess the behaviour could be a bit
> surprising if --all is specified first and --include-untracked later
> on the command line.
>
> Changing this could possibly break someone that just adds parameters
> to their 'git stash' invocation, but I'm tempted to say allowing both
> at once is a bug, and change it to make git die when both are
> specified.

I am on the fence.

If this were --include=untracked vs --include=all, then I'd say your
suggestion will violate the usual expectation of "on the command
line, last one wins", but "--include-untracked" and "--all" are
spelled very differently, and may not look all that related to a
casual reader, so the expectation for "the last one wins" might be
weaker than usual.

But once we start complaining to a command line that has both,
saying they are mutually exclusive, people will realize that they
are very much closely related options, even though spelled quite
differently.  And at that point, they will find it very unreasonable
that we do not follow the usual "the last one wins" rule but error
out X-<.

If I really cared deeply about these two options [*1*], I would
think that the ideal longer term direction would be to introduce
--include={untracked,all-crufts} to replace and deprecate the
current two options.  And then we make sure --include=* forms follow
the usual "last one wins" rule.


[Footnote]

*1* I personally don't, but that does not mean I will block efforts
    by others who do to make this part of the system better.
