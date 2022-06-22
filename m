Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7192C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiFVNxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357533AbiFVNxj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 09:53:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156032074
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 06:53:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s37so16169091pfg.11
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=spUXTnRQHD2FWQSE2sB+txz5fw8Er6/5lfuITSayQDY=;
        b=AqetBVrDklWG9/PLIxFU8+XpPHtXpBJo9V9u/MoCWAIv6BGK3/t0FM+qlDLx4U+6uZ
         /t9AhfBuSY7LaFOdghf3iwTp5A40+MqNWyA3cVktcIrQKnRKZjbYI8W9o0M3pAdatLuc
         eZ8P2qIab+Kxab4DBR5/+Gm80V3wFHZ0/tMAN0slFD2MxdzwDcrmwkyzk3jZ+OGCZhoo
         nnNHBBqSuXmujFkp8XhOoYTIG8aTosNikEiiBFno/vpfZdQ/MZdBzpU7grjTu2W+SZuT
         T4jyel6BSEhBf5mcmwWV4TB46vQDOhfsChmi+apnGbqRPQOVjkUF5ytLZzZviM5oU7et
         idGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=spUXTnRQHD2FWQSE2sB+txz5fw8Er6/5lfuITSayQDY=;
        b=t3x0zllya2kbp/whEY1RWHLb7PdCIk1p+ictu+/o6FSvBrZXjcQbJoYm+1f2TmSEZ2
         JRQNgpkBGBZZzhIkPhTQuEZIvEnNt4f7CK1HZ5r+fdbtj9DF4pCaq9fW9EIU0GHyeJdz
         DEumubLyemQrVlktT83YJUfYURN/Ptm8EFiViD3Wk78FcmCcWrd3PKXopcdyfC3sSpSX
         3YEa8QjxafRa3fS7DC8mA0OYTgg3MkeTvgHGkeo7QYoWzBRX/AUxw5yF8T6lU95zhKq/
         InKpsT67UzrSZ+uVI6R5PK70u8TTbpVYIyIbsz4SFacsgrCIz3UdcZoiRtdPxxmpqpFO
         ZS8w==
X-Gm-Message-State: AJIora+StqHowcW/sXjRCVzPjdnNjNPB6DDPw8D4W0OYfbmq/LMwsIH7
        29ZcXjc1yQLrUaabXGXFHVi8B8AwtiSOtbgHoU0MeEZjlf0=
X-Google-Smtp-Source: AGRyM1vTS/bvKOYcd8HTNMEzqS5P388ahGNXO3kBzXVN+9L0qPtfVJgFSJrPIBePc21wmXyA6yg7kX92Bag3oqctvio=
X-Received: by 2002:a05:6a00:1948:b0:525:45e3:2eb7 with SMTP id
 s8-20020a056a00194800b0052545e32eb7mr3318021pfk.77.1655906018342; Wed, 22 Jun
 2022 06:53:38 -0700 (PDT)
MIME-Version: 1.0
From:   void f <fv729164860@gmail.com>
Date:   Wed, 22 Jun 2022 21:53:26 +0800
Message-ID: <CADRR3BF7rY0Z3UTJf223+ALns06Re+vxeNuhx9sKNFxu73=EWw@mail.gmail.com>
Subject: Bug report. Out of memory about git checkout.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How to repeat:

env:

git version: 2.36.1
os : center os
memory 8G

When you execute "git checkout .=E2=80=9D to chekout a very large lfs-file,
Which is larger than your memory. It would throw =E2=80=9COut of memory,
realloc failed=E2=80=9D exception.


reason of the bug:


When you execute git checkout, Which have to checkout a lfs-file to
the worktree. Git would execute "convert.c apply_multi_file_filter()"
to convert lfs pointer from git-object to the lfs file. It will
execute a subprocess to convert this file. But It is strange that git
would read all of the file into memory When finish the git-lfs
subprocess. (The code is about pkt-line.c
read_packetized_to_strbut()). Lfs usually is a very large file even
more than the memory. So it would throw out of memory exception.

With this bug, it would have trouble to use sparse-chekout in a
repository with large lfs-file. Because you must init the repository
first and set the sparse-chekout config, than use git
pull/merge/checkout to checkout your subset worktree. It would out of
memory when you checkout it.

I think git don=E2=80=99t need to read all of the file in memory. It can us=
e a
stream to finish the checkout.
