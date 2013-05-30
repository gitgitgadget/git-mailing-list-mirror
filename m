From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 16:01:58 +0100
Message-ID: <CAJ-05NMt6h=JFLLCP+LASKMcToENhF=BSsk1dPML0024hJTwTw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<CALkWK0=bgM+fYcVEwjHHF8k2Q8wMmjdbM5bxXdPH6s9StDH_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 17:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4Me-0006Yi-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277Ab3E3PCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 11:02:00 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60392 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab3E3PB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 11:01:59 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so790596obb.15
        for <git@vger.kernel.org>; Thu, 30 May 2013 08:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=wklI4nj2HdspacUUEVopW4UCOewsgAc/z2UZFYcz//k=;
        b=IfxEe5nIFbd4ooqw+hlfa/ugrcDTXzgMYshDugA6mb6bWPpsjrBi7BuEntendDiXCB
         P6AgZyiCz3i6GtQUMaXnIKm1RsrdY744NzINoqtKbt4RfJyCeaa/E9tNDNA5j6gKu4Ua
         duansd8OK3xb3r7JQVJ+jNIU4eE5ywzw5kRRdKCWOgOEYY17A9dmYPRUqpJcTBe5tYqQ
         iQj8f9OtUY8LB0xoZNVuAUtUSr0qdunJTYurz/jUVkrwFhrrIEsLIRTJsgLTgIGnZrdl
         tKKPP66hy5gwkFUonTrT+5bAZVqLLiy0UE490Qbz5jhQpzR7Hga42FVQNvp5UTDtdz9r
         iCtg==
X-Received: by 10.60.131.35 with SMTP id oj3mr4348317oeb.55.1369926118454;
 Thu, 30 May 2013 08:01:58 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 08:01:58 -0700 (PDT)
In-Reply-To: <CALkWK0=bgM+fYcVEwjHHF8k2Q8wMmjdbM5bxXdPH6s9StDH_Ng@mail.gmail.com>
X-Google-Sender-Auth: GIH1yOxIULRIoVT4XYIXQP7PV7s
X-Gm-Message-State: ALoCoQlXl10wNNPlByVaVdcF/whlKXoMinXWsN0Xoms1H9o89uQPLZNZkTvL1vvB6sIIlaPkIw2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226008>

On 30 May 2013 15:32, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Alex Benn=C3=A9e wrote:
>> And through my "special" repo:
>>
>>  41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse3
>>  33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
>>  10.39%   git  libz.so.1.2.3.4     [.] adler32
>>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c
>>
>>  I'm not sure why libcrypto features so highly in the results
>
> While Duy churns on the delta chain, let me try to make a (rather
> crude) observation:
>
> What does it mean for libcrypto to be so high in your perf report?
> sha1_block_data_order is ultimately by object.c:parse_object.  While
> it indicates that deltas are taking a long time to apply (or are
> somehow not optimally organized for IO), I think it indicates either:
>
> 1. Your history is very deep and there are an unusually high number o=
f
> deltas for each blob.  What are the total number of commits?

Well the history does en-compose about 10 years of product development
and has a high number of files in the repo (including about 3 copies of
the kernel - sans upstream history).

15:50 ajb@sloy/x86_64 [work.git] >time git log --pretty=3Doneline | wc =
-l
24648

real    0m0.434s
user    0m0.388s
sys     0m0.112s

Although it doesn't take too long to walk the whole mainline history
(obviously ignoring all the other branches).

15:52 ajb@sloy/x86_64 [work.git] >git count-objects -v -H
count: 581
size: 5.09 MiB
in-pack: 399307
packs: 1
size-pack: 1.49 GiB
prune-packable: 0
garbage: 0
size-garbage: 0 bytes

It is a pick repo. The gc --aggressive nearly took out my machine keepi=
ng
around 4gb resident for most of the half hour and using nearly 8gb of V=
M.

Of course most of the history is not needed for day to day stuff. Maybe
if I split the pack files up it wouldn't be quite such a strain to work
through them?

> 2. You have have huge (binary) files checked into your repository.  D=
o
> you?  If so, why isn't the code in streaming.c kicking in?

We do have some binary blobs in the repository (mainly DSP and FPGA ima=
ges)
although not a huge number:

15:58 ajb@sloy/x86_64 [work.git] >time git log --pretty=3Doneline -- xx=
x
xxx/xxxxxx/*.out ./xxx/xxx/*.out ./xxx/xxxxxxx/*.out | wc -l
234

real    0m0.590s
user    0m0.552s
sys     0m0.040s

How can I tell if streaming is kicking in or now?


--=20
Alex, homepage: http://www.bennee.com/~alex/
