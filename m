Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EED81F954
	for <e@80x24.org>; Fri, 17 Aug 2018 09:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeHQMbq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 17 Aug 2018 08:31:46 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36911 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQMbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 08:31:46 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so8054657qtl.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 02:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NC3yU/vUhZGNpHo9rqe+yvzNF/odY7r+qG3/BbEkkbE=;
        b=dmLflfk/fUgPP+0bHjPCVwppW09zhoy8Q1lBgCxDLw2L9dvvG6Ls4TCsQJhem3u6FX
         sAclyHz1/9RvO92zFdUqlxURKp+hLIoHlqNJcaHTWSmPYt2RRKV+afPKvGfd8J7rEbCZ
         jksJsybss6jI1kC9GH2qrtbueEq9dxSC6GkpEfE6r3/ZQ9hu66tmRoKqPW5dsttZ90t9
         8OVTMJIWmN0I1IX0+ZELGdFb1MkiI2rLwoD6UvvMMwxN8OxIBAW4FbYElcs4TfZa2Iwj
         II2NhSIDKjMboontW+rhO7BekrYqqgz8GZOVVOGD67g39BDyoYFEG9CTfQn/RUOR8Tds
         x7vw==
X-Gm-Message-State: AOUpUlGL6en0SCzlUl0N8GmXck/MCfb0Ff+avHR+2SPQddIauk4nTqhf
        i1NhBRKhpBIOTEg+ZXInvCsZlRmSTNBO0RzK708ioNeP
X-Google-Smtp-Source: AA+uWPzRjj5erDdUqpDlg0XJ2DhNAcgQqn98olkTYHqf87xTKGC2AJgKMQjTjcbq6Vp7SW5OUmW2DnRrr9DnXQ4MivI=
X-Received: by 2002:a0c:85a3:: with SMTP id o32-v6mr30369822qva.62.1534498145745;
 Fri, 17 Aug 2018 02:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180817091710.1767-1-mgorny@gentoo.org>
In-Reply-To: <20180817091710.1767-1-mgorny@gentoo.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Aug 2018 05:28:54 -0400
Message-ID: <CAPig+cQVWY3+2aarYw=uXti0=1SW8boMPoYj1zatw1KKKVOqnQ@mail.gmail.com>
Subject: Re: [PATCH] gpg-interface.c: Fix potentially freeing NULL values
To:     mgorny@gentoo.org
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 5:17 AM Michał Górny <mgorny@gentoo.org> wrote:
> Fix signature_check_clear() to free only values that are non-NULL.  This
> especially applies to 'key' and 'signer' members that can be NULL during
> normal operations, depending on exact GnuPG output.  While at it, also
> allow other members to be NULL to make the function easier to use,
> even if there is no real need to account for that right now.

free(NULL) is valid behavior[1] and much of the Git codebase relies upon it.

Did you run into a case where it misbehaved?

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/free.html

> Signed-off-by: Michał Górny <mgorny@gentoo.org>
> ---
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 35c25106a..9aedaf464 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -15,9 +15,14 @@ static const char *gpg_program = "gpg";
>  void signature_check_clear(struct signature_check *sigc)
>  {
> -       FREE_AND_NULL(sigc->payload);
> -       FREE_AND_NULL(sigc->gpg_output);
> -       FREE_AND_NULL(sigc->gpg_status);
> -       FREE_AND_NULL(sigc->signer);
> -       FREE_AND_NULL(sigc->key);
> +       if (sigc->payload)
> +               FREE_AND_NULL(sigc->payload);
> +       if (sigc->gpg_output)
> +               FREE_AND_NULL(sigc->gpg_output);
> +       if (sigc->gpg_status)
> +               FREE_AND_NULL(sigc->gpg_status);
> +       if (sigc->signer)
> +               FREE_AND_NULL(sigc->signer);
> +       if (sigc->key)
> +               FREE_AND_NULL(sigc->key);
>  }
