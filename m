Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8706EC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiK3WK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiK3WKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 17:10:05 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE63950F0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:09:38 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA0215B65A;
        Wed, 30 Nov 2022 17:09:36 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        3qyzfpAgZiLrjlN/jDNVcDuNGDX2MvURHjjYuLxqH6o=; b=l1PaRaroQs0qepUx
        C3OiuGQBniiqUrF1o+E0A/cqw435sLUf3dUm3HwqnnDHTzEqnJlLQoV23wmLV2Jp
        Nol01l3mchU8A49/5zhiYP30/Y7NUuWHvI/4PidB0Vjnwhu623CWxx1vPbSGxM+3
        FTo/HIBtfHdw5un7ZHohvzHhyMQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2EC015B659;
        Wed, 30 Nov 2022 17:09:36 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2799C15B658;
        Wed, 30 Nov 2022 17:09:36 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 30 Nov 2022 17:09:34 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: t5559-http-fetch-smart-http2 failures
Message-ID: <Y4fUntdlc1mqwad5@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: AD237C70-70FB-11ED-8E29-307A8E0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I started seeing failures in rc0 but I was distracted by the
long weekend.

The changes in 73c49a4474 (t: run t5551 tests with both HTTP
and HTTP/2, 2022-11-11) seem to rather frequently trigger
test failures on Fedora.

The most frequent test to fail is "large fetch-pack requests
can be sent using chunked encoding" (t5559.30), but earlier
tests have also failed on occasion.  For the common failure,
the test exits with:

    expecting success of 5559.30 'large fetch-pack requests can be sent using chunked encoding': 
	    GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
		    clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
	    {
		    test_have_prereq HTTP2 ||
		    grep "^=> Send header: Transfer-Encoding: chunked" err
	    }
    +++ GIT_TRACE_CURL=true
    +++ git -c http.postbuffer=65536 clone --bare http://127.0.0.1:5559/smart/repo.git split.git
    error: last command exited with $?=128
    not ok 30 - large fetch-pack requests can be sent using chunked encoding

(Less frequently, I've seen the last command exit 141.)

I haven't been able to track down the problem, which happens
a lot on the Fedora build system but less often during local
builds.  Obviously, the bug is too shy to show itself while
anyone is watching. ;)

I can easily disable the failing tests for a bit, but does
anyone have an idea what might be the cause or how to better
debug it when it occurs on a buildsystem without direct
access?

Thanks,

-- 
Todd
