Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C885C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 05:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMFvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJMFvu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 01:51:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F0402DE
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:51:49 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id p127so53638oih.9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=singh-im.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jOs1GaVAyD34KCHnDTL313v3mvHaFs7mpMh5+ULQ8Z8=;
        b=H5fo8dfo6m/LPjbW4NuEVhv7HxvJT7tLoqv0zjY9gy3hLLDJiYHkFC8w1Ipy4qu6Cd
         i7F78H0bW7FFPKBrKnZPsJQAd+QvZyXKBOcXBtA2xIOjad47iV13rF69C8QpBUzlplVK
         P4cmqxD5h46717gpW9RXtfdVWe9UspRFJa66+XFNG25qeN2do+LHrrnFJMS8wESMhwK3
         bgNXfWIV6BnBkRXvR/GkSFYKUlAlMN53QbjlU8Yk75zjHbG79T2yFLZHcdFERUlyR9AV
         Fg6EdxlTYuLdK++6nXnEzeP6iGJVS/HB1pJHXeo242tOA15w2Rux4QYf5QdsRKNaXNdT
         lg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOs1GaVAyD34KCHnDTL313v3mvHaFs7mpMh5+ULQ8Z8=;
        b=hCvBYuLcKHIFoeE+8PXZHAp2RQgFLimDmEdaGFEU/kAZldRP5XAba+Xk9wQPfNLblQ
         NsBkyYaeCFgYywlOuVp2zy7VsHBn6Ftnp64jYPWSNVrnmz7ynP5Xm8EnaekncOVpPVAE
         ac/4m5b5HVTYs0nZkVm1TdK5g/yh80VgW0aYKWSlMT5mmEcEFZPZhvvqGzcHyceTKLPN
         unyB4EK9HpLmU/dRnqc7THJXxIHrrddw3TftmvUpFPp12bOgFPDYnVUH9DA7BTQaz553
         qV1pVoDqKjT+EN6dmjyYpRzGS1hflCieOv5Z1qQ2aQDU0REMAqPMUyHEp9B+XMR6PGMM
         3Nsg==
X-Gm-Message-State: ACrzQf2pJlO8d+2oJc/ka1fSh8u7RjD5R2dVAX7JeE6NxvgSRyZVa4On
        3Ne5C5B8YgD/0CMS+il2M9lu1oE1XqKQ2d7oRnK9Oi9FUj8=
X-Google-Smtp-Source: AMsMyM5IX9qkhJRjf2MCr0AhY4wt35XPeispUctAgDsYJYPjKVr+mp/MwvcaeLLrTeSjvLvzwO6bVMME+gNLx+ZtSIs=
X-Received: by 2002:a05:6808:16a9:b0:353:ebec:603d with SMTP id
 bb41-20020a05680816a900b00353ebec603dmr3836455oib.75.1665640308195; Wed, 12
 Oct 2022 22:51:48 -0700 (PDT)
MIME-Version: 1.0
From:   Gurjeet Singh <gurjeet@singh.im>
Date:   Wed, 12 Oct 2022 22:51:31 -0700
Message-ID: <CABwTF4U-KXHF7=8RWY7Ecbspz205Msa3syZFiWYDg3XmZsNGVw@mail.gmail.com>
Subject: Git diff misattributes the first word of a line to the previous line
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git diff seems to get confused about word boundaries, and includes the
first word from the next line.

In the output below, you'd be forgiven to assume that the word 'ab'
was removed from first line, and was replaced with the word 'opt1'.
But as you can see in the contents of file '1.txt', that word was on
the _second_ line.

It seems that the first word of a line gets attributed to the previous
line, ignoring the fact that there's an intervening newline before the
word.

This confusion is exhibited by the --color-words option, too, where I
discovered it first. But when trying to create a reproducible test
case, I discovered that this may be a problem with the word-boundary
identification, and the --word-diff=plain is a better way to
demonstrate the bug.

I have also eliminated the possibility that this may be due to some
misconfiguration in my GIt config files, by setting some environment
variables, as seen in the last command.

$ git diff --word-diff=plain /tmp/1.txt /tmp/2.txt
diff --git a/tmp/1.txt b/tmp/2.txt
index 8239f93..099fb80 100644
--- a/tmp/1.txt
+++ b/tmp/2.txt
@@ -1,2 +1,2 @@
    x = yz [-ab-]{+opt1+}
{+    ac+} = [-cd ef-]{+pq opt2+}

$ cat /tmp/1.txt
    x = yz
    ab = cd ef

$ cat /tmp/2.txt
    x = yz opt1
    ac = pq opt2

# Git installed on macOS, via Nixpkgs
$ git --version
git version 2.35.1

# Also tested on Git installed via Homebrew
$ /usr/local/bin/git --version
git version 2.38.0

# Try to run with a clean environment.
$ export GIT_CONFIG_GLOBAL=/dev/null
$ export GIT_CONFIG_SYSTEM=/dev/null
$ export GIT_CONFIG_NOSYSTEM=yes
$ git diff --word-diff=plain /tmp/1.txt /tmp/2.txt # Same buggy output

# **** Expected **** output
$ git diff --word-diff=plain /tmp/1.txt /tmp/2.txt
diff --git a/tmp/1.txt b/tmp/2.txt
index 8239f93..099fb80 100644
--- a/tmp/1.txt
+++ b/tmp/2.txt
@@ -1,2 +1,2 @@
    x = yz {+opt1+}
    [-ab-]{+ac+} = [-cd ef-]{+pq opt2+}

Best regards,
Gurjeet
http://Gurje.et
