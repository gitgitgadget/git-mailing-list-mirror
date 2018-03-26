Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1381F404
	for <e@80x24.org>; Mon, 26 Mar 2018 12:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCZMnL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 08:43:11 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59333 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751903AbeCZMnK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Mar 2018 08:43:10 -0400
X-AuditID: 12074412-3b3ff70000005f3d-7e-5ab8eaddeb7f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.B5.24381.DDAE8BA5; Mon, 26 Mar 2018 08:43:09 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCABB.dip0.t-ipconnect.de [87.188.202.187])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w2QCh5bQ029836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Mar 2018 08:43:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 0/1] Tolerate broken headers in `packed-refs` files
Date:   Mon, 26 Mar 2018 14:42:58 +0200
Message-Id: <cover.1522062649.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqHv31Y4og8+HuS26rnQzWTT0XmG2
        uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUVw2Kak5mWWpRfp2CVwZHcsvsxTM
        F6749S6sgXEefxcjJ4eEgInEq/aPrF2MXBxCAjuYJA7fWMUC4Vxikvi/8QsbSBWbgK7Eop5m
        JhBbREBNYmLbIRYQm1kgRaLjeTcjiC0s4CixrnMmWA2LgKrE9m9PwGp4Bcwl/s7exgaxTV7i
        /YL7jBBxQYmTM0FqOIDmqEusnycEMVJeonnrbOYJjLyzkFTNQqiahaRqASPzKka5xJzSXN3c
        xMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQABTawbj+pNwhRgEORiUe3gP/t0cJsSaWFVfm
        HmKU5GBSEuU1O7gjSogvKT+lMiOxOCO+qDQntfgQowQHs5IIL998oBxvSmJlVWpRPkxKmoNF
        SZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgTvjpdAjYJFqempFWmZOSUIaSYOTpDhPEDDp4DU
        8BYXJOYWZ6ZD5E8xGnP8efiyjZnjxovXbcxCLHn5ealS4rxPQUoFQEozSvPgpsGSyCtGcaDn
        hHmrQap4gAkIbt4roFVMQKu2NYGtKklESEk1MAoo9EQfED7d1WdcYspxmjnc/RtLmC+v8o4K
        ZoHG2X0pXVa8W6fftDAPm6G6fG7u4tkPF6xL/XVzO89R9vY7/Qn2YgZyXYuOq6pMO7fauHZt
        5O2ZXgX9y7Lm3W/TOe7KZGkv+k9bfaZMjvJu0/vGihE3Dx19cmT3IaXAyP8GHkINs6d9ybhn
        pMRSnJFoqMVcVJwIAAC0pon9AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to

    9308b7f3ca read_packed_refs(): die if `packed-refs` contains bogus data, 2017-07-01

we silently ignored pretty much any bogus data in a `packed-refs`
file. I think that was pretty clearly a bad policy. The above commit
made parsing quite a bit stricter, calling `die()` if it found any
lines that it didn't understand.

But there's one situation that is maybe not quite so clear-cut. The
first line of a `packed-refs` file can be a header that enumerates
some traits of the file containing it; for example,

    # pack-refs with: peeled fully-peeled 

The old code would have tolerated lots of breakage in that line. For
example, any of the following headers would have just been ignored:

    # arbitrary data that looks like a comment
    # pack-refs with peeled fully-peeled          ← note: missing colon
    # pack-refs

Now, any of the above lines are considered errors and cause git to
die.

In my opinion, that is a good thing and we *shouldn't* tolerate broken
header lines; i.e., the status quo is good and we *shouldn't* apply
this patch.

But there might be some tools out in the wild that have been writing
broken headers. In that case, users who upgrade Git might suddenly
find that they can't read repositories that they could read before. In
fact, a tool that we wrote and use internally at GitHub was doing
exactly that, which is how we discovered this "problem".

This patch shows what it would look like to relax the parsing again,
albeit *only* for the first line of the file, and *only* for lines
that start with '#'.

The problem with this patch is that it would make it harder for people
who implement broken tools in the future to discover their mistakes.
The only result of the error would be that it is slower to work with
the `packed-refs` files that they wrote. Such an error could go
undiscovered for a long time.

The tighter check was released quite a while ago, and AFAIK we haven't
had any bug reports from people tripped up by this consistency check.
So I'm inclined to believe that the existing tools are OK and this
patch would be counterproductive. But I wanted to share it with the
list anyway.

Michael

Michael Haggerty (1):
  packed-backend: ignore broken headers

 refs/packed-backend.c | 21 +++++++++------------
 t/t3210-pack-refs.sh  | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.14.2

