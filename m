Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DD61F731
	for <e@80x24.org>; Wed, 31 Jul 2019 14:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfGaOJW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 10:09:22 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:48308 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbfGaOJV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jul 2019 10:09:21 -0400
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::22])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 697D935008DC;
        Wed, 31 Jul 2019 17:09:17 +0300 (MSK)
Received: from unknown (unknown [::1])
        by mxback8o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4dl4mbxzGV-9G2K4h0d;
        Wed, 31 Jul 2019 17:09:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564582156;
        bh=tz2a8ZkFm43UFfLW7RahHDQov02Od+0JoRUTMTFbNEU=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=Ms9/9Py8hUXnNpk3ewgFE+G9fdvNuPFYUdO4LJqQPGrl0EvWpkJgYgJu+G9wB8XdL
         QFkH6A+OkqNXYEex4X9Lci35Fqx3jFcFMJVYjZsUt4fgcPuk5RwxqyAxasDRfTqzf3
         r11JLU1V36NfOWIS5GWLJw0zIvYyA4J4o7ZN61z4=
Authentication-Results: mxback8o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-4218ece6190d.qloud-c.yandex.net with HTTP;
        Wed, 31 Jul 2019 17:09:16 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Philip McGraw <philip.mcgraw@bentley.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
In-Reply-To: <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net> <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
Subject: Re: [PATCH] git-p4: close temporary file before removing
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 31 Jul 2019 10:09:16 -0400
Message-Id: <2835251564582156@myt6-4218ece6190d.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



31.07.2019, 09:53, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>  30.07.2019, 13:37, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>  > python os.remove() throws exceptions on Windows platform when attempting
>>  > to remove file while it is still open. Need to grab filename while file open,
>>  > close file handle, then remove by name. Apparently other platforms are more
>>  > permissive of removing files while busy.
>>  > reference: https://docs.python.org/3/library/os.html#os.remove
>>  > ---
>>  >  git-p4.py | 4 +++-
>>  >  1 file changed, 3 insertions(+), 1 deletion(-)
>>  >
>>  > diff --git a/git-p4.py b/git-p4.py
>>  > index c71a6832e2..6b9d2a8317 100755
>>  > --- a/git-p4.py
>>  > +++ b/git-p4.py
>>  > @@ -1161,12 +1161,14 @@ def exceedsLargeFileThreshold(self, relPath, contents):
>>  >                  return False
>>  >              contentTempFile = self.generateTempFile(contents)
>>  >              compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
>>  > + compressedContentFileName = compressedContentFile.name
>>  >              zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
>>  >              zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
>>  >              zf.close()
>>  >              compressedContentsSize = zf.infolist()[0].compress_size
>>  >              os.remove(contentTempFile)
>>  > - os.remove(compressedContentFile.name)
>>  > + compressedContentFile.close()
>>  > + os.remove(compressedContentFileName)
>>
>>  I'm not sure why NamedTemporaryFile() is called with delete=False above,
>>  but it appears to me that it can have delete=True instead,
>>  so that there is no need to call os.remove() explicitly
>>  and thus worry about remove vs close ordering at all.
>>
>>  >              if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
>>  >                  return True
>>  >          return False
>>  > --
>>  > 2.21.0.windows.1
>>
>>  Thank you,
>>  Andrey.
>
> Thanks Andrey; simpler is certainly better! I will test and re-submit v2 of patch with that approach.

Thank you, that would be great!

-- 
Andrey.

