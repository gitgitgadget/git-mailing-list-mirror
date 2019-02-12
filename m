Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1C11F453
	for <e@80x24.org>; Tue, 12 Feb 2019 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfBLUvE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 15:51:04 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:31295 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfBLUvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 15:51:04 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43zZYw45QKz5tlC;
        Tue, 12 Feb 2019 21:51:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EC6BE4388;
        Tue, 12 Feb 2019 21:50:59 +0100 (CET)
Subject: Re: [Patch v1 3/3] t5562: replace /dev/zero with a pipe from
 generate_zero_bytes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
 <20190209185930.5256-4-randall.s.becker@rogers.com>
 <CAPig+cQY57w9rmGzVifKMTMVwt209b959iL9+K79AMfEgiVTfg@mail.gmail.com>
 <xmqqd0nwex7w.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f3b506bb-52eb-3a1f-ba3d-0cf327271ab2@kdbg.org>
Date:   Tue, 12 Feb 2019 21:50:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0nwex7w.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.19 um 18:24 schrieb Junio C Hamano:
>>> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
>>> @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
>>>  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>>>         NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
>>> -       env \
>>> +       generate_zero_bytes infinity  | env \
>>>                 CONTENT_TYPE=application/x-git-upload-pack-request \
>>>                 QUERY_STRING=/repo.git/git-upload-pack \
>>>                 PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>>>                 GIT_HTTP_EXPORT_ALL=TRUE \
>>>                 REQUEST_METHOD=POST \
>>>                 CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
>>> -               git http-backend </dev/zero >/dev/null 2>err &&
>>> +               git http-backend >/dev/null 2>err &&
> 
> Doesn't this "inifinity" mode have the same issue that was worked
> around by 6129c930 ("test-lib: limit the output of the yes utility",
> 2016-02-02) on Windows?  If I read correctly, the process upstream
> of the pipe (in this case, perl producing a stream of infinite NULs)
> would not die when the downstream stops reading with SIGPIPE.

I think we do not have to worry, and the reason is that the
justification for 6129c930 is simply wrong.

As I did not find the patch series discussed here to pull and test, I
repeated the timing tests with t7610-mergetool.sh with and without
6129c930 reverted, and the difference is only in the noise. The reason
t7610 takes so long on Windows looks more like a consequence of the
10,000 processes that it spawns. It is a mystery to me how I came to the
conclusion that the change in 6129c930 would make a difference. :-(

-- Hannes
