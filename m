Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B36C201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbdBYBTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:19:20 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35357 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdBYBTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:19:14 -0500
Received: by mail-pg0-f45.google.com with SMTP id b129so17994037pgc.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 17:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eZSgNmY39SMHTh+z8/hK38AVubKYfr4yrUsrixFr5FE=;
        b=pmC6GJ9pDfJuIU9W+OuOGBgobIbAhScaOWPZfqrR7k0Jp5OuUYRtrg3AL46EY7UIdu
         dy8SnXhcPebGCtyAoqGcVBC9ctwoRDwO7ZMEjwgThKunrja4qc2ewV+AjxoKfNfSVdpf
         JmnattaFpKtZKcxCHgdgm6dP09AwkmLE2QgpLRK8yR471hrMcWWnBEL/sShXYkrMkxXU
         blvd/s2QAxxCySlLh7f4E+LZWT5iND9oA5JEHkyiBJVtOgPYFPqjvHZMlMaBFrjG0OCw
         CZHMo97G2yTAaGN8gMUo5SfhDe5IV6OZR+iMY05lVZehCfOi9E8RXZrQN4QJceQkHjYY
         ab3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eZSgNmY39SMHTh+z8/hK38AVubKYfr4yrUsrixFr5FE=;
        b=HPEQ5QlgIcWnVv14Q+PVGOmUNGjHuA10PodgZKaG37N9c3SUSvDjv0iMdU9M+EZ7fL
         YEF1O5nOIYgL5AsSybD+rj+FaURj7QdTT6xHwHSvLQKfzrFPiwh3KAJcXDCVGkYcgk9y
         c7eXtS6N1/naElqNBIaNplS1sEP9msyi8ZlkacjKCXKr0kozABXs8Q+mr0N7NUwpNw+7
         04OwE8LxTJ1WS+3ZTfXLeJVzrL72qB7AMjPHVhLVbyfmT3o/erBiGSr0bAcM6qG9qH3X
         i0k24ZVOLtY+P2tBp3Zl9BvmpNYgIvfam19GKrmf6f5yNpaAmGe87lZSX7VGhKWsjF57
         r26Q==
X-Gm-Message-State: AMke39m1Wju8KAiol6KDq8GB6GJP1QAr/z+xESe7I2A16CCsrEsQIcjQDrNKoqND0MGqeD42
X-Received: by 10.98.74.84 with SMTP id x81mr7153668pfa.172.1487985525214;
        Fri, 24 Feb 2017 17:18:45 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id 67sm17082280pfd.120.2017.02.24.17.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 17:18:44 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, peartben@gmail.com, benpeart@microsoft.com
Subject: [PATCH 3/3] upload-pack: compute blob reachability correctly
Date:   Fri, 24 Feb 2017 17:18:38 -0800
Message-Id: <0d36e20e3c35c5c60fcf451c8f810fcbfbdd004c.1487984670.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1487984670.git.jonathantanmy@google.com>
References: <cover.1487984670.git.jonathantanmy@google.com>
In-Reply-To: <cover.1487984670.git.jonathantanmy@google.com>
References: <cover.1487984670.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If allowreachablesha1inwant is set, upload-pack will provide a blob to a
user, provided its hash, regardless of whether the blob is reachable or
not. Teach upload-pack to compute reachability correctly by passing the
"--objects" argument when it invokes "rev-list" if necessary.

This commit only affects the case where blob/tree hashes are provided to
upload-pack; the more typical case of only commit/tag hashes being
provided is not affected. In the case where blob/tree hashes are
provided, the reachability check is now slower (since trees need to be
read) but correct. (The user may still set allowanysha1inwant instead of
allowreachablesha1inwant to opt-out of the reachability check.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
 upload-pack.c         | 15 +++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 505e1b4a7..a4ae888ff 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,6 +547,36 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
 
+test_expect_success 'setup for tests that fetch blobs by hash' '
+	git init blobserver &&
+	test_commit -C blobserver 1 &&
+	test_commit -C blobserver 2 &&
+	test_commit -C blobserver 3 &&
+	blob1=$(echo 1 | git hash-object --stdin) &&
+	blob2=$(echo 2 | git hash-object --stdin) &&
+	blob3=$(echo 3 | git hash-object --stdin) &&
+
+	unreachable=$(echo 4 | git -C blobserver hash-object -w --stdin) &&
+	git -C blobserver cat-file -e "$unreachable"
+'
+
+test_expect_success 'fetch-pack can fetch reachable blobs by hash' '
+	test_config -C blobserver uploadpack.allowreachablesha1inwant 1 &&
+
+	git init reachabletest &&
+	git -C reachabletest fetch-pack ../blobserver "$blob1" "$blob2" &&
+	git -C reachabletest cat-file -e "$blob1" &&
+	git -C reachabletest cat-file -e "$blob2" &&
+	test_must_fail git -C reachabletest cat-file -e "$blob3"
+'
+
+test_expect_success 'fetch-pack cannot fetch unreachable blobs' '
+	test_config -C blobserver uploadpack.allowreachablesha1inwant 1 &&
+
+	git init unreachabletest &&
+	test_must_fail git -C unreachabletest fetch-pack ../blobserver "$blob1" "$unreachable"
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
diff --git a/upload-pack.c b/upload-pack.c
index 7597ba340..f05cc2b5e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -471,6 +471,9 @@ static int do_reachable_revlist(struct child_process *cmd,
 	static const char *argv[] = {
 		"rev-list", "--stdin", NULL,
 	};
+	static const char *argv_with_objects[] = {
+		"rev-list", "--objects", "--stdin", NULL,
+	};
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
@@ -488,6 +491,18 @@ static int do_reachable_revlist(struct child_process *cmd,
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 
+	/*
+	 * If we are testing reachability of a tree or blob, rev-list needs to
+	 * operate more granularly.
+	 */
+	for (i = 0; i < src->nr; i++) {
+		o = src->objects[i].item;
+		if (o->type == OBJ_TREE || o->type == OBJ_BLOB) {
+			cmd->argv = argv_with_objects;
+			break;
+		}
+	}
+
 	if (start_command(cmd))
 		goto error;
 
-- 
2.11.0.483.g087da7b7c-goog

