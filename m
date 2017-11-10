Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A501F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 10:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbdKJK7M (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 05:59:12 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:52867 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbdKJK7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 05:59:11 -0500
Received: by mail-wr0-f194.google.com with SMTP id j23so8237371wra.9
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 02:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4VFVHjmkdlpp1b95dgIO51BdGyZ3/zsphlm+XZNT82o=;
        b=CO9eXqADb3yURW4swnCOz70uGroQAXn8TJkmn1Fs7TAlwzTQrVw9IFBQO5r8LHY/RD
         lq/cBDx36uZAnxhJa4N43xtd/itvPVrds6ugVjqCvLdI8yyC2/ic4mV7S8MmVgQVsv2n
         TTYwiRte5Gpwcp57KBsW/otStr54UXG8eUqq6DCoPFIku25lfMKYUiLRk6Qvgd/AFvvR
         2GikT5X1nXPa3gpRZZ5h/GAu8FrkZbQVOZCMXht565aVFQdbElXlQAfHK2jZEBy7Oz48
         YU5OGg8F7wBpQZPkGi/j+U0tkkC0AgFwkyW5llbnUqJg/oOQplS4/fya4jbhWaNmGMoJ
         ULAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4VFVHjmkdlpp1b95dgIO51BdGyZ3/zsphlm+XZNT82o=;
        b=fisFAN44U75JYYN7Tn9kU5OEpDZ1wa9dUUzsVUN7DQLV2iLMNH6PoEMljYuhvnDWVs
         upcenT3ncR55F82NJAvYMrBOd7hfIzrF7jh1sEAG6cv/Yl4UABPfSEquxVe6gRn9opA9
         vANf23cr8pTMMimhAcA+nOM1ok/sFa4fs600GgmoQSB0DajgPxVH5bKFUlrh8OXcm5kq
         Dt9BhCgkPxiSby3xhVBkE61jGgQLUMHGP4JESFeM9sT1En5IEwR0XvhqlWrrRbEesEXk
         zWBWY+LrqfoHXHI6jFRxnE6LpxCblW5xusNkL411GbMYmzAMCQwMCCTO1ao6F/xjbp82
         QVZg==
X-Gm-Message-State: AJaThX7eGGL84mSo7zZ6plaOjFmRxnywf5UHSfxtnS4cKjSwH434bE1m
        UV6MLGTOs832UJG9iT6UNdEk6YWXeAncyn0F1Aqa/A==
X-Google-Smtp-Source: ABhQp+Rpg5xNQIhE5G5Yw5lKA8+Def7PYngj0sfikbNhRfSnbjuSI/ICX0EUXkmw3yIWRuxQrjgH1p45b7lYS61obX8=
X-Received: by 10.223.165.4 with SMTP id i4mr3219716wrb.158.1510311549906;
 Fri, 10 Nov 2017 02:59:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.184.133 with HTTP; Fri, 10 Nov 2017 02:58:49 -0800 (PST)
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Fri, 10 Nov 2017 13:58:49 +0300
Message-ID: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
Subject: Unify annotated and non-annotated tags
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It is hard to work with Git tags, because on low level hash
of non-annotated tag is pointing to commit, but hash for
annotated tag is pointing to tag metadata.

On low level that means that there is no way to get commit
hash from tag in a single step. If tag is annotated, you need
to find and parse ^{} string of show-ref, if not, then look for
string without ^{}.

So, why not just make all tags work the same so that every
tag has its own hash and you need to dereference it in the
same way to get commit hash?

This way I could get all commit hashes with just:

    git show-ref --tags -d | grep "\^{}"

or abandon ^{} completely and show commit hashes on -d:

    git show-ref --tags --dereference

-- 
anatoly t.
