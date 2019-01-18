Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916EE1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfARHYp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:24:45 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:52772 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfARHYp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:24:45 -0500
Received: by mail-it1-f179.google.com with SMTP id g76so5466427itg.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZRhxmmAuEi++v1M0VJC4t+nIbAXXGaDVfCD3oc++/is=;
        b=XOeHpioFKBaEX9M5nbCPWNWE3n1xdJ4aX01f/J19uazd9f2bI5YKBjuvOfvmkqnR3A
         DCb6V7NcB+Ki4ZWz5umZ8exYzDN7VFJb798LQ2xqMQyxOUAVS+lj2OiCDpPIJYgD5bKY
         aS4ms6jBHSrh+tkXOwBDsd85qT8aRuQL3RqEl3HYHARxwo3RODyVlHhhdmAvQzvGywaE
         g7r92U8rfi1ItrxDHjXtZh3WM9KRKh4pRXKX4sBUm9g0hel5B90RYTC58mnuKM5NxSoj
         CHhJ+ruoMND/vAnYgRZ3FTFUEFlsHPj4zGxSvSFpmVwzVWLhHnFJBkJiuDs3bUdA+MMo
         zC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZRhxmmAuEi++v1M0VJC4t+nIbAXXGaDVfCD3oc++/is=;
        b=Lcg0Bx1gNaWSiHQdD73Zk4pvceE7ZD9c4z9BnwrtxkE3/iDkWrCz03ozs3Lp6qwWb+
         2aH68BPV/76FtT4UUspzvhYRyhnf8Fm+2FY3m5SacSmfjJtD/VPT65rMAHiAMTX1PaJI
         2LTNZxuX1QsdXAxoIBwqJI6/ByPHej6Xjvrslrs4u0tFSk1VNvczTKyd6OlkDr3PS6dF
         /qaaHmXY1MitOtJtIFz88W4h4wKiG7sWe2MKgskpo1eyS7+crFVjAOuVetJwwXF9gE4z
         rzqpiXf7JWdChEtLZl2uF0LFy3LqcjxawQH/s0zeqqofiDcR8DTvjMl+xrf2LdCQ/QS5
         rpRg==
X-Gm-Message-State: AJcUukcQ2FQFJbeUNV0aIQkRiENgERUxC+4SBbUfMMVDeL+b8e9aymrk
        P2SWyt9Zt1sOmzZ7qB6Hj7UyTiuqvAqhUPRzavn/zpWs
X-Google-Smtp-Source: ALg8bN72NwdsjuC1lTOoswrv6McP0FuoKvD1YJXOO7WvNNGbr01iHZLKD6pJKV/nw4h1sl0df0bIudgM30WwRDPX3Y4=
X-Received: by 2002:a24:648f:: with SMTP id t137mr9651242itc.176.1547796284009;
 Thu, 17 Jan 2019 23:24:44 -0800 (PST)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Fri, 18 Jan 2019 02:24:32 -0500
Message-ID: <CAFd4kYAbrUcV2U1u6Fz3VgZDN_YcpLrSymeA5bvvLy1LY98aHA@mail.gmail.com>
Subject: Calculate packfile and idxfile checksums
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am trying to understand how git's index-pack works, particularly how
it calculates the packfile checksum and idxfile checksum. I traced
back the packfile checksum in the source to the value char *sha1 that
is utilized in write_idx_file() in pack_file.c:45. However, I cannot
determine where this value is set.

My printf() debugging has it set at pack-write.c:171 (right before the
hashwrite call) but it does not seem to be utilized prior to that
point. Please assist.

Thanks!
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
