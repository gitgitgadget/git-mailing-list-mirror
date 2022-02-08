Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E167DC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387554AbiBHWY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387157AbiBHWEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 17:04:01 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F310C0612B8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 14:04:01 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g14so618258ybs.8
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NZ5UKYmlYueUk/bZJbVKnVvDxWd5vo4W5tnmHew4bvw=;
        b=XfDVAhflntClDuapYXxuJ2zrhTewIcsw3HyNMCWd1MfeTZ3r/pVc7FZ6zFFg0EB8PG
         ciR5JrTojmkFajxdC17WAOgpN0ld/XLnADw9Age5kwRcfYfwHzXZ70kb5a81YMWIPmze
         4r27K/bUWEL/Fk4gauqJHjIT+btdg7jPnpIKDTi39s0P4M9ob966X5NSbQ+B9IEMYB/0
         WI/4LUjBGhlgmNZ393G69yUJezO0ZKMjnJrKIdM0b9IIwjBxXQxamGrHLSZk5LKOThij
         oli3R1AnxSPFLgoR5T0EEx90guye6dekKFoh/OmCDXDpW7WH4OcSLZfjjApR9Mr406WC
         0elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NZ5UKYmlYueUk/bZJbVKnVvDxWd5vo4W5tnmHew4bvw=;
        b=PuPx1CZZErUymEYct3apjYALSUW9MmSyuRBbJXsXslA4w5J+zleO9tTJBOapO6VcVd
         QBWNu6WGvfsEEI5bLc6vUp2r4+hoxTbmjQjSlJp5/xDudPMpNhjYrOhtxIqfTgSfQP7q
         Bilr/zgLzn8EI05mg1pmSQHpJHDhqyBwchKEox1XkIyaq4qimg+avoz5Qd4kukt10SlK
         UIucMXTAzANhREMwBZMPe3W35VZwQ1lNY39ZsAuZkjEkesovtyqXt/OfiXSQbmtfHtaX
         k4Jut0iFqCCVsaC4cec/FG+qA8BHhcFaSTi2NaY92uruFAVKMXKWV5qOBwUC8mxuXIbe
         pawg==
X-Gm-Message-State: AOAM531ZATkAHy4yuDv1RmHvSp1foNuG2bUgiPm2+kXBWiifH6DsAbnY
        xzLFPEX+qit1jZ7hEWQwjHjcGM2/QScqeBeIT3zD32HBGYo=
X-Google-Smtp-Source: ABdhPJyzLKs2/BaIqx5iJWo4GhvkbkAGLxdfRxtqzU//tBAt7y8b3C75X+aiWPStDDMuMOVdifWnNDvO7G9/o/NGcMQ=
X-Received: by 2002:a25:e78d:: with SMTP id e135mr6493723ybh.234.1644357840087;
 Tue, 08 Feb 2022 14:04:00 -0800 (PST)
MIME-Version: 1.0
From:   Patrick Marlier <patrick.marlier@gmail.com>
Date:   Tue, 8 Feb 2022 23:03:49 +0100
Message-ID: <CAKQMxzSQRL-Q5daxETF+gYhVScmq_n=r2LJAeEuxpM7=jPajZQ@mail.gmail.com>
Subject: Optimization for "git clean -ffdx"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git Developers,

In a big repository with a lot of untracked directories and files
(build in tree), "git clean -ffdx" can be optimized. Indeed, "git
clean" goes recursively into all untracked and nested directories to
look for .git files even if "-ff" is specified.
Using breakpoint on stat or "strace -e newfstatat", it is possible to
see the recursing search for ".git" and ".git/HEAD". Also it seems to
traverse the untracked directories a few times, which I am not sure
why.

Using "-ff" should not check for nested .git and no need to recurse if
the directory is already untracked.

Doing the following, it seems to avoid looking for nested .git and all
tests are passing.

@@ -1007,6 +1008,12 @@ int cmd_clean(int argc, const char **argv,
const char *prefix)
                 * the code clearer to exclude it, though.
                 */
                dir.flags |= DIR_KEEP_UNTRACKED_CONTENTS;
+
+               /*
+                * No need to go to deeper in directories if already untracked
+                */
+               if (rm_flags == 0)
+                       dir.flags |= DIR_NO_GITLINKS;
        }

        if (read_cache() < 0)

However reading the documentation of DIR_NO_GITLINKS seems to say that
is not the right fix.

Another thing to note is that it shows "Removing XXX" but it shows it
when the directory is already gone. So we could change to "Removed
XXX" or display the "Removing XXX" before starting to remove the
directory.

Thanks in advance for any fix or help in getting it right.
--
Patrick Marlier
