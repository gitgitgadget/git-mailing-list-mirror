Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E824A1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeJOW1g (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:27:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34937 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeJOW1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:27:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id d21-v6so9311868qtq.2
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/2t+S8dKAwViUpYtTvDGIsbZiza0h4ztB3qvZbnbV8=;
        b=M8tzPfNwwn6rraAb0dMSEoythKMZDy5WqXw+OYfNG9BvOrd/ZrOarHW557lMfAKe7p
         8CH2bDxkMeYD0eulYYsZBxrIPSrR6HuqzHojIHRH9H2RrugAlYmqb5HeVdwIvS70vItV
         KtDG9OJfWZBE1sz67ZviApKOakJ96b24bng6B2TLNMC96zsQ13hBKDoT8Ob+ijd95gVg
         FvavHww1jZWsLcuxJIr6qOXkThyWWsQ1svtVHgSm3K6hgfDmAYuGq3i0P6+JrUxjVYtn
         /r/Y1Daw8KBoKbrOoJPFzGBeClc0NQT+p9zgVbQCFOsk4OzlZEOzMMPhahK+rPMapzXX
         A6Fw==
X-Gm-Message-State: ABuFfoiAaYvaPthpLoBHYiltz0BfAjMWCWmRfDQ5Y//ys1qgJ276TGIh
        LR+HFW19lsml3uyULG+MszA2ED/mFCW89EKszm0=
X-Google-Smtp-Source: ACcGV60qMplF3b5N7sCGLStCmTgXHRugnIrZRGAbqPjHZd++3WhFrS1Wd5Zl37vIercR4xBYUBAtMP+CT3rrGOMkIPk=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr11445216qtp.352.1539614522861;
 Mon, 15 Oct 2018 07:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.45.git.gitgitgadget@gmail.com> <271a5f57cef00d24ee33e99839cf3890e561efe7.1539596822.git.gitgitgadget@gmail.com>
In-Reply-To: <271a5f57cef00d24ee33e99839cf3890e561efe7.1539596822.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 10:41:51 -0400
Message-ID: <CAPig+cRaBRP9f3sR8suZxC+Y2_UZaBMbMcpjsRUY+mGN+nyXkQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mingw: use domain information for default email
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 5:47 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When a user is registered in a Windows domain, it is really easy to
> obtain the email address. So let's do that.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -1826,6 +1826,11 @@ static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
> +char *mingw_query_user_email(void)
> +{
> +       return get_extended_user_info(NameUserPrincipal);
> +}
> diff --git a/ident.c b/ident.c
> @@ -168,6 +168,9 @@ const char *ident_default_email(void)
> +               } else if ((email = query_user_email()) && email[0]) {
> +                       strbuf_addstr(&git_default_email, email);
> +                       free((char *)email);

If query_user_email(), which calls get_extended_user_info(), returns
NULL, then we do nothing (and don't worry about freeing the result).
However, if query_user_email() returns a zero-length allocated string,
then this conditional will leak that string (due to the email[0]
check). From patch 2/3, we see in get_extended_user_info():

+static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
+{
+       if (GetUserNameExW(type, wbuffer, &len)) {
+               char *converted = xmalloc((len *= 3));
+               if (xwcstoutf(converted, wbuffer, len) >= 0)
+                       return converted;

that it may possibly return a zero-length string (due to the ">=0").
Do we care about this potential leak (or is GetUserNameExW()
guaranteed never to return such a string)?
