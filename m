Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EACA1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 03:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeAUDAt (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 22:00:49 -0500
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33688 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932525AbeAUDAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 22:00:48 -0500
Received: by mail-yb0-f179.google.com with SMTP id c66so2053959ybf.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 19:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=i8Ow9Nwrn7yxv/PfCHHhhFSVIsBXDrFRd64OB57LRGo=;
        b=iIDFOpF9z+Kg//hQmmHC+pvdakDjVYrY/u/4oiQ4opAFGSRelPb6gc5chdTIOxcWP8
         VcDAm9jUccs6hX8OXfiBX3P7PYZnz6ZGsgS91QDmMuAzio6eaHQx/X2xwBHVaey2Hi8z
         1gtfki67RNuPHEhZwiKAb0XPz4GqSL/bgFm1iHDe6wDGq5qlDw/ZnMe5gJiQ+luhCSmq
         ASnkn6pbNR20yShjbT7PkcMV+5NgSxJgGlnQ++fb1ZKQ7Pkym+GYfrhMro814sooIrKo
         4GiXdEDf3AghcydVDxHFl0QSSpPGUQJwDahGRlmy9HtMR9HLQhogXygNLhkESw0amLre
         7jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i8Ow9Nwrn7yxv/PfCHHhhFSVIsBXDrFRd64OB57LRGo=;
        b=q/lz1+lJB5kbt30+ibyqgkB/YMPYPKCJgu734YKnZBckQ9N6YxihfRG50dQ9YeZeDQ
         3Rrpq9MK5T8Q+E6tdiDeXEzZf9pqVIUshRfShmfRHJkOwGGRWKg9x4nYkHHaF24BS4+G
         WLxbw+qz73lODiLbHw6thnrS22c3YMJ5wJ6cGsVSP8uyoudnG/JUbEcmgrdNtCBarHji
         j1qSqwLz0T2DhpfArr5o92mCHHm3nbbPl8Sje7jTPJiUhiAdjNzvcBSKsIOzImGWbFp9
         sHMkH9a4k5R00qxOUNnwkU8TzcxPDpqAzwMDv9012P+amujTsvaHbt9087b5Gv17S0uv
         WU4A==
X-Gm-Message-State: AKwxyteOzWQbpmcG3rHyrLBjg6EWnaQVrJvyRB+JAoO/a6nAHYaZCBHg
        6tT7fZR0lNB2uv7rX8HVLI+HVEOOa/oefzWVPXNZmjfk
X-Google-Smtp-Source: AH8x227cJkFEJ5cmdSAE62gr/TCTnrDzeqD5UbBmdLTwn6EulIMz+amuMDde6Q9mb2rYSnxh+0KX8rim3HEkBg/Tn2g=
X-Received: by 10.37.234.3 with SMTP id p3mr3150780ybd.368.1516503647064; Sat,
 20 Jan 2018 19:00:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.87.17 with HTTP; Sat, 20 Jan 2018 19:00:06 -0800 (PST)
From:   Josh Bleecher Snyder <josharian@gmail.com>
Date:   Sat, 20 Jan 2018 19:00:06 -0800
Message-ID: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
Subject: git merge-tree: bug report and some feature requests
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all.

I'm experimenting with some new porcelain for interactive rebase. One
goal is to leave the work tree untouched for most operations. It looks
to me like 'git merge-tree' may be the right plumbing command for
doing the merge part of the pick work of the todo list, one commit at
a time. If I'm wrong about this, I'd love pointers; what follows may
still be interesting anyway.

I've encountered some bumps with 'git merge-tree'. A bug report and
some feature requests follow. Apologies for the long email.


1. Bug

When a binary file containing NUL is added on only one side, the
resulting patch is malformed. Reproduction script:

mkdir test
cd test
git init .
touch shared
git add shared
git commit -m "base"
git checkout -b left
echo "left" > x
printf '\1\0\1\n' > binary
git add x binary
git commit -m "left"
git checkout master
git checkout -b right
echo "right" > x
git add x
git commit -m "right"
git merge-tree master right left
git merge-tree master right left | xxd
cd ..
rm -rf test

The merge-tree results I get with 2.15.1 are:

added in remote
  their  100644 ddc50ce55647db1421b18aa33417442e29f63d2f binary
@@ -0,0 +1 @@
+added in both
  our    100644 c376d892e8b105bd712d06ec5162b5f31ce949c3 x
  their  100644 45cf141ba67d59203f02a54f03162f3fcef57830 x
@@ -1 +1,5 @@
+<<<<<<< .our
 right
+=======
+left
+>>>>>>> .their

00000000: 6164 6465 6420 696e 2072 656d 6f74 650a  added in remote.
00000010: 2020 7468 6569 7220 2031 3030 3634 3420    their  100644
00000020: 6464 6335 3063 6535 3536 3437 6462 3134  ddc50ce55647db14
00000030: 3231 6231 3861 6133 3334 3137 3434 3265  21b18aa33417442e
00000040: 3239 6636 3364 3266 2062 696e 6172 790a  29f63d2f binary.
00000050: 4040 202d 302c 3020 2b31 2040 400a 2b01  @@ -0,0 +1 @@.+.
00000060: 6164 6465 6420 696e 2062 6f74 680a 2020  added in both.
00000070: 6f75 7220 2020 2031 3030 3634 3420 6333  our    100644 c3
00000080: 3736 6438 3932 6538 6231 3035 6264 3731  76d892e8b105bd71
00000090: 3264 3036 6563 3531 3632 6235 6633 3163  2d06ec5162b5f31c
000000a0: 6539 3439 6333 2078 0a20 2074 6865 6972  e949c3 x.  their
000000b0: 2020 3130 3036 3434 2034 3563 6631 3431    100644 45cf141
000000c0: 6261 3637 6435 3932 3033 6630 3261 3534  ba67d59203f02a54
000000d0: 6630 3331 3632 6633 6663 6566 3537 3833  f03162f3fcef5783
000000e0: 3020 780a 4040 202d 3120 2b31 2c35 2040  0 x.@@ -1 +1,5 @
000000f0: 400a 2b3c 3c3c 3c3c 3c3c 202e 6f75 720a  @.+<<<<<<< .our.
00000100: 2072 6967 6874 0a2b 3d3d 3d3d 3d3d 3d0a   right.+=======.
00000110: 2b6c 6566 740a 2b3e 3e3e 3e3e 3e3e 202e  +left.+>>>>>>> .
00000120: 7468 6569 720a                           their.

Note that the "added in both" explanation appears to be part of the
diff for binary. The diff line should be '\1\0\1\n', but it is only
'\1', obviously suggesting a C string operation gone awry.

I haven't checked whether regular 'git diff' operations contain a
similar bug. (The NUL would have to be pretty far into the file, to
confuse the binary file detection heuristic, but that is possible.)

I don't see any particularly good work-arounds. Looking for all
possible explanations as a trigger to detect a malformed patch runs
into false positives with the explanation "merged", which occurs in
regular code.


2. Feature suggestion

Related to the bug, may I suggest a flag to omit unnecessary patches?
For "added in remote" and "deleted in remote", I don't actually need
the patch--I can grab the blob contents from the SHA myself if needed.
These cases need special handling anyway (to create/delete the file),
so the (often large) patch doesn't add much anyway. This would provide
a workaround for the bug.


3. Feature suggestion

There's no direct indication of whether any given file's merge
succeeded. Currently I sniff for merge conflicts by looking for
"+<<<<<<< .our", which feels like an ugly kludge. Could we provide an
explicit indicator? (And maybe also one for binary vs text
processing?)

Note that binary file merge conflicts don't generate patches with
three-way merge markers but instead say "warning: Cannot merge binary
files: binary (.our vs. .their)". Looking for this case even further
complicates the output parser.


4. API suggestion

Here's what I really want 'git merge-tree' to output. :)

If the merge had no conflicts, write the resulting tree to the object
database and give me its sha. I can always diff that tree against
branch1's tree if I want to see what has changed.

If the merge had conflicts, write the "as merged as possible" tree to
the object database and give me its sha, and then also give me the
three-way merge diff output for all conflicts, as a regular patch
against that tree, using full path names and shas. (Alternatively,
maybe better, give me a second sha for a tree containing all the
three-way merge diff patches applied, which I can diff against the
first tree to find the conflict patches.)

I'm not sure what to do about binary merge conflicts, since they
aren't representable with three-way markers. Maybe just list them,
with the two conflicting blob ids?



Thanks very much,
-josh
