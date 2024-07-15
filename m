Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764494C62
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003783; cv=none; b=nQ5IH/THxmBxize46Ycd3lUz2JO8UYgp7vwBk+dIYpTv0jUqMU0v9H//h0xFEz5wUSn8/ITnGR9YUQz92QCA0OoASzDfxI+bc0Zy7RLkztaY50bHfRKqPhech8sjCuGsfM2IdxRs0kBF50jlzzJYlDMbvN+0/tbsZb9HCmlPJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003783; c=relaxed/simple;
	bh=kFW1zCBR8NfwsOKyKBr5hnsC3QkrlJ9a7h03TapSl20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssjBngXvk/vqsZlrlGhzYLIHnBd/ie6fTOk/T3svjyYrO8FDa5NQCNYMchAwV9LvD+BJPYqAMId9XbKELtQ8/6hVRBVJf4/ZTU0ZzyrATPkcRdhHMLkoA2Gv5cz9XI6+dxZ1macPxhOV5zziEiRnaoYgR9Ch/SUxXVhSFR5Xb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=T6+gu/kU; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="T6+gu/kU"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3821F5BA;
	Mon, 15 Jul 2024 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003721;
	bh=kFW1zCBR8NfwsOKyKBr5hnsC3QkrlJ9a7h03TapSl20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6+gu/kUfDCrJwpGmIFU5mRsL7Iir86/xxiMxXToTNwC9EmuOMlVGPKuIcRVLvtUX
	 CDmfEy5D7Dgrl+pwnMaB+AKvuIJJbNe0w7k2J+8QkyainIoptnhPRPiBpsIyppzWWS
	 TO3LOwWFb38qDB2Ad+D1m3ogH62HLUlPLIWIW8+g=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 08/10] cat-file: batch-command uses content_limit
Date: Mon, 15 Jul 2024 00:35:17 +0000
Message-ID: <20240715003519.2671385-9-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with the normal `--batch' mode, we can use the content_limit
round trip optimization to avoid a redundant lookup.  The only
tricky thing here is we need to enable/disable setting the
object_info.contentp field depending on whether we hit an `info'
or `contents' command.

t1006 is updated to ensure we can switch back and forth between
`info' and `contents' commands without problems.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c  |  5 ++++-
 t/t1006-cat-file.sh | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0752ff7a74..c4c28236db 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -666,6 +666,7 @@ static void parse_cmd_contents(struct batch_options *opt,
 			     struct expand_data *data)
 {
 	opt->batch_mode = BATCH_MODE_CONTENTS;
+	data->info.contentp = &data->content;
 	batch_one_object(line, output, opt, data);
 }
 
@@ -675,6 +676,7 @@ static void parse_cmd_info(struct batch_options *opt,
 			   struct expand_data *data)
 {
 	opt->batch_mode = BATCH_MODE_INFO;
+	data->info.contentp = NULL;
 	batch_one_object(line, output, opt, data);
 }
 
@@ -816,7 +818,8 @@ static int batch_objects(struct batch_options *opt)
 	 * Likewise, grab the content in the initial request if it's small
 	 * and we're not planning to filter it.
 	 */
-	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
+	if ((opt->batch_mode == BATCH_MODE_CONTENTS) ||
+			(opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH)) {
 		data.info.typep = &data.type;
 		if (!opt->transform_mode) {
 			data.info.sizep = &data.size;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..841e8567e9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -622,20 +622,33 @@ test_expect_success 'confirm that neither loose blob is a delta' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup delta base tests' '
+	foo="$(git rev-parse HEAD:foo)" &&
+	foo_plus="$(git rev-parse HEAD:foo-plus)" &&
+	git repack -ad
+'
+
 # To avoid relying too much on the current delta heuristics,
 # we will check only that one of the two objects is a delta
 # against the other, but not the order. We can do so by just
 # asking for the base of both, and checking whether either
 # oid appears in the output.
 test_expect_success '%(deltabase) reports packed delta bases' '
-	git repack -ad &&
 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
 	{
-		grep "$(git rev-parse HEAD:foo)" actual ||
-		grep "$(git rev-parse HEAD:foo-plus)" actual
+		grep "$foo" actual || grep "$foo_plus" actual
 	}
 '
 
+test_expect_success 'delta base direct cache use succeeds w/o asserting' '
+	commands="info $foo
+info $foo_plus
+contents $foo_plus
+contents $foo" &&
+	echo "$commands" >in &&
+	git cat-file --batch-command <in >out
+'
+
 test_expect_success 'setup bogus data' '
 	bogus_short_type="bogus" &&
 	bogus_short_content="bogus" &&
