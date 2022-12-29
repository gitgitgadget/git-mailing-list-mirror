Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E870BC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 17:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiL2RGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiL2RGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 12:06:19 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197B812AFE
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 09:06:17 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id v23so19758777pju.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 09:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ofre/BQ8AMlDbGj+L82z8TiUqJkyz4Mb60XWPo+Zqqg=;
        b=A/SwUKrDWJmLnjnakNkopBOfNdkbCJz6UNjuwo5PpGXFvEUz+UmJC8aixBIfU8nmdo
         u/zXU+viO7Ha6x5nXIh25eUAovVmIGdJI9GGqmlnE9EHfhytu51hFA5xkFL4zew859Ju
         J6r9SLa9JNsZdmqKENlS0SKQK1WnJKocpUXck6PKERPLWO1lmK2mcmcuB45dJ6y/Moao
         F5smvw4I3sHipp5Pc9lORq842VSDozgcCE6XxKVKbNJulsZLDIvJ/b+K9uOBEN7y6coK
         D1xiqBk0PYoHwbF1G2QJ5Sy4nDKQa2u39TLYSxWwUHUpI6diFJTajk2N6Nw7H3d+sEHR
         voJA==
X-Gm-Message-State: AFqh2koUoQsG6t3NRoZh+bq076QiKz3oS9doaUf2s8O6qhBp0QhNN2fv
        YH+qTzoko1sWeLTQxeStLof8qftWRSf536N2ctA=
X-Google-Smtp-Source: AMrXdXu2fllayRp04S1PozF/bji6QFKD1CPUKvSyPpbfHt3yNm1LihgUF+IAXTrt6UhoxSeuMvOhEpYgkcW2e2CoIBc=
X-Received: by 2002:a17:90b:48cf:b0:226:164f:522e with SMTP id
 li15-20020a17090b48cf00b00226164f522emr594236pjb.22.1672333576519; Thu, 29
 Dec 2022 09:06:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1418.git.git.1672333122193.gitgitgadget@gmail.com>
In-Reply-To: <pull.1418.git.git.1672333122193.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Dec 2022 12:06:04 -0500
Message-ID: <CAPig+cSFAUcU74qULYkN7OX4-OqU_3VJeTdb1ZH_QoOW9FBwZQ@mail.gmail.com>
Subject: Re: [PATCH] grep: simplify is_empty_line
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2022 at 12:00 PM Rose via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/grep.c b/grep.c
> @@ -1483,9 +1483,10 @@ static int fill_textconv_grep(struct repository *r,
>  static int is_empty_line(const char *bol, const char *eol)
>  {
> -       while (bol < eol && isspace(*bol))
> -               bol++;
> -       return bol == eol;
> +       while (bol < eol)
> +               if (!isspace(*bol))
> +                       return 0;
> +       return 1;
>  }

The rewritten code appears to be quite broken. It never increments `bol`.
