Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA26C41513
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 20:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376384AbjJKUoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjJKUoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962290
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 13:44:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 045CD1C600;
        Wed, 11 Oct 2023 16:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=WAc5OcLCotCeGBb4B2ZMj8q8TX76IcCG00SQe6
        SHxMs=; b=P2OJ4C7sv0EwVjQLmxsxvgoKm5ILpTgXf7l4hyywGMUvfDRygK66bx
        LmCudlPBQiR7UR+UdjxAZV98wRfWxHZmvEogAvT4rc36mLVNcywUFz4a3XITNJ2C
        9JmhWkcn4ub/WHjeOPSZnXdjZ/VunP4MpdrVPX0eaM+/p8VrVNaBg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F08C01C5FF;
        Wed, 11 Oct 2023 16:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32FE71C5FE;
        Wed, 11 Oct 2023 16:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Erik Cervin Edin <erik@cervined.in>
Subject: [PATCH] stash: be careful what we store
In-Reply-To: <xmqqzg0pnmv5.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        11 Oct 2023 09:29:50 -0700")
References: <CA+JQ7M_effxh9BSOhF67N+rsvBVTULe0dWZzp-kq1yOiDq3+hQ@mail.gmail.com>
        <xmqqzg0pnmv5.fsf@gitster.g>
Date:   Wed, 11 Oct 2023 13:44:03 -0700
Message-ID: <xmqqbkd4lwj0.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAF25CBA-6876-11EE-923A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git stash store" is meant to store what "git stash create"
produces, as these two are implementation details of the end-user
facing "git stash save" command.  Even though it is clearly
documented as such, users would try silly things like "git stash
store HEAD" to render their stash unusable.

Worse yet, because "git stash drop" does not allow such a stash
entry to be removed, "git stash clear" would be the only way to
recover from such a mishap.  Reuse the logic that allows "drop" to
refrain from working on such a stash entry to teach "store" to avoid
storing an object that is not a stash entry in the first place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  > It may be just the matter of doing something silly like this.
  > Not even compile tested, but hopefully it is sufficient to
  > convey the idea.

  Now it is at least compile-tested.

 builtin/stash.c  | 6 ++++++
 t/t3903-stash.sh | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3a4f9fd566..8073ef4019 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -977,6 +977,12 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
 			  int quiet)
 {
+	struct stash_info info;
+	char revision[GIT_MAX_HEXSZ];
+
+	oid_to_hex_r(revision, w_commit);
+	assert_stash_like(&info, revision);
+
 	if (!stash_msg)
 		stash_msg = "Created via \"git stash store\".";
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 376cc8f4ab..35c8569aea 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -931,6 +931,10 @@ test_expect_success 'store called with invalid commit' '
 	test_must_fail git stash store foo
 '
 
+test_expect_success 'store called with non-stash commit' '
+	test_must_fail git stash store HEAD
+'
+
 test_expect_success 'store updates stash ref and reflog' '
 	git stash clear &&
 	git reset --hard &&
-- 
2.42.0-345-gaab89be2eb

