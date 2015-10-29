From: =?UTF-8?Q?Rafael_Esp=C3=ADndola?= <rafael.espindola@gmail.com>
Subject: Re: git fsck failure on OS X with files >= 4 GiB
Date: Thu, 29 Oct 2015 03:46:53 -0700
Message-ID: <CAG3jRe+23sy1k9QNdpdn3GF3nbzPMmYO=TM=SufEq83OtwNxbA@mail.gmail.com>
References: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
	<CAEDE8505fXAwVXx=EZwxPHvXpMByzpnXJ9LBgfx3U6VUaFbPHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Filipe Cabecinhas <filcab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 11:47:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrkjS-000381-QP
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 11:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbJ2Kqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2015 06:46:55 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34346 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbbJ2Kqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2015 06:46:54 -0400
Received: by oies66 with SMTP id s66so26782044oie.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5X+OtefOed1ODwsbgevVMQO2s7ll7InvGnO80nHFQTg=;
        b=SwcRmn1+D0QKji9yDVg0ZnyPZDXZfWkVlduMX3sgPu8K9pjaXsze5eF81JkRvjbwik
         H8cMDJD5Kuo2BgfJ2pPcCJ+4HKUNozt5QqhkrIOUCGfdh+f4BRbwDAH0H0VdGgCTa4OQ
         y4ci52XB2PuUKowxkdyWZQqBwc8ShackC4wgOzHKQ/MaLIPGCxjbu6yzQwnh0RCCDyTh
         wSyvzvbsj/Mf81FV/Z9MQbVF7u3jma2H/E+I0swg66OUqD/hCJQ4eUWCrizTRLNS7Dqz
         pD2azXxMqhSUT/zo5Nxojpe3QDuxUmmcHAAvm9ikCufjPrSuvYRpLle8qXoTUYDQwkzf
         N7sA==
X-Received: by 10.202.97.196 with SMTP id v187mr482400oib.91.1446115613377;
 Thu, 29 Oct 2015 03:46:53 -0700 (PDT)
Received: by 10.202.228.73 with HTTP; Thu, 29 Oct 2015 03:46:53 -0700 (PDT)
In-Reply-To: <CAEDE8505fXAwVXx=EZwxPHvXpMByzpnXJ9LBgfx3U6VUaFbPHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280437>

Awesome, building with

NO_OPENSSL =3D 1
NO_GETTEXT =3D 1

produces a working git :-)

Cheers,
Rafael


On 28 October 2015 at 23:37, Filipe Cabecinhas <filcab@gmail.com> wrote=
:
> I did some debugging, and it seems CC_SHA1_Update (used by
> write_sha1_file_prepare if APPLE_COMMON_CRYPTO is defined in the Make=
file)
> takes a uint32_t as a "length" parameter, which explains why it stops
> working at 4GiB (UINT_MAX+1).
>
> In the OS X 10.11 SDK header CommonCrypto/CommonDigest.h, we have:
>
> typedef uint32_t CC_LONG;       /* 32 bit unsigned integer */
> //...
> extern int CC_SHA1_Update(CC_SHA1_CTX *c, const void *data, CC_LONG l=
en)
>
> A possible fix would be to either call SHA1_Update with a maximum of
> UINT_MAX, looping if necessary. Or have a compatibility SHA1_Update f=
or OS X
> which can handle data longer than UINT_MAX.
>
> I'm not sure what the git maintainers would prefer.
>
> Regards,
>
>   Filipe
>
> On Wed, Oct 28, 2015 at 4:10 PM, Rafael Esp=C3=ADndola
> <rafael.espindola@gmail.com> wrote:
>>
>> I first noticed this with "2.4.9 (Apple Git-60)", but it reproduces
>> with git built from 37023ba381b6d251d7140a997b39b566dbc63c42.
>>
>> Create two files with just 0s:
>>
>> -rw-r--r--  1 espindola  staff  4294967296 28 Oct 11:09 exactly-4gib
>> -rw-r--r--  1 espindola  staff  4294967295 28 Oct 11:09 one-less-tha=
n-4gib
>>
>>
>> and run
>>
>> git init
>> git add one-less-than-4gib
>> git commit -m bar
>> git fsck
>> git add exactly-4gib
>> git commit -m bar
>> git fsck
>>
>> The first fsck will run with no problems, but the second one fails:
>>
>> error: packed cfdaf54c9ccfd8f5e4cee562f7d5f92df13d3106 from
>> .git/objects/pack/pack-ff08480fd7f767b6bd0aeb559f0f5dea2245b0b3.pack
>> is corrupt
>>
>> Using the very same revision on freebsd doesn't cause any errors.
>>
>> Cheers,
>> Rafael
>
>
