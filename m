Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10B21F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 03:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeKMNIR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 08:08:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54338 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMNIR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 08:08:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB61F10DCA8;
        Mon, 12 Nov 2018 22:12:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RqJsF4tidyXUU5hA1hugxrBNcdE=; b=hpnt77
        Un4qoKy/MRJpvyPhA6HaOoIhwNQSDPHd/6tumP9+Gl2i8hPAoo3F4//fxP/RsFiB
        xvWYsTceg4BqtnpKkqJg8mA3/4Wq1svbp3KR5Gk36uZiEhNq03YWL9SQgAdr8TL0
        t5wgj+bzemnEI8aeA2hWgt6MKGzaubJpfNqRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qyl1SF32VSVQxJB2iUHV0XY7wcDC5+a2
        JxRPADXw9SF2GwgNAjm0BNhrp655fLF3ST0F0QVNWoSm+mVWsCKW37yTS7mWf5wP
        mZ0B+5xV5ObwEAI1CdEDM18RSfGVwMn6Wn9BOOTCjl2sr1d6Dyd6qOWXaNyZRgWf
        1S5LZBNIUyk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4E9D10DCA7;
        Mon, 12 Nov 2018 22:12:10 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66D6D10DCA6;
        Mon, 12 Nov 2018 22:12:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: use CXXFLAGS for linking fuzzers
References: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
Date:   Tue, 13 Nov 2018 12:12:09 +0900
In-Reply-To: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
        (steadmon's message of "Mon, 12 Nov 2018 14:02:56 -0800")
Message-ID: <xmqq36s5y8l2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8F00B94-E6F1-11E8-8E18-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> OSS-Fuzz requires C++-specific flags to link fuzzers. Passing these in
> CFLAGS causes lots of build warnings. Using separate CXXFLAGS avoids
> this.

We are not a C++ shop, so allow me to show ignorance about how
projects that are OSS-Fuzz-enabled work.  Do they use one set of
CXXFLAGS when compiling the "real thing" and a separate set (perhaps
one is subset of the other, or perhaps these two just have overlap)
of CXXFLAGS when building to link with the fuzzer?

What I am trying to get at is if this should be CXXFLAGS or
CXX_FUZZER_FLAGS.  If the OSS-Fuzz-enabled C++ projects use one set
of flags for the "main" part of the project (to produce binaries to
be run by the end users) and then link with extra flags to work with
fuzzers, I would imagine that they won't call the latter CXXFLAGS
but call it something else, and we probably should follow suit if
that is the case.

Not that we plan to (re)write the maint part of Git in C++ ever, so
I am personally OK with sacrificing the most generic CXXFLAGS macro
for the sole use of OSS-Fuzz linkage, but I'd prefer to leave the
door open so that other things like OSS-Fuzz that require C++ can be
added like your work does to the project.

Thanks.


> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bbfbb4292d..5462bc4b6b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -497,6 +497,7 @@ GIT-VERSION-FILE: FORCE
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
>  CFLAGS = -g -O2 -Wall
> +CXXFLAGS ?= $(CFLAGS)
>  LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> @@ -3098,14 +3099,14 @@ cover_db_html: cover_db
>  # An example command to build against libFuzzer from LLVM 4.0.0:
>  #
>  # make CC=clang CXX=clang++ \
> -#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> +#      CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
>  #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
>  #      fuzz-all
>  #
>  .PHONY: fuzz-all
>  
>  $(FUZZ_PROGRAMS): all
> -	$(QUIET_LINK)$(CXX) $(CFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
> +	$(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
>  		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
>  
>  fuzz-all: $(FUZZ_PROGRAMS)
