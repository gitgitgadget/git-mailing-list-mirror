Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD160C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGXDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBGXDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:03:51 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5B3A5B5
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:03:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bi36so24566179lfb.8
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8uDKFpgcXEabjPJQVypLGQEgpAuzTrrlwx+pM877AJQ=;
        b=Nz2Jwq+nanvF6fterndN2jqU85mXT2mwVPb/34fezo+DI1L4Tq8EyhNElWuXiwIa6T
         jfJImimelZQRbS3PBq/aubarDwYxIt0znZiWh1MghjX9TkLjwiSJ+iida2JooEOK3sT0
         tlmxSzFvtgniECjiv28FDOphk4nweUIBQ/H7RVK0/E0ZE+0fZ3XsBJ3i1G/MHpBfxJCp
         YKeIN0VC58wKKK+1diYG/uM6TLwEB8aaWuPDq6EZT+GXk9KnQkj80lGvEEqiy4ZmQaBY
         sD/KO3PsFX0+Q0HFYtaDrG9geAcPNPsEx5JK7kxzcCfKPMV4Uj9OckFHATRYSkqfw2sW
         3A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uDKFpgcXEabjPJQVypLGQEgpAuzTrrlwx+pM877AJQ=;
        b=Xvi7Fs8jl8hT3M05K5si8VzClGtpO7dbZN8epd5wdpGt/tVgZ3xlvHqaN6AGN06mNl
         UtMEghnTt+U7GS6CWAQBn4qT72Boxt6nUsH+ANKcaGJ9qQWZ24bsqpEHMn/K2CAleYav
         bznKgUqkofWO4yHel0rGH+N6j9Uqax3n4xzHAPF8KEBnrxptwFYbsG4eTWmQsLuuCIZ9
         gtG2zYQ8T3ZP+9KFQz85pgFf/OtJ/kdySU0hfz+je2q6J3IPmGpcp+M8B/mHF+h9OB3s
         qFwOvw9T63khaQE9WS5KvYVMzy8RYlNfBayYtSW+deDhn6CgisYRiyrr9BLn4GBo1S7F
         0rBw==
X-Gm-Message-State: AO0yUKWmEMsRsvxIrGM6hEV1Iy2qCXU6CTJzx3a89V9dXuyUomAPZeiZ
        ix1VStlZcg2WvqSUHEkPvBYZhJqpx6SQj0N1cWYlCUdkcaA=
X-Google-Smtp-Source: AK7set+KB2SrTYAoUlmgM5WjaJYxfwt/uqGFsnYP9K6rhhNDIUaOtKSr1LYvLeWd2tklICHVlHyPFZvsrFifww07DVc=
X-Received: by 2002:ac2:4a99:0:b0:4a2:4b43:9aad with SMTP id
 l25-20020ac24a99000000b004a24b439aadmr721110lfp.213.1675811027333; Tue, 07
 Feb 2023 15:03:47 -0800 (PST)
MIME-Version: 1.0
From:   William Blevins <wblevins001@gmail.com>
Date:   Tue, 7 Feb 2023 18:03:37 -0500
Message-ID: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
Subject: Unexpected (bug-like) behavior in `git ls-remote` matching.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setup as follows.

example repo: git@github.com:owner/repo.git
example branches:
* ABC-1
* feature/ABC-1
* XBC-1
* EABC-1

These are all things that work as "expected".
```
$ git ls-remote --heads git@github.com:owner/repo.git ABC-
$ git ls-remote --heads git@github.com:owner/repo.git BC-1
$ git ls-remote --heads git@github.com:owner/repo.git XBC-1
<ref>    refs/head/XBC-1
$ git ls-remote --heads git@github.com:owner/repo.git *BC-1
<ref>    refs/head/ABC-1
<ref>    refs/head/EABC-1
<ref>    refs/head/XBC-1
<ref>    refs/head/feature/ABC-1
$ git ls-remote --heads git@github.com:owner/repo.git "[^/]ABC-1"
<ref>    refs/head/EABC-1
```

What is totally unexpected.... is the most simple search for ABC-1...
```
$ git ls-remote --heads git@github.com:owner/repo.git ABC-1
<ref>    refs/head/ABC-1
<ref>    refs/head/feature/ABC-1
```

It appears that the matching behavior trims at the last slash... which
isn't correct.

V/R,
William
