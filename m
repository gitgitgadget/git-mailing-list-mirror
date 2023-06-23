Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C100EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 22:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjFWWHs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 23 Jun 2023 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjFWWHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 18:07:45 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5342703
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 15:07:34 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-763bd31d223so94373985a.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 15:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558053; x=1690150053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42WeS58ndB6rHEyAMxkk9EvaaR75MQXhZPiEiRfZbtM=;
        b=G13wXYrlhHHCY7G2OW+KOeRKThnpPCnLw30FiAIqVQ8t3ARkxZvQ3fG6VGyXGZGyur
         +NIqa2G9snqfhHCiGJ4rwZ45vt8G3ABaCt/2GVrDz7kwTg513wDoB/C4a97AgfuuWyeb
         engDDOvksXVGO2beGfOaZUD4N0JJptB0yYUmE+LxNCkW+eyf/dxY50NcLx8NW4Q9LDDZ
         qTW23V8rvnc8Ygx2K5Voro5JtI3xxxbYFyp4kS3V4TlDIiUVzeqLiIyZZ9zk2S2/5gOL
         ljQp25cian6PC4rXIMGJZrdKqLhAdhFdGDtEXfHCRWCAWXCCzK0wzVctveuCOpwhtRGd
         mQnw==
X-Gm-Message-State: AC+VfDwXdLFqeqcLfZ+62pavudRNO7vXaVnhDEwKRIiu8jK/JD3U094z
        Y7cy4Rj00n97kzO0cuWk0Tk/TKR3xJg4L9JLYjuREKYZ8Zk=
X-Google-Smtp-Source: ACHHUZ70pKe/H8xAbf9zd0Uv3X+cKjJRL1CbJvu+3pHqDySux2re/xduazMjkR92H84Ljml7mvLg4dcQvih8EbPajnA=
X-Received: by 2002:ad4:5762:0:b0:62d:feee:2520 with SMTP id
 r2-20020ad45762000000b0062dfeee2520mr29811691qvx.51.1687558053637; Fri, 23
 Jun 2023 15:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <CWLP265MB3841D32521E79202079DB7F58C22A@CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWLP265MB3841D32521E79202079DB7F58C22A@CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Jun 2023 18:07:22 -0400
Message-ID: <CAPig+cQ1qzO5txhZhki4UrvLBThdgo-aknBmEkNSjFhR9WXLRg@mail.gmail.com>
Subject: Re: Bug: git add does not process gitignore properly
To:     David C Black <david.black@doulos.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 3:56 PM David C Black <david.black@doulos.com> wrote:
> Sitting at the rood of my working directory I attempted to add a file to the git repository with:
> > git add extern/bin/build
>
> The repository had the following .gitignore file contents:
> > /extern/
> > !/extern/bin/
> > !/extern/ABOUT.md
>
> I received an error message:
> > The following paths are ignored by one of your .gitignore files:
> > extern
> > hint: Use -f if you really want to add them.
>
> By negating entries in the /extern/bin/ directory, I did not expect an error
> message. Of course adding -f made it work, but I think it does not match the
> described behavior for this tool.

This appears to be working as documented. From the gitginore(5) man page:

    An optional prefix "!" which negates the pattern; any matching
    file excluded by a previous pattern will become included again. It
    is not possible to re-include a file if a parent directory of that
    file is excluded.

In your .gitignore file, /extern/ is ignored, which means that the
subsequent "!/extern/.../" lines are ineffectual. So, as far as Git is
concerned, /extern/bin/build is indeed ignored, thus its refusal
without --force.
