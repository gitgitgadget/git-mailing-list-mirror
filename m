Return-Path: <SRS0=5lEM=AQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB75C433E0
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 05:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651B020874
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 05:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iL4Dr0Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgGEF2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 01:28:24 -0400
Received: from mout.web.de ([212.227.15.4]:54951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgGEF2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 01:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593926887;
        bh=4aGm+y05OsVEMSJg/esRlm60INmtTqGwnfbT+do1oPg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iL4Dr0KsiwJeLIMyuJmg/FB6qvv8UmjC/IQhIVImAjSgdH4KV/luendvsdWLAypzp
         xZiSN938pCKgGRKBS1RNRr0hajEoaYpC0VVQzlQo2PLP44HeiPL6szyRXT8l690PIT
         PxKNuLjMtpEa6UwLMzx7b6PteTgnm5ZH79Lt+kDI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyUha-1kxeEb2NNO-015uPM; Sun, 05
 Jul 2020 07:28:07 +0200
Subject: Re: [PATCH v12 5/5] read-cache: speed up has_dir_name (part 2)
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Brandon Williams <bwilliamseng@gmail.com>
References: <20170419170618.16535-1-git@jeffhostetler.com>
 <20170419170618.16535-6-git@jeffhostetler.com>
 <20200704172708.GC11341@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fd593c77-ac40-9c4a-7556-2f10d60e2cee@web.de>
Date:   Sun, 5 Jul 2020 07:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200704172708.GC11341@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kIpNihd2bGfZ0jaz5s66CjTSI3XbTKipqbzlkPUHWrxsQoxjcLI
 xMJx9Ud7Cix7BNFviWpBIwYrEh9+AjnDZrRGOOH3bA+8zcKt9YzXvIDAC2kSIVHReg9PsrN
 nMUYs7W3B9DedBMTMD5u8Q3WSiiUKbFyOumIix33cNyt1u5qor5w4d0+JeJ1D2RUQfy96iC
 oseO2z11mQxI1nf3yeAvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/wksjbg52U=:vfhNA5CkZ/i+MoKDH6VkYS
 8LhF6OuYWq6QyZz/embfKzl4HtIYxXiQv+wwP9v49nWqWhYD2Cl50OFmyFuSdwgV8C620pusV
 FnQyA6t4daHEwqZiIzqX1a3MvsHycHKTODTmq3CZd0oTXAIKXYZPtY1IV5LZASxWRESOfgf2E
 fCZxQSrr5BuaSilWoQYZ3SpCTT69LQHLMzvTJ2sb5ygKN7gi6BKy6+/XBQhePF0y/pRBJIalX
 fLTvYFb4Id0r+BzLqKRzyEQJ96gSTGXvqLT7Zb4UZvRexpBcGtvHYGOdrE3rTFS9cSZyxzntS
 k3FqxqHyaqUgLNk2xpnjgFWb5zbCymirYeAiJI2yVZi9JkUbH0pULO0XlooV1geXr7SE4TSrf
 UlXpYtm0Wilzoy/xcHQJdM1adgpFiXnoALTyhzDa0xJEQSrpd0UWCy/p0kyUFqxAuD/nOCVnh
 ipegtKwDVWEBbs/q1QRZZLf27FNOcz4mVwe4CDQ1n6Fahl93UQ6OGbr2FwC05z/3dG3gTT3SC
 ZrttSywFgCaDZnKSGTS99fYeTXo/ARqMOF2utMWXQgO+Ag5Cmj+qIbRSw178nBr1hgJEXtbp0
 KGd9KJO9rYEULWYf0GKmnxCa1dIji4KKzKOVBtSPXj2t4/N8/PhvWwFrVbcdOKOoye7otlV82
 0gzQG8LoUeTcSnPmJhAxokD9eQ9Tc8Soh493BbEJmlZ5xc2vt6sG7D3T8lDYsa+EmcvwtVCGi
 cofRNfBM4WYWdXjckjne5g2hSmsRL0OgCVvm758ZcsaZMmvsCqtfpuqGRAXAvQtWc6+JJq633
 5nf3JHIl1WZq2IwQBi5AVM3UxhsCTsEKne9DShmgP7S1zb6aCA4PoEpX7YThM7OYsEQl9aovl
 gjx1w+JyvA6362icbcMoQFdxN3dK7MzqC/e+6fxpSXnsDUYznSJmNaJ1ilbT6F1zFTIa0DKIt
 xnww4wfg1ClU4fs6GWxm3Ut2148t5CRlw7rTk/u6uGS2haEVFbyFeFnLqz9HLi9ecmPyDEBqD
 XzctoJ0mTLHjR2IWRA5AF31SHggrIG/vIEl8cRW1/nCo8zZx4PFIlejP5gSPazO+FhGdCi4A+
 T3AEvwNtsAnZmW7A2NT2aIvzwg1NLPlcACpTUgE/GO5Zj+yJ2wApua9HxcHdNrr+Mj3Y2fytP
 YwwNEf40JpHJQISzP4fyV1gE3bkqUB9paIHjXtSlduby48QvL4b+W+kcXAZFrYuAf8/AA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.07.20 um 19:27 schrieb SZEDER G=C3=A1bor:
> diff --git a/t/t9999-test.sh b/t/t9999-test.sh
> new file mode 100755
> index 0000000000..4c802d5940
> --- /dev/null
> +++ b/t/t9999-test.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description=3D'test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'file to dir breakage' '
> +	>file-to-dir &&
> +	# This sorts between "file-to-dir" as a file and "file-to-dir"
> +	# as a directory (with the trailing / appended implicitly.
> +	>file-to-dir.uh-oh &&
> +	git add file-to-dir file-to-dir.uh-oh &&
> +	git commit -m "add a file" &&
> +
> +	# Not "git rm", to preserve "file-to-dir" in the index.
> +	rm file-to-dir &&
> +	mkdir file-to-dir &&
> +	>file-to-dir/file &&
> +
> +	# It is important to add the file in the directory; adding only
> +	# the directory doesnt trigger the bug.
> +	git add file-to-dir/file &&
> +
> +	git diff --cached --no-renames --name-status >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	D	file-to-dir
> +	A	file-to-dir/file
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'is it committed as-is?' '
> +	git commit -m "replace file with a dir" &&
> +	git ls-tree HEAD >actual &&
> +
> +	# Hardcoded SHA-1 oid :(, because with this bug present
> +	# "git rev-parse HEAD:file-to-dir" doesnt show the oid of
> +	# the tree, but the oid of the blob that shouldnt be there.
> +	cat >expect <<-EOF &&
> +	100644 blob $EMPTY_BLOB	file-to-dir.uh-oh
> +	040000 tree df2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078	file-to-dir

You can get the hash of the tree with:

  echo "100644 blob $EMPTY_BLOB	file" | git mktree

(TAB before "file", the rest of the whitespace are regular spaces)

> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_done
>
