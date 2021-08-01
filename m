Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCE7C4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 12:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E36610CF
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 12:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhHAM7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 08:59:13 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34497 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHAM7M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 08:59:12 -0400
Received: by mail-lf1-f41.google.com with SMTP id z2so28584567lft.1
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 05:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wlMMzK08ZepycDX4fz5itlEU6sYv6mgdvE2GzKphmEI=;
        b=lnIYMcDU+baqB2ouq92an9Eu9Hi7AyhvlZaUpXaOD8UUpr3bqzHfhLba72j4NwdbqE
         h7Ek3noWpiQ/R9mRQZmLhDfCR2zufOgGcbbNTmeVELYmz/iiSXWQwYAgET8LBGRyMsy3
         Lg1DjzRus5ZyNBteNB3BD15hH7kEOgP144sdXKBy0Vne/MCCnRZ2DoP4ioMvKHnC/W1M
         lxg+Jww9KSxFYoDqs4mdB4j9ZyIXrsRtaK2Y9dzIt7ugDgpmeQEv60SbwqbOt6gHlkhu
         u+wZCOCdOB+/I11aYyXfYlsW9ZC1Ph9F2bXcLxRnql403Ri7ij96EpUOa6bTGSfv0syq
         dkCg==
X-Gm-Message-State: AOAM532czsj7KZo2/L3gqM59EHqCcgOAJas8qmTkaczJH9OunJiZ52Lw
        /nUq/Z7btDoVYzwdEANePVVQzIY+yyeTSTNzdzsMwEeWpHwZtQ==
X-Google-Smtp-Source: ABdhPJwkLvcP1hEIceueTL6DV7Trjq73Q3i/ZFm3nEhDDObj4onFXjAMIoQnd4czEfKtB6Lu50RoiMspN8FU1Hqmu+U=
X-Received: by 2002:a05:6512:3186:: with SMTP id i6mr9216081lfe.308.1627822742395;
 Sun, 01 Aug 2021 05:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Hoffmeister <Stefan.Hoffmeister@econos.de>
Date:   Sun, 1 Aug 2021 14:58:51 +0200
Message-ID: <CALhB_QNf98O=kOnZ=rmUt90SmqZzxRF2CfyYOKiiJv+Qa2abqg@mail.gmail.com>
Subject: git blame --ignore-rev degenerate performance on large(r) line counts
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git blame has a very useful option --ignore-rev (or --ignore-rev-file)
which allows ignoring of commits for the purpose of attributing blame.

One use case for this option is a scenario where a repository was
"cleaned" up for line breaks, e.g. via "git add --renormalize ."

Alas, git blame with --ignore-rev will fall apart at runtime whenever
the number of lines of code affected is high; it will show exponential
increases in execution duration on linearly increasing line counts.

The Python script below demonstrates the undesirable performance
behaviour for a single text file and just two commits. In a real world
scenario, with a repository-wide line-ending fix commit affecting a
large number of _files_ (in addition to some files being large),
performance behaviour will be even worse.

The Python script below will initialize a new repo and do the
reproduction dance fully isolated and offline; "matplotlib" as a
dependency (pip install matplotlib) is a nice optional add-on to have,
as it visualizes that on my system (i7-7820HQ, 2.9 GHz) runtime
duration explodes exponentially at around 35000 lines of "Hello Hello"
text.

****************
#!/usr/bin/env bash

# Beware - no error handling

import matplotlib.pyplot as plt
import os
import shutil
import subprocess
import time
from typing import Generator

REPO_LOCATION="git-repository-container/git-repo"
BLAME_ME_TXT="blame-me.txt"

def run_iteration(line_count: int):
    shutil.rmtree(REPO_LOCATION, ignore_errors=True)
    os.makedirs(REPO_LOCATION, exist_ok=False)

    os.chdir(REPO_LOCATION)
    subprocess.run(["git", "init"], capture_output=True)

    subprocess.run(["git", "config", "--local", "user.name", "me"],
capture_output=True)
    subprocess.run(["git", "config", "--local", "user.email",
"me@example.com"], capture_output=True)

    with open(".gitattributes", "w") as gitattributes:
        gitattributes.writelines("* text=crlf\n")

    def produce_some_file_content_sequence(line_count: int) ->
Generator[str, None, None]:
        mytext: str = "Hello Hello\r\n"
        num = 0
        while num < line_count:
            yield mytext
            num += 1

    with open(BLAME_ME_TXT, "w") as blame_me:
        for line in produce_some_file_content_sequence(line_count):
            blame_me.writelines(line)

    subprocess.run(["git", "add", "."], capture_output=True)

    subprocess.run(["git", "commit", "-m", "Initial commit"],
capture_output=True)

    capture = subprocess.run(["git", "rev-list", "HEAD"], capture_output=True)
    initial_commit_rev = (capture.stdout).decode().strip()

    with open(".gitattributes", "w") as gitattributes:
        gitattributes.writelines("* text=auto\n")

    subprocess.run(["git", "add", "--renormalize", "."], capture_output=True)

    subprocess.run(["git", "commit", "-m", "Renormalized"], capture_output=True)

    capture = subprocess.run(["git", "rev-list", "--max-count", "1",
"HEAD"], capture_output=True)
    renormalized_commit_rev = (capture.stdout).decode().strip()

    blame_capture = subprocess.run(["git", "blame", "-C ./", "--line-porcelain",
        "--ignore-rev", renormalized_commit_rev,
        "HEAD", BLAME_ME_TXT],
        capture_output=True)

x=list[int]()
y=list[float]()
for factor in range(40):
    start = time.time()
    line_count = 1000 * factor
    x.append(line_count)

    print(f'Line count: {line_count}')
    run_iteration(line_count)

    end = time.time()
    duration = end - start
    print(duration)
    y.append(duration)

plt.plot(x, y)
plt.show()
