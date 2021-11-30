Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0FC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 13:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbhK3Nx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbhK3Nx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 08:53:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1822AC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:50:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id l22so53927588lfg.7
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSxXiY6WcWkWd0j1+azoKFgYig+IWiYqXEOA6HWMsYQ=;
        b=dIpyHv9uDLxl3mSuaxRvJ8VEvNQQg5DihtjOAlpIXxK4Gj21qWjs8Q5nZsXTihfP/V
         kSIZ6uyGnil9rPwEqGCftRP0UHtIKtBo4yGFGuARkERJ3ylO6vsSV21Jvb8bxgj4MIMg
         cPwxQgK3F2tNryrFXBfATqI776nkLRUhfKjCiQonPMbRA5ppKdGRBfMyW/GZjSMPeXEH
         em9PTVpPGA5gA5XOZHOUIklLExhsE1nPmqasit2fouQW+axE3xJiGwXDu1DbVpWOXoOK
         baR7WkrMVVd+CTjtYR2TmlZuOGL2qkIvQQgIWBUk7s0+23Y0lDndR76nZotMh1M589su
         JhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSxXiY6WcWkWd0j1+azoKFgYig+IWiYqXEOA6HWMsYQ=;
        b=7laAWiOUPQV2fDqOnSQIVmBlkKYkwReW/kXHp0oL0P+tNjyjiHsIfzUXMfSH598zQX
         WSYkDsgSQxohktM9sojsX8ljXnzswUItAwOvbKd8E4pf0fXEL2k4IBA7C7ntiCAhSynZ
         n62/qSrWzkvffF6HxRAnUJmovEtb33zt4A1W2bm5Ine5e6PWkWa/IN5ueK3OuWCdHR4m
         iIbWx3YGj6u5bUz6dP304sZ0Znl4MipvQN6JrRXEJg2i7W6/Fp4/wzAYdh1qs6i095zy
         uZw1Ge0zjXFbJGSpScwz6HfSORfqTzgrM0+XzYYV7memO7kT4uRaps6M+C2rqV6oCN3y
         v4Tw==
X-Gm-Message-State: AOAM531GiyGud+ZdlDASIoMdOYa6NrveC0mKtNCX0TZmWdFVOMpivr4v
        UmGzAASt3BNFJ8U9Lw0fOVY/XQmdPXGPPDFFWfk=
X-Google-Smtp-Source: ABdhPJzRmCK7qRGIGFcSmfBMKvir+zuqVcZwqAawQmxyBes/a+JlD5wnUmv+3JZIWUySDvRKFdXtRslicjyZW9NsRaY=
X-Received: by 2002:a19:5052:: with SMTP id z18mr54919300lfj.23.1638280206223;
 Tue, 30 Nov 2021 05:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211122033220.32883-6-chiyutianyi@gmail.com>
 <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com>
In-Reply-To: <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 30 Nov 2021 21:49:53 +0800
Message-ID: <CAO0brD0oPHMwGNQXpC2XVhU=fY7XrrtBeu-x8GmJndeVptJaBg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 1:37 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/21/2021 10:32 PM, Han Xin wrote:
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> > entire contents of a blob object, no matter how big it is. This
> > implementation may consume all the memory and cause OOM.
> >
> > By implementing a zstream version of input_stream interface, we can use
> > a small fixed buffer for "unpack_non_delta_entry()".
> >
> > However, unpack non-delta objects from a stream instead of from an entr=
ie
> > buffer will have 10% performance penalty. Therefore, only unpack object
> > larger than the "big_file_threshold" in zstream. See the following
> > benchmarks:
> >
> >     $ hyperfine \
> >     --prepare 'rm -rf dest.git && git init --bare dest.git' \
> >     'git -C dest.git unpack-objects <binary_320M.pack'
> >     Benchmark 1: git -C dest.git unpack-objects <binary_320M.pack
> >       Time (mean =C2=B1 =CF=83):     10.029 s =C2=B1  0.270 s    [User:=
 8.265 s, System: 1.522 s]
