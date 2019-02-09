Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE661F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfBISIQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Feb 2019 13:08:16 -0500
Received: from elephants.elehost.com ([216.66.27.132]:29174 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 13:08:16 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x19I88Qd057586
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 13:08:08 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>, "'Duy Nguyen'" <pclouds@gmail.com>
References: <004901d4bff7$2e17dc50$8a4794f0$@nexbridge.com> <20190209042404.GA18286@sigill.intra.peff.net>
In-Reply-To: <20190209042404.GA18286@sigill.intra.peff.net>
Subject: RE: [Possible Breakage] t1308 - Bad return value from test-tool
Date:   Sat, 9 Feb 2019 13:08:01 -0500
Message-ID: <000501d4c0a2$683b78f0$38b26ad0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFP7fuNublZkJLXRWkPs2MwF1xnIAIEfDc4ptFDloA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 23:24, Jeff King wrote:
> On Fri, Feb 08, 2019 at 04:42:19PM -0500, Randall S. Becker wrote:
> 
> > t1308 has me perplexed - this is an old breakage on the NonStop
> > platform, that I have just gotten around to checking with the new bash
> > version we have. When running sub-test 23, the following was reported:
> >
> > Value not found for "foo.bar"
> > test_expect_code: command exited with 1, we wanted 2 test-tool config
> > configset_get_value foo.bar a-directory
> >
> > However, when I looked inside t/helper/test-config.c, every path
> > reporting "Value not found" has a goto exit1 not exit2. It seems, from
> > the code, that the test is actually incorrect and should be expecting
> > 1 not 2, and that it is working properly on NonStop (but the test fails as a
> result).
> 
> We're expecting it to report an error reading the directory, not "value not
> found". Which would yield code 2.
> 
> It sounds like you might need to set FREAD_READS_DIRECTORIES in your
> config.mak.

Setting FREAD_READS_DIRECTORIES = UnfortunatelyYes

still results in 

Value not found for "foo.bar"
test_expect_code: command exited with 1, we wanted 2 test-tool config configset_get_value foo.bar a-directory
not ok 23 - proper error on directory "files"
#
#               echo "Error (-1) reading configuration file a-directory." >expect &&
#               mkdir a-directory &&
#               test_expect_code 2 test-tool config configset_get_value foo.bar a-directory 2>output &&
#               grep "^warning:" output &&
#               grep "^Error" output >actual &&
#               test_cmp expect actual
#

I don't think that helped. While fopen can open a directory, fread does not return any data in this platform. readdir or nftw/ftw are pretty much the only options. However, the code still goes down the goto exit1 path in this situation. 

Perplexed,
Randall

