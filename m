Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88BEB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 10:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGFKdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFKdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 06:33:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46E124
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 03:33:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso1358345e9.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uw.co.uk; s=google; t=1688639620; x=1691231620;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C7q8YJydt+N8nk2aGLAoyE9hLP17MZvzpy3h1O9/S+8=;
        b=iuJq8kv5n9EI0cZWRAAWczYBLfjegxeStVb8LHZNUf/CbVmptqX32ORyPRLYMHbct1
         F+BNKuEEs+cWBjwczLsV9rqIsdkEVMCMzhW4uU3siPTUiUSAIOCKmkucI4ZU7R/rW7Dz
         at2dO1DKRjd5XBe6YCi/IYGzFUHT2uhL+iwJgFC+mDLGJdyn+4Wv42jbCJ7/LtFn7x3c
         nCodC45WHf3HFI05vmKZ+MQj1UxFTz/RXbbyuzFAhjTvdd9Rbnqk/Y/S/BizAvyimvyE
         Lnc2QUMI+xCvdaTQdEppJ8MEtVIz6CHGkoFfgTz3cJS36nb2xL6fFKsCEwaCZ2U0/WtZ
         ehRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688639620; x=1691231620;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7q8YJydt+N8nk2aGLAoyE9hLP17MZvzpy3h1O9/S+8=;
        b=E9wP4NSdNgYDlaxaCy/asB5T/151iQ9m155keth5s2q/qjP6xx2QUg5CdemPNjpwnp
         zy+dav3SvbhzE4BPMUsvz6vKOPJDgWBxv4saKi2MsTmHZ9P6FG1NQ2MZw46HlhK4BTsK
         nhpNpHSvGmveD7+L/Y1YVfofuMDLXYzhC+jfFEHOtzoqXi0/fMR49Lm8/tTtW4dUGIRp
         A28tF/DwQe9y25X5UMb78H9bF6G5x0ZZ9oYfCr6Z6bHP6nMbMPY6qiluK6MC1whuofXu
         6uSpHKoYFlke3F5KY+pd/tLY227SbOpwx5ueRM3bolUzVIKWzCHKSvflup2NXc+Sdfdm
         ByZw==
X-Gm-Message-State: ABy/qLa8M1Pla/92LfbaMLs5h+8Bpwqm38Ev5BOvgxA5D5SNMbXhyw6p
        jN+n4u/woyY9DTCM6igb9KMzJ0KaJrApgO8GtwqUSR8EnA5dBPT2MiQ=
X-Google-Smtp-Source: APBJJlH8Z34sHUbvRlN0uNap3oyhhH7YY/5sDJjtjhKJEoKNQ24dmVl0+sLeRs40mfngR1LYE1/sEUA0NlEleLAN61s=
X-Received: by 2002:a05:600c:82c6:b0:3f7:fb5d:6e7a with SMTP id
 eo6-20020a05600c82c600b003f7fb5d6e7amr1236369wmb.0.1688639620615; Thu, 06 Jul
 2023 03:33:40 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Hughes <mhughes@uw.co.uk>
Date:   Thu, 6 Jul 2023 11:33:29 +0100
Message-ID: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
Subject: Expected behaviour for pathspecs matching attributes in subdirectories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm working with pathspecs matching on attributes, here's a basic repo setup:

    $ git init .
    $ mkdir -p sub/sub
    $ touch fileA sub/fileA sub/sub/fileA
    $ echo 'fileA labelA' > sub/.gitattributes
    $ git add .
    $ git commit -m 'Build the repo'

What I want to do: list all files under 'sub/sub' that have 'labelA' as an
attribute.

Working from the top level I get the output I would expect:

    $ git ls-files -- ':(attr:labelA)'
    sub/fileA
    sub/sub/fileA
    $ git ls-files -- ':(attr:labelA)sub'
    sub/fileA
    sub/sub/fileA

But as soon as a directory is included in the pathspec's path no files are
returned:

    $ git ls-files -- ':(attr:labelA)sub/'
    $ git ls-files -- ':(attr:labelA)sub/sub'

Without the attribtue magic I can use a directory to list files there:

    $ git ls-files -- sub/sub
    sub/sub/fileA

Is this the expected behaviour? I looked in t/t6135-pathspec-with-attrs.sh and
didn't see a test case covering something similar. If this is expected, is
there another way to achieve what I'm looking for?

Thanks for your time,
Matt