> >       Range (min =E2=80=A6 max):    9.786 s =E2=80=A6 10.603 s    10 ru=
ns
> >
> >     $ hyperfine \
> >     --prepare 'rm -rf dest.git && git init --bare dest.git' \
> >     'git -c core.bigFileThreshold=3D2m -C dest.git unpack-objects <bina=
ry_320M.pack'
> >     Benchmark 1: git -c core.bigFileThreshold=3D2m -C dest.git unpack-o=
bjects <binary_320M.pack
> >       Time (mean =C2=B1 =CF=83):     10.859 s =C2=B1  0.774 s    [User:=
 8.813 s, System: 1.898 s]
> >       Range (min =E2=80=A6 max):    9.884 s =E2=80=A6 12.192 s    10 ru=
ns
>
> It seems that you want us to compare this pair of results, and
> hyperfine can assist with that by including multiple benchmarks
> (with labels, using '-n') as follows:
>
> $ hyperfine \
>         --prepare 'rm -rf dest.git && git init --bare dest.git' \
>         -n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <big=
.pack' \
>         -n 'new' '~/_git/git/git -C dest.git unpack-objects <big.pack' \
>         -n 'new (small threshold)' '~/_git/git/git -c core.bigfilethresho=
ld=3D64k -C dest.git unpack-objects <big.pack'
>
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):     20.835 s =C2=B1  0.058 s    [User: 14.51=
0 s, System: 6.284 s]
>   Range (min =E2=80=A6 max):   20.741 s =E2=80=A6 20.909 s    10 runs
>
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):     26.515 s =C2=B1  0.072 s    [User: 19.78=
3 s, System: 6.696 s]
>   Range (min =E2=80=A6 max):   26.419 s =E2=80=A6 26.611 s    10 runs
>
> Benchmark 3: new (small threshold)
>   Time (mean =C2=B1 =CF=83):     26.523 s =C2=B1  0.101 s    [User: 19.80=
5 s, System: 6.680 s]
>   Range (min =E2=80=A6 max):   26.416 s =E2=80=A6 26.739 s    10 runs
>
> Summary
>   'old' ran
>     1.27 =C2=B1 0.00 times faster than 'new'
>     1.27 =C2=B1 0.01 times faster than 'new (small threshold)'
>
> (Here, 'old' is testing a compiled version of the latest 'master'
> branch, while 'new' has your patches applied on top.)
>
> Notice from this example I had a pack with many small objects (mostly
> commits and trees) and I see that this change introduces significant
> overhead to this case.
>
> It would be nice to understand this overhead and fix it before taking
> this change any further.
>
> Thanks,
> -Stolee

Can you show me the specific information of the repository you
tested, so that I can analyze it further.

I test this repository, but did not meet the problem:

 Unpacking objects: 100% (18345/18345), 43.15 MiB

hyperfine \
        --prepare 'rm -rf dest.git && git init --bare dest.git' \
        -n 'old' 'git -C dest.git unpack-objects <big.pack' \
        -n 'new' 'new/git -C dest.git unpack-objects <big.pack' \
        -n 'new (small threshold)' 'new/git -c
core.bigfilethreshold=3D64k -C dest.git unpack-objects <big.pack'
Benchmark 1: old
  Time (mean =C2=B1 =CF=83):     17.403 s =C2=B1  0.880 s    [User: 4.996 s=
, System: 11.803 s]
  Range (min =E2=80=A6 max):   15.911 s =E2=80=A6 19.368 s    10 runs

Benchmark 2: new
  Time (mean =C2=B1 =CF=83):     17.788 s =C2=B1  0.199 s    [User: 5.054 s=
, System: 12.257 s]
  Range (min =E2=80=A6 max):   17.420 s =E2=80=A6 18.195 s    10 runs

Benchmark 3: new (small threshold)
  Time (mean =C2=B1 =CF=83):     18.433 s =C2=B1  0.711 s    [User: 4.982 s=
, System: 12.338 s]
  Range (min =E2=80=A6 max):   17.518 s =E2=80=A6 19.775 s    10 runs

Summary
  'old' ran
    1.02 =C2=B1 0.05 times faster than 'new'
    1.06 =C2=B1 0.07 times faster than 'new (small threshold)'

Thanks,
- Han Xin
