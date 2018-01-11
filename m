Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139821F404
	for <e@80x24.org>; Thu, 11 Jan 2018 06:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeAKGBc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 11 Jan 2018 01:01:32 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45108 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeAKGBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 01:01:32 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0B61Uia033043
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 01:01:31 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
References: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
In-Reply-To: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
Subject: RE: [PATCH] Replaced read with xread in transport-helper.c to fix SSIZE_MAX overun in t5509
Date:   Thu, 11 Jan 2018 01:01:25 -0500
Message-ID: <011001d38aa1$a097b160$e1c71420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJsSMotxvL6FxEkVCXZaKOUGVaNvKI8sNgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 11, 2018 12:40 AM, I wrote:
> Subject: [PATCH] Replaced read with xread in transport-helper.c to fix
> SSIZE_MAX overun in t5509
> 
> This fix was needed on HPE NonStop NSE where SSIZE_MAX is less than
> BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
> was the only place outside of wrapper.c.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  transport-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index 3640804..68a4e30 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1202,7 +1202,7 @@ static int udt_do_read(struct
> unidirectional_transfer *t)
>                 return 0;       /* No space for more. */
> 
>         transfer_debug("%s is readable", t->src_name);
> -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>                 errno != EINTR) {
>                 error_errno("read(%s) failed", t->src_name);

This fixes all known breaks except 3 on NonStop down from 229, so I'm thinking it's worth it. A high fix-to-bytes-changed ratio 😉

Cheers,
Randall

