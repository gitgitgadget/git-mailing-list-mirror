Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953801F453
	for <e@80x24.org>; Mon, 11 Feb 2019 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfBKQ7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 11:59:10 -0500
Received: from elephants.elehost.com ([216.66.27.132]:24345 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfBKQ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 11:59:10 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1BGx6EZ089871
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 11:59:07 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Cc:     <max@max630.net>
Subject: [BUG] More on t5562 hangs randomly in subtests 6,8 and 13 in 2.21.0-rc0
Date:   Mon, 11 Feb 2019 11:59:00 -0500
Message-ID: <001901d4c22b$194bfe60$4be3fb20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_000F_01D4C200.F5B95760";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI9831LtvP1rg7wRQGztGn0+sOUTQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I have localized the hang in t5562 (previous thread) to the
invoke-with-content-length.pl script. At least on NonStop, what happens is
that the perl process hangs waiting for close($out) to complete whether
explicitly or implicitly (if the call is removed). The trace for the perl
process shows it hung at Perl_io_close (the platform's trace anyway). My
interpretation is that the reading process is still around but is no longer
reading on that pipe. If any of the processes hanging around are killed, the
structure unwinds. However, when some of the tests are run, git-http-backend
remains running after subtest 6 and/or 8 runs even if that subtest does not
hang. The presence of other git-http-backend processes seems to interfere
with subsequent tests, and if you run tests individually, subtests 6,8, and
13 consistently pass. Strangely, if a bunch of print statements are added to
another terminal explicitly, the test works consistently, so this is
sounding a bit either like a race condition or flushes are not being handled
consistently although the code appears to handle the latter case.

Simply killing old git-http-backend and/or perl processes does not make a
difference so the race may involve test contents, but I can't make that
determination. There is no correlation with system load.

That's as far as I have been able to analyze the situation at this stage.
I've CC'd the author to see whether there might be some perspective that can
come in here to help out.

This test has broken our CI process for git on NonStop, because of the hang,
so it's rather important to us to get this resolved before the official
2.21.0.

Still hoping for help on this issue,
Randall


