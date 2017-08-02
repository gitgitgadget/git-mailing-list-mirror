Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CF720899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbdHBTtb (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:31 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35820 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBTt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id v189so25054673pgd.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W7HJ+v5OwIluzocOQGelVPNuyp5uJihOUporxUOInW0=;
        b=fKXcobjse064/Vrgv10UF4UJ9ibeIWNMZKDmZfyXiPqHUJWWyHihttAQsobxAcJ3Pv
         L8dPaaYsFZEUfbFzQFTIYNNfdNJXF6NfJPB5wYJbA5DQ2YPd0EdnPmCJJvcsTNA60Jfx
         xxa+F5VXbb6JjH3ScxWJn3ku98BgZQ9SAOk6wnBVG4nD0TwNvi8SKPUMTeidUA07be0n
         4ZEXlJ5OjgoHMb0xuqEOENk6kXBOqWiHHsB/3tBtDFRF6P80mAnouBsLoFb+iU3ALeQB
         cCq7F7v/4f9Q2NsWaBV5ssxN6TauLnpVBdKERw+QzvILguY1pVQI/0K/0pqiTitGTwoC
         RO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W7HJ+v5OwIluzocOQGelVPNuyp5uJihOUporxUOInW0=;
        b=MbYT09xxtVOLEIpm1pB1irqnhVpqzV97JkAtyg099lLq+px/rBHYfItgyEebKv9i6R
         gXD5g1QaDTYSovNbEEV4vxWbx9o7qDGljjSTGqzSTc4msUYNIALn6P2ZZcYkevaXsFfy
         7uzQ1B0bkBf1cLIDJDlXpJrmnzNBs27guTVbYZO1lN6eUeXnkH5HvV2gSJ9oMX4iL6Bv
         PrmUW2dxZpqY1UEZ73RssgDweQ5n5rt8RdDcM0+2qrgYFVuBtjSLiKYMoNGzvzIkMAse
         pEA+XTbV37TQohWjn3j1VAAV5y+0wwXmXUSK1Lf1EcuicU2aJmZA86lZMkltCxjA3B1c
         JsgQ==
X-Gm-Message-State: AIVw112VQ0pPWZd2IFHIE7IJygv99D/UB+oyuLEZVMCh4tMPCQGl7LnH
        YkFXfql/JuY2roaHriu7SQ==
X-Received: by 10.84.177.36 with SMTP id w33mr26789445plb.302.1501703368945;
        Wed, 02 Aug 2017 12:49:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 01/10] repo_read_index: don't discard the index
Date:   Wed,  2 Aug 2017 12:49:14 -0700
Message-Id: <20170802194923.88239-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have 'repo_read_index()' behave more like the other read_index family of
functions and don't discard the index if it has already been populated
and instead rely on the quick return of read_index_from which has:

  /* istate->initialized covers both .git/index and .git/sharedindex.xxx */
  if (istate->initialized)
    return istate->cache_nr;

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 2 --
 repository.h | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/repository.c b/repository.c
index edca90740..8e60af1d5 100644
--- a/repository.c
+++ b/repository.c
@@ -235,8 +235,6 @@ int repo_read_index(struct repository *repo)
 {
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
-	else
-		discard_index(repo->index);
 
 	return read_index_from(repo->index, repo->index_file);
 }
diff --git a/repository.h b/repository.h
index 417787f3e..7f5e24a0a 100644
--- a/repository.h
+++ b/repository.h
@@ -92,6 +92,14 @@ extern int repo_submodule_init(struct repository *submodule,
 			       const char *path);
 extern void repo_clear(struct repository *repo);
 
+/*
+ * Populates the repository's index from its index_file, an index struct will
+ * be allocated if needed.
+ *
+ * Return the number of index entries in the populated index or a value less
+ * than zero if an error occured.  If the repository's index has already been
+ * populated then the number of entries will simply be returned.
+ */
 extern int repo_read_index(struct repository *repo);
 
 #endif /* REPOSITORY_H */
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

