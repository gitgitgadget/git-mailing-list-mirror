Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BBA1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 08:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfBLI1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 03:27:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38549 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfBLI1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 03:27:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so6514978qkl.5
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 00:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxuuaTX9QFTfR/L0O9cEvMreuq5Eul/soLArgdms8TU=;
        b=gjs9m+lf8Wo8IBxgqTwGBXpr+nRo41j3gX+BZKUu/UOeuipcniUyqBZeMwnItprqUZ
         M9IKGSubGsUIkPFxKebnz2lJLrSClmMwHbJHu8RBp55Amoa8S785BUbVhxE87/3lwy9M
         bDBBpfPKg8dHRERf261xMsogagTyGtVgXO7vei4jhAgMm/zhGcYtHs5cVwZ9ajJ4jLyH
         L5r+TpxKY9jYnTP27wb/0KvW8tgIkZUZy8M4c5gZI3oUcOCHbk8WrqWAqgFCcOTz7M/V
         QgkfL1NbZFbLkhxG5CXe1pUHFwjWHUg4d1UehjJJkx7zWCC749D0wgjOMZlWb/x8kdZz
         5sTA==
X-Gm-Message-State: AHQUAuYWSKEZh+p9ytAz9aXHZR3Lv/0hhK7ukcvNJTp/wnqv3LsHZ1Ym
        R4hC0crYH0jkyLE3jgOZDOy54ua68bwYjuVamtU=
X-Google-Smtp-Source: AHgI3IYAmgzbnWvzobjd6M1LaNF+rjvEo38N1ihJmvAAohiwhKdwVmG3/QWITrzA1kE9BKfIx0W2Y6sivDEBnfDIHU0=
X-Received: by 2002:a37:c313:: with SMTP id a19mr1668144qkj.220.1549960054806;
 Tue, 12 Feb 2019 00:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-28-sandals@crustytoothpaste.net>
In-Reply-To: <20190212012256.1005924-28-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Feb 2019 03:27:23 -0500
Message-ID: <CAPig+cRTKTWPA66YTnX=RMJyCZmWK6efkxOyfYH_zn9OOSb8_w@mail.gmail.com>
Subject: Re: [PATCH 27/31] builtin/difftool: use parse_oid_hex
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 8:24 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Instead of using get_oid_hex and adding constants to the result, use
> parse_oid_hex to make this code independent of the hash size.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> @@ -65,14 +65,12 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
>         if (*p != ' ')
>                 return error("expected ' ', got '%c'", *p);
> -       if (get_oid_hex(++p, oid1))
> +       if (parse_oid_hex(++p, oid1, (const char **)&p))
>                 return error("expected object ID, got '%s'", p + 1);

Not a problem introduced by this patch, but is the 'p + 1' in the
error message correct? 'p' has already been incremented via '++p' in
the call to parse_oid_hex() to point at what _should_ be the start of
OID, so one would think that the error message would want to print out
whatever was found there rather than what was found one character
after the start of OID.

> -       if (get_oid_hex(++p, oid2))
> +       if (parse_oid_hex(++p, oid2, (const char **)&p))
>                 return error("expected object ID, got '%s'", p + 1);

Ditto.
