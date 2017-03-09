Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B713D20135
	for <e@80x24.org>; Thu,  9 Mar 2017 00:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbdCIAga (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 19:36:30 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33333 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753908AbdCIAg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 19:36:28 -0500
Received: by mail-pf0-f170.google.com with SMTP id w189so21318086pfb.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 16:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KSMq7w+wGc+7FIIR4THaqUi228ZVhxeTjhlfJo8FWJA=;
        b=afwmMYxSqElY1CFIxgRyWPVtiIbmcSSZ53TOe3Dg2DkyBWKHwbVwmRgPgnupRN/k25
         BX3CA9IGgsKfTjytdfcN/bShlw1USmm2aX42kJnQKOhp7OBdULS4/HsbqG+QWxKiP9Rq
         jfbr6XXdbPHPMcUJtu4yb8aZeQWiam4t9SCWcyWak/yJ63NIXo0y6Xl8LULd6yPFYXrR
         EIu8RZmEu/MjtHrD+gaFGD/b/vI5EhU+/4j/XATjo+nbByBjNoGgHaSGBtgYpYvtyjBI
         9ycMOrvAdjER7eNoCSIjVxYpySC0Qo+u7bJ8wPk3OiF2D9rnN5k9Mec6utQj693CITsd
         ovfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KSMq7w+wGc+7FIIR4THaqUi228ZVhxeTjhlfJo8FWJA=;
        b=Hr1zVPQFEYZwSCgwJK7gxi9U0Qz3XohagDom5sXIFrAQGPx8Pv72xFKqiQPvvagLAJ
         4oBxNIv1lYO8mnslVZU5aqynhRBuzIP1B1LDofZ14PsaNuCEw/l6HnqeK6f+dGATc+Jr
         6nXSBeJASmfO29jH5xZeYnbYc1IvW8T0M39ltJc3q4/huuN9Vm3OZyrunnzMoH/VRypq
         ReeW4tonP3oJ9BJ5FaB+Z/wO8vJTJhl7w+fUd6F6M1ZAM5iPdgh6nprV8LHEUzCgPq/g
         JW4DSjZVLGx/8whi5UZVvsjTxUAIOULun7hkxaZfEohBU3v6gPqiOQlMtmqfuPK0ZBme
         uasQ==
X-Gm-Message-State: AMke39n2vMmCZHMm7zwO+K5K6RXleX1lH0VXVcru6DouNcEiSO/yDquRV/j7WPehOsnSW9Nk
X-Received: by 10.98.27.204 with SMTP id b195mr10405046pfb.154.1489019755519;
        Wed, 08 Mar 2017 16:35:55 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id t5sm8315450pgb.36.2017.03.08.16.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 16:35:54 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com,
        markbt@efaref.net
Subject: More about blob reachability (while fetching arbitrary blobs)
Date:   Wed,  8 Mar 2017 16:35:47 -0800
Message-Id: <20170309003547.6930-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has been some talk about fetching blobs from repos with missing
objects [1] [2]. I took a further look at the issue of blob
reachability.

I have written earlier that there is a bug in rev-list when used to
compute reachability [3], but someone pointed me to bitmaps, and I found
out that "--use-bitmap-index" makes rev-list use an alternative code
path in the presence of a bitmap (whether fully covering or partially
covering the relevant objects), and that code doesn't contain that bug.
If reachability checks are desired, bitmaps are probably required for
performance anyway [4].

We should implement things so that users will be strongly recommended to
do one of the following:
 1) configure explicitly (instead of it being the default) the
    equivalent of allowanysha1inwant to disable reachability checks, or
 2) use a bitmap (and it is recommended to periodically repack).

(This strong recommendation is currently a requirement due to the fact
that the 3rd option, "do nothing", is not possible due to the bug in
rev-list described above.)

I have included a small patch (below) to do that for upload-pack. (For
the case of upload-pack, which until now does not really need to process
blob wants, a possible alternative is to forbid trees and blobs from
being processed by upload-pack at all.)

[1] <20170304191901.9622-1-markbt@efaref.net>
[2] <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
[3] <cover.1487984670.git.jonathantanmy@google.com>
[4] I checked, and got 0m0.281s for "time git rev-list --objects
    --use-bitmap-index HEAD^{tree} --not --all" on a fully repacked
    git.git. (Not sure whether that's OK performance.)

-- 8< --
Subject: [PATCH] upload-pack: forbid fetching unreachable blobs

If allowreachablesha1inwant is set, upload-pack will provide a blob to a
user, provided its hash, regardless of whether the blob is reachable or
not.

Partially fix this by (i) including the "--objects" argument, if
necessary, when invoking "rev-list", and (ii) including the
"--use-bitmap-index" argument.

(i) is so that rev-list operates on the correct granularity, depending
on the type of objects checked.

(ii) needs more explanation:

  Our invocation of "rev-list" is supposed to return `A - B`, where `A`
  is the set of all objects reachable from the objects that we want to
  check the reachability of, and `B` is the set of all objects reachable
  from any of our refs. If all our objects are reachable, then the
  resulting set is empty.  However, the non-bitmap-using part of the
  code wrongly excludes some trees and blobs from `B`, making the
  resulting set sometimes non-empty and thus wrongly concluding that an
  object is unreachable when it is, in fact, reachable.  (However, the
  error does not run the other way - an object will not be indicated as
  reachable when it is unreachable.)

  The "--use-bitmap-index" argument partially solves this problem by
  activating another code path when the serving repository has a bitmap.
  This other code path does not contain the bug described above.

("--use-bitmap-index" has other benefits besides correctness, but has
not yet been included likely because bitmaps were introduced in commit
fff4275 ("pack-bitmap: add support for bitmap indexes", 2013-12-21),
later than the last time this part of the code was touched in commit
051e400 ("helping smart-http/stateless-rpc fetch race", 2011-08-05)).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5500-fetch-pack.sh | 31 +++++++++++++++++++++++++++++++
 upload-pack.c         | 17 ++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 505e1b4a7..1568aed82 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,6 +547,37 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
 
+test_expect_success 'setup for tests that fetch blobs by hash' '
+	git init blobserver &&
+	test_commit -C blobserver 1 &&
+	git -C blobserver repack -a -d --write-bitmap-index &&
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
index 7597ba340..a00f0034c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -469,7 +469,10 @@ static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *reachable)
 {
 	static const char *argv[] = {
-		"rev-list", "--stdin", NULL,
+		"rev-list", "--use-bitmap-index", "--stdin", NULL,
+	};
+	static const char *argv_with_objects[] = {
+		"rev-list", "--use-bitmap-index", "--objects", "--stdin", NULL,
 	};
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
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
2.12.0.246.ga2ecc84866-goog

