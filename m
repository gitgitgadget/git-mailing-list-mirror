Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8D51F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 02:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAECs1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 21:48:27 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:53653 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfAECs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 21:48:27 -0500
Received: by mail-it1-f173.google.com with SMTP id g85so4180682ita.3
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 18:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FLdoIXnCvJYcEadcScrjTUo/s0BM47u0zFDUol+RsG4=;
        b=ZgRvQarDFWjyh/wByXDYEfQ9HQGc1PQuz7KZMSb2qA0D8rfGVyf0DuYmrZ/ZDxL1tA
         rufB7MNfz0feKbqEZjzQYz415EzF3eweWV6AufBVvdt419bW1HBQMRoMhJefDFin2hDd
         39DOxKRiQLZuRs3cu0qf775qqxYfKLzUY5GHrZOEVbamqr7DdRvHWEVCdPJ109ewAL4Z
         UsdT0pJVqVe+p1a3oT9ij4o6ivluQJXxy3ym2/tCaGE6+C52DurtwLlAj/If1lfCc+rT
         HmcPFljz2JZgN3pvFiVce0u5ksNHTPnKl9ZKSuOTds2nPu2afVWjKmUepyDmCxFVD5PL
         sGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FLdoIXnCvJYcEadcScrjTUo/s0BM47u0zFDUol+RsG4=;
        b=aG2Pf3XQ7dP9qb3AGkPpj8IRNBcrwIfRTfPzGK8+Fdt43NOtzYkzRyJyfPWaev4W6W
         kgWWw+rROjp43h7fLLZxgvrpT/4ppKdfAuMcnZxZvfRfXmzsUgmN900aD8wM0z7/ZKWN
         5NLl7+LsXw0Wx71gvO5xkAUJLuzxlbGLn9ZZrXn44ArN/WGpRaV/xJmX6wdygg6kSV+b
         2znwAeWjXj9V7hjRWpx/NKTbEE0tqJiBe7HygOjvp103oXWdeDV+ebomM+f7v5MKl1DV
         wWJPsy2+aE65SnvpCE2cIT+nIfQdrX9xeX4PgUdLKxGOH3KU4ohhxeuZaLe2nQMP/ESf
         5beg==
X-Gm-Message-State: AJcUukfJiQgTmUr8PadeoH6A5KsPF1tsVe0HTvabYLmgvnzDbxg7YoQJ
        0qzqxfrvO4R0wlxfDZqFNrBsT0jtUwS4mO26rVHwnGSw
X-Google-Smtp-Source: ALg8bN7GxfDPDX63BuC+yOg3ZQDSJpATXtMW6YyuWXy+gIed1QkqKoTa7q8DRJRpea19JweBLfLPJerk3gck3853X5Y=
X-Received: by 2002:a24:648f:: with SMTP id t137mr2348492itc.176.1546656505278;
 Fri, 04 Jan 2019 18:48:25 -0800 (PST)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Fri, 4 Jan 2019 21:48:03 -0500
Message-ID: <CAFd4kYBX+HrLxbga=VJgC5WjyeDZEznm2UCL+HF8A1YKVo3Trw@mail.gmail.com>
Subject: How DELTA objects values work and are calculated
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm having trouble understanding how OBJ_REF_DELTA and OBJ_REF_DELTA
(deltas) work in git. Where does git calculate the sha1 hash values
when doing "git index-pack" in builtin/index-pack.c. I think my lack
of understanding of the code is compounded the fact that I do not
understand what the two object types are.

From tracing the code starting from index-pack, all non-delta object
type hashes are calculated in index-pack.c:1131 (parse_pack_objects).
However, when the function ends, the delta objects hash values are set
to all 0's.

My questions are:
A) How do Delta objects work?
B) Where and how are the sha1 values calculated?

I have read Documentation/technical/pack-format.txt, but am still not clear.

Thank you!
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
