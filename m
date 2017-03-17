Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6B320951
	for <e@80x24.org>; Fri, 17 Mar 2017 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdCQUaf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 16:30:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751250AbdCQUad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 16:30:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC07F7B11D;
        Fri, 17 Mar 2017 16:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8TOmagk+fz/i3Rj66gws2WrR2qc=; b=Ukr83T
        P0eNZsLvYEh+PdQP4ldi42Pq08SThojchiZ4K+pHBojvG4LIkme9pRG4/dc3xpnc
        zCdetrX5AJGVP6exqq9XSgfEjHxveOkMRrFJkwBZBIAqiHCD3WTTP2sWyXUh/X28
        RePcWy0Jqajzr5RQd3+OuVKnWa9wb5+2vB84c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PqdoYpmqcVNQE8GYHZcKH0MIsLzjqQ++
        fZ+HZTYPGsxJf9OLKNBUO3vwpz6DyNc0YX+GHFolxNONsCXDSFWets1yutfryA1u
        tv6Bui3BQpq2GezA5hMo6UsU1yeLTBGdan0F4le20dOLOw4fE7O/7r9QmP/Cap7o
        lo/BDgaxrWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B47387B11C;
        Fri, 17 Mar 2017 16:30:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22A717B11B;
        Fri, 17 Mar 2017 16:30:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
References: <20170314221100.24856-1-bmwill@google.com>
        <20170317172257.4690-1-bmwill@google.com>
        <20170317172257.4690-3-bmwill@google.com>
        <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
        <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
        <20170317192103.GE110341@google.com>
Date:   Fri, 17 Mar 2017 13:30:30 -0700
In-Reply-To: <20170317192103.GE110341@google.com> (Brandon Williams's message
        of "Fri, 17 Mar 2017 12:21:03 -0700")
Message-ID: <xmqqy3w363yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90C48518-0B50-11E7-A43A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ...  I was being cautious with this patch since git didn't currently
> read GIT_PREFIX.

Ahh, I forgot about that.  Processes we spawn do expect GIT_PREFIX
to tell them where the original $cwd was and they also do expect
that "git" invoked by them would not be affected by GIT_PREFIX
environment variable.  So we cannot change that now.

If you recurse into sub-sub module, it is likely that you would want
to update the TOPLEVEL_PREFIX relative to that sub-sub module you
are descending into.

That probably also means that processes we spawn now need to also
pay attention to TOPLEVEL_PREFIX in addition to GIT_PREFIX, and we
should NOT re-export what we got from TOPLEVEL_PREFIX to GIT_PREFIX.
I.e. if a "git" process started from src/ subdirectory of the
superproject that goes into module/sub1/ submodule, top-level prefix
may export ../src/ to point at the original location, but the
process that is running in the submodule will be running at the root
level of the submodule working tree, so its prefix should be NULL or
"", no?

Adjusting pathspec and other file references on the caller's side,
instead of exporting toplevel-prefix to have them adjusted by the
callee, started to smell more and more like an easier/more correct
approach to me, but perhaps I haven't thought things deeply enough.

I dunno.

