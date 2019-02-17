Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE56E1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBQREx (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 12:04:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:51113 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfBQREx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 12:04:53 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id vPs2gIMLAAOoyvPs4gYFWc; Sun, 17 Feb 2019 17:04:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=onhi19IbAAAA:8 a=Dx4yW56zAAAA:8 a=RweQsQeYAAAA:8
 a=LQnUi9dTad_2p9WNpagA:9 a=QEXdDO2ut3YA:10 a=JvkiTdytZRqVYIXWt-wT:22
 a=X_u8qhY6y2Nm79co_leF:22 a=7sf21nnitdzR5Yzgb_TM:22
X-AUTH: ramsayjones@:2500
Subject: Re: [Fix v1] builtin/ls-files.c: add error check on lstat for
 modified files
To:     randall.s.becker@rogers.com, git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20190217163456.17560-1-randall.s.becker@rogers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e762e80a-d1ef-f906-e128-03f35de3c3ba@ramsayjones.plus.com>
Date:   Sun, 17 Feb 2019 17:04:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190217163456.17560-1-randall.s.becker@rogers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHYdcBg654RXdjj0B3CM1oH8RIfdTkPDgmKeyAjsy+Sm6iD0geExcm2NBis63ITsLytYW7dBvSxDneLEdc5fVOJizke/L64fNEvbrx/e5myPFvopB20Q
 q8+jo8JQDcQbIuvQYPpVl6yUtvbOYrzjoF6DCKugI4E+x6r7qMekPPpC1TgFJWdWlSi9q2ikmovXEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/02/2019 16:34, randall.s.becker@rogers.com wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> The result from lstat, checking whether a file has been deleted, is now
> included priot to calling id_modified when showing modified files. Prior

s/priot/prior/; s/id_modified/ie_modified/

> to this fix, it is possible that files that were deleted could show up
> as being modified because the lstat error was unchecked.
> 
> Reported-by: Joe Ranieri <jranieri@grammatech.com>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/ls-files.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 29a8762d4..fc21f4795 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -348,7 +348,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  			err = lstat(fullname.buf, &st);
>  			if (show_deleted && err)

To be pedantic, this should probably check for (err == ENOENT), since
lstat() can fail for several reasons which don't imply that the path
has been deleted. However, that is unlikely.

No reason to include such a check in this patch, of course.

ATB,
Ramsay Jones

>  				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> -			if (show_modified && ie_modified(repo->index, ce, &st, 0))
> +			if (show_modified && !err && ie_modified(repo->index, ce, &st, 0))
>  				show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  		}
>  	}
> 
