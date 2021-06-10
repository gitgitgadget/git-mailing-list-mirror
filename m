Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF94C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04BA6135C
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJK1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:27:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34721 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJK1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:27:12 -0400
Received: by mail-ed1-f44.google.com with SMTP id cb9so32389938edb.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=6l0HNO6DbeKCSEWJxTX14GbLlxxnOWL86Y3ndUv4P5I=;
        b=uu43C6PNPiIDGXlSxyA8zyfMMJ33IhniI72z1CXA4rCjxd+yoJDNVd2KfeU/w6gpCq
         OMqc32rq4GAb02iEOVT9yCuiosX6ZdyYuWf3rbGv5x+dq4uPXNz4vD7HNiEe9V3mMHpm
         nypqTCa7WRFKziJ6ookKlRkoi2C667UvYWTpBEe3gOtGzLG1e8GBF7iV/2SHDgev/AmZ
         af3cezkk1xJD/1qNSEkyC/mCmjjeMcSFoQ8QJNXU0P1u8OxcgdC6MUdSMkqWNTPJSHBQ
         XrpK0hmcjCdmZ3bQzxPmSoPldxRakkIfCeGXYvWORnUrMkR5bhF7oYiJ2ujFz9ZL5TL9
         3fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6l0HNO6DbeKCSEWJxTX14GbLlxxnOWL86Y3ndUv4P5I=;
        b=LvQXgGkgNDMj0MjffXiK+1EeG5GWic+YDQgmL/3enPXIusrM4FkRB7uLkY/WeTi/uG
         obkLSveBNKVDvmtdrHB9WcYcvrkGvdagRPybTRwMsOXMJ8TjBQGtgDqDLZTvdB8YX6cG
         99zxUIJ1+zGeNCaEsW0E3xhH9/fB3LlRYaAdXmJpCkkrcB6XmW9xBd2u1WNANE0IyOEJ
         v6S5mwJgKPfF1/EpZtVJdicaP7Ui9zPHfJgygJG7VwOcM2788Az5mMwFojVbPoge8kay
         UoRu4GoTTYJfT85EseBZdjEAMLMVHCtQajjTz3pWIYaAaiy87w/bU9VTiXfrmb6fIJDc
         ashA==
X-Gm-Message-State: AOAM531p4fF5sG3uk3LAfq09VnMCl/4ivtEUEETCvOWebz9jxODnMg5l
        9++3U6EzoHY1wB6hIXS4+7SCBPCXe3TCtxqxLSCeuhWPs94zcC1B
X-Google-Smtp-Source: ABdhPJyVZyN4UNeRc8SHQdMwlrh55difVfR2zpyz/k0GqWAKz16YAe+yE/+M6Iimx+pWH+MVQ6CE1CEo/1t8TMscr4M=
X-Received: by 2002:aa7:ca1a:: with SMTP id y26mr3897439eds.314.1623320655602;
 Thu, 10 Jun 2021 03:24:15 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 10 Jun 2021 12:24:04 +0200
Message-ID: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
Subject: Windows: core.useBuiltinFSMonitor without core.untrackedcache -
 performance hazard?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

With the new "core.useBuiltinFSMonitor" support in the Windows
installer, I think this subject is worth calling out explicitly (and
my apologies if I missed prior discussion):

TL;DR:
 - I believe "core.untrackedcache" should be enabled by default in
Windows (and it does not appear to be)
 - If a user enables "core.useBuiltinFSMonitor" (eg in the installer)
in the hopes of getting snappy "git status" on a repo with a large
deep working tree, they will be *unnecessarily* disappointed if
"core.untrackedcache" is not enabled
 - There is also a lingering "problem" with "git status -uall", with
both "core.useBuiltinFSMonitor" and "core.fsmonitor", but that seems
far less trivial to address

Detail:

I just started testing the new "core.useBuiltinFSMonitor" option in
the new installer, and it's amazing, thanks Ben, Alex, Johannes and
Kevin!

However, when I first enabled it, I was getting slightly *worse* git
status times than without it... and those worse git status times were
accompanied by a message along the lines of:
---
It took 5.88 seconds to enumerate untracked files. 'status -uno' may
speed it up, but you have to be careful not to forget to add new files
yourself (see 'git help status').
---

For context, this is in a repo with 200,000 or so files, within 40,000
folders (avg path depth 4 I think?), with a reasonably-intricate set
of .gitignore patterns. Obviously that's not "your average user", but
I would imagine it matches "the target audience for
'core.useBuiltinFSMonitor'" pretty well.

After a little head-scratching, I recalled an exchange with Johannes
from last year:
https://lore.kernel.org/git/CAPMMpohJicVeCaKsPvommYbGEH-D1V02TTMaiVTV8ux+9z9vkQ@mail.gmail.com/

I never did understand the relevant code paths in much detail, but the
practical conclusions were:
 - Without "core.untrackedcache" enabled, git ends up iterating
through the entire path structure of the working tree *even if
"core.fsmonitor" (and now "core.useBuiltinFSMonitor") is enabled*,
looking for untracked files to report
 - Even with "core.untrackedcache" enabled, if "core.fsmonitor" (and
now "core.useBuiltinFSMonitor") is enabled, git iterates through the
entire path structure of the working tree *single-threaded* when the
"--untracked-files" mode is set to "all" (by config or command-line)

Now, I imagine that addressing/improving these behaviors is very
non-trivial, but the impact could be reasonably limited if:
 - core.untrackedcache were defaulted to "true", at least under
Windows, at least when the installer is asked to set
core.useBuiltinFSMonitor
 - The "It took N.NN seconds to enumerate untracked files" message
were to include a hint about core.untrackedcache, at least when the
"--untracked-files" mode is set to "normal".

Final note: I personally would love to see "core.useBuiltinFSMonitor
actually makes things slower, when --untracked-files=all is specified"
behavior be addressed, because common windows git integrations or
front-ends like Git Extensions or IntelliJ IDEA commonly use those
options, and therefore "suffer" a performance degradation on at least
some operations when core.useBuiltinFSMonitor is enabled.

I don't know whether this is the right place to report Windows-centric
concerns, if not, my apologies.

Thanks,
Tao
