From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] read-cache: increase write buffer size
Date: Sat, 19 Mar 2016 15:55:46 +0530
Message-ID: <CAFZEwPMtv0JF+Q_1P53NB2oxH-XJXGzmiUsOxk0KBaa+AJE+vA@mail.gmail.com>
References: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
	<56ED0863.3020709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 11:27:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahE6t-0004cg-F5
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 11:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcCSKZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 06:25:47 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35729 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbcCSKZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 06:25:46 -0400
Received: by mail-yw0-f175.google.com with SMTP id g127so167181660ywf.2
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=DriZnDc+QbNz5lBLdB9Imwxv1hpA3uWZaeFHytFl6bA=;
        b=d5EDJHyBODe5E22yYSP8mT8uzZXA5Uz7Tg7oT12jllDoTqjk7kugKzdfCSBUIHehIs
         TsmzgI3RVIWtse935fahoT1Hoz3SXW+6QoRLF//7ODGW3Q+Xkm4xaWlDplNUL3JFk0fS
         8yAupmGdgastjv6dBG1ewPZmCLFFB7Y3Bvet36NuHWKUrpqN9NqZRpgD86e4cmEE4Q5X
         Ka7Wpccb9w0GCHHgzhGthZcs5FkyfQdR65xbR29RxOeetzoAs6fyeDLcOeswZLonWRM5
         KDRCxom+2xL02qxTX2mcyt7XAVoWVZNilKE22H/vx9Z0CU4raFyO8r714FOxP9/0RKXs
         kcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=DriZnDc+QbNz5lBLdB9Imwxv1hpA3uWZaeFHytFl6bA=;
        b=OuWPIgXtkkVO9CpqgzvnAOpU4K5wnFMlCfGlbmF6o6BNOuJO2jv7Gge4tNyQlcGdQ9
         9i/HliZOrasNr658HVE8UVNOELiIjxFMmK2IYVI7f5F54pL20a7Ua+Qj/2As1mRO32CR
         BsU6/+5z6XMqEE/OEa0hT2PynlwYABkBWjw50rPniafUMCEQGCb3SKDWONt4PBNVHemt
         r/x+pSeEDTWN0bdMVVDREUuMEXutdpy09sF7ltqpxlz0cZX/+bAXUZHlpnAI1G3caug2
         uR5gKGPKV8XHob/aYnEciLRHhxP3dQSqmgXQ/9q+EwTwelSvMMsrqD1lr6OZSQiDwCaq
         iWoQ==
X-Gm-Message-State: AD7BkJI9KbGE6cqR6Tjy5ZRzaQRkUgie0fjqcPXAWc8wZXU6M9IC5PEcKYOyRq5EbKWyD/nPrvnvheFCBTFwFA==
X-Received: by 10.129.45.194 with SMTP id t185mr8723366ywt.243.1458383146097;
 Sat, 19 Mar 2016 03:25:46 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sat, 19 Mar 2016 03:25:46 -0700 (PDT)
In-Reply-To: <56ED0863.3020709@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289300>

On Sat, Mar 19, 2016 at 1:35 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2016-03-19 02.19, David Turner wrote:
>> Each write() has syscall overhead, and writing a large index entails
>> many such calls.  A larger write buffer reduces the overhead,
>> leading to increased performance.
>>
>> On my repo, which has an index size of 30m, this saves about 10ms of
>> time writing the index.
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>>  read-cache.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index d9fb78b..09ebe08 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1714,7 +1714,7 @@ int unmerged_index(const struct index_state *i=
state)
>>       return 0;
>>  }
>>
>> -#define WRITE_BUFFER_SIZE 8192
>> +#define WRITE_BUFFER_SIZE 131072
>>  static unsigned char write_buffer[WRITE_BUFFER_SIZE];
>>  static unsigned long write_buffer_len;
>>
>>
> Do I read that right, it saves 10 milliseconds ?
> What happens to small system (like Raspberry PI), when you
> want 128K write buffer ?
> Could the buffer size be turned into a makefile variable, defaulting =
to 8192 ?

Maybe for all ARM devices not just Raspberry Pi.

There is one way, though its not that good. This is just a sample
code. I am unsure about if using bash in makefile is a good idea

in Makefile,
uname -a | grep "arm" >out
if [ -s out ]; then
    export ARM=3Darm
fi
rm out

in read-cache.c,
#define ARCH (getenv("ARCH"))
#ifdef ARCH,
    #define WRITE_BUFFER_SIZE 128000
#endif
