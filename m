Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BDF1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAaR7V (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 12:59:21 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:37830 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbfAaR7V (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Jan 2019 12:59:21 -0500
Received: from app04-neu.ox.hosteurope.de ([92.51.170.138]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gpGcP-00048T-Mo; Thu, 31 Jan 2019 18:59:17 +0100
Date:   Thu, 31 Jan 2019 18:59:17 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Martin Koegler <martin.koegler@chello.at>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Message-ID: <994568940.109648.1548957557643@ox.hosteurope.de>
In-Reply-To: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
Subject: mk/use-size-t-in-zlib [was: Re: What's cooking in git.git (Jan
 2019, #05; Tue, 29)]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev48
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1548957560;c0c4b272;
X-HE-SMSGID: 1gpGcP-00048T-Mo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> hat am 29. Januar 2019 um 23:15 geschrieben:

[...]

> * mk/use-size-t-in-zlib (2018-10-15) 1 commit
>  - zlib.c: use size_t for size
> 
>  The wrapper to call into zlib followed our long tradition to use
>  "unsigned long" for sizes of regions in memory, which have been
>  updated to use "size_t".
> 

I've started playing around with the patch from Thorsten [1] for getting unsigned long replaced in more places so that you can commit large files on platforms like Windows there unsigned long is 32-bit even on 64-bit OSes.

And the first thing which bugs out when I do a quick test with committing a large file and fsck the repo is in zlib.c:

	if (s->z.total_out != s->total_out + bytes_produced)
		BUG("total_out mismatch");

here s->z.total_out is an unsigned long and s->total_out is size_t and this triggers the BUG message once the unsigned long wraps. There is even an FAQ entry for zlib at [2] which warns about that potential issue.

So I would think that something like

----------->8

diff --git a/zlib.c b/zlib.c
index 197a1acc7b..9cc6421eba 100644
--- a/zlib.c
+++ b/zlib.c
@@ -51,13 +51,9 @@ static void zlib_post_call(git_zstream *s)

        bytes_consumed = s->z.next_in - s->next_in;
        bytes_produced = s->z.next_out - s->next_out;
-       if (s->z.total_out != s->total_out + bytes_produced)
-               BUG("total_out mismatch");
-       if (s->z.total_in != s->total_in + bytes_consumed)
-               BUG("total_in mismatch");

-       s->total_out = s->z.total_out;
-       s->total_in = s->z.total_in;
+       s->total_out += bytes_produced;
+       s->total_in += bytes_consumed;
        s->next_in = s->z.next_in;
        s->next_out = s->z.next_out;
        s->avail_in -= bytes_consumed;

-----------8<

would make the patch [3] more complete IMHO.

Another potential issue in that patch is that the signature change in git_deflate_bound forces size to unsigned long on the call to deflateBound (for newer zlib versions) and if that conversion is not faithful this will certainly not work.

Just my 2cents I'm not vetoing anything here,
Thomas

[1]: http://public-inbox.org/git/20181120050456.16715-1-tboegi@web.de/
[2]: http://www.zlib.net/zlib_faq.html#faq32
[3]: http://public-inbox.org/git/20181012204229.11890-1-tboegi@web.de/
