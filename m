Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278711F404
	for <e@80x24.org>; Mon, 26 Mar 2018 04:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750787AbeCZElg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 00:41:36 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35072 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCZElf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 00:41:35 -0400
Received: by mail-ua0-f181.google.com with SMTP id c40so11261374uae.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 21:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IvuU3hqW9tG8ghpcQQk7o5XBTgO8zLhjggKlKVlxj/I=;
        b=pvhxYAGBOwhLk/GvRklBtq3CdHm3zkXLNhz3t8M5FAXlX1m1QlvH1sTr3MRzMBLq45
         jBc2Sf9uuXQwYsxw9/2Ce1At/eF5APL20Tv0fytWjEWGMilm1iA/9GtFW8inlvMyoc5w
         G+Frj4pJHx4prhKd1Z6tDtNYzqW3WnztmDIXq+G58o1KX2nppzsVVpOlSh76KMtRiPEQ
         4dBWnbm1VybBQ9VlkD1VnUPB2CHmkM0llzLNQX2ELX+hpdlRcJjMpsq0krT25iI7fi6z
         tIGycg73cKpXRo/39GyjlblgoKKP1baxzc411MWSuHdRu+YKLYsp//SW+3+Rg5kHzwiB
         mUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IvuU3hqW9tG8ghpcQQk7o5XBTgO8zLhjggKlKVlxj/I=;
        b=DLj1EnNaRVKQX3fvF1ocUrTZdvd3EZebBiNLxiyjMXGcsTWhO+/9ckyc10BpLEvc/U
         qSNz31xVXIC3NSdLA7N7OSxztz6ZIW5MXZzVJHhRrDDwJZR/rmTumDrhlFb9xLvZiRo1
         E73/FHUIj3/oW8l1zuqQ2h8xfxF/5opY279Q+BGhOY+Pj6Z1Jh6h4WVAM+mUfr+Xprie
         Hp8hGhEyAMfnLzh1MFQtD4L1e2GN2U4z+/6yMf3qt1nbPYNqecapE8MJTpNAcOtBwdE7
         DFxmU0k9jxJjF+XH0NbWTD+sq7uySPLq2LmbQqjrgdUV95dBn4/yEIP14hntnBbIjGtf
         0eGw==
X-Gm-Message-State: AElRT7FuNIJcnuKWcDC0NG5z4xJdRLojmJQWpapwfKYJ6h1F2uknp9gg
        uNQLF3pg2io4KVV8mqs+JX3GNrIm863i15+AB61yH9cb
X-Google-Smtp-Source: AG47ELsi/JgTdCwCvkyziyvmJqHaaCw0bnsu/jGylc7i0A8Z2mAYyBbS7GZq5pBqP5MvUCkDJi56stL4TqgMFkHBQMo=
X-Received: by 10.159.61.203 with SMTP id e11mr17958677uaj.115.1522039294345;
 Sun, 25 Mar 2018 21:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.72.228 with HTTP; Sun, 25 Mar 2018 21:41:34 -0700 (PDT)
From:   Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Date:   Mon, 26 Mar 2018 13:41:34 +0900
Message-ID: <CANqewP332-+esYWDPBtPif==wnb4PiNd89R1qTZsuWZAFSV0ew@mail.gmail.com>
Subject: core.fsmonitor always perform rescans
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm facing issue with core.fsmonitor.

I'm currently using the provided watchman hook, but it doesn't seem to
record the fact that it has queried the fsmonitor backend, and as a
result the timestamp passed to the hook doesn't seem to change.

As it always pass a timestamp before watchman has crawled the
directories, watchman will always return all files inside the
directory. This happens everytime I run a git command, resulting in
slowness.

Is the timestamp not being updated an intended behavior, or is this a bug?

Tatsuyuki Ishi
