Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D931FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756562AbcLPSoR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 13:44:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62575 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755951AbcLPSoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 13:44:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1905B556F2;
        Fri, 16 Dec 2016 13:43:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SNpsCjGVoU+qI5qHjIuDbZeB/cs=; b=wrsBMx
        YDLdFCNhTtQy2WlydF8JCCj6xP1MhahrgSJn+KUFCtowRTGe7PmRnAly1p6xS2rN
        W/BUXw0vVDz2lH5Ka3QmW7wYnlr1XUwjW5gzJ3ZeXDLq1gYwc72zIwlMkvFkEV+R
        QJ2Qz+BFZhZIO8j5jRa4QT20h+SdYveanKT1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q79xCIH5ONPl0QchTjWaA1CxfeFNw8gA
        VJhegzh3wADoP9MLhqaxDCjXFqhYdI/+WOaPdG4LcaW3k/ShWniMgY5GIdN0GKbk
        /5gc3mq/yzUm5k7d9zQ4m059S7unZw7eXS8uPU+JEGWmC9xN3t6PsQV0NZVoIE9R
        k0A0T/dUL4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02B8F556F1;
        Fri, 16 Dec 2016 13:43:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47C5A556EF;
        Fri, 16 Dec 2016 13:43:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        stefan.naewe@atlas-elektronik.com, gitter.spiros@gmail.com
Subject: Re: [RFC/PATCH] Makefile: suppress some cppcheck false-positives
References: <20161214112401.mq3n5kui5eeebdtk@sigill.intra.peff.net>
        <20161215232240.19427-1-judge.packham@gmail.com>
Date:   Fri, 16 Dec 2016 10:43:48 -0800
In-Reply-To: <20161215232240.19427-1-judge.packham@gmail.com> (Chris Packham's
        message of "Fri, 16 Dec 2016 12:22:40 +1300")
Message-ID: <xmqqshpnsoij.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95579422-C3BF-11E6-96D3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Packham <judge.packham@gmail.com> writes:

> -CPPCHECK_FLAGS = --force --quiet --inline-suppr $(if $(CPPCHECK_ADD),--enable=$(CPPCHECK_ADD))
> +CPPCHECK_SUPP = --suppressions-list=nedmalloc.supp \
> +	--suppressions-list=regcomp.supp
> +
> +CPPCHECK_FLAGS = --force --quiet --inline-suppr \
> +	$(if $(CPPCHECK_ADD),--enable=$(CPPCHECK_ADD)) \
> +	$(CPPCHECK_SUPP)

Has it been agreed that it is a good idea to tie $(CPPCHECK_ADD)
only to --enable?  I somehow thought I saw an objection to this.

> diff --git a/nedmalloc.supp b/nedmalloc.supp
> new file mode 100644
> index 000000000..37bd54def
> --- /dev/null
> +++ b/nedmalloc.supp
> @@ -0,0 +1,4 @@
> +nullPointer:compat/nedmalloc/malloc.c.h:4093
> +nullPointer:compat/nedmalloc/malloc.c.h:4106
> +memleak:compat/nedmalloc/malloc.c.h:4646
> +
> diff --git a/regcomp.supp b/regcomp.supp
> new file mode 100644
> index 000000000..3ae023c26
> --- /dev/null
> +++ b/regcomp.supp
> @@ -0,0 +1,8 @@
> +memleak:compat/regex/regcomp.c:3086
> +memleak:compat/regex/regcomp.c:3634
> +memleak:compat/regex/regcomp.c:3086
> +memleak:compat/regex/regcomp.c:3634
> +uninitvar:compat/regex/regcomp.c:2802
> +uninitvar:compat/regex/regcomp.c:2805
> +memleak:compat/regex/regcomp.c:532
> +

Yuck for both files for multiple reasons.  

I do not think it is a good idea to allow these files to clutter the
top-level of tree.  How often do we expect that we may have to add
more of these files?  Every time we start borrowing code from third
parties?

What is the goal we want to achieve by running cppcheck?  

 a. Our code must be clean but we do not bother "fixing" [*1*] the
    code we borrow from third parties and squelch output instead?

 b. Both our own code and third party code we borrow need to be free
    of errors and misdetections from cppcheck?

 c. Something else?

If a. is what we aim for, perhaps a better option may be not to run
cppcheck for the code we borrowed from third-party at all in the
first place.  

If b. is our goal, we need to make sure that the false positive rate
of cppcheck is acceptably low.


[Footnote]

*1* "Fixing" a real problem it uncovers is a good thing, but it may
    have to also involve working around false positives reported by
    cppcheck, either by rewriting a perfectly correct code to please
    it, or adding these line-number based suppression that is
    totally unworkable.  Like Peff, I'm worried that we will end up
    with two static checkers fighting each other, and no good way to
    please both.
