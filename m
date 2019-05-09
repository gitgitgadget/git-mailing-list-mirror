Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93961F45F
	for <e@80x24.org>; Thu,  9 May 2019 08:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEIIJp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 04:09:45 -0400
Received: from thoth.sbs.de ([192.35.17.2]:56080 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfEIIJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 04:09:44 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x4989fSx021703
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 10:09:41 +0200
Received: from [147.54.65.49] (MD11GXTC.ad001.siemens.net [147.54.65.49])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id x4989ess005291;
        Thu, 9 May 2019 10:09:40 +0200
Subject: Re: [PATCH] Improving HP-UX support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com>
 <87lfzggk1n.fsf@evledraar.gmail.com>
From:   "Osipov, Michael" <michael.osipov@siemens.com>
Message-ID: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com>
Date:   Thu, 9 May 2019 10:09:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfzggk1n.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there,

Am 2019-05-09 um 09:32 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Wed, May 08 2019, Osipov, Michael wrote:
> 
>> Hi folks,
> 
> Hi see Documentation/SubmittingPatches for how to submit patches inline
> instead of as attachments.

Do you want me to resend the configure.ac change as per wiki article? I 
can also create a PR on GitHub. I am happy with both as long as I don't 
have to retain the patch for myself only ;-)

> For the sha1dc change it seems trivially correct, but we import that
> upstream project as-is, could you please submit a pull request at
> https://github.com/cr-marcstevens/sha1collisiondetection then we can
> update our version?

Sure thing, will do.

>> diff -ur configure.ac configure.ac
>> --- configure.ac	2019-02-24 16:55:19 +0000
>> +++ configure.ac	2019-05-08 11:31:42 +0000
>> @@ -475,8 +475,18 @@
>>         if test "$git_cv_ld_rpath" = "yes"; then
>>            CC_LD_DYNPATH=-rpath
>>         else
>> -         CC_LD_DYNPATH=
>> -         AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
>> +         AC_CACHE_CHECK([if linker supports -Wl,+b,], git_cv_ld_wl_b, [
>> +            SAVE_LDFLAGS="${LDFLAGS}"
>> +            LDFLAGS="${SAVE_LDFLAGS} -Wl,+b,/"
>> +            AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_b=yes], [git_cv_ld_wl_b=no])
>> +            LDFLAGS="${SAVE_LDFLAGS}"
>> +         ])
>> +         if test "$git_cv_ld_wl_b" = "yes"; then
>> +            CC_LD_DYNPATH=-Wl,+b,
>> +          else
>> +             CC_LD_DYNPATH=
>> +             AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
>> +          fi
>>         fi
>>      fi
>>   fi
> 
> Do we want to also have something in config.mak.uname to always do this
> on HP/UX?

I am not convinced by that. I wouldn't mix operating system with 
compiler settings. One could also use GCC on HP-UX. The one above is for 
HP aCC.

>>   /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
>> -#elif (defined(_AIX))
>> +#elif (defined(_AIX) || defined(__hpux))
> 
> Seems sane, and per my googling even though HP/UX now runs on
> little-endian hardware it's always big-endian. But in this manual they
> advice doing it at runtime with a TEST_ENDIAN() macro in sys/portal.h:
> http://h20628.www2.hp.com/km-ext/kmcsdirect/emr_na-c01921401-1.pdf
> 
> Is that something we need to worry about / support? E.g. in the
> configure script?
> 

That'd be much more work to extend configure.ac for that because is a 
runtime check. Since there are no real products vailable on x86 for 
HP-UX I'd neglect that. Our HPE salesman told us that this will be 
available somewhere in the future. So, I think this is very good for now.

Michael
