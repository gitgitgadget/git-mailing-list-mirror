Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B943C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 13:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBYNFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 08:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYNFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 08:05:17 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Feb 2023 05:05:15 PST
Received: from smtp1.phpwebhosting.com (smtp1.phpwebhosting.com [184.154.71.7])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 55EC117CF5
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 05:05:15 -0800 (PST)
Received: (qmail 19583 invoked from network); 25 Feb 2023 12:58:36 -0000
Received: from unknown (HELO mailman.drmikehenry.com) (drmikehenry@drmikehenry.com@96.244.102.80)
        by smtp1.phpwebhosting.com with SMTP; Sat, 25 Feb 2023 07:58:36 -0500
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
        by mailman.drmikehenry.com (Postfix) with ESMTP id 788B51A010C
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 07:58:33 -0500 (EST)
Message-ID: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
Date:   Sat, 25 Feb 2023 07:58:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Michael Henry <git@drmikehenry.com>
Subject: `git bundle create -` may not write to `stdout`
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

I've encountered some unexpected behavior with `git bundle create -`.

Summary
=======

Using `-` to create a bundle file on `stdout` works only when the current
working directory is at the root of the repository; when in a
subdirectory, `-`
is treated as the name of a file instead.

What did you do before the bug happened? (Steps to reproduce your issue)
========================================================================

The below steps are using Git's `next` branch (cloned today) to demonstrate.

- Bundle creation to `stdout` works in the repository root:

      $ ./git bundle create -q - HEAD ^HEAD~ > head.bundle
      $ ./git bundle list-heads head.bundle
      a93b1961839a603a8ac2df08fd80c48bd140fe02 HEAD

- From the `Documentation` directory, `-` is treated like a filename:

      $ cd Documentation/
      $ ../git bundle create -q - HEAD ^HEAD~ > head.bundle
      $ ../git bundle list-heads head.bundle
      error: 'Documentation/head.bundle' does not look like a v2 or v3
bundle file
      $ ../git bundle list-heads ./-
      a93b1961839a603a8ac2df08fd80c48bd140fe02 HEAD

- Consider this patch to display the bundle file path:

      diff --git a/bundle.c b/bundle.c
      index 6ab6cd7378..05be3ed520 100644
      --- a/bundle.c
      +++ b/bundle.c
      @@ -524,6 +524,7 @@ int create_bundle(struct repository *r, const
char *path,
                      goto err;
              }
       
      +    fprintf(stderr, "create_bundle(): path=\"%s\"\n", path);
              bundle_to_stdout = !strcmp(path, "-");
              if (bundle_to_stdout)
                      bundle_fd = 1;

  When in a subdirectory, it seems that the current working directory is
being
  changed to the root, and the bundle file's path is being adjusted
accordingly:

      $ ../git bundle create -q - HEAD ^HEAD~ > head.bundle
      create_bundle(): path="Documentation/-"

What did you expect to happen? (Expected behavior)
==================================================

I expected `-` to be treated as `stdout` in subdirectories as well as in the
repository root directory.

What happened instead? (Actual behavior)
========================================

When in a subdirectory `some/subdir`, `-` is converted to
`some/subdir/-` and
treated like a regular file instead of `stdout`.

What's different between what you expected and what actually happened?
======================================================================

I expected the bundle file to appear on `stdout`; instead, it was
written to a
file named `-` in the current directory.

Anything else you want to add:
==============================

It's unclear to me whether creating a bundle file to `stdout` is documented
behavior.  I can't find direct mention of it in
`Documentation/git-bundle.txt`,
though that document does have this text:

    --all-progress::
            When --stdout is specified then progress report is
            displayed during the object count and compression phases
            but inhibited during the write-out phase. The reason is
            that in some cases the output stream is directly linked
            to another command which may wish to display progress
            status of its own as it processes incoming pack data.
            This flag is like --progress except that it forces progress
            report for the write-out phase as well even if --stdout is
            used.

The switch `--stdout` doesn't seem to exist, though; perhaps it was a past
feature that got removed but the documentation hung around?

I find the ability to create a bundle to `stdout` a useful feature, though a
niche use case: I'm post-processing the bundle file's contents before
writing to
a file, and bundling to `stdout` saves the creation of a potentially large
temporary file.  I'm currently using the temporary file approach, however,
because I'm not sure that bundling to `stdout` is intended as a supported
feature; I'll leave that for you to determine.

Thanks,
Michael Henry

==============================================================================

[System Info]
git version:
git version 2.40.0.rc0.245.ga93b196183
cpu: x86_64
built from commit: a93b1961839a603a8ac2df08fd80c48bd140fe02
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC
2022 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

