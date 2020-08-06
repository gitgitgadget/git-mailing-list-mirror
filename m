Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9FC433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BF321744
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jzw33kd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFXrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:47:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61801 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFXrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 19:47:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78A26808A2;
        Thu,  6 Aug 2020 19:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=X
        X1RSFNePnyg2YfNB86xCmUiMac=; b=Jzw33kd0NaDQzBrHkim//J+xXb8ICSRW8
        mDqgQDkDfD1fzJdhR4i/FKipc7IoR9kyPxl4HDrLHcLxyTfmKWirGt6ntyryy+Q8
        AwQu1pTPdkNRFCFYEGfPKPgga+uQNOw2sMOHsujCr/5LrKbXgOHMEZ/Sl9Gj5xAV
        zsIsAwtJAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=nau
        Q8CJ7nfCrkgpCY6q12/yVK1vJEzEgyYjI895J48WnlVfYKVCfQoI5aXeieT0nqIy
        NhDuLOgcGreXanTzA5tV/JU43Ri6Bo681pFq+oArbmHI1DwW9PYzIEVuWHtLh6hm
        TXHpVxCqNVLyq0pDbrZllw9N7JPQb06c6SMiUaaw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FF55808A1;
        Thu,  6 Aug 2020 19:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0101B808A0;
        Thu,  6 Aug 2020 19:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: "#define precompose_argv(c,v) /* empty */" is evil
Date:   Thu, 06 Aug 2020 16:47:34 -0700
Message-ID: <xmqqy2mribft.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33B42E68-D83F-11EA-A986-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had seen an interesting compilation breakage today.  A topic adds
many more uses of argv-array API so I resolved semantic conflict
patch until "make builtins/submodule-helper.o" passed.  I failed to
spot one remaining breakage until I saw

    https://travis-ci.org/github/git/git/jobs/715668996

The problematic line was

    precompose_argv(diff_args.argc, diff_args.argv);

where diff_args used to be an argv_array and is now a strvec.

Why didn't I catch this in my local test?

$ git grep -n -e precompose_argv -- \*.h
compat/precompose_utf8.h:31:void precompose_argv(int argc, const char **argv);
git-compat-util.h:256:#define precompose_argv(c,v)

The problematic part is this one used on all platforms other than macOS:

    /* used on Mac OS X */
    #ifdef PRECOMPOSE_UNICODE
    #include "compat/precompose_utf8.h"
    #else
    #define precompose_str(in,i_nfd2nfc)
    #define precompose_argv(c,v)
    #define probe_utf8_pathname_composition()
    #endif

I am wondering if it is a good idea to use something like

    static inline void precompose_argv(int argc, const char **argv)
    {
	; /* nothing */
    }

instead.  As long as the compiler is reasonable enough, this should
not result in any code change in the result, except that it would
still catch wrong arguments, even if these two parameters are unused
and optimized out.

