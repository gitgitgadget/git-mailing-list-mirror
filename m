Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39156C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 04:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiDMEpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDMEpE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 00:45:04 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0912A96
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 21:42:41 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id bh17so1493244ejb.8
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 21:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lmpUVo0uUhl4i8QBv6ZykqwhiQA7QNRS7g0Fx2JCMAM=;
        b=AKIaVuljVMDwg07xLyB4CxcZ6tGuBJnWxW9v9ZoNGqiGaELxvT4PeLG8oN6n5eViQH
         bHIcRt1znzHAXFwi9wWJQjG6qvlqtbl1yeXqHuV0IG9tyQ1SQIb+CwWIea+kjG3fVWPF
         TNO4ZoytN1Y6WvNABzkwLlDJ/lYKRa5pHJv8rtomN/63q7so0tJoGmt6i/pnrfzmJgwl
         FT88TivIxeoRPuGURtWaAzvy3dF3J33V4jDvrsparRe/39m7l4hrkhgBKQb/1hVBwO7N
         mY+Gdo8vJyxLXZYQsnImsggdAe459wbQZA4OlQIk1CEoqaZdQcocCnjwYurhiZtr8SmE
         Ch4g==
X-Gm-Message-State: AOAM531cb80WtfUjAdKJydp3Wo4/2gjFMrvC18BPP/3cuvTFTCM7xvmu
        o0QPo/yDhENlCYFqIUmQ3gGBkUbuXj8EN7qEa7A47UjZlfY=
X-Google-Smtp-Source: ABdhPJw4N/hPIb4XkIUK08F+GcUMVclv87HszFRuuJDBkw0BJoLG2zpY5WpT1jCHFlfY1bPUcIofN0ubXLB0GtUZ708=
X-Received: by 2002:a17:906:2883:b0:6e8:7012:4185 with SMTP id
 o3-20020a170906288300b006e870124185mr17220999ejd.204.1649824960116; Tue, 12
 Apr 2022 21:42:40 -0700 (PDT)
MIME-Version: 1.0
From:   Jeremy Maitin-Shepard <jeremy@jeremyms.com>
Date:   Tue, 12 Apr 2022 21:42:29 -0700
Message-ID: <CAKJfoCEgiNvQJGt=rGYTaKQ1i2ihrPmX2Sz3Zxg-y66L+1Qh6g@mail.gmail.com>
Subject: Limitations of ownership checking fox for CVE-2022-24765
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current fix for CVE-2022-24765 prevents unsafe command execution
in some cases but does not address all cases:

- Ownership by the current user should not be taken to mean "trusted":
the user may have retrieved a directory tree from an untrusted source,
including:
  - Another version control system (which won't prevent a .git directory)
  - Unpacking an archive
  - FUSE mounting a remote filesystem

Additionally, the current fix requires additional configuration to
support existing use cases, and does not provide uses a way to safely
execute commands like `git status` or `git log` on untrusted
repositories.

I think a better solution would be for git to support a `--safe`
option that only runs config-specified commands specifically added to
an allowed list, or if the repository itself has been added to
safe.directories.

Ideally git would default to running in `--safe` mode, but if that is
too disruptive at least the option would be available for use in
prompt commands, etc.

(Please CC me in replies as I'm not subscribed to the list.)
