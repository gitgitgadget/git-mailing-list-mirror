Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B021F89D
	for <e@80x24.org>; Sat, 22 Jul 2017 16:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbdGVQPS (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 12:15:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62842 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752099AbdGVQPR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 12:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A972A1DBE;
        Sat, 22 Jul 2017 12:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wkralpxFZZfThQ77C/qgO1iWE1I=; b=AhlFio
        dOPODtd8KXhytCO/ZwuYtoukKCMYMx0iO2f/D27Lk9KFn75tgBA75FYknzqkwcSF
        ZY4BuV+ug71dGswXag+NBIKHKQOEvnkKRIiUS9nubFiOzxCGcspekfabJDnzwDBS
        N/90cIlt/BzmZATUw9rUFHqJFIj0nz8AgVYNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VSkAIUrY3KROhDNgAtZ+rVbZQEJOCIh3
        ceEjwtbFwLr/GOwuxQ11mqHJCoWB0uUnJ5rvjvUs9+DySzvFcXxzQEHvX5//kYrv
        48ZTVssPagWldOy+o+A5Q2xKUzncH2m5fdtzdXp+bq4fJcZ+rqI5DjiHer3j35vU
        fHfjP5rIEFs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02839A1DBD;
        Sat, 22 Jul 2017 12:15:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DB5BA1DBB;
        Sat, 22 Jul 2017 12:15:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: use access(), not lstat(), if possible
References: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox>
        <20170719171251.11906-1-jonathantanmy@google.com>
        <xmqqbmoekce5.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707221309530.4271@virtualbox>
Date:   Sat, 22 Jul 2017 09:15:08 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707221309530.4271@virtualbox> (Johannes
        Schindelin's message of "Sat, 22 Jul 2017 13:16:27 +0200 (CEST)")
Message-ID: <xmqq1sp8fnxv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEACB90A-6EF8-11E7-983D-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But this whole thread taps into a gripe I have with parts of Git's code
> base: part of the code is not clear at all in its intent by virtue of
> calling whatever POSIX function may seem to give the answer for the
> intended question, instead of implementing a function whose name says
> precisely what question is asked.
>
> In this instance, we do not call a helper get_file_size(). Oh no. That
> would make it too obvious. We call lstat() instead.

I agree with you for this case and a case like this in general.  

In codepaths at a lot lower level (they tend to be the ancient and
quite fundamental ones) in our codebase, lstat() is often directly
used by the caller because they are interested not only in a single
aspect of a path but many fields in struct stat are of interest.

When the code is interested in existence or size or whatever single
aspect of a path and nothing else, however, the code would become
easier to read if a helper function with a more specific name is
used.  And it may even help individual platforms that do not want to
use the full lstat() emulation, by telling them that other fields in
struct stat are not needed.

Of course, then the issue becomes what to do when we are interested
in not just one but a selected few attributes.  Perhaps we create a
helper "get_A_B_and_C_attributes_for_path()", which may use lstat()
on POSIX and the most efficient way to get only A, B and C attributes
on non-POSIX platforms.  The implementation would be OK, but the naming
becomes a bit hard; we need to give it a good name.

Things gets even more interesting when the set of attributes we are
interested in grows by one and we need to rename the function to
"get_A_B_C_and_D_attributes_for_path()".  When it is a lot easier to
fall back to the full lstat() emulation on non-POSIX platforms, the
temptation to just use it even though it would grab attributes that
are not needed in that function grows, which needs to be resisted by
those who are doing the actual implementation for a particular platform.
