Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1B3CCA47C
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349675AbiFJOrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiFJOrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C923F328
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 15so24060974pfy.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jF2cS0KnZJI7MMdTZgCLRxpV1DUxHxTlX2Y8bFHi2uc=;
        b=YF3hN8DhBSLUGd/0dQ9MOBDslj9Vhuo3Qm5MU1vLuh0jh7sbE4G1kA0LSdF2vcMB03
         KDGydFxXpVYHRsqSn0iumD+iQDtdwGOmRzXTUlYskHLxvDDiWJORmE+gpN+D52s1Wqhs
         czhRbFuMgsQkg81u9NSWTlygd5OqJuRp8EFICmlxbCx9UQ8KBabVLE1nrWclOnQOmd4k
         XepCXPHlHUs/1sx4q3E9ANp5ClAQINZs1wezfmEz4mT+SqMiuAhbNArr3Uy+9rj7eveG
         tV8bUUGfm8x2bRJ1Y4NbRRJ6AsmHRvIT0dYgBhwgXuYzJrHQJKra2GwqTBhrtCY09dB1
         AJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jF2cS0KnZJI7MMdTZgCLRxpV1DUxHxTlX2Y8bFHi2uc=;
        b=Cbi7eQt/VPnneIJQrP7ceeqwIerNn3unD6x8PB0e7uuNhyuhXTVMr01f0RGSPzovJM
         3BVm2ray68n2WqBlt9SsHTHx6M6Oxi+GNnoqxUdtRcWsIFRlHfrli6uFQuzqVpfIORkZ
         DPQN3vyXjZsQ5EhXIbCcVbULI1D7xdcUokM+kzk++FWyIFnXSeuk8+Tq+3MBTchWHjuO
         jgLcid+dKWtAk6PmWhQ3/zRx1Xck1+xSbJ1oAsd8XrmR0CEsRrzCEaPkJESF7MRYcRAV
         bxyTJgaUPTL9qW3XqC3mWdBeX2ZXVhHtyaLH1g9dzMGe6Vo59oezZdI7WRgSQZs+rgBa
         lS2A==
X-Gm-Message-State: AOAM531q7ItCSVa3izXXiwWcHgtiJQ5lTKz8iWJ+CLgifF4j4Fwlrj6A
        7kQ1OztCZxF83eZeXlH3qt8=
X-Google-Smtp-Source: ABdhPJwITL8JoiLlHl7Aps9/ig3FttT6EtKsULHiVju0RhZ/2/0PUGDntv5YbSVySbVvQM+CI7svnw==
X-Received: by 2002:a65:6045:0:b0:399:3a5e:e25a with SMTP id a5-20020a656045000000b003993a5ee25amr39157502pgp.139.1654872438825;
        Fri, 10 Jun 2022 07:47:18 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:18 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     chiyutianyi@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v14 2/7] object-file.c: do fsync() and close() before post-write die()
Date:   Fri, 10 Jun 2022 22:46:02 +0800
Message-Id: <a327f484f7f7466597930e87686e7156beabdc45.1654871916.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654871915.git.chiyutianyi@gmail.com>
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com> <cover.1654871915.git.chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change write_loose_object() to do an fsync() and close() before the
oideq() sanity check at the end. This change re-joins code that was
split up by the die() sanity check added in 748af44c63e (sha1_file: be
paranoid when creating loose objects, 2010-02-21).

I don't think that this change matters in itself, if we called die()
it was possible that our data wouldn't fully make it to disk, but in
any case we were writing data that we'd consider corrupted. It's
possible that a subsequent "git fsck" will be less confused now.

The real reason to make this change is that in a subsequent commit
we'll split this code in write_loose_object() into a utility function,
all its callers will want the preceding sanity checks, but not the
"oideq" check. By moving the close_loose_object() earlier it'll be
easier to reason about the introduction of the utility function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 79eb8339b6..e4a83012ba 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2012,12 +2012,12 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
+	close_loose_object(fd, tmp_file.buf);
+
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd, tmp_file.buf);
-
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
-- 
2.36.1

