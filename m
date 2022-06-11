Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DC3C43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 02:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349559AbiFKCoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347920AbiFKCou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 22:44:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627F03F5747
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 187so987195pfu.9
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIVqbTk5XIFI0jQWEt/RmRrC1Esc+UsR1LRB41yEoOk=;
        b=SuoznkmBOsDLy8fM82DQoAebSI18aR1wQwWJ33Ah024P1SjFt+eqvgGFN2dKrP4cbe
         k0ItUQVptx+C9Qj8+w2ANGbpSYHsmVww+dI8cNKau0e2PtOkLyvpw0CFWvRQAWHqEVV8
         Xd2+cifQiyzxya31Wbp6HXRT6SMiNMrjFxU8F0v1fmIEmrPGtr6xi8n2PipegnR0vD5z
         KXv5FU1YJR/KvbgKNLOxX2MD2h2rBbQ+aBDvu7xhrumZdpG9txJJK7V/viP5hqEYyQfY
         s3kWSpzD/hhuB/FfxLJSemmQTqgggWIH5PQ1YZ7HeGgYUOUqXe4ci/nbSlUdGvVeCt/m
         UEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIVqbTk5XIFI0jQWEt/RmRrC1Esc+UsR1LRB41yEoOk=;
        b=SvGdkKpQyC4A5D254AfYNeqLxg0vUCV0/7A3qPLB4nns56CPKiLi8G+3GJBXRBI9uw
         CPSMCI1ae3Fe1NqyAXKcaxO70OwGrPuijOcm0alnr+LqMcdA+WHX4l0o7e0t578r4lW1
         i4USyAKpIOZlxi1ve+zSWPgb7vKHf0mmi5oIqIRymv/A1x8XUNnzzOCxKd5B3Dv4yNqp
         Q5PQCvIS+JSnsVuNLW65KIgn0WIngbMApj5VrGRuKyHJZq5sf3mS0Ue6l+JO/UbJCvTu
         6LQ9yNBEWNhLIiQbFnwUHw2RfUfBBBrom4YBuJLmApRbtwY0uMzhdsPr9kdRzSWl8Bzv
         yRJw==
X-Gm-Message-State: AOAM533PHmYi70vC8NriEPds1werUwHw1ilJ101GiFZKpbbACc8V1qx/
        fF5MmFHLXGRLkKDt+wpXYVc=
X-Google-Smtp-Source: ABdhPJw6HF4PzZdvsFxIYFH/NAJHpr3SsGUrBRlCeosD0gi2dxtKHkZBv1IaNtYYs/9dE/yQz3KX6Q==
X-Received: by 2002:a63:f0d:0:b0:401:9819:c6ee with SMTP id e13-20020a630f0d000000b004019819c6eemr9694566pgl.450.1654915488917;
        Fri, 10 Jun 2022 19:44:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:80c:ca60:6957:cd88:1852:9438])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0051ba90d55acsm257077pff.207.2022.06.10.19.44.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 19:44:48 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     chiyutianyi@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v15 3/6] object-file.c: factor out deflate part of write_loose_object()
Date:   Sat, 11 Jun 2022 10:44:18 +0800
Message-Id: <0ddf912d479eeda47c47e6b770816831aed4ebdb.1654914555.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654914555.git.chiyutianyi@gmail.com>
References: <cover.1654871915.git.chiyutianyi@gmail.com> <cover.1654914555.git.chiyutianyi@gmail.com>
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
index b5bce03274..18dbf2a4e4 100644
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

