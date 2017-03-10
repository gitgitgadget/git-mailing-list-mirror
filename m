Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C054202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 10:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935379AbdCJKnq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 05:43:46 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33184 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935162AbdCJKnm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 05:43:42 -0500
Received: by mail-io0-f171.google.com with SMTP id f84so44830995ioj.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9zVqKafpiHb9bq3gOXSx2Cy8Ndyk/SprVi2Pd9zGUzk=;
        b=AnPFkiaK3uaOUFIM0pkV5t+Fl5I1rojrxy8ZVGNVbnfZbCX9NPWFrYlaoyppSpvoMk
         qhTpNB2xj1bslFtE5ChnSE1dRHgV3eHgEhbulcq81MFXjLQMaYTPTKvpTeSFZIAKVdK9
         njhFS777R7IDXZDZlDVHFk9icFLHnJzxWDsOdZfMHrRPTw6zYTbhpKXxb9l12Bgv4Yu2
         UU3SsSMdWqI0eNbxOFFRo7y4IgcjKyp0qRAjuGBCZI+y7OWnD5EQmaVMzGR096mGoxq2
         vVzKWsS1gWy+NBQxVdtnrQJByynp28TOsAlAmFrbdWodpfVAfs4NXaBIJsjPbJ9+q1zr
         8Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9zVqKafpiHb9bq3gOXSx2Cy8Ndyk/SprVi2Pd9zGUzk=;
        b=mdhxVzBlDJNSfQBVKKQrR6EX8h8qCiy3oIPEzK2UzzkrJPOKhdl/mSCtbFlupYR1Uk
         FPCGhlNdJnsAy3a3wrA8y07yVEs0d5J4n9gn0b6Ux3pcWJwa0fSnxx+eQI1eKBOTG5Lk
         TX5a3UKVxpAwljf1idvcWM/V/Q8twyiwp/sSK/KfJ2Wrf2gFZSKTyr/8bqamJBtbBlNt
         N1hAXV9oA4caSw4eeH8od2CApLhXb4eoYL3llpbHgLWvXtwIhHGdfAxXpRjZ/LOpc3Mx
         tItFE8Spc4z0WbM6DQEGROQ28ZXS8cyVIOIeZou3HjElPZ2gxVpKm1HI96f8Llt8Utjf
         ouaw==
X-Gm-Message-State: AMke39muiO+zvm0/ra/WrmfU4kBx7JtTSvKlM4RCxyoGRj+yDV+nXM17zrYMH6At2IpyKFl3eYmQhXcpipJoaQ==
X-Received: by 10.107.57.2 with SMTP id g2mr17399007ioa.117.1489142616060;
 Fri, 10 Mar 2017 02:43:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 10 Mar 2017 02:43:15 -0800 (PST)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 10 Mar 2017 11:43:15 +0100
Message-ID: <CACBZZX7OSH_dSJ+kswbv2g1Hv6JieDxHHRmqazppgih0d1+hVg@mail.gmail.com>
Subject: BUG: "git branch --contains <commit> <name>" does nothing, silently fails
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ran into this when preparing my --no-contains series, this is a long
standing bug:

    $ ./git branch -D test; ./git branch --contains v2.8.0 test; echo
$?; git rev-parse test
    error: branch 'test' not found.
    0
    test
    fatal: ambiguous argument 'test': unknown revision or path not in
the working tree.

I.e. this should return an error like "git tag" does:

    $ ./git tag -d test; ./git tag --contains v2.8.0 test; echo $?;
git rev-parse test
    error: tag 'test' not found.
    fatal: --contains option is only allowed with -l.
    128
    test
    fatal: ambiguous argument 'test': unknown revision or path not in
the working tree.

I briefly looked through builtin/branch.c, couldn't find a trivial way
to patch it, unfamiliar with the code, didn't want to forget about it,
hence this E-Mail.
