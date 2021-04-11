Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D2C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3060FE8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhDKUbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:31:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65375 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKUba (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 16:31:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E45EABE3B2;
        Sun, 11 Apr 2021 16:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5pf7gvjBsn2sd96cU+Jl1Z97iEc=; b=DzTu9C
        6t/42tsgWStN0kQG/Kw2kLGAWgTlj8v95xO+nMHkAtfDFbI2pO3ReKALtu211Sdm
        d6rFg3zUGoHbzUtFXeWCS+p4B3qy7+p7TT0YWgjn2jLeDShiHrZDf9UGEImW2p2n
        7szpi/sjW6RV8MMVRlg1qfli2pBzBuDTphsBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ovZqnkQijq6i4Xv80jM9ZXTqC2An9WcD
        oAMt167z3z+1WLDVIUhxTYFJ8uxLUd0zSLcv0AA4zbje8d/k874ZaAOw4dQ2aH7e
        LWftROZXoNOTl6dBI12yZyk5SRxISpRyPrzrV/8RcekebKfgdgpnSUhv3QYkHdu3
        /R/doQPYFmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1DD5BE3B1;
        Sun, 11 Apr 2021 16:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55EE3BE3B0;
        Sun, 11 Apr 2021 16:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
References: <20210411095538.34129-1-mirucam@gmail.com>
        <20210411095538.34129-4-mirucam@gmail.com>
Date:   Sun, 11 Apr 2021 13:31:12 -0700
In-Reply-To: <20210411095538.34129-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Sun, 11 Apr 2021 11:55:37 +0200")
Message-ID: <xmqqy2doftrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBBCFFEE-9B04-11EB-8A3A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> +		if (res < 0 || 128 <= res) {
> +			error(_("bisect run failed: exit code %d from"
> +				" '%s' is < 0 or >= 128"), res, command.buf);

Good now.

> +		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
> +		saved_stdout = dup(1);
> +		dup2(temporary_stdout_fd, 1);
> +
> +		res = bisect_state(terms, args.v, args.nr);
> +
> +		dup2(saved_stdout, 1);
> +		close(saved_stdout);
> +		close(temporary_stdout_fd);

In v2, we just let bisect_state() to write to our standard output,
which was the reason why the loss of "cat" in the "write to
BISECT_RUN file and cat it to show to the user" in the scripted
version in v2 was OK.  Now, we are writing out, just like the
scripted version did, to BISECT_RUN, the user does not see its
contents.

Does the distinction matter?  Christian, what's your call on this?

If it does not matter, then the code and tests are good as-is, but
if it does, the fact that you posted this round without noticing any
broken tests means that we have a gap in the test coverage.  Can we
have a new test about this (i.e. at the end of each round in "bisect
run", the output from bisect_state() is shown to the user)?

> +		if (res == BISECT_ONLY_SKIPPED_LEFT)
> +			error(_("bisect run cannot continue any more"));
> +		else if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> +			printf(_("bisect run success"));
> +			res = BISECT_OK;
> +		} else if (res) {
> +			error(_("bisect run failed:'git bisect--helper --bisect-state"
> +			" %s' exited with error code %d"), args.v[0], res);
> +		} else {
> +			exit = 0;
> +		}
