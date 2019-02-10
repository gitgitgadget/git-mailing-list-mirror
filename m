Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BAF1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBJAQE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Feb 2019 19:16:04 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41679 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfBJAQE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 19:16:04 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1A0FuKT078278
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 19:15:56 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>, "'Duy Nguyen'" <pclouds@gmail.com>
References: <004901d4bff7$2e17dc50$8a4794f0$@nexbridge.com> <20190209042404.GA18286@sigill.intra.peff.net> <000501d4c0a2$683b78f0$38b26ad0$@nexbridge.com> <20190209233246.GB7135@sigill.intra.peff.net>
In-Reply-To: <20190209233246.GB7135@sigill.intra.peff.net>
Subject: RE: [Possible Breakage] t1308 - Bad return value from test-tool
Date:   Sat, 9 Feb 2019 19:15:48 -0500
Message-ID: <000001d4c0d5$c972ad90$5c5808b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFP7fuNublZkJLXRWkPs2MwF1xnIAIEfDc4AkthSGkDEfpLLqamv0aA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 9, 2019 18:33, Jeff King wrote:
> On Sat, Feb 09, 2019 at 01:08:01PM -0500, Randall S. Becker wrote:
> 
> > > It sounds like you might need to set FREAD_READS_DIRECTORIES in your
> > > config.mak.
> >
> > Setting FREAD_READS_DIRECTORIES = UnfortunatelyYes
> 
> Silly question, but you did rebuild after setting that, not just re-run the tests,
> right?

Yes make was run, but some doofus (me) did not run make tests first, so test-tool was out of date, post reconfigure. When just a code change is made, test-tool gets build. I was/am confused.

> > still results in
> >
> > Value not found for "foo.bar"
> > test_expect_code: command exited with 1, we wanted 2 test-tool config
> > configset_get_value foo.bar a-directory not ok 23 - proper error on
> directory "files"
> > #
> > #               echo "Error (-1) reading configuration file a-directory." >expect
> &&
> > #               mkdir a-directory &&
> > #               test_expect_code 2 test-tool config configset_get_value foo.bar
> a-directory 2>output &&
> > #               grep "^warning:" output &&
> > #               grep "^Error" output >actual &&
> > #               test_cmp expect actual
> > #
> >
> > I don't think that helped. While fopen can open a directory, fread
> > does not return any data in this platform. readdir or nftw/ftw are
> > pretty much the only options. However, the code still goes down the
> > goto exit1 path in this situation.
> 
> Hrm. That's the exact case FREAD_READS_DIRECTORIES is supposed to help.
> It does an fstat() after fopen()ing the file to see if it points to a directory, and
> if so closes it immediately and returns EISDIR.
> 
> Can you confirm via debugger (or printf statements) that we make it into
> git_fopen, and what the resulting st.st_mode we see looks like?

It did not get into git_fopen at all. Subtest 1 did, but that's no surprise.

t1308 is passes now, finally. Patch coming.

Thanks for the help,
Randall



