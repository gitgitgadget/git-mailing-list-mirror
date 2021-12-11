Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A81C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhLKHcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:32:31 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:35419 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHcb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:32:31 -0500
Received: by mail-pf1-f176.google.com with SMTP id p13so10443204pfw.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVVGEcb41tt50h6PhXr+0XNjhp6dyGrOvAsQWYSKeRk=;
        b=JxbS92UP7FD71qQwmDhXzeZkjTkEfwzkRGfsSsv9nvVba0VPaSo6BuTIaAcMM0p+dN
         nq3ir6Wp3IISp4gbVtEYXJ5q6PuBJ4p4AQmUkFFClJmCHQcs4Xpfogs6R0G2wBbxPEuH
         Ki55+KooXQ2d/b543MRXf2LJwlNnND62ix2kivnWV/T4myhVUh9cAYliCA42wAmhBgrT
         ZkOQMGhirCd1ui/sIGuJp2nPADrnBgxe30utI7DoSti+MEdfkemyP9Y8yeHxr1p0wS3l
         +cH9ANi/BoULp5us6xzT3a3kpQd13OgcpxyEWLjTtNmgtOCCSBantNaamVdQAlDtpFUq
         feqw==
X-Gm-Message-State: AOAM532Sxl8Ccl2Zeeeix5alRQYC0W45D7HVwpAeb1HGXpIvjEFX7iz6
        h6Prq/JflNxCwTiR/IeQxvXLFbGQv0xTzgz9bOU=
X-Google-Smtp-Source: ABdhPJznb+0Juk3biqdV4kZlCVtBp/EWLZ6mh0d7HzYT3G1yTzMZFzNIpO1a5G3iCBnC382Bv/8MCfm/UOlR20JgVPM=
X-Received: by 2002:a63:380e:: with SMTP id f14mr42184646pga.227.1639207950614;
 Fri, 10 Dec 2021 23:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-13-sunshine@sunshineco.com> <20211210093827.a5s5mby3if5f7a4u@fs>
In-Reply-To: <20211210093827.a5s5mby3if5f7a4u@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Dec 2021 02:32:19 -0500
Message-ID: <CAPig+cRDKM3E5ZEV-A8Ze7pzDnM+s=xs0ioW_qXoM3yYfu7jSw@mail.gmail.com>
Subject: Re: [PATCH 12/19] tests: fix broken &&-chains in `{...}` groups
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 4:38 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 09.12.2021 00:11, Eric Sunshine wrote:
> >Fix broken &&-chains in `{...}` groups in order to reduce the number of
> >possible lurking bugs.
> >       {
> >-          echo "*.t filter=rot13"
> >+          echo "*.t filter=rot13" &&
> >           echo "*.i ident"
> >       } >.gitattributes &&
> >       {
> >-              echo "expanded-keywords ident"
> >+              echo "expanded-keywords ident" &&
> >               echo "expanded-keywords-crlf ident text eol=crlf"
> >       } >>.gitattributes &&
> >
>
> Wouldn't some of these be better off as heredocs as well?
> There are a couple more below. I personally don't much mind either way but
> since you changed quite a few in an earlier commit why not these?

It's been months since I made these changes, but I think there were at
least a couple reasons for not converting these to here-docs. First,
in these cases, there were only one or two missing `&&` per block. Had
I bulk converted them to here-docs, it would have made for a much more
noisy patch, which would have taxed reviewers more, and
reviewer-fatigue is a real concern when crafting a lengthy patch
series like this one. In the "here-doc conversion" patch, on the other
hand, many of those cases involved a significant number of missing
`&&`; often every line was missing `&&`. So, the changes in that patch
was going to be very noisy anyhow, whether I added missing `&&` or
converted to here-docs.

Second...

> >       {
> >               echoid insert 444 1 2 3 4 5 a b c d e &&
> >-              echoid contains 44 441 440 444 4440 4444
> >+              echoid contains 44 441 440 444 4440 4444 &&
> >               echo clear
> >       } | test-tool oidtree >actual &&

... there are a number of cases like this which look like they could
easily be converted to here-doc, but in fact `echoid` is a function
call, so a here-doc wouldn't work. Also...

> >       {
> >               echo $(git rev-parse refs/tags/A) refs/tags/A &&
> >-              echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}"
> >+              echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}" &&
> >               echo $(git rev-parse refs/tags/C) refs/tags/C
> >       } >expect &&

... this sort of thing could certainly become a here-doc because
$(...) will work in a here-doc, but when there is a preponderance of
this sort of `{ echo && ... }` block in the test script, it would feel
inconsistent to convert a few of them to here-docs.
