Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61ED1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeK1PRw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:17:52 -0500
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net ([173.201.193.237]:35412
        "EHLO p3plsmtpa09-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbeK1PRw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 10:17:52 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id RrI9gdfMQGKVWRrIBglI7W; Tue, 27 Nov 2018 21:17:40 -0700
Date:   Wed, 28 Nov 2018 06:17:37 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, peff@peff.net,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5562: do not reuse output files
Message-ID: <20181128041737.GI5348@jessie.local>
References: <20181124070428.18571-1-max@max630.net>
 <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
 <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
 <20181124130337.GH5348@jessie.local>
 <xmqqlg5g1tjj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlg5g1tjj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMc7sNxll6rmLhaKMn323wvZfblAtEiEpYRz05SzrWLLJjFqbXhJJscfKtsK7GCeFOpKtJUPAG4XN8RH/Wc3wZ4C2+q1pWityaHcsFOBY9FBZ/XILN7O
 HEzbyLzVoer1gHO9NVVdt4P3uesg6CXcUTCQE4KQHoknGrx333wdQFkWKV4LiCVEaGd7FyQ9WrioSjIQ8sHtShkhp0hsCaSh6ixPiXv9c++Y31R8XMHN+w3d
 5FFHKoE8S3N9yvAs/o9tZl6z7o98WoPrAtk3jb7SAM4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 11:06:40AM +0900, Junio C Hamano wrote:
> I am offhand not sure what the right value of wait_after_clean for
> this codepath be, though.  46df6906 ("execv_dashed_external: wait
> for child on signal death", 2017-01-06) made this non-default but
> turned it on for dashed externals (especially to help the case where
> they spawn a pager), as the parent has nothing other than to wait
> for the child to exit in that codepath.  Does the same reasoning
> apply here, too?

As far as I understand, the reason to _not_ wait was that
the child might still be expecting closed stdin even after
receiving SIGTERM, so parent would wait forever. But this is
not clearly the case here. And otherwise there should be no
reason to not wait, as long as we are interested in
synchronous exiting of the child.

In my Linux experiments the child was exiting because of signal
earlier than because of closed stdin, but who knows, maybe
with some bad luck the signal would be delivered after the
closed stdin, and we would still have the issue. After all,
at Linux it was mostly working even without fix.
