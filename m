Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4951F453
	for <e@80x24.org>; Sat,  9 Feb 2019 19:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfBITHw (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 14:07:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:48132 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBITHw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 14:07:52 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x19J7YUT061835
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 14:07:35 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
References: <20190208220751.9936-1-randall.s.becker@rogers.com> <f01141d4-e77e-24ba-2354-e7aebc2c3c57@kdbg.org> <xmqqwom8izu1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwom8izu1.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Fix v2] t5562: remove dependency on /dev/zero
Date:   Sat, 9 Feb 2019 14:07:27 -0500
Message-ID: <000801d4c0aa$b5f829a0$21e87ce0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIc/tXX6nKYZRK3AZUxuMH5inI1NwGK/39SAj4x6dilKQ3SMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 9, 2019 13:25, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > How many bytes are needed here? yes() in test-lib.sh generates only 99
> > 'y', if I am not mistaken.
> 
> I think we will not use "yes" in the end for this topic, which makes this
> comment totally irrelevant to the thread, but I wonder why we have the
limit
> of 99 there?  It cannot be "we do not want to worry about sigpipe"
affecting
> the end result of the test (after all the reader may stop reading from
after
> reading just one, and the status of the upstream process that would die
with
> sigpipe is lost anyway).
> 
> It turns out it is about sigpipe ;-) but in somewhat a different way.  To
> prevent others from wasting their time wondering about this, probably we
> want to have something like the attached?
> 
>  t/README      | 9 +++++++++
>  t/test-lib.sh | 6 +++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/t/README b/t/README
> index 1326fd7505..f4e1a82657 100644
> --- a/t/README
> +++ b/t/README
> @@ -927,6 +927,15 @@ library for your script to use.
>     test_oid_init or test_oid_cache.  Providing an unknown key is an
>     error.
> 
> + - yes [<string>]
> +
> +   This is often seen in modern UNIX but some platforms lack it, so
> +   the test harness overrides the platform implementation with a
> +   more limited one.  Use this only when feeding a handful lines of
> +   output to the downstream---unlike the real version, it generates
> +   only up to 99 lines.
> +
> +
>  Prerequisites
>  -------------
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh index 42b1a0aa7f..541a37f4c0
100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1313,7 +1313,11 @@ then
>  	fi
>  fi
> 
> -# Provide an implementation of the 'yes' utility
> +# Provide an implementation of the 'yes' utility; the upper bound #
> +limit is there to help Windows that cannot stop this loop from #
> +wasting cycles when the downstream stops reading, so do not be #
> +tempted to turn it into an infinite loop. cf. 6129c930 ("test-lib:
> +# limit the output of the yes utility", 2016-02-02)
>  yes () {
>  	if test $# = 0
>  	then

Sadly, I already the other path ready, but did not have a chance to send it.
I'm ok either way as long as I can get the tests running.

Regards,
Randall

