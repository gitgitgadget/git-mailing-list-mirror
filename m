Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037181F453
	for <e@80x24.org>; Tue, 12 Feb 2019 03:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBLDr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 22:47:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44128 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfBLDr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 22:47:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id r21so7874067qkl.11
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 19:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96Bve2AcJT+G1CGpMjc3RQXKFLL9LqYK/rOEjbIgLX0=;
        b=L4Ff/kz+vszp8UZnQB/SHvxZDXP4XTiHgn0FzrQRKP/2sVk7uAY1jxP5T37gKESWY8
         KJ5LYhEeOb1I1at2esERXk3xpEcuHfZdWuE0AAarhedldv1EbaTMRxiQBwvJvQkyPRvH
         PB/doTA/hpsNl2Ox+xKaFG9oRCLHUkfSsB/F9yyhYHUaJQH+1aqjf0+kXE+CVSABiy1M
         b+0PqVa6vIoZyhdxuf+AE/VyAL1nRPlojDaK76PuEpk2+joFg45Jn6DjMJs5+mvbplVf
         Baqf0WdytVgTZU7ciDcsm5qLynn2h+ZXlDLwxqkDRzMjS4USPbyvepTmi9q6Svo4XmVg
         Didw==
X-Gm-Message-State: AHQUAubKKbUHsHhJ+UqBEXWimWk6mnDpx1TIRVzE1zNpK1GdualJheHv
        b8ozHWl8m9x0lF3g9p/aqcvJ0p4mW/6Ycbo0fsk=
X-Google-Smtp-Source: AHgI3IbMtrWpP4CBHo8O5yB/vJNofdOBr+UxNIhkfiV5jbtMWlTkFLuMJNydwy08xU8KxeS1CLV0ScRrgRvt8IqngHQ=
X-Received: by 2002:a37:9584:: with SMTP id x126mr1157998qkd.36.1549943277356;
 Mon, 11 Feb 2019 19:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-16-sandals@crustytoothpaste.net>
In-Reply-To: <20190212012256.1005924-16-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Feb 2019 22:47:46 -0500
Message-ID: <CAPig+cRv04mcbxNUn6bRXbJiQvgj2cpwDGLJP=7NdmZ2LXJJfQ@mail.gmail.com>
Subject: Re: [PATCH 15/31] builtin/pull: make hash-size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Instead of using get_oid_hex and GIT_SHA1_HEXSZ, use parse_oid_hex to
> avoid the need for a constant and simplify the code.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/builtin/pull.c b/builtin/pull.c
> @@ -365,9 +365,10 @@ static void get_merge_heads(struct oid_array *merge_heads)
>         while (strbuf_getline_lf(&sb, fp) != EOF) {
> -               if (get_oid_hex(sb.buf, &oid))
> +               const char *p;
> +               if (parse_oid_hex(sb.buf, &oid, &p))
>                         continue;  /* invalid line: does not start with SHA1 */

While you're here, perhaps fix the comment so it doesn't talk about
SHA1 anymore.

> -               if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
> +               if (starts_with(p, "\tnot-for-merge\t"))
>                         continue;  /* ref is not-for-merge */
>                 oid_array_append(merge_heads, &oid);
>         }
