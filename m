Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E82E202D7
	for <e@80x24.org>; Sun,  5 Mar 2017 23:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdCEXmq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 18:42:46 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34787 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdCEXmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 18:42:45 -0500
Received: by mail-lf0-f68.google.com with SMTP id y193so10417919lfd.1
        for <git@vger.kernel.org>; Sun, 05 Mar 2017 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=laszlo.nu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+Gu3IYM+3WjTVLZ8xb1fALJXR3gk2C2RJY2BrMMCtQ=;
        b=X3LlAJdL/U8QQz4dJrXR1Oxw8O4TMQmJUhP0xhQFaGcCm85otO1JTY6jSz8gqYknjC
         etmSlQ5/PVWaN/Iir1JGYyMvwxX7CK3OGGUV6UQNGGugP8bblCUJBQVxyF1f/NOY7uHe
         RzW5UJNXK3qyzJihyctoiIxlPqXcV4kESXKO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+Gu3IYM+3WjTVLZ8xb1fALJXR3gk2C2RJY2BrMMCtQ=;
        b=XcJI6PATgbhnxHQNfHAEJMt0eobYXJt9qUr5jIduk9x/jK7fysoLEbuT1E8zKk6QCM
         If9Cay6jhw8Xc+brPXrnf81ULJDQfqC0kDs6mEku4lgGowmvvpa2X7LNSwtn7NazZ0cl
         BITyPtknUD4cQfoJXd/dbYRWCV4sPduYjuzCmcBKg7X1vkjRUt1HROSM7xHS4IEPehW2
         HBLnG/nbJXmuPylTZE3XZAdHHII4CMYiwgLhB8uhhHkwpScVA4MyAvlWTtzmI/vJnTvH
         5PTLhZKVy6WirrmFU2PxD1uR+BYypDxjicVryGgAXv+tdtJby5JG9iZ2hpnriMXVy3/g
         G1Iw==
X-Gm-Message-State: AMke39mj2rMXa5nM7BHKGJpIqUgYrzK9It2E+mHbQDLaxNkKv2FQXYY5uWCQW0CZBYKDPQ==
X-Received: by 10.46.22.14 with SMTP id w14mr4527773ljd.18.1488757345545;
        Sun, 05 Mar 2017 15:42:25 -0800 (PST)
Received: from ion.zyxel.com (ua-85-228-69-197.cust.bredbandsbolaget.se. [85.228.69.197])
        by smtp.gmail.com with ESMTPSA id f188sm3751933lfe.12.2017.03.05.15.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2017 15:42:24 -0800 (PST)
From:   =?UTF-8?q?Andr=C3=A9=20Laszlo?= <andre@laszlo.nu>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Andr=C3=A9=20Laszlo?= <andre@laszlo.nu>
Subject: [PATCH] pull: do not segfault when HEAD refers to missing object file
Date:   Mon,  6 Mar 2017 00:42:22 +0100
Message-Id: <20170305234222.4590-1-andre@laszlo.nu>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git pull --rebase on a corrupted HEAD used to segfault; it has been
corrected to error out with a message. A test has also been added to
verify this fix.

Signed-off-by: André Laszlo <andre@laszlo.nu>
---

Notes:
    When add_head_to_pending fails to add a pending object, git pull
    --rebase segfaults. This can happen if HEAD is referring to a corrupt
    or missing object.
    
    I discovered this segfault on my machine after pulling a repo from
    GitHub, but I have been unable to reproduce the sequence of events
    that lead to the corrupted HEAD (I think it may have been caused by a
    lost network connection in my case).
    
    The following commands use add_head_to_pending:
    
    format-patch  setup_revisions before add_head_to_pending
    diff          checks rev.pending.nr
    shortlog      checks rev.pending.nr
    log           uses resolve_ref_unsafe
    
    All of the above return an error code of 128 and print "fatal: bad
    object HEAD" instead of segfaulting, which I think is correct
    behavior. The check and error message have been added to
    has_uncommitted_changes, where they were missing, as well as to
    diff-lib.c (without the error message).

 diff-lib.c      |  2 +-
 t/t5520-pull.sh | 12 ++++++++++++
 wt-status.c     |  5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 52447466b..9d26b18c3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -512,7 +512,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	struct object_array_entry *ent;
 
 	ent = revs->pending.objects;
-	if (diff_cache(revs, ent->item->oid.hash, ent->name, cached))
+	if (!ent || diff_cache(revs, ent->item->oid.hash, ent->name, cached))
 		exit(128);
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 17f4d0fe4..1edb6a97a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -664,4 +664,16 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull --rebase with corrupt HEAD does not segfault' '
+	mkdir corrupted &&
+	(cd corrupted &&
+	git init &&
+	echo one >file && git add file &&
+	git commit -m one &&
+	REV=$(git rev-parse HEAD) &&
+	rm -f .git/objects/${REV:0:2}/${REV:2} &&
+	test_expect_code 128 git pull --rebase > /dev/null
+	)
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index d47012048..3d60eaff5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2252,6 +2252,11 @@ int has_uncommitted_changes(int ignore_submodules)
 		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
+
+	/* The add_head_to_pending call might not have added anything. */
+	if (!rev_info.pending.nr)
+		die("bad object %s", "HEAD");
+
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
 	return diff_result_code(&rev_info.diffopt, result);
-- 
2.12.0

