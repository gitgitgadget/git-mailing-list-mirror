From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] pack-bitmaps: plug memory leak, fix allocation size for
 recent_bitmaps
Date: Tue, 19 May 2015 22:29:18 +0200
Message-ID: <555B9D1E.2050609@web.de>
References: <555A7499.7090900@web.de> <CAGZ79kZeX_VqcvTt_kgGKyWH0SV2zsV_j1KuxNhwR18zWfp5LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 22:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuo9G-0000TA-Ei
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 22:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbbESU3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 16:29:54 -0400
Received: from mout.web.de ([212.227.15.14]:52981 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbbESU3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 16:29:53 -0400
Received: from [192.168.178.27] ([79.253.161.1]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M4Hqd-1ZBVyw1QQN-00rmBE; Tue, 19 May 2015 22:29:41
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAGZ79kZeX_VqcvTt_kgGKyWH0SV2zsV_j1KuxNhwR18zWfp5LA@mail.gmail.com>
X-Provags-ID: V03:K0:4r6AasJy3+ctTeMzT7UFzboEeKBhi3D5KW08mxfuEvTvQDfBpGV
 Bmtjs3I7scUNszokOUvlYIwV33S84OjRQnc00DQbQLiMy7cnJEWBOYx0oi9tnrUy9D8x5vt
 IvqkgoyUOje+sxuJjOZD0Bx7uh4WtLEXbMhvPGbSgCRkMiTAXGVw2CyKuoVSBC1YqwbFubY
 WupVgGh4F1BDCNRMCKOFQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269397>

Am 19.05.2015 um 02:57 schrieb Stefan Beller:
> On Mon, May 18, 2015 at 4:24 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> diff --git a/pack-bitmap.c b/pack-bitmap.c
>> index 62a98cc..e5abb8a 100644
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -209,14 +209,12 @@ static inline uint8_t read_u8(const unsigned c=
har *buffer, size_t *pos)
>>          return buffer[(*pos)++];
>>   }
>>
>> +#define MAX_XOR_OFFSET 160
>> +
>>   static int load_bitmap_entries_v1(struct bitmap_index *index)
>>   {
>> -       static const size_t MAX_XOR_OFFSET =3D 160;
>
> Is there a reason why we prefer defines over a  static const size_t h=
ere?

Yes, see below.

>> -
>>          uint32_t i;
>> -       struct stored_bitmap **recent_bitmaps;
>> -
>> -       recent_bitmaps =3D xcalloc(MAX_XOR_OFFSET, sizeof(struct sto=
red_bitmap));
>> +       struct stored_bitmap *recent_bitmaps[MAX_XOR_OFFSET] =3D { N=
ULL };

If MAX_XOR_OFFSET is a const then C89 does not allow this declaration.=20
C99 gives you a variable-length array here.  VLAs can't be initialized=20
at declaration time, so we'd need to add a memset() call (at least with=
=20
GCC 4.9).  Overall it's simpler and shorter to use a macro.

We could also use an enum, but that's not exactly common.

Ren=C3=A9
