Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B68C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C7522BEA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 15:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgLUPCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 10:02:37 -0500
Received: from sebres.de ([5.181.51.239]:60380 "EHLO sebres.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLUPCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 10:02:36 -0500
X-Greylist: delayed 1069 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 10:02:35 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sebres.de;
         s=dkim; h=Message-ID:Reply-To:From:Date:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Subject:To:Sender:Cc:Content-ID:Content-Description
        :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VY53x/1b/x+P9enMcH6dZPon7FgDRPC8tTWeMPNVBRk=; b=S2pPS/BVCumY47aGcKgnJTI8xl
        1++5sk+S2DH3CTpE8rfgqbddTULtYDoJIK6uoor7u65n+1LKshHCWTOMUmy1x7eHIiVu+6ekh7qY/
        NjkEhw4evrwOSUc4BAn9nndKZSpL+Faaz9E01O+PNb3OV2x9p3ttEgo68sMp5aoNQZIb0JPT2uUFG
        jQ5OlAfpW+N/Qe3mcjFnZsXNPL92dH7jb6OlWHi0B3L2riL9bA2lR4C2eeouLa1sx8r8mksv5Tikj
        ED8yMXIcvsD1J4JxG0n5j2DaWvrCJWS7P3Yl1yj7VfNAxm4l+iHOJef/gQ/1GQ9dYE/2bioBAQiBi
        dcHEpOvA==;
To:     git@vger.kernel.org
Subject: git diff --ignore-space-change -- ignore whitespace prefers  unmodified next line to modified one in patch
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Dec 2020 15:43:59 +0100
From:   "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Reply-To: serg.brester@gmx.net
Mail-Reply-To: serg.brester@gmx.net
Message-ID: <8a6a45cbda00ae1f0f679daf62fba27c@sebres.de>
X-Sender: serg.brester@sebres.de
User-Agent: Webmail/1.0.3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce the issue:

  1. create two simple C files and diff both ignoring whitespaces:
```
printf "if (some_var1) {\n  do {\n    some-code\n  } while (1);\n}\n" > 
a.c
printf "if (some_var1) {\n  do {\n    if (some_var2) {\n      
some-code\n    }\n  } while (1);\n}\n" > b.c
git diff --ignore-space-change --no-index a.c b.c
```
     which would produce fully correct resulting patch:
```
diff --git a/a.c b/b.c
--- a/a.c
+++ b/b.c
@@ -1,5 +1,7 @@
  if (some_var1) {
    do {
+    if (some_var2) {
        some-code
+    }
    } while (1);
  }
```
     but this behavior will change if line 5 would be equal line 6 
(containing only brace ...).

  2. now we'll modify that a bit (e. g. use while instead of do, to make 
the lines more similar
     (containing only braces):
```
printf "if (some_var1) {\n  while (1) {\n    some-code\n  }\n}\n" > a.c
printf "if (some_var1) {\n  while (1) {\n    if (some_var2) {\n      
some-code\n    }\n  }\n}\n" > b.c
git diff --ignore-space-change --no-index a.c b.c
```
     which then would produce this result:
```
diff --git a/a.c b/b.c
--- a/a.c
+++ b/b.c
@@ -1,5 +1,7 @@
  if (some_var1) {
    while (1) {
+    if (some_var2) {
        some-code
      }
+  }
  }
```
     As one can see, a line 6 instead of line 5 is marked as new (thereby 
line 6 was **completely unmodified**).
     In my opinion correct would be this variant (also similar patch of 
test in step 1):
```
diff --git a/a.c b/b.c
--- a/a.c
+++ b/b.c
@@ -1,5 +1,7 @@
  if (some_var1) {
    while (1) {
+    if (some_var2) {
        some-code
+    }
    }
  }
```

I understand that using --ignore-space-change both lines are quasi 
"equal", and then first "change"
will be noticed as a new created line, but from point of view of the 
developer (and common sense)
it is very strange either, especially if one considers that whole code 
starting from line 6 is totally unmodified.

This causes that on some much complex nested blocks, this simple "first 
wins" logic (without a simple look-ahead),
confuses still more (because affects several unmodified blocks, braces 
etc), especially if some
conflicts should be resolved or a 3-way merge/review takes place.

This makes the usage of option "--ignore-space-change" pretty pointless, 
because the diff of larger nested blocks
is often error prune on braces, brackets etc, so the review is often 
needless complicated.


[System Info]
git version:
git version 2.28.0.windows.1
cpu: x86_64
built from commit: 77982caf269b7ee713a76da2bcf260c34d3bf7a7
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 18363
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>

-- 

Regards,
Sergey Brester

