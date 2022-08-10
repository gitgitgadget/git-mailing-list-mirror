Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8949C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiHJVeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiHJVeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:34:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286546AA23
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:34:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o2so15682648lfb.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=uvqlOslqNoEcFaCVMtaKaGqdYcBNH1vhmCha1QOdpJc=;
        b=juu8dWse7R1Xir7QU1bccVbtISPraZJiapmNaIE07ua56hjEwoTAvrSnIUll3RpoWe
         VIBIpztrTQXvJXDyneFuIJYBD2rTpegiyMRuZhPXsfEu5dYLHn22nuRCNdWFMm4tpXJ/
         Lb53lQQOWBL3mcSZa5x/22hq/aZGdSNb1bKelSzt3l/7KJ8P+P0Jumk6lY+Ptrfj+8OC
         SoEqHqz+oQqYP/3Et2pXBuMppYc0p54aahw56NbxuA/e9RkDXfciP3mj7U4UY+bu+8r+
         fHSPsc20B90DX3y04FDcQROdN6o5ZON4IQUKEEIivvrvmwfis+bzF/0nzq9rle7stmby
         PBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=uvqlOslqNoEcFaCVMtaKaGqdYcBNH1vhmCha1QOdpJc=;
        b=djbUccdHgVQswaOksu2N7tWnxxf2w2uIcLrtvSKhNrlEWAAb2sfTWgy83HPg/VGIIg
         U5EY61rZVF05tzf3XUfbBrIsNJN6vd1ycVIggpShejTrtr+jNTQBD49XNWjhqA+IpXEj
         tEQp0vYChO/C6I5HP2s3PaCzmuZvGFufkviuHjSQbwm8Il+IWK6mzQgDIeuzcbxou3O8
         Qz0Yf49vCSCegxZTt6Rxpu6ChdtiHbHR6ul7RY78SoE1YSqT+RTw1nGKxdW2XLYhNWNg
         ypLmPu51ZuYJykCk9J5MbbBebxmolvbCkFfgO9KST7EuDd/GpbnF4u1yp2LEGGE/C71o
         w70A==
X-Gm-Message-State: ACgBeo1xmrIS2cXR/Xfe6KNs8C/LDh/w8803pUTk+4yTDs+xHLiO8gE1
        FxnNBvVlq3QYQltFG8tDcgFaGsNcS7O1l/UM5oXMtdCbAnDP
X-Google-Smtp-Source: AA6agR7HWUXRNMlUOctjeu0w10TLFW4r/+gK7uwyXF+Ro5mAY9DoXhMFxA2qZdBXS5Dr2YUDYJDRAseLNFZIGnZUz4M=
X-Received: by 2002:ac2:435a:0:b0:48a:73bf:7371 with SMTP id
 o26-20020ac2435a000000b0048a73bf7371mr9714988lfl.96.1660167245160; Wed, 10
 Aug 2022 14:34:05 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Olsen <andrew.olsen@koordinates.com>
Date:   Thu, 11 Aug 2022 09:33:54 +1200
Message-ID: <CAPJmHpVssKshapGYDF-ifU1fts-jFTC-HqxnjN8meSMP3weB4g@mail.gmail.com>
Subject: [BUG] git rev-list --missing=allow-promisor
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce:
1. Create a git repository with missing+promised blobs.
For example, I did this:
git clone git@github.com:git/git.git git-no-blobs --filter=blob:none
--depth=1 --bare

--filter=blob:none - don't fetch any blobs
--depth=1 - we don't need git's entire history, just one commit is fine
--bare - this avoids git fetching any blobs as part of the checkout operation

2. In this repository, run:
git rev-list HEAD --objects --missing=allow-promisor

Expected outcome:
git rev-list prints the paths and OIDs of all the objects

Actual outcome:
Any of the following:
a) git rev-list prints the paths and OIDs of all the objects
b) git rev-list fails with "fatal: malformed mode in tree entry"
c) git rev-list fails with "fatal: too-short tree object"

Diagnosis:
With missing=allow-promisor, when git encounters a missing object, it
calls is_promisor on it, which in turn calls add_promisor_object on
lots of things.
In this line in add_promisor_object, the buffer of the tree that we
are currently traversing is freed:
https://github.com/git/git/blob/master/packfile.c#L2242
This clearly causes problems but not in a deterministic way.
