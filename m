Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiF1KvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiF1KvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:51:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0124F26
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:51:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so11859748pju.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9FGhMs3vVUoCCMzGhbYaHLCZWfi7HW8l6SJ2I16yQzk=;
        b=FAfhCegrlyup46E+XGaFeqx0FhcVgYzoxiFpWzc5xveep2uGix0R1Px9KjT+k3qCdK
         mdMLM49gmTaBKgSoM5g8S1wLzLIjVHYPyfzTpTUU6LmJyAnL/SWgUzUB2O0+eOILy2Pw
         PBgX4udCT8gEds0SFIRMvcCPnzdfpdTe63AmH6Kk2XZA9cEsNRmx1OdriZZCgwQ00yob
         qXvNCnrUU8dqyA2RbUZPddyp8uiegE+LOm8xcycJmTvqA30jWdVblKODSlxikQSJPpFK
         9dMdB/wcFDq6HHfMIhUQA8EfA8GLL42RHG0xTxmRbAY62K/zqX/NRwHSToZE+zvf55uy
         0OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9FGhMs3vVUoCCMzGhbYaHLCZWfi7HW8l6SJ2I16yQzk=;
        b=nF4NJWDgCWfhsheLUCxvU6blRc/UtadpeYZrW5307DnRS7Cgn7qxwLYB/JIqK0vQpp
         aK9Bg/+g3PZqrtotK/LIjB2rScEMDIOy4A4moQIeZMHFHjJVZAyyrCPdYzC8aOpHWykn
         nO82gDBCogqFeFNKZ0xUcXzgh7eh7V46lgr7pBeNmC485arCN+SylsSNKc6ZEThRwn4E
         IRhUUPUiyLEJdDvitUYprH9fTVITfsvViA4nGecehN1dAB0HzdmbLUevzhF2cWQJzfQx
         i0q4E4iPOIdOpFlbdlRp3HWJhRYUihE0kg42MP22KewNobr1SKx49DBOL0OO25I+TMFP
         o3Bw==
X-Gm-Message-State: AJIora+GV7dXwxODuB0YcdpyI2g6XEX1xIbZVRTEXpJMhQ9FS+lqWOkA
        F2XUFC+sOYu2oSpPMgLaKwqJPxwb3VyrXib3MFKbh1IFrZdH9Q==
X-Google-Smtp-Source: AGRyM1uqcQPNp83UhIdtzqNHcuET8HKLqxkvjxxcvQqR3VP3OoVYnVaNVw+4iVAwWKuohzM7veqJratTyrAE/cupiSs=
X-Received: by 2002:a17:903:32ce:b0:16a:607b:31df with SMTP id
 i14-20020a17090332ce00b0016a607b31dfmr4497707plr.117.1656413461170; Tue, 28
 Jun 2022 03:51:01 -0700 (PDT)
MIME-Version: 1.0
From:   Pavel Rappo <pavel.rappo@gmail.com>
Date:   Tue, 28 Jun 2022 11:50:49 +0100
Message-ID: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
Subject: How to reduce pickaxe times for a particular repo?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a repo of the following characteristics:

  * 1 branch
  * 100,000 commits
  * 1TB in size
  * The tip of the branch has 55,000 files
  * No new commits are expected: the repo is abandoned and kept for
archaeological purposes.

Typically, a `git log -S/-G` lookup takes around a minute to complete.
I would like to significantly reduce that time. How can I do that? I
can spend up to 10x more disk space, if required. The machine has 10
cores and 32GB of RAM.

Thanks,
-Pavel
