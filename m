Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A9C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 06:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJCGjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJCGjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 02:39:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D5B29
        for <git@vger.kernel.org>; Sun,  2 Oct 2022 23:39:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z97so13176602ede.8
        for <git@vger.kernel.org>; Sun, 02 Oct 2022 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=xtKDH+Lt5P1CG0SBYVllDGw+zamrw0L6hqnsWVqpiRc=;
        b=htH8BcvUfWlkNwVaXwSplNyAFlMZ+FkMkWhwH2AJlD7GugQHjWxJZ83+COg7RR/K3S
         SogBIHGpU8E4KQKiqPSJZwrVWZLp2OrlTg923auvjkdGuKZNPPe0iPz20fnDDRL4vudZ
         AaC17jM0KD5X+GNh8A+SnaB89seMZg+B3oX7XCRMD9jrqsswZjaUU81zq9vlqvoSsxeZ
         tYlvX3ybKrzfZ0pKFqzSF5eb2RmkxTdNxcdIgrbuHF1uaKmnNfWY1K8pCsMEl3OHbFx0
         Q4Icxps9F4vlje/Pz4cX9jtP9dCz0dFLLPHCTBATQ8xagxJIMvOkUkUoWZLy3ANoMS+w
         qaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xtKDH+Lt5P1CG0SBYVllDGw+zamrw0L6hqnsWVqpiRc=;
        b=7sFtp8DtoRYlJFXnct5GcJ7pSu1vRKCjx65rxlQq6V9kwuXZM2HKv9xLRWbxMm9b2k
         tmtPAirfE4KbcVlBzSImcR0Aonver/cLg3aO5OCehGQ1pYN9GbQGlJWhFbOTyAUgp2oa
         +DqsnIXsv+I8BY+5WlFS5VP+LgBQnZuhV+vmGjzNZvTTjOZHM1FJy4cFZYU+k/erVCFk
         1uGTBy452t2Q4+m07WoazHxRav6vDOXzxGwZgjxssIeMtus4S4s7qFIyH88BEQdo+4Z9
         MhvBMecoXtcGZUNfRNAryfHmgb9v5nkOs6T4HnUembZW4watYQx0OUNnmMd5OeMxm3SG
         Tp8A==
X-Gm-Message-State: ACrzQf1Vtrhkmc09ueM0nxnq+vuxjK+s3VBfyAWMvW/X1rNlFaZLVUFH
        l19jqgKX9UN5gqH5AQ2ufRfd7D/i3Nj/JOxvzoJMj2rwoIk=
X-Google-Smtp-Source: AMsMyM6zo096OUtzPbpVU1cdNnoBErXBYpkItlYfwstZVehROHPnreyZm1mxpPwl39Tt8qfpmc2fY2GFNTQHUVpCAe0=
X-Received: by 2002:a05:6402:4446:b0:457:eebd:fe52 with SMTP id
 o6-20020a056402444600b00457eebdfe52mr17350127edb.234.1664779173096; Sun, 02
 Oct 2022 23:39:33 -0700 (PDT)
MIME-Version: 1.0
From:   "Michael V. Scovetta" <michael.scovetta@gmail.com>
Date:   Sun, 2 Oct 2022 23:39:16 -0700
Message-ID: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
Subject: Bug Report: Duplicate condition in read_author_script (sequencer.c)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!
I noticed a duplicate condition in the read_author_script function
defined in sequencer.c. I reported this initially to the security
mailing list, but folks there thought it was unlikely to be
interesting from a security perspective, and advised me to report it
here.

In commit 2a7d63a2, sequencer.c:912 looks like:
912  if (name_i == -2)
913      error(_("missing 'GIT_AUTHOR_NAME'"));
914  if (email_i == -2)
915      error(_("missing 'GIT_AUTHOR_EMAIL'"));
916  if (date_i == -2)
917      error(_("missing 'GIT_AUTHOR_DATE'"));
918  if (date_i < 0 || email_i < 0 || date_i < 0 || err)    <-- date_i
is referenced here twice
919      goto finish;

I'm fairly sure that line 918 should be:
918  if (name_i < 0 || email_i < 0 || date_i < 0 || err)

I haven't validated this, but I suspect that if
`rebase-merge/author-script` contained two GIT_AUTHOR_NAME fields,
then name_i would be set to -1 (by the error function), but control
wouldn't flow to finish, but instead to line 920 ( *name =
kv.items[name_i].util; ) where it would attempt to access memory
slightly outside of items' memory space.

I haven't been able to actually trigger the bug, but strongly suspect
I'm just not familiar enough with how rebasing works under the covers.

I can dig into this deeper if you'd like, but it looks like an obvious
typo or copy/paste error. Is this something that a maintainer would be
able to take from here?

Thanks so much!!

Mike
