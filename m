Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59679C6FD1C
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 11:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCILLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCILK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 06:10:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6DF16BE
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 03:05:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j2so1426758wrh.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359918;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vaCJjpb1KdeUVDKY6WG6AD3tox4e0T3T0OMU6dYg3NY=;
        b=J0Jq34l2ivzhe0YG4RrhRYolXdrEYi+irQSzOReA3N9Ee/63zQDy+1YleG1ahbzfQD
         sHmhc398my0ty+kbnEwQK+NTG5tsrJSMta9+MqLrCp9JLdtdSDJlVBupbz9EAsOHUpeI
         8AIHWmxs+G+N5721KSPJ7ZA6M9CI2CyQM9qNs1z+Jt2xmZ2iaGZjQCjPyOFhnyoVXI+B
         10Io2V/v9p8eyN+fNhjsw35KzdbCEcTvVNHPJB3fES5OxLdU4IMSEUMC2RwjA+3Or4ad
         81sme/BSXU+ztEZaQKHNfH9cvQ/vq1ZXsEc4Cae8t9SPXe3TGrodRbjfTZcok5Um5asz
         6rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359918;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaCJjpb1KdeUVDKY6WG6AD3tox4e0T3T0OMU6dYg3NY=;
        b=qQARVdXgPETzUvl9joWdu39xQlTiCF4nN3E8gI3drA91utHdGzg3cP76TvH+e66aLW
         vH6/apBZ8yjFVFbOnvshgx+nbL7lA1gmPHgeXpLHQu3eIiigfcGLNp+cRytdt2zkXDqy
         JW2Z4nxS2/uNIVIIRQB9pH7DK3KiyWw+WQIJz/q06KDkL+ZcoKTZ5kw+s7e5MKt3jllT
         JwSel/XRQMcV+HVcEOHOm8rY2/PUtatxMT+Ix4cRQ6/6jLMqF1sAS3MCr3DZc0+EB1AC
         n4WD6sA0JJulXATbFkxpzNMPywh1Ox3GQ1gYxJgQHf10lSfIA7EZMXOOGjSkmYABOzH3
         lNow==
X-Gm-Message-State: AO0yUKXvWDPLOtU6QtofLzMEoSS6OkJ7MISHg8cxuoPUzHrnroXts0lw
        Fi5W5RWyToq/JoG/KoOEKGlWa4iLwI21qHIpE635Y+WARo0=
X-Google-Smtp-Source: AK7set+EidsatwCGN/PW1YWxjmobf5FTZpdmsl5nDMnw5iJRF/PVxm1PinQSlXgae27QP8lAJ1DoYTiUaUpmFR7+sL4=
X-Received: by 2002:a5d:6485:0:b0:2c5:4adc:6e52 with SMTP id
 o5-20020a5d6485000000b002c54adc6e52mr5904449wri.3.1678359918188; Thu, 09 Mar
 2023 03:05:18 -0800 (PST)
MIME-Version: 1.0
From:   Ilia Pozhilov <ilyapoz@gmail.com>
Date:   Thu, 9 Mar 2023 13:05:07 +0200
Message-ID: <CAAo-ADZBBRxSROeAwrA9o30Etf3QQhLCaWQJtVsChVwT-AbgTg@mail.gmail.com>
Subject: Track git blame through two unrelated histories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I have a weird use case. A repository at my company was migrated git
-> non-git vcs -> git again.

During transition to non-git vcs the history was lost, i.e. an initial
commit was created from some known commit from the old git repo.

Migration to new git repo was more transparent and we have the whole history.

So let's say I add two remotes and fetch all the commits, but they
look like this:

A->B-> .... . . . -> Z    history1

1 -> 2 -> ..... -> 0 history2

and file contents in commits Z and 1 are exactly the same, but the
commits themselves are completely unrelated for git.

What I want to achieve is blame working across this boundary.

What can I do? It this possible right now? Is it difficult to
implement? Is there a good enough workaround? I don't think rewriting
commits 1... 0 is an option, but rewriting A ... Z is an option.

What do you think?
