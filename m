Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CB01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeGaMTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:19:32 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33690 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbeGaMTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:19:32 -0400
Received: from [192.168.129.6] (x006.home.local [192.168.129.6])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6VAdfLO10289304;
        Tue, 31 Jul 2018 10:39:41 GMT
Subject: Re: Is detecting endianness at compile-time unworkable?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
 <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com>
From:   Michael Felt <aixtools@felt.demon.nl>
Message-ID: <93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl>
Date:   Tue, 31 Jul 2018 12:39:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wotdt649.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small step back...


On 7/30/2018 11:39 AM, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Jul 29 2018, Michael wrote:
>
>> On 29/07/2018 22:06, brian m. carlson wrote:
>>> On Sun, Jul 29, 2018 at 09:48:43PM +0200, Michael wrote:
>>>> On 29/07/2018 21:27, brian m. carlson wrote:
>>>>> Well, that explains it.  I would recommend submitting a patch to
>>>>> https://github.com/cr-marcstevens/sha1collisiondetection, and the we can
>>>>> pull in the updated submodule with that fix.
>>>> Not sure I am smart enough to do that. I'll have to download, build, and see
>>>> what it says.
>>> The issue is that somewhere in lib/sha1.c, you need to cause
>>> SHA1DC_BIGENDIAN to be set.  That means you need to figure out what
>>> compiler macro might indicate that.
>> I remember - roughly - a few decades back - having an assignment to
>> write code to determine endianness. PDP and VAC were different iirc,
>> and many other micro-processors besides the 8088/8086/z85/68k/etc..
>>
>> If you are looking for a compiler macro as a way to determine this -
>> maybe you have one for gcc, but not for xlc. I do not know it - currently :)
> I'm not familiar with AIX, but from searching around I found this
> porting manual from IBM:
> http://www.redbooks.ibm.com/redbooks/pdfs/sg246034.pdf
This is from July 2001 - when AIX 5L, for Linux affinity, was new. AIX 
was (nearly) the #1 posix system, and linux was a minor player in the 
data center (in or out (now as IAAS)). IMHO, the recommendations made in 
2001 are probably no longer applicable (64-bit was fairly new, e.g., 
rather than common).
>
> There they suggest either defining your own macros, or testing the
> memory layout at runtime (see section "2.2.2.3 Technique 3: Testing
> memory layout" and surrounding sections).
>
> Perhaps it's worth taking a step back here and thinking about whether
> this whole thing is unworkable. It was hard enough to get this to work
> on the combination of Linux, *BSD and Solaris, but I suspect we'll run
> into increasingly obscure platforms where this is hard or impossible
> (AIX, HP/UX etc.)
>
> The reason we're in this hole is because we use this
> sha1collisiondetection library to do SHA-1, and the reason we have
> issues with it specifically (not OpenSSL et al) is because its only
> method of detecting endianness is at compile time.
Cannot speak for the "others", but as I have mentioned before - as AIX 
in only on POWER it is also only Big Endian - so a compiletime #if 
testing for _AIX will work fine
> This didn't use to be the case, it was changed in this commit:
> https://github.com/cr-marcstevens/sha1collisiondetection/commit/d597672
>
> Dan Shumow: Since the commit message doesn't say why, can you elaborate
> a bit on why this was done, i.e. is determining this at runtime harmful
> for performance? If not, perhaps it would be best to bring this back, at
> least as an option.
>
> And, as an aside, the reason we can't easily make it better ourselves is
> because the build process for git.git doesn't have a facility to run
> code to detect this type of stuff (the configure script is always
> optional). So we can't just run this test ourselves.
On AIX - I am required to run configure, and frankly, I am amazed that 
not everyone is running it. Among other things I an modifying the prefix 
(to /opt) and many of the others to different /var/git/* areas as I do 
not want to "polute" the BOS (base OS) and/or other packages/packagers. 
Officially, according the Linux FHS-3.0 I sould be using /opt/aixtools 
as prefix.

FYI: my current build process is:
wget git-{version}.tar.xz
xz -dc git-{version}.tar.xz
cd git-{version}.tar.xz
mv Makefile Makefile.git #my build scripts only run configure when 
Makefile does not exist
./configure ...
ln Makefile.git Makefile
make

I am amazed, as it rarely happens (maybe git is my first encounter) - 
that configure does not create a Makefile. This also complicates 
building git "out of tree".
>
> Junio: I've barked up that particular tree before in
> https://public-inbox.org/git/87a7x3kmh5.fsf@evledraar.gmail.com/ and I
> won't bore you all by repeating myself, except to say that this is yet
> another case where I wish we had a hard dependency on some way of doing
> checks via compiled code in our build system.
For AIX: again - the determination is simple. If _AIX is set to 1 then 
use BigEndian, or, use:
michael@x071:[/home/michael]uname
AIX
  i.e., something like:
$(uname) == "AIX" && BigEndian=1
