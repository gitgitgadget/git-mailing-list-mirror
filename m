Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBAC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiFJOsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349163AbiFJOrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D842A07
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:30 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 123so14608900pgb.5
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gflyq7EOoQVeGLLM8PXlWuyszqP8mNnYSDXG4oZS4e4=;
        b=UG/hxqCMA/ZtfXkf6FU5R69Th710Um8XpYct8Amb/LMLEF7thwgoCEAC4AeSTMkJUm
         4cc4dYInDMgJjpTiujkMe+yjXl/7UWZGozeurzj6D6glLDo+ReVvQ+ONwY8O8RUzS1dd
         mMelVjg+h1lh+5cFRxCu0WPZhreAukO+VXQwbAUlaPRrgFB5ERZf6kpOkxNeeWXU2kXN
         mIst8BMw4ZmHkknc4c6oCMosv/hXgGzSDanW31+wcZwaVf3UJf+FK06B7MsFozz56KJ4
         ZVmYPR+XfC7FlPatKqeOL++4cH9bJ3c3XEEg4ZbebFlfwDNDiS/loYF2gvldlZ1fPvc4
         u0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gflyq7EOoQVeGLLM8PXlWuyszqP8mNnYSDXG4oZS4e4=;
        b=z6EYzU3u6z5AlNLqkya92H/nOncYj9HZvhQGTeEx/qjEXcCt3PZc1RKftz/DQgL7BG
         EXOaCI7wRMxyLyRoGibQ1dtT5jQx7ZfUHnXvXLJKkWKFoQAPZzYjueBB+6nC1jlT29C4
         zwczJ2JQbD2DoxrZVK/8/Xvm4ehQUBgQe7Nj+SbnBU0fobw+Eiz3HQAdcU0x2n7pZ484
         RCeT7CNx8HP0dcnKb4gHwNKVquk1KrmoDx/PBSqk+gxzmXoKzD2EGYG7gXvF/gK4pWBr
         xMRX4lXGwDqgyQ6pcjW4gdwW8n2MjcF80AfVCnuNKhdDdr25dXQ0x9rqnAEPU8lahWzi
         rpfQ==
X-Gm-Message-State: AOAM531rm5dkEj7zXwzCT/VhgIitG4mB2nqD1WPSMp3Q8dWAkdTSh8Eu
        Q0vv2Da9zmbRDwk9rWb6CAc=
X-Google-Smtp-Source: ABdhPJwr12IgTimp2RztbXxmU0OmM474skSnzd+fdCX1bVp1YT9aDvkwl1mLVpsk1aa5UuLyNBfHCA==
X-Received: by 2002:a63:5f0d:0:b0:3fd:7b18:bad8 with SMTP id t13-20020a635f0d000000b003fd7b18bad8mr28238598pgb.213.1654872449606;
        Fri, 10 Jun 2022 07:47:29 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:29 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     chiyutianyi@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v14 4/7] object-file.c: factor out deflate part of write_loose_object()
Date:   Fri, 10 Jun 2022 22:46:04 +0800
Message-Id: <7c73815f188f16bb91c9b4ad981d299330dd3424.1654871916.git.chiyutianyi@gmail.com>
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

Split out the part of write_loose_object() that deals with calling
git_deflate() into a utility function, a subsequent commit will
introduce another function that'll make use of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index f4d7f8c109..cfae54762e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2000,6 +2000,28 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 	return fd;
 }
 
+/**
+ * Common steps for the inner git_deflate() loop for writing loose
+ * objects. Returns what git_deflate() returns.
+ */
+static int write_loose_object_common(git_hash_ctx *c,
+				     git_zstream *stream, const int flush,
+				     unsigned char *in0, const int fd,
+				     unsigned char *compressed,
+				     const size_t compressed_len)
+{
+	int ret;
+
+	ret = git_deflate(stream, flush ? Z_FINISH : 0);
+	the_hash_algo->update_fn(c, in0, stream->next_in - in0);
+	if (write_buffer(fd, compressed, stream->next_out - compressed) < 0)
+		die(_("unable to write loose object file"));
+	stream->next_out = compressed;
+	stream->avail_out = compressed_len;
+
+	return ret;
+}
+
 /**
  * Common steps for loose object writers to end writing loose objects:
  *
@@ -2047,12 +2069,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
-		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
-		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die(_("unable to write loose object file"));
-		stream.next_out = compressed;
-		stream.avail_out = sizeof(compressed);
+
+		ret = write_loose_object_common(&c, &stream, 1, in0, fd,
+						compressed, sizeof(compressed));
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
-- 
2.36.1

