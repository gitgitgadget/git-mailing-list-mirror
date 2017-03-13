Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530F820373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbdCMUVH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:21:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51439 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752355AbdCMUVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:21:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DD958496B;
        Mon, 13 Mar 2017 16:20:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=skFcC9RZBzH+rcLJMgYhLRYOlr4=; b=IxzkaU
        I9R3w0z9OhMfeGwsxDUbnomcrLJI1Ah4ZiG+d2GHONDcTk7lNP6G4ncRA+IpYo/n
        Axh3c6m7NuirLPFdApNUi4n2iArhjuPkxGa0VpTLAnmP0lX/uhcnJQ2MfDuo+PdZ
        NTLTcSNXq0hKTXB3+c6oIvY3ps3LhshiIaSnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pSXxr8ch7aDUF73VaCL70UThUjJ8Alfw
        Hvr++Sf5lWYBwbq7am/4c5ZKiR7lAWjV2IsXaCVuG7iBG+HFslffwHgQ3TYKZCD1
        3lqm4vrbhMMBLnxn6s9hW7nDzquLZ3KeanX3/q1QRniXUI4KTIoowMo/UpIvNu2o
        pl630F5lEko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 067CC8496A;
        Mon, 13 Mar 2017 16:20:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59B5284969;
        Mon, 13 Mar 2017 16:20:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid die()ing
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de>
        <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703131826330.3767@virtualbox>
        <xmqqzigpq7qp.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Mar 2017 13:20:57 -0700
In-Reply-To: <xmqqzigpq7qp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Mar 2017 12:47:26 -0700")
Message-ID: <xmqqvardq66u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91B6E458-082A-11E7-983C-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The former case may split into two.  "Yes I agree that is bad and it
> is the same badness as the version without this change", in which
> case we may want to leave a "NEEDSWORK" comment in-code so that
> people can notice when browsing the code (but fixing the badness
> would be outside the scope of the series), and "yes that is bad and
> we shouldn't introduce that badness", in which case we do want to
> fix it in the patch.

We however need to be a bit careful here, though.

When a patch series is refactoring an existing function to be used
in different codepaths, an existing issue inherited from the
original code (e.g. perhaps an existing error checking that is
looser than ideal) may have been OK in the original context (e.g.
perhaps it died and refused to run until the user corrected the
repository), and it still is OK in the codepath that uses the
refactored building blocks to replace the original code, but it may
not be acceptable to leave the issue in the original code when a new
caller calls the refactored building block (e.g. perhaps the
refactoring made it possible for a caller to ask the function not to
die and instead act on different kinds of errors in different ways).

So "being bug-to-bug compatible with existing code" is not always a
good thing---we need to see case by case if a problem identified in
the review as inherited from the original needs to be addressed in
the series.

It would be better to address issues we identify even if it is an
old one.  After all, any change has potential to introduce new bugs,
and striving to leave known bug inherited from the old code around
would guarantee that the resulting code will be buggier than the
original ;-) 

But in order to keep bisectability, such "further fixups" should be
done as a follow-up to the series, not as part of it.
