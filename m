Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE951F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfHABer (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:34:47 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:35410 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728582AbfHABer (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jul 2019 21:34:47 -0400
Received: from mxback6q.mail.yandex.net (mxback6q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:9de5:975f])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 6F73C11C1B5D;
        Thu,  1 Aug 2019 04:34:44 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback6q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id sKyc908uYu-YhRmuvgr;
        Thu, 01 Aug 2019 04:34:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564623283;
        bh=zauIwyRMgiX5qBgdGcM7tbGukWOmnzIlpBdtMBw2W90=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=F5+lGZv9ljqkubmWhZp1Sta8VAfdfkITdoGjzNwJrXOx6sduYlYKDoRBItrachoQM
         /C7HFaxp2ZHGHpWsnbS1ASSoqhl4dfMuC20/1irDlxKtmz2PJ5Tp2hAkqMqmxLyDDS
         /HCr9oYvah2khSpHwoXcUKqMUAzcILeB5jYbbq4c=
Authentication-Results: mxback6q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-822b1b47a947.qloud-c.yandex.net with HTTP;
        Thu, 01 Aug 2019 04:34:43 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Philip McGraw <philip.mcgraw@bentley.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
In-Reply-To: <BL0PR1901MB209790A0A8F5F9C8EFB8B3F0FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
         <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <2835251564582156@myt6-4218ece6190d.qloud-c.yandex.net> <BL0PR1901MB209790A0A8F5F9C8EFB8B3F0FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
Subject: Re: [PATCH] git-p4: close temporary file before removing
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 31 Jul 2019 21:34:43 -0400
Message-Id: <2717551564623283@vla1-822b1b47a947.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



31.07.2019, 17:52, "Philip McGraw" <philip.mcgraw@bentley.com>:
> 2019.07.31 10:09 Andrey <ahippo@yandex.ru>
>> 31.07.2019, 09:53, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>>>   30.07.2019, 13:37, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>>>   > python os.remove() throws exceptions on Windows platform when attempting
>>>>   > to remove file while it is still open. Need to grab filename while file open,
>>>>   > close file handle, then remove by name. Apparently other platforms are more
>>>>   > permissive of removing files while busy.
>>>>   > reference:
>>>>   > ---
>>>>   >  git-p4.py | 4 +++-
>>>>   >  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>   >
>>>>   > diff --git a/git-p4.py b/git-p4.py
>>>>   > index c71a6832e2..6b9d2a8317 100755
>>>>   > --- a/git-p4.py
>>>>   > +++ b/git-p4.py
>>>>   > @@ -1161,12 +1161,14 @@ def exceedsLargeFileThreshold(self, relPath, contents):
>>>>   >                  return False
>>>>   >              contentTempFile = self.generateTempFile(contents)
>>>>   >              compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
>>>>   > + compressedContentFileName = compressedContentFile.name
>>>>   >              zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
>>>>   >              zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
>>>>   >              zf.close()
>>>>   >              compressedContentsSize = zf.infolist()[0].compress_size
>>>>   >              os.remove(contentTempFile)
>>>>   > - os.remove(compressedContentFile.name)
>>>>   > + compressedContentFile.close()
>>>>   > + os.remove(compressedContentFileName)
>>>>
>>>>   I'm not sure why NamedTemporaryFile() is called with delete=False above,
>>>>   but it appears to me that it can have delete=True instead,
>>>>   so that there is no need to call os.remove() explicitly
>>>>   and thus worry about remove vs close ordering at all.
>>>>
>>>>   >              if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
>>>>   >                  return True
>>>>   >          return False
>>>>   > --
>>>>   > 2.21.0.windows.1
>>>>
>>>>   Thank you,
>>>>   Andrey.
>>>
>>>  Thanks Andrey; simpler is certainly better! I will test and re-submit v2 of patch with that approach.
>>
>> Thank you, that would be great!
>>
>> --
>> Andrey.
>
> Unfortunately it wasn't as simple it seemed: upon testing with only changing delete=True,
> found that the problem was not solved. Upon further debugging, recoded/refactored slightly adding
> allocateTempFileName() locally scoped function to try to clarify how the NamedTemporaryFile()
> was actually being used.
>
> We can't depend on the delete-on-close because the NamedTemporaryFile() is merely allocating
> a temporary name for real use by the zipfile open-for-write which fails (on Windows) if file
> was not explicitly closed first.

Oh, sorry for misguiding you!
I didn't think of this aspect.

> Hopefully the new patch (https://github.com/gitgitgadget/git/pull/301) will make this more clear.

The new changeset looks good to me.
(I'll post a reply in that thread too)

> Open to other suggestions if still not clear.

Just as a thought, ZipFile() can take a file-like object instead of a file name,
so can be passed the NamedTemporaryFile() object directly instead of its file name.
This should hopefully avoid double-open issue on Windows.

However, I'm good with your allocateTempFileName() changeset,
so it's up to you to give it a try or not.

> Thanks again,
> Philip

Thank you,
Andrey.

