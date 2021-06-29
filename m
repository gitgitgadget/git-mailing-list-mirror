Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4049C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8934261DB4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhF2UTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:19:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47944 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233801AbhF2UTs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 16:19:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F12D21F8C6;
        Tue, 29 Jun 2021 20:17:20 +0000 (UTC)
Date:   Tue, 29 Jun 2021 20:17:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 5/5] oidtree: a crit-bit tree for odb_loose_cache
Message-ID: <20210629201720.GA18039@dcvr>
References: <20210627024718.25383-1-e@80x24.org>
 <20210627024718.25383-6-e@80x24.org>
 <xmqqzgv8ybpg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgv8ybpg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > This saves 8K per `struct object_directory', meaning it saves
> > around 800MB in my case involving 100K alternates (half or more
> > of those alternates are unlikely to hold loose objects).
> >
> > This is implemented in two parts: a generic, allocation-free
> > `cbtree' and the `oidtree' wrapper on top of it.  The latter
> > provides allocation using alloc_state as a memory pool to
> > improve locality and reduce free(3) overhead.
> 
> This seems to break CI test, with "fatal: not a hexadecimal oid",
> perhaps because there is hardcoded 40 here?

Yes, I think this needs to be squashed in:
--------8<------
Subject: [PATCH] t0069: make oidtree test hash-agnostic

Tested with both:

make -C t t0069-oidtree.sh GIT_TEST_DEFAULT_HASH=sha1
make -C t t0069-oidtree.sh GIT_TEST_DEFAULT_HASH=sha256

Signed-off-by: Eric Wong <e@80x24.org>
---
 t/helper/test-oidtree.c | 14 ++++++++------
 t/t0069-oidtree.sh      |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 44bb2e7c29..e0da13eea3 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -13,6 +13,7 @@ int cmd__oidtree(int argc, const char **argv)
 	struct oidtree ot = OIDTREE_INIT;
 	struct strbuf line = STRBUF_INIT;
 	int nongit_ok;
+	int algo = GIT_HASH_UNKNOWN;
 
 	setup_git_directory_gently(&nongit_ok);
 
@@ -21,20 +22,21 @@ int cmd__oidtree(int argc, const char **argv)
 		struct object_id oid;
 
 		if (skip_prefix(line.buf, "insert ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
+			if (get_oid_hex_any(arg, &oid) == GIT_HASH_UNKNOWN)
+				die("insert not a hexadecimal oid: %s", arg);
+			algo = oid.algo;
 			oidtree_insert(&ot, &oid);
 		} else if (skip_prefix(line.buf, "contains ", &arg)) {
 			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
+				die("contains not a hexadecimal oid: %s", arg);
 			printf("%d\n", oidtree_contains(&ot, &oid));
 		} else if (skip_prefix(line.buf, "each ", &arg)) {
-			char buf[GIT_SHA1_HEXSZ  + 1] = { '0' };
+			char buf[GIT_MAX_HEXSZ + 1] = { '0' };
 			memset(&oid, 0, sizeof(oid));
 			memcpy(buf, arg, strlen(arg));
-			buf[GIT_SHA1_HEXSZ] = 0;
+			buf[hash_algos[algo].hexsz] = 0;
 			get_oid_hex_any(buf, &oid);
-			oid.algo = GIT_HASH_SHA1;
+			oid.algo = algo;
 			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
 		} else if (!strcmp(line.buf, "destroy"))
 			oidtree_destroy(&ot);
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
index bb4229210c..0594f57c81 100755
--- a/t/t0069-oidtree.sh
+++ b/t/t0069-oidtree.sh
@@ -10,9 +10,9 @@ echoid () {
 	do
 		echo "$1"
 		shift
-	done | awk -v prefix="$prefix" '{
+	done | awk -v prefix="$prefix" -v ZERO_OID=$ZERO_OID '{
 		printf("%s%s", prefix, $0);
-		need = 40 - length($0);
+		need = length(ZERO_OID) - length($0);
 		for (i = 0; i < need; i++)
 			printf("0");
 		printf "\n";
