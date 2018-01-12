Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CD21F406
	for <e@80x24.org>; Fri, 12 Jan 2018 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965304AbeALXKT (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 18:10:19 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17577 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965260AbeALXKS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 18:10:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0CNABqx025008
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Jan 2018 18:10:11 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "'Tanay Abhra'" <tanayabh@gmail.com>,
        "'Matthieu Moy'" <git@matthieu-moy.fr>
References: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com> <xmqqd12ewx1v.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd12ewx1v.fsf@gitster.mtv.corp.google.com>
Subject: RE: [ANNOUNCE] Git v2.16.0-rc2 - breakages in t1308 and 1404
Date:   Fri, 12 Jan 2018 18:10:05 -0500
Message-ID: <008f01d38bfa$7eba9bc0$7c2fd340$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHHiNv2BEqC34ia2FxRCk/aLMaSEAHvubufo3lb6YA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 12, 2018 5:08 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > It looks like the exit code is coming back as 1 not 2. There is also a
> > file except vs expect.
> > ./trash directory.t1308-config-set: ls a-directory  actual  config2
> > except  expect  output  result
> 
> The test that leaves "except" does look wrong.  The relevant part looks
like
> this:
> 
>     test_expect_success 'find value with highest priority from a
configset' '
>             echo hask >expect &&
>             test-config configset_get_value case.baz config2 .git/config
>actual &&
>             test_cmp expect actual
>     '
> 
>     test_expect_success 'find value_list for a key from a configset' '
>             cat >except <<-\EOF &&
>             sam
>             ...
>             EOF
>             test-config configset_get_value case.baz config2 .git/config
>actual &&
>             test_cmp expect actual
>     '
> 
> The invocations of test-config in these two tests look exactly the same,
at
> least to me, so whatever comes out of the command and stored in 'actual'
> must match what the first test stored in 'expect'
> and compared the same as 'actual' in that test.
> 
> So the second test is probably asking a wrong question to test-config but
> because it prepares an expected answer in a wrong file, it did not even
> notice that it is asking a wrong question X-<.
> 
> The wrong test comes from 4c715ebb ("test-config: add tests for the
> config_set API", 2014-07-28); I do not know offhand if the author of that
> change is still around.
> 
> Having said all that, I suspect that the "except" thing may not have
anything
> to do with what you are observing; sorry for not ending up to be very
helpful
> X-<.

Sadly, fixing the "except" thing causes the test to break now. I can't make
sense of the intent of this, unless the test is to find unmatching keys and
it really does mean "except"
--- expect      2018-01-12 23:03:41 +0000
+++ actual      2018-01-12 23:03:41 +0000
@@ -1,5 +1 @@
-sam
-bat
 hask
-lama
-ball

[case]
baz = lama
[my]
new = silk
[case]
baz = ball

