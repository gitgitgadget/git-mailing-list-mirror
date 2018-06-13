Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD9A1F517
	for <e@80x24.org>; Wed, 13 Jun 2018 17:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935240AbeFMRVP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 13:21:15 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45259 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbeFMRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 13:21:15 -0400
Received: by mail-yb0-f196.google.com with SMTP id x6-v6so1185457ybl.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 10:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ye2LGcIF0V5Kazj98ARm50+Kn4uDMAKQSH3jFakfhY=;
        b=cXapPh7KuKI/zDNCvxNYI9ee31mFvplsN1jkqgT9lUSiprbnU48mYGBUNml9d25gh3
         qIKXPBkPhC4okC2JEfMZM5xQ8rf1Oxxiim0Uc6u4M4X7Z67ItlhcSKHl/AB1lGHguDVi
         Ack/9KAV1DItOGl4TQ+L43AWYR9EtkLx/7LVQkXC9Vpk9VbvFsCQBNCmjvG4Gzvuwneh
         ZDXyiAThDgvpPncpI2kK1mv2RkfkIBDYQAU3oWvlWFP5m14DXgtGy0UhzDzJZV1TfsUc
         MzJ3T5FIRjE8R2r4D9Qmlb4COuOmi6H8wLKz32BBQLBHJ3hV5m08PDmZLoqLrBSqbgyV
         2VOg==
X-Gm-Message-State: APt69E1SDadTA14E3XnJSMDQlnultJE0l0F6V9kJXsvakBejOl51q6DB
        /D/p6+eC5YAN0HM3aJVGzqboRKlznPTWgRy44JQ=
X-Google-Smtp-Source: ADUXVKIGNLzrjeCPYL8mMlaStfDcZ2Nk5iV1zCNXDaQHNakgPTD9djZEoLv2zD7NuqHdbyNDGDG3y7cxZo6R3uErBpY=
X-Received: by 2002:a25:83c6:: with SMTP id v6-v6mr2886174ybm.263.1528910474316;
 Wed, 13 Jun 2018 10:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180613142207.14385-1-lintonrjeremy@gmail.com>
In-Reply-To: <20180613142207.14385-1-lintonrjeremy@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Jun 2018 13:21:03 -0400
Message-ID: <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com>
Subject: Re: [PATCH v2] packfile: Correct zlib buffer handling
To:     Jeremy Linton <lintonrjeremy@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple comments if you happen to re-roll...

On Wed, Jun 13, 2018 at 10:22 AM Jeremy Linton <lintonrjeremy@gmail.com> wrote:
> The buffer being passed to zlib includes a null terminator that

On this project, the character mnemonic "NUL" is typically used, not
"null" or "NULL" (which is typically reserved for pointers), so:
s/null/NUL/g

> git needs to keep in place. unpack_compressed_entry() attempts to
> detect the case that the source buffer hasn't been fully consumed
> by checking to see if the destination buffer has been over consumed.
>
> This causes a problem, that more recent zlib patches have been
> poisoning the unconsumed portions of the buffer which overwrites
> the null, while correctly returning length and status.
>
> Let's replace the null at the end of the buffer to assure that
> if its been overwritten by zlib it doesn't result in problems for
> git.
>
> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
> ---
> diff --git a/packfile.c b/packfile.c
> @@ -1433,6 +1433,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
> +       buffer[size] = 0; /* assure that the buffer is still terminated */

I think we normally use '\0' for NUL on this project rather than simply 0.

The comment is also effectively pure noise since it merely repeats
what the code already states clearly (especially when the code says
"buffer[size] = '\0';"), so dropping the comment altogether would be
reasonable.
