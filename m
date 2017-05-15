Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91153201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbdEOSIl (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:08:41 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33870 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbdEOSIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:08:40 -0400
Received: by mail-oi0-f47.google.com with SMTP id b204so140766271oii.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Q4Kb6T9S65EZK3AsJ8ZxhdSOBoSGB1bAfpzNqgxjS9U=;
        b=Wo5AcqOhHqDULBUiJxMV+l+2LmWPxJT1kCeQXLCsBdP916EhnQsemHaGPx098703EE
         TbgkO3gvykwn27pH5IHnIC7dJwVsjv8AXu7NF0RBICkgMVq94I267zulIH4wI6xyfc70
         crdS4vkZfnYkqjGYwnIndUuknjV924CeYJM0DK9ldYMexE0E620T6Og4OjiFvxG12CQ9
         76OmD7fDUTZUvJlF9kfq9KWp7/awDf6YWdE6nAUXDddqfcExwA0K5gYJVKZlPlp2IYKy
         Roam9WhSAY8BcssfXG8t1kg1FZuNFGEHuIu1/zIUoSq/1BRqL9OUr/H15wZUeZfJTq/a
         sEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q4Kb6T9S65EZK3AsJ8ZxhdSOBoSGB1bAfpzNqgxjS9U=;
        b=N+pA8qh++rAIA8+WUlHiMEfxWzzqPz0bZZ4gxam4Fhkuhl61yehcT0IB2Ud90P+mhj
         FbGNCpNblxC6bfZRkvJLYEheKHGGvsZppO75fHfrhmh1vG6LRyZ+SH66li5RcEQtF1hb
         QGP0cGffTIPCUbO77s8tSOdbXOVjIr8g+ekJtqjqkiqapCe6dnF/9drUvxfu23CkUmzM
         e25wK/KaIgarCZd7WwGhAETTE2RB39bQHayXCpg4Mid86Zyk3t8N92fAvF7MuId7XC3E
         QMtDkqu1tunErrgrXfTSPWsbeRaJVv3mqpGZz7pTzwBArrQWFgRA2nPO+gStBVJbWevD
         ak3w==
X-Gm-Message-State: AODbwcD+AhLD82u0a3iG73/z9urhizgI9z1b8KHUxeZS+1helbDDExHS
        VWHLA7I9TQXLUTHlbN/c5ToUv0w4Ww==
X-Received: by 10.202.0.4 with SMTP id 4mr3260298oia.8.1494871719735; Mon, 15
 May 2017 11:08:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.54.53 with HTTP; Mon, 15 May 2017 11:08:39 -0700 (PDT)
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Mon, 15 May 2017 11:08:39 -0700
Message-ID: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
Subject: git rebase regression: cannot pass a shell expression directly to --exec
To:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It used to be possible to run a sequence like:

  foo() { echo X; }
  export -f foo
  git rebase --exec foo HEAD~10

Since upgrading to 2.13.0, I had to update my scripts to run:

  git rebase --exec "bash -c foo" HEAD~10

I'm not sure if this was an intended change. Bisecting with the
following script:

  #!/usr/bin/env bash

  make -j8 || exit 3

  function foo() {
          echo OK
  }
  export -f foo

  pushd tmp
  ../git --exec-path=.. rebase --exec foo HEAD^^
  ret=$?
  # Cleanup if failure
  ../git --exec-path=.. rebase --abort &> /dev/null
  popd
  exit $ret

It points to this commit:

commit 18633e1a22a68bbe8e6311a1039d13ebbf6fd041 (refs/bisect/bad)
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Thu Feb 9 23:23:11 2017 +0100

    rebase -i: use the rebase--helper builtin

    Now that the sequencer learned to process a "normal" interactive rebase,
    we use it. The original shell script is still used for "non-normal"
    interactive rebases, i.e. when --root or --preserve-merges was passed.

    Please note that the --root option (via the $squash_onto variable) needs
    special handling only for the very first command, hence it is still okay
    to use the helper upon continue/skip.

    Also please note that the --no-ff setting is volatile, i.e. when the
    interactive rebase is interrupted at any stage, there is no record of
    it. Therefore, we have to pass it from the shell script to the
    rebase--helper.

    Note: the test t3404 had to be adjusted because the the error messages
    produced by the sequencer comply with our current convention to start with
    a lower-case letter.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


Thanks,
Eric
