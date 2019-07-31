Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017461F462
	for <e@80x24.org>; Wed, 31 Jul 2019 01:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGaBsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 21:48:07 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:60371 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbfGaBsH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jul 2019 21:48:07 -0400
Received: from mxback10q.mail.yandex.net (mxback10q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:b6ef:cb3])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id BCCD433803F4;
        Wed, 31 Jul 2019 04:48:04 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZQilKZoctJ-m3quISv2;
        Wed, 31 Jul 2019 04:48:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564537683;
        bh=8agwZyA6ZK7mlgrvwXZy1patVZ9rYxUgCu55rIAq4CM=;
        h=Message-Id:Subject:In-Reply-To:Date:References:To:From;
        b=iiRvDQ5qN3ImW7JqbADs0e/NffV3eWai0utoGW/dRDseWXC+KhHfHHLOkSwz7L6ZU
         gWhBUDRROfkxNwvQGGYfxKUM5I3n1nyBP4y7Jh0Xjt6Pk0uG1KmsrpGFlStOInY8NX
         LmuYEX1kvuw1W1BNHYmS/0QM+nFdBtVSFd+bpFrs=
Authentication-Results: mxback10q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-53bffb0b04ed.qloud-c.yandex.net with HTTP;
        Wed, 31 Jul 2019 04:48:03 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Philip McGraw <philip.mcgraw@bentley.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, luke@diamand.org
In-Reply-To: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
Subject: Re: [PATCH] git-p4: close temporary file before removing
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 30 Jul 2019 21:48:03 -0400
Message-Id: <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



30.07.2019, 13:37, "Philip McGraw" <philip.mcgraw@bentley.com>:
> python os.remove() throws exceptions on Windows platform when attempting
> to remove file while it is still open. Need to grab filename while file open,
> close file handle, then remove by name. Apparently other platforms are more
> permissive of removing files while busy.
> reference: https://docs.python.org/3/library/os.html#os.remove
> ---
>  git-p4.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c71a6832e2..6b9d2a8317 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1161,12 +1161,14 @@ def exceedsLargeFileThreshold(self, relPath, contents):
>                  return False
>              contentTempFile = self.generateTempFile(contents)
>              compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
> + compressedContentFileName = compressedContentFile.name
>              zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
>              zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
>              zf.close()
>              compressedContentsSize = zf.infolist()[0].compress_size
>              os.remove(contentTempFile)
> - os.remove(compressedContentFile.name)
> + compressedContentFile.close()
> + os.remove(compressedContentFileName)

I'm not sure why NamedTemporaryFile() is called with delete=False above,
but it appears to me that it can have delete=True instead,
so that there is no need to call os.remove() explicitly
and thus worry about remove vs close ordering at all.

>              if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
>                  return True
>          return False
> --
> 2.21.0.windows.1

Thank you,
Andrey.

