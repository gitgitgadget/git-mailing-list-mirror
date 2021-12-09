Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C66C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 16:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbhLIQ5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:57:37 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42645 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhLIQ5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 11:57:32 -0500
Received: by mail-pf1-f181.google.com with SMTP id u80so5937007pfc.9
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 08:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tmODaIqxTj+X8roi+skkb+b82JnNAazAvhYYVndbl8=;
        b=hOCE1H1CJyMQQ76Lccv/xW51TiG3BxSgONFskZIq/TrLuQge/BviUJxVbYfbScSF+X
         nyJCLQwqLZoQamgqamK1c7IUnx5Jozoch47ay/KNKSi3CKuo784NlrL6RQ8aDDfe4CSx
         c1NgGBqv7yl836C4MefCvoLciYEXDSoft4xBx1IUe2msOuOrsktDq0wr33wi2T+g3oTX
         417myq9bR7vNGoG5psc45o/Dunlo9Xx+SbaFVBdnUmK4qeTkLh9+uIWWWwAAjerQ3sEs
         TYnnS6nYdEV919fs1SD7crgRyB3pstjEX34gwaHBQae5ZXLmM+TuWfZ1+4nLYXKLbfis
         VG/A==
X-Gm-Message-State: AOAM5331VUaU+tLt+qX5x1cWkAM2sC5yH1eXub+7TJDl10aGpecuffzQ
        ceIbrxIqg11DGirSuCXczAKV6ojTBMuC+ebJQWFajhqMj582bg==
X-Google-Smtp-Source: ABdhPJxKSmraIlLPXUqpKRrW63V5lSDGdBg7jgguDRfvX1zkGIiEX7EeVIr0vEN0y8ZuXR2OgSd3DBrpacHVe7QCCmo=
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr12816696pfj.15.1639068838031; Thu, 09
 Dec 2021 08:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-12-sunshine@sunshineco.com> <CABPp-BGBhxbvh_Ob=bR8U9f-3muiBzWmFruKLXd=K7420i8COw@mail.gmail.com>
In-Reply-To: <CABPp-BGBhxbvh_Ob=bR8U9f-3muiBzWmFruKLXd=K7420i8COw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Dec 2021 11:53:47 -0500
Message-ID: <CAPig+cQzTnQiwT4Nmpp8qYJOaRpy2pK7DDOu42Wk-1TfmbUxSg@mail.gmail.com>
Subject: Re: [PATCH 11/19] tests: fix broken &&-chains in `$(...)` command substitutions
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 11:44 AM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 8, 2021 at 11:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >  test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
> > -       OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
> > +       OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
>
> Shouldn't the second ';' be replaced with '&&' as well?

Thanks for reading so carefully. In this case, the answer is "no", the
semicolon is correct. This code legitimately wants to capture in the
OUT variable the numeric exit status of the command preceding `echo
$?`. If the semicolon is replaced with `&&`, then the echo won't be
executed if the exit status is non-zero, but we want `echo` to be
executed regardless of the exit status. So, the code is correct with
the semicolon, and would be incorrect with `&&`. (I hope I'm
explaining this well enough to make sense.)

It's this sort of special case which accounts for why the new linter
(as mentioned in the cover letter) has special understanding that a
broken &&-chain can be legitimate in certain circumstances, such as
explicit handling of `$?`.

> > -       OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
> > +       OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
>
> Same here; shouldn't the second ';' be replaced with '&&' as well?

Same answer as above.
