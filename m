Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375DE1F4F8
	for <e@80x24.org>; Mon, 10 Oct 2016 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbcJJKjK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 06:39:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45229 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751479AbcJJKjJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Oct 2016 06:39:09 -0400
X-AuditID: 12074413-991ff70000000a14-59-57fb6e9e66ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.96.02580.E9E6BF75; Mon, 10 Oct 2016 06:34:07 -0400 (EDT)
Received: from [192.168.69.190] (p57906111.dip0.t-ipconnect.de [87.144.97.17])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u9AAY58Q011363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 10 Oct 2016 06:34:06 -0400
Subject: Re: [PATCH 2/2] files_read_raw_ref: prevent infinite retry loops in
 general
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
 <20161006164842.yzrdigfimzvgkubv@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d01fa7f9-827c-fc56-2d4d-69ba87ae851a@alum.mit.edu>
Date:   Mon, 10 Oct 2016 12:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161006164842.yzrdigfimzvgkubv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqDs/73e4wYuv6hZdV7qZLH609DA7
        MHk8693D6PF5k1wAUxSXTUpqTmZZapG+XQJXxq4nF1kLNrNUvL27jLWBcTdzFyMnh4SAicSn
        ZV9Zuhi5OIQELjNKPNm2jhXCOcck8ezwH3aQKmGBMIn9G3vBbBEBI4kbH76xgdhCArUSD3ev
        BbPZBHQlFvU0M4HYvAL2Egtv/2cFsVkEVCV+Pl4Ltk1UIETi98bpLBA1ghInZz4BszkFXCT2
        LrwOZjMLqEv8mXeJGcKWl9j+dg7zBEa+WUhaZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i
        5MS8vNQiXXO93MwSvdSU0k2MkMAT3sG466TcIUYBDkYlHt4Xlb/ChVgTy4orcw8xSnIwKYny
        Jp74ES7El5SfUpmRWJwRX1Sak1p8iFGCg1lJhNcy53e4EG9KYmVValE+TEqag0VJnFdtibqf
        kEB6YklqdmpqQWoRTFaGg0NJglcqF6hRsCg1PbUiLTOnBCHNxMEJMpwHaLggSA1vcUFibnFm
        OkT+FKMux4Ift9cyCbHk5eelSonzPge5QACkKKM0D24OLGG8YhQHekuY9xjIKB5gsoGb9Apo
        CRPQEpbFP0CWlCQipKQaGGWnXZjwoHp3/frJbVPaGP8V2nW1Otm1LtfaonQiPfB/w/2dHZyz
        A5dcWOS2/s435Y8BzcG7Fl7+IbyvIrfm8u6AzU2uPcHR663mP+7UE94qmxV06KKej4nTwsX8
        29u77rf/ff6TIXNTR8SZYHa2gs6e36fXn1nUt3PKz8q5M6/bN3LO6yndEazEUpyRaKjFXFSc
        CACCP+XE8wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2016 06:48 PM, Jeff King wrote:
> Limit the number of retries to 3. That should be adequate to
> prevent any races, while preventing the possibility of
> infinite loops if the logic fails to handle any other
> possible error modes correctly.
> 
> After the fix in the previous commit, there's no known way
> to trigger an infinite loop, but I did manually verify that
> this fixes the test in that commit even when the code change
> is not applied.
> [...]

This patch is

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

