Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476CECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 11:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiIIL4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 07:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIIL4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 07:56:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD87135D7E
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 04:56:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r18so3378632eja.11
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=0j3uXpLzKuOSiPuNDl7WRvdT5DBYqIkKdP5V9Louqus=;
        b=HXaDtxmHi6rDYJTX1HjhkVUKz8iBY5TUvots3VHgt7zJVvfw65AX3CPcvbpKRCHUEW
         2puDTPLlWHWSJ6zSMbSnv8h5dBZmTII+qQjXFNca6ss9R33xvHvJoPDiDcE+klLiBcqN
         zgqdjrRKAjdX1ylJCwq6epfJ3AZ4dDqmcQ6AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0j3uXpLzKuOSiPuNDl7WRvdT5DBYqIkKdP5V9Louqus=;
        b=2bpzv7iNcojZGcb4w/tzLXjL2KeHNGRz1R6muwDk2TiKKmbN1kkozgusxOFSs0E1o0
         xwsto12cqLiHxsZ8TT5HkjrzyTEy4V6Z1n6TU+VsjfiCkfXXaa2iZGGtvjFxUXeT8+2K
         xVuwcnKESrisIUG8JickLvvVBr+q2Sb0fBcVUn48QpZZxVPFNkrVTaGIqTzjcLDiRFpX
         bzerNplUqeNR8Cv0Ub1jDrxTPlAEGi3Ykq0Q7muk3Le7+X/8etzMvjKdiSr0C8Xi0RZs
         e4nOrbcdZktrOlRodxYZPKwNp8/1N2rgwmusXhi5KT4rKdXvzpGPZLFVhvP6c3owCFTY
         6vIA==
X-Gm-Message-State: ACgBeo2Va1zw9qcJlembAu7fyF8lxeLy08pu2+BCg9KECzynAatiC9mq
        3dUY+QWqjBk4LI/BEDGRNei0f+tIwAEBS0JUvD/CZLw4b2o6W7Dh
X-Google-Smtp-Source: AA6agR5Hrymjfv5A/OghnmJPo8nlAsgfA/d4b6p4Jeab8s5QPpiCHXwnbhajcWCKIYQ6i6ipUerhfkTJM08Tn8EC9kg=
X-Received: by 2002:a17:907:2cd4:b0:73c:9fa8:3ddc with SMTP id
 hg20-20020a1709072cd400b0073c9fa83ddcmr9459179ejc.40.1662724597125; Fri, 09
 Sep 2022 04:56:37 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 9 Sep 2022 13:56:24 +0200
Message-ID: <CAPMMpogZd_em4_Fdk0sNFqAXqH19VOVyw3WsNT2LHsQNOb0_rw@mail.gmail.com>
Subject: git mergetool, merge.tool, merge.guitool and DISPLAY
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've just become aware today of what *seems* like a very strange
discrepancy or limitation in "git mergetool":

When you use it without having configured a "merge.tool", it
auto-selects the first available tool from a predefined list, which
appears to be hardcoded in "git-mergetool--lib.sh", with some
conditions around "$DISPLAY", "$GNOME_DESKTOP_SESSION_ID" and
"${VISUAL:-$EDITOR}".

In this "auto-selection" situation, no GUI-based merge tool will be
offered/selected if you're not in a GUI session.

When you configure your tools, you can configure "merge.tool" for the
default, and "merge.guitool" for GUI contexts - so far so good, sounds
consistent.

However, once you've configured these two settings, "git mergetool"
will never select the GUI tool you've configured unless you very
*explicitly* tell it to, by specifying the --gui argument. The
sensible auto-selection based on "DISPLAY" disappears.

The upshot, as I understand it, is that the only way to get a GUI when
I'm connected with an X session, and get a terminal-based mergetool
when I'm not, without having to be aware and issue different commands,
is to accept whatever tooling default order is hardcoded in
"git-mergetool--lib.sh"

Is this intentional / is there any logic here, or is this just
unfortunate, a result of the auto-selection evolving more
intelligently than the built-in explicit "--gui" selection, over
time??

If I wanted to improve this, what would be a more sensible approach?
* Assume "--gui" if there is a DISPLAY and "--no-gui" has not been
specified? (behavior change for some existing users)
* Add a new configuration to enable such an "auto-gui respecting
config" mode (no behavior change)

(I have not looked into "git difftool", but I assume the same
arguments and issues apply - if so an equivalent improvement would
need to be made there of course)

Thanks for any thoughts,
Tao
