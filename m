Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17931F462
	for <e@80x24.org>; Fri, 26 Jul 2019 18:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbfGZSnZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 14:43:25 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34545 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfGZSnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 14:43:25 -0400
Received: by mail-io1-f45.google.com with SMTP id k8so106869392iot.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=influxdata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=irsG5wjKrWic/8XuBQzkdViAlQx/6wsOQSVGOR3Nu84=;
        b=aCEEos4juRxD92395VxhuEWGBjAZ27Z9uzgp6dy92l0zLCiIIhS2ysOUrYDVyaaVEL
         x+Cg8P8QYiS+BJ240sih5/MBEOk9GGiXRXJWS2KmrqQ+eY/7f9wmRjoA5GFVprt4whe/
         z5LaMdsct3c9dxVEy0biMuc6cAMZTtDgKg9Majm0EIzsMWKIz/8O8H0+0AQvPDQopVEq
         /0x11MgtsbKt9VKDTCzZqEl1s62nNVFd32TIAtqn2O1dzgm4AoeELk18A8+SyRYK5f7v
         7Qpli8k/HtjSI+q64gJvl36QuYnTxSQqaDyY5tPdc+6f/rBgG4hUgx7dMpefo/S9wZTv
         UdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=irsG5wjKrWic/8XuBQzkdViAlQx/6wsOQSVGOR3Nu84=;
        b=WSnYT9bLW5ok4eN1h9wxqTKl5jYIS5tIn5aWO7uQMg/9q5mbX9OqJLw22HK1jaOcct
         HTxkbij7MHR5i82UTujFgA5iaWDfevSFpwBUw0+VLR5urwo946MRe3NTusMsAlty5qJ2
         70m1TV4DCYIUxStkChAbrUCogPDV6U/RCBzQQBeKrCMbBUs1gRKCTsLXTGfpy7ecpbAb
         lmFLV6mzbiFdxKOfXh9Cpr9FZTnOqOwqvrpVEa7HC+Nl4SQYEvkT/4mbqokg3onDzafQ
         0bA7RwjUxQQQWJ585vsV5YwM9A1sEwty3+/g0dr834iSWzYZ+aVYumqPrfOLyuV5mRMD
         m7FA==
X-Gm-Message-State: APjAAAXHTjBj/WGrfS792Fo/zYPZ/CouTSKvpyfTeDV/XjZAnI8KiYXp
        QKZJDeW2AzK3jp0lOM1RChaoLg612jCSzt8N5yD9Yiqk+B8=
X-Google-Smtp-Source: APXvYqwLYFEl9t5briLHNWSHDuUNJ01mQBPjHGxrKU8zXn+XHCFJqqLPeeoKNzKjhGpbhYYer40GdVLenQaACBt75eM=
X-Received: by 2002:a5d:9752:: with SMTP id c18mr19478514ioo.22.1564166604430;
 Fri, 26 Jul 2019 11:43:24 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Rushakoff <mark@influxdata.com>
Date:   Fri, 26 Jul 2019 11:43:13 -0700
Message-ID: <CALxJwdP70PpcJKFC3FRm5t58yjxz438WwYisuFwQsJ2oaXV_9A@mail.gmail.com>
Subject: Possible to unshallow or deepen based on local objects?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am building some CI tooling, and I am working with a large-ish repository, so
I am trying to start with a shallow clone of the repository and deepen it on
demand. I am finding it very difficult to correctly switch between fetch
--depth and fetch --deepen.

I am looking for a way to "recover" from a fetch --depth call that made my
history shallower than before. Ultimately, I may take a different approach to
just work around this altogether, but I thought I'd ask here first.

In particular, if there is history like this:

A --- B --- C --- D --- E --- F
       \                 \
         ---------------- G
And my shallow history includes D..F, then I believe I am limited in my options
for fetching G:

- If I do a plain fetch of G, or if I use --deepen, then I pull in A and all of
  its history, which I don't strictly need or want yet.
- If I know G's parent is B, and I fetch --depth=1, then (I think) I will see
  B, E, F, and G, effectively losing sight of D

As a more contrived example, suppose I have a shallow clone of a repository:

bash-3.2$ git clone --depth=4 -q git@github.com:git/git.git
bash-3.2$ cd git
bash-3.2$ git log --format='%h %d'
3034dab  (HEAD -> master, origin/master, origin/HEAD)
98e06de
352253a
4098130  (grafted)
7b974e3
df63c2e
75ce486  (grafted)
70b39fb  (grafted)
afc3bf6  (grafted)
bash-3.2$ cat .git/shallow
409813088ad55ae4a60f55412f6b5ba6a89d89e7
70b39fbede78313656e8a6bd9b38b238ab10db2f
75ce48674889df6a2bb493fb5d6bef0ef60ca7ae
afc3bf6eb13d9fc489b569164819cff44db8ac17

And then suppose I fetch with depth smaller than before:

bash-3.2$ git fetch --depth=1 -q
bash-3.2$ git log --format='%h %d'
3034dab  (grafted, HEAD -> master, origin/master, origin/HEAD)
bash-3.2$ cat .git/shallow
3034dab9ed6b11970a53099a7b3ca981f1461365
409813088ad55ae4a60f55412f6b5ba6a89d89e7
70b39fbede78313656e8a6bd9b38b238ab10db2f
75ce48674889df6a2bb493fb5d6bef0ef60ca7ae
afc3bf6eb13d9fc489b569164819cff44db8ac17

I can still see the commits I had before the --depth=1 fetch:

bash-3.2$ git log -1 --format=oneline 75ce486
75ce48674889df6a2bb493fb5d6bef0ef60ca7ae (grafted) Merge branch
'di/readme-markup-fix'

Short of looking through .git/shallow and removing each entry whose parents I
can resolve, is there a built-in command to "unshallow based on local objects"?
I have tried many web search terms, I have looked through the docs for many
low-level git commands, I have tried variations of "git fetch .", and I am
stumped.
