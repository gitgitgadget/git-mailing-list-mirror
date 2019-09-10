Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB281F463
	for <e@80x24.org>; Tue, 10 Sep 2019 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfIJMNa (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 08:13:30 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:41447 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbfIJMNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 08:13:30 -0400
Received: by mail-qt1-f178.google.com with SMTP id j10so20341290qtp.8
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=rTY5V8MBbnEkSTCnb1hCG54jtEYdh5ARinssynTftR4=;
        b=REcCOjvPnJ5mkLJAfUYA+rovdBgG71g/3P9sIwHNn4U5nu8DjBlGBXY59HtUjfipV8
         snkH6tMZtyLzDw7jx6bdkm6hXOcoe6NVubaMAhdnVqnbAgArh9nQWatuekB46ZHf2ICA
         740Xlqo2r5b7bI1GQoheQxXFh3m5Ivc3V5+60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=rTY5V8MBbnEkSTCnb1hCG54jtEYdh5ARinssynTftR4=;
        b=kjgddBPNBbXyBpjoO6+EwEd+SH+W6pWmXJTU788+A4HsivLEz+IcpyUei0SbzdMVB9
         zZlRqlrHSDTS/MaRVjP9vGUvHj1GLzS2Vtjd/r1uvX/c7HOh/q8PA6ttlNBKoJwCpzs5
         M5FmeYx0puuESst4nnJ6YiEvgKMLJVmcMEFA8O1Lgy/xaz4oarpohzTfKCAAp+eh6b1e
         teMEAx6/hgU6Jfys5uftQSLYhvTiTJLK6l42O+c2Tdz6iIy3VvrmBi8tbUsAiFkB0o3k
         jmNMGwiZ1lm2TA4HQP/gj6gPH6bUBinTQEFTChinAAy78oXOz6EOqFx+fYmVKrK8GGnq
         jF/A==
X-Gm-Message-State: APjAAAXENJKV+dr9fOSg8LgH7cKPw4uOoYB630ZVpdbwDC8Mspj+cvpq
        pLYIL44d3LJx3zrTEzPAmFx626m2ZKQngJMC
X-Google-Smtp-Source: APXvYqy9Y3OQQLl7m7M6bd0r1X6/omAgXuRplw970tfmxcTNrwSR6yo1bs3K8mN1kwLyMARtilg0Kg==
X-Received: by 2002:ac8:13c2:: with SMTP id i2mr27545711qtj.211.1568117608537;
        Tue, 10 Sep 2019 05:13:28 -0700 (PDT)
Received: from pure.paranoia.local ([87.101.92.157])
        by smtp.gmail.com with ESMTPSA id y58sm3719864qta.1.2019.09.10.05.13.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 05:13:27 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:13:24 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: RFC: Cryptographic attestation for email-based patch workflows
Message-ID: <20190910121324.GA6867@pure.paranoia.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, all:

This is a very "raw" idea that stems from a handful of conversations
that took place at the Kernel Summit. I wanted to pass it along to this
list in hopes that it can generate some workable ideas (or shot down and
allowed to die early).

# Problem

One of the recurring concerns raised by kernel developers is the fact
that email-based patch workflow offers no git-native mechanism of
cryptographic integrity attestation. In other words, the only mechanism
for someone to verify that patch contents have not been altered is
via PGP-signed email. For a slew of reasons, this is not a sufficiently
good solution:

- PGP support in mail clients continues to be sub-par
- Patch archival and management tools (like patchwork) remove easy
  ability to verify PGP signatures because they need to modify email
  bodies (but not patch content), e.g. to add Reviewed-By: or similar
  taglines
- Tools like git-am have no native support for verifying PGP signatures

# Proposed approach

I recommend that we provide a way to include cryptographic signature
information natively using git-format-patch, using roughly the following
process:

- generate a signify-compatible cryptographic signature of the verbatim
  patch content, perhaps slightly normalized for things like LF vs. CRLF
  line endings (see minisign/libsodium for crypto details)
- include both the signature and the public key in the area below '---',
  using "Minisig:" and "Minikey:" taglines

For example:

---8<---
From b41a2a0f817caddc9a76f43c3c9ed7d8edd6b2de Mon Sep 17 00:00:00 2001
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Tue, 10 Sep 2019 06:15:36 -0400
Subject: [PATCH] Second commit

Change the greeting.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 foo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Minisig: RWT9fcUvSnHPLiqWgXEnn98sgk8nl4FteDRkD+9lVK+He//eLOxNZ5QjCROoKJgPGpL4uzoHicN+f6gB54qmtO1cQtfvjS+++QU=
 Minikey: RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q

diff --git a/foo.c b/foo.c
index d40a2b9..dcfad55 100644
--- a/foo.c
+++ b/foo.c
@@ -1,5 +1,5 @@
 #include <stdio.h>
 int main()
 {
-    printf("Hello, World!");
+    printf("Hello, Signed World!");
 }
--ᐞ
2.21.0
---8<---

When git-am encounters a signed patch, it should:

1. check if the email in From: matches existing entries in git's TOFU
   (trust on first use) database, which is a simple key-value store
   like:

   konstantin@linuxfoundation.org: RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q

2. if no matches, add a new entry to the TOFU tracking database and
   consider the key automatically trusted (perhaps configurable)
3. if there are existing matches:

   a. compare the keys to make sure they haven't changed
   b. if keys changed, emit a warning and let developer decide if they
      trust the key change
   c. if keys did not change, validate the signature
   d. if validation failed, alert the developer and error out

4. if the TOFU db exists at all, git-am should check if the email
   address in From: matches any existing records and alert if the patch
   carries no signature (in case it's been removed by a malicious
   attacker).

All of these operations should be sufficiently fast, since both ECC
crypto and key-value lookups are fast operations that don't require a
lot of resources.

# Why minisigs?

In my experience, the kinds of developers who submit patches to mailing
lists would consider PGP/GnuPG too cumbersome to bootstrap, which is why I
lean towards managing keys natively by git. In my mind, the process
would go like this:

- developer sends patches to the mailing list
- maintainer responds with "looks good, but please sign and resubmit
  by passing --minisign to git-format-patch"
- developer runs `git format-patch --minisign`, which walks them through
  generating the key and storing it in a dedicated file
- git can take care of passphrase handling by hooking into
  credential-helper and credential-cache routines

# Coupling with PGP

Communities relying on the PGP web of trust can tie minikeys with their
PGP identity by creating a UID entry containing their minisign public key,
e.g.:

pub   rsa4096/E63EDCA9329DD07E 2011-11-07 [SC]
      DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
uid                 [ultimate] Konstantin Ryabitsev <konstantin@linuxfoundation.org>
uid                 [ultimate] Konstantin Ryabitsev <RWT9fcUvSnHPLqqyfLbkGBMEscBWciFFp2iBj2XnZPzW69OVIoYwZ25q>

Such UIDs can be revoked as necessary and new ones can be created --
plus they are searchable using standard gnupg/keyserver tools.

# Comments?

I'd love to hear your feedback on the idea. Even if this scheme is not
used by maintainers directly, it offers ways of verifying if patches
stored in public archives (such as public-inbox) have been modified and
provides some developer attestation of email-based workflows.

-K
