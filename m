Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21221F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeIGIGe (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:06:34 -0400
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:59536
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbeIGIGd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Sep 2018 04:06:33 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id y7Qqflmwh0Gwuy7QxfZbrQ; Thu, 06 Sep 2018 20:27:48 -0700
Date:   Fri, 7 Sep 2018 06:27:40 +0300
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180907032740.GA20545@jessie.local>
References: <20180906193516.28909-1-max@max630.net>
 <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfOgFFR5crQRhxZWLGP2zYdt2VBxd6VXoCOktGD6WFp9hsA5JJVS4OGVe+arG7ZzELDM3FuKBliU+U5RKc1IY2lTl6+bnjYO6Su3QygdpkmAoeWKeJpZ1
 RtcMbekg3SV25mULDgCKiNvbSuzKcGfnPHPYXjUySi1vsU8cAL3Ti2nRitElqEbBd3uz1yLdqCxW6EF+EZ92IbWHFQCErdRodxhr3RXHFdY+NRWQ/FLnLY0R
 MYqtad1BPaftwq0Wj7iK+mCSuSMlZAsM/p4M6ZTLErjFNOoDtdT0h9YLKWsqqzHz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 02:54:18PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
>> This should fix it. I'm not sure should it treat it as 0 or "-1"
>> At least the tests mentioned by Jeff fails if I try to treat missing CONTENT_LENGTH as "-1"
>> So keep the existing behavior as much as possible
> 
> I am not sure what you mean by the above, between 0 and -1.  The
> code signals the caller of get_content_length() that req_len is -1
> which is used as a sign to read through to the EOF, so it appears to
> me that the code treats missing content-length (i.e. str == NULL
> case) as "-1".

I made a mistake in this, it should be "if I try to treat missing
CONTENT_LENGTH as 0". This, as far as I understand, what the
RFC specifies.

That is, after the following change, the test "large fetch-pack
requests can be split across POSTs" from t5551 starts faliing:

-- >8 --
@@ -353,8 +353,12 @@ static ssize_t get_content_length(void)
        ssize_t val = -1;
        const char *str = getenv("CONTENT_LENGTH");
 
-       if (str && *str && !git_parse_ssize_t(str, &val))
-               die("failed to parse CONTENT_LENGTH: %s", str);
+       if (str && *str) {
+               if (!git_parse_ssize_t(str, &val))
+                       die("failed to parse CONTENT_LENGTH: %s", str);
+       } else
+               val = 0;
+
        return val;
 }
