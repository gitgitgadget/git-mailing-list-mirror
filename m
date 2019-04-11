Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AB020248
	for <e@80x24.org>; Thu, 11 Apr 2019 23:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDKX4V (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 19:56:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40255 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDKX4V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 19:56:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so9276998qts.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CyidiXVjHEqz0BL9xHeRqBcKdfQaxL1w99KYBS9k7FA=;
        b=RVEiYdNDntagbUx2g0qm84FT/Y4ZX4b7XFq/07mGzZvFopKpRvyESM/60cWXZS+8t+
         KNqT+4Pv1yzELEQAdEU9N379nLg4Qyyo4jVQGJrQCbsRvkYLrAE54C8J57Hr2zqY5cEK
         wFjspOgqAT2Ni16AzPqdXyXqlSlDuf5QgDkicRWdH+zTBmzNIdBPg/ZjdzXePrSrb2ty
         BD8pbCIR4niYLao2a/Txb2evuGaJ6pqBFc7KTqej0K6FiR8mP435es9weRipXdZ+iYkb
         VcRofhJJjD9nKVj7OGoxH1YgM0QfEjGMUPAEKPWHSQPBzTVkNhadRG1RudrvIYJdkzVF
         pHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CyidiXVjHEqz0BL9xHeRqBcKdfQaxL1w99KYBS9k7FA=;
        b=bAKHB5Et7K74M+cMpxFiOqOi9xsQNLorxd0eSXoK9TzasHeDr+oaA9Axr5MWl9fWxj
         MYbx+62krG6WOTYKE3u8rrb4FGdjuXbhEMAe+5RKUw291MtvBjAhRKdKqn257Q7nf1uA
         7fGneX+vq9WRo2slBCEm6eOk7UWfrVuavzwFHffOhN3iNMlzumHrStWpWHzvZ6z0Kkbk
         xLF7OdWpyK596WI6szghKpzo7vX2frJK6lJ1syK7lSHr90Bu6Gql0GjLzipY6S7ls5UX
         5dJaqbotqqWfKo22AP/hxFU1SVlVNqm17Kzz8QhDT4SlAKJp4F5ZoZ8HW4+30iMG+xJ1
         IG8Q==
X-Gm-Message-State: APjAAAVJ9JrX0o0Dk9uhg0SNukRbil4E1OtxmgRydzGlxHAI6Nv2YHz8
        IH1o32qAcWevb3xgq8AKSf51MR+zXfugMunP7JXeQdPH
X-Google-Smtp-Source: APXvYqxiOgfPNyFL9KlkYuA+XLIMNgUayLWM/8LfwIWsvN2NupFsQZi0lpZI82mm5vTXJ7dTIiDgZEI5ukGquCuxJHQ=
X-Received: by 2002:a0c:d4a2:: with SMTP id u31mr44404798qvh.139.1555026980252;
 Thu, 11 Apr 2019 16:56:20 -0700 (PDT)
MIME-Version: 1.0
From:   wh <microrffr@gmail.com>
Date:   Thu, 11 Apr 2019 16:56:09 -0700
Message-ID: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
Subject: [BUG] rebase --interactive silently overwrites ignored files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git 2.20.1 from Debian. Git is usually careful not to
overwrite untracked files, including ignored files. But interactive
rebase doesn't detect this (non-interactive rebase works fine).

Reproduction:
-----

#!/bin/sh
mkdir upstream
cd upstream
git init
echo 1 >feature-1
git add feature-1
git commit -m "feature 1"

cd ..
git clone upstream local
cd local
# write some tools for our own convenience
echo ours >tools
echo /tools >>.git/info/exclude
# start working on a feature
git checkout -b f2
echo wip >feature-2
git add feature-2
git commit -m "wip"

cd ../upstream
# official tools are available
echo theirs >tools
git add tools
git commit -m "tools"

cd ../local
git fetch ../upstream master

# this would be okay
#git rebase FETCH_HEAD

# problem: overwrites tools silently
GIT_EDITOR=true git rebase -i FETCH_HEAD

cat tools

-----

Expected: `git rebase -i` fails because it would have to overwrite the
untracked "tools" file. Contents of tools file remains `ours`.

Actual: Contents of tools file becomes `theirs`.
