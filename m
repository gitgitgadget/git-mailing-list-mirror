Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D037E208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeHFSRH (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:17:07 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35293 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733178AbeHFSRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:17:07 -0400
Received: by mail-lj1-f171.google.com with SMTP id p10-v6so11071111ljg.2
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=r7FeSa84LDsFAnSpkBevV5LnqGwuwobclPIMX2CYAik=;
        b=rK5tXlzK+Ro+lZl/o1ygvPfe541JyunUiD2UAbxdHiqNEWoUknC3CM/ASHFMqnBbir
         uKqm2WLd8BYljJwIv2e/y8wUdq+o6eSeGLbgi6TS9PnGdMOAwk1YmEKiQSfHuGI7zQQo
         e1c0NaH4zJlfVHmx3hNdJ6R7pKCsyFXKXjDNRH1FnzFYTkwjGthhcm7T4dXoxMqtcSMv
         g+51LV3+N0fTYa9K0/9m/8MJf5zeIEYeOHE7h6mXmpZcqwj+Pg64Ds1M8mVPCkmqLfSz
         Kmvs8WLy6M7FzXabz3lDIpIsNoHqy+1Q6UE+M0YYDbGxE4ayT/YEhw45EgP0oxEs4QR6
         g6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r7FeSa84LDsFAnSpkBevV5LnqGwuwobclPIMX2CYAik=;
        b=EdFKyohiN/feDXld1zX26SheB+/jlyaeI1qt+kbi5mcKPFhq2yI+bsQ0hj0VozO08L
         OzTLtUJtTr6MUzGyaGC7jLpmKbBTbUYkj2MOgi+DEUMNh8BdWYU+8ViWb3VJhgCwYIrR
         6wLuQ16XbDTlVdpDPxS8cWa4ZVggOGiVi5Azf6jWB0gptXFHeYUln7MPlZf9ZeGGJvBh
         PCuPZv3vHznXvsDbn3oGX+pl+CMzeT+pgJEHi9L+w/6re+0KUpk+Qo9/WcNigRV39jUg
         oGWHZbc8ux6ZKrpcShGB+Cf1l3tDi95q80H7VjfS5cGFFHKj5V80S8IAOgmHjmeMPtwz
         aZ0Q==
X-Gm-Message-State: AOUpUlGl3SNkaZ20V93RniK4sMnnnjx8zU0n0hDH85I16m12e/pxuhlc
        Uev9ODuKmJM2y1bFPDOuK7lhIJgko8skL0saPzO65V01
X-Google-Smtp-Source: AAOMgpcXPbb17S/hrsIIrTXnr2XJ/We55K1wKekV9f/Qsg/sh2D1cGwE4EeKfA7AHu+JXFj/LZ5pnw0mplCYygesnmw=
X-Received: by 2002:a2e:2c09:: with SMTP id s9-v6mr5447511ljs.88.1533571638128;
 Mon, 06 Aug 2018 09:07:18 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 6 Aug 2018 18:07:06 +0200
Message-ID: <CAM0VKj=DDOPDxo_xDvhk2-HUPHfkUcLQTimqmY31yjq5eZiM2Q@mail.gmail.com>
Subject: [BUG] 'git ls-files --no-exclude' segfault & co
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git ls-files' has the options '--exclude', '--exclude-from',
'--exclude-per-directory', and '--exclude-standard', which all work
fine.  However, it also allows the negated version of all these four
options, and they definitely don't work very well:

  $ git ls-files --no-exclude
  Segmentation fault
  $ git ls-files --no-exclude-from
  warning: unable to access '(null)': Bad address
  fatal: cannot use (null) as an exclude file

And '--no-exclude-standard' has the same effect as
'--exclude-standard', because its parseopt callback function
option_parse_exclude_standard() doesn't bother to look at its 'unset'
parameter.
