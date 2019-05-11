Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874F41F4A3
	for <e@80x24.org>; Sat, 11 May 2019 07:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfEKHfg (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 03:35:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfEKHfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 03:35:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so10051883wrp.2
        for <git@vger.kernel.org>; Sat, 11 May 2019 00:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adA+ehxV/y6442BtXuGlp3swtmP+Ei/GlpdFqVkJToQ=;
        b=T469ElroN9+D0B1psHhmaMfemNxXlrdVySVmjOgt/fGgzHrikxHvfuF6Ky/qsFw3/A
         iQxgJ8tSZunS+PVeNqpkAGvdCNbxJjlaPA/UIR/Q/k4ndhgmGAw9aNTA61r6ht1zloTZ
         eFck4v38fAej9SpmAE2lH5P0oWS19KOWibLiHBgTbXgyZL+fr2wObhHJ/PzKVdVaYwBL
         sIJxEKKjzycHU4hqafgWs1rjESiciTnzZq4NQfznerpXxT3q1fOMJGnQgsmPdHVWaCHG
         pnP38TBMgkW2Bm1tsXymUAjZ+UxyotudEWQL8P78i1R+j8m1yn7IsHM11AW9eSfx2CnP
         1arw==
X-Gm-Message-State: APjAAAW38xYLQYYZ6IA5OE9o01ws3yF3oAwKyBORUwt7/lQzAxjE0WQZ
        mv3J9635oTnnZ2dlg66JTCR0wayXAZImglYfzn1FtA==
X-Google-Smtp-Source: APXvYqwNMZKw8lzhBG2QqtE1t6EKG4BHYNKPqA/AaTa68qkqWa9fkvZJMLbiRmGvG0aVb9KmBy3cdVmuOnaw5jphssE=
X-Received: by 2002:a5d:5282:: with SMTP id c2mr10564305wrv.88.1557560134742;
 Sat, 11 May 2019 00:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190511013455.5886-1-e@80x24.org>
In-Reply-To: <20190511013455.5886-1-e@80x24.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 May 2019 03:35:23 -0400
Message-ID: <CAPig+cRZy4yM+ZuHhZK3tPV_QRvSy63aHBZZj6AcFTu+5FNG0A@mail.gmail.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
To:     Eric Wong <e@80x24.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 9:35 PM Eric Wong <e@80x24.org> wrote:
> Do not change the existing info/refs and objects/info/packs
> files if they match the existing content on the filesystem.
> This is intended to preserve mtime and make it easier for dumb
> HTTP pollers to rely on the If-Modified-Since header.
> [...]
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
> diff --git a/server-info.c b/server-info.c
> @@ -6,37 +6,78 @@
> +static int files_differ(FILE *fp, const char *path)
> +{
> +       [...]
> +       struct strbuf tmp = STRBUF_INIT;
> +       [...]
> +       if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len)
> +               return 1;

Although strbuf_fread() will release 'tmp' automatically if the read
actually fails, it won't do so otherwise. So, if it reads more or
fewer bytes than expected, for some reason, then this early return
will leak the strbuf, won't it?

> +       the_hash_algo->init_fn(&c);
> +       the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
> +       the_hash_algo->final_fn(oid_new.hash, &c);
> +       strbuf_release(&tmp);
> +
> +       if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0)
> +               return 1;

Same issue.

> diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
> @@ -0,0 +1,41 @@
> +test_description='Test git stash show configuration.'

Copy/paste error for test description?
