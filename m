Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB70C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 03:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhLGDEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 22:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLGDEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 22:04:38 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B4C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 19:01:09 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id w23so23774461uao.5
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 19:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcweathers.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=hlw3hnxVprTGSGFztXFwiXyCgwXp0uYe6BMI1D8gXRE=;
        b=nXwLT5QD/SVmSROZzIWf1f1cXq8Booq913Uh4IQWiITeFq5Xu4dYglV65rjAnOT/QF
         EQ/QhX9jY+RaqtCqe+GJwS601+u/9Fi29XzhSrumkSTGdOSpJlijHa7GNr11crFtl+5W
         1E8fr+gfcf+VN434k2pw2Hx7vkSFrjRmFfOqqYU9T+1YjN+oN7IeRAJyj3h7/7cpKwaw
         kjbbrFXBzzQCPeXRVY9HgjzIEUQqXevBi6/UuwQP1TqcjB0ZGcV8Z+5Iu8uaN+vQkeuY
         UEaJwEBKD4rQFCalucFruC3WeSNo2aBn1ggiJ2+sXNjlQG8DOP7momIYEfeON2ddLqIp
         wjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hlw3hnxVprTGSGFztXFwiXyCgwXp0uYe6BMI1D8gXRE=;
        b=ytYWFImT19iV6Ry6//25PaH9kQkTHthBzsLS8KSWkl5GtvHjrlxk7bdqfG18UgoJvS
         JPinXFm8dE+vURDRb9roXVW29g/6dB6wxQD+MabbLg1l3leO9OFtrjAP0M66cs7e5caU
         FV4bVovS7ZCvuL+hskBlZESWoGorPdNjdv6rIsanAaF5lkfOt4DGHNIX+2tMM66gfu/a
         HHovxmFkA1eAQ2J6kdLh1fD3Tsh+xs5ty8ux05Pf8bICFJ07PjWPf2Hf3zElpv1+1lWS
         MIv1RhSrIkZ6NEGntSysGYa5RXBbENAp0KkDQVsPlpIwokuubK025n3I5ZdC/RTqsAUg
         BA+g==
X-Gm-Message-State: AOAM530SLRBA6I3+ueSbPssZIXtwKtjlrqiSiEH30FGbW7Cbr/kkgStu
        8W6Pr7eHPSJ4jMWiIB5XP6lBSJtUiwI5pO+SPZ4LImT84DaRqqjeAzc=
X-Google-Smtp-Source: ABdhPJw64Ix79bTN3YC6NNTRZJe+kDxH/Srmukf2dd+ee9r/H8mEiwFd4tvc0Vf2LHVO1BU3GwMi3Ly64L4dk/E2YK8=
X-Received: by 2002:a05:6102:e07:: with SMTP id o7mr40502124vst.27.1638846068050;
 Mon, 06 Dec 2021 19:01:08 -0800 (PST)
MIME-Version: 1.0
From:   Leland Weathers <leland@lcweathers.net>
Date:   Mon, 6 Dec 2021 21:00:56 -0600
Message-ID: <CAHeq4YxktibxMBnMLwEq9Nvsgw0UqCrjW2WPcerJCM4mXKxiEw@mail.gmail.com>
Subject: BUG: git bash / python interaction with absolute paths as environment
 variables in Windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue: Using Git Bash for Windows (2.34.1-64) and Python 3.9.9, a git
path is incorrectly prepended to environment variables in Python code.

Sample Output of a simple Python script pulling an environment
variable - this is the expected output, where Python is given the
correct environment variables for both absolute directory paths and
non-directory paths - OS should not matter:

(gitfu-XXGUYdp7) C:\Users\Leland\code\gitfu>type foobar.py
from os import environ
from sys import stdout

stdout.write(f'environ: {environ["TEST_DIR_BROKEN"]}\n')
stdout.write(f'environ: {environ["TEST_DIR_WORKING"]}\n')
(gitfu-XXGUYdp7) C:\Users\Leland\code\gitfu>echo %TEST_DIR_BROKEN%
/foo/bar

(gitfu-XXGUYdp7) C:\Users\Leland\code\gitfu>echo %TEST_DIR_WORKING%
foo/bar

(gitfu-XXGUYdp7) C:\Users\Leland\code\gitfu>python foobar.py
environ: /foo/bar
environ: foo/bar

(gitfu-XXGUYdp7) C:\Users\Leland\code\gitfu>powershell Get-Command python.exe

CommandType     Name
Version    Source
-----------     ----
-------    ------
Application     python.exe
3.9.915... C:\Users\Leland\.virtualenvs\gitfu-XXGUYdp7\Scripts\python.exe



(gitfu-XXGUYdp7) C:\Users\Leland\code\gitfu>





Sample output when the same set of commands is run in git bash -
absolute path has been altered the relative path has not been:

$ cat foobar.py
from os import environ
from sys import stdout

stdout.write(f'environ: {environ["TEST_DIR_BROKEN"]}\n')
stdout.write(f'environ: {environ["TEST_DIR_WORKING"]}\n')
Leland@local MINGW64 ~/code/gitfu
$ echo $TEST_DIR_BROKEN
/foo/bar

Leland@local MINGW64 ~/code/gitfu
$ echo $TEST_DIR_WORKING
foo/bar

Leland@local MINGW64 ~/code/gitfu
$ python foobar.py
environ: C:/Users/Leland/AppData/Local/Programs/Git/foo/bar
environ: foo/bar

Leland@local MINGW64 ~/code/gitfu
$ which python
/c/Users/Leland/.virtualenvs/gitfu-XXGUYdp7/Scripts/python

Leland@local MINGW64 ~/code/gitfu
$




Is there anything else I'm missing on why the same Python script would
read environment variables differently than what is read from Git Bash
itself or why the exact same Python code reads the environment
variable correctly when run from a command prompt and not in Git Bash?

In both cases I am using the same Python virtual environment. Other
environment variables (e.g. non-absolute directory paths) appear to be
read correctly. I'm assuming that this is a git issue given the
