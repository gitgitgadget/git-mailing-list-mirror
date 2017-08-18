Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B335F208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbdHRTrF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:47:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60802 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751935AbdHRTrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:47:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69DE7B0CF2;
        Fri, 18 Aug 2017 15:47:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w+xjgSQaqCrlFPUFnJeRIkKY2l8=; b=adle90
        eEs83V6HxteSYb++t1wENQH725keI0xcTb+FH0G1N21CLmF+46JUnLWUmEOu2Hyr
        vK3FmBcW16KGF05iCk9jvj1B8hsvONuQ0ymt4FdVe7wrnvB2rwIx4PqDmapilRC6
        /quourf3CKkP/EybX3xmrbEMZqxhquEs22oYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZBHMiPJMwyRj/yB2OSLZdAWr3aoEBao/
        3OEozsw9fIPlWOrgAb8Gno07MIhmkfUaJjG/HExPyJPy1IyVVzF2oEgYxt3s27/n
        6CLRAlakgEoM5zAYsk0j8m2o0SrB6rtA32ClK565cYyyccaqrsSE+GPoQSKUqXB7
        gR3tY7ZyUNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62D23B0CF1;
        Fri, 18 Aug 2017 15:47:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B538FB0CEF;
        Fri, 18 Aug 2017 15:47:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v4 4/4] commit: rewrite read_graft_line
References: <cover.1503020338.git.patryk.obara@gmail.com>
        <cover.1503079879.git.patryk.obara@gmail.com>
        <9a4548f1d0832d036cad152771339d853b5885f3.1503079879.git.patryk.obara@gmail.com>
        <CAJfL8+T3vqnmFJmx19H-v8yGiY4Se78SM+ax_q07_PF4VHDv3Q@mail.gmail.com>
Date:   Fri, 18 Aug 2017 12:47:00 -0700
In-Reply-To: <CAJfL8+T3vqnmFJmx19H-v8yGiY4Se78SM+ax_q07_PF4VHDv3Q@mail.gmail.com>
        (Patryk Obara's message of "Fri, 18 Aug 2017 20:38:25 +0200")
Message-ID: <xmqqefs8bqvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 010FCDFC-844E-11E7-9B36-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Actually, I don't think I needed to remove free(graft) line, but I don't
> know if freeing NULL is considered ok in git code. Let me know if I
> should bring it back, please.

Either free(graft) or assert(!graft) is fine, but we should have one
of them there.  I'll add assert(!graft) there while queuing, at
least for now.

In the current code, when the control reaches the bad_graft_data
label, 'graft' must be NULL, or there is a bug in our code.  Because
we are parsing exactly the same input using the same helper routines
in both passes, we should see failure during the first pass before
'graft' points to an allocated piece of memory.  So it may be a good
idea to have assert(!graft) there than free(graft); the latter would
sweep a potential bug under the carpet.

If this were a part of the system whose design is still fluid (it is
not), it is not implausible that we would later want to add new test
that jumps to the bad_graft_data label.  For example, after the
"runs exactly twice" loop, we may add a new test that iterates over
the graft->parents[] to ensure that there is no duplicate and jumps
to bad_graft_data when we find one.

If we add assert(!graft) there today, and if such an enhancement
forgets to replace it with free(graft), the assert() will catch the
mistake.  If we have neither, it makes it more likely that such an
enhancement leaves a possible memory leak in its error codepath.

Thanks.
