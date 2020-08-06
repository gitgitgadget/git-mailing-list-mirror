Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D9C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B78E221E5
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZNu4EeYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFVBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:01:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52687 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgHFVBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 17:01:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E32AE83DD;
        Thu,  6 Aug 2020 17:00:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Np6pKtIUdV/uHFFBFXI5NNIxDtE=; b=ZNu4Ee
        Ywd7UZn8QYTGoDlNXiixotwr0knFyVYANyxn7JztpNXNeoxjhGYBvpse3zvmpZdI
        rsm41pAIFijUaFh01DfcYDDt5EW1AcDXOJjXx/52bYiEttew5992IqO6n6te3PSu
        8TyWU96My51nDVQ1EnE7IA1nAljJPRVckamxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FM/czciTs4qONhEK5m6HHhVzi14U+25R
        KNIJK2cWFL97zw/ZP/DqflFy/e5WM2fWQ9OR9PtR2Z4fK1+JnvPomctlXpowG7GD
        ZP735Sv6ajNhJ8f031vHqkzaQ3coZDvOERoZGIX6VHEgZVdPoLsz93LZdXPEYwvs
        U2iLwNbCSHA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 767C8E83DC;
        Thu,  6 Aug 2020 17:00:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD1BDE83D9;
        Thu,  6 Aug 2020 17:00:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/3] apply: make i-t-a entries never match worktree
References: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
        <20200806060119.74587-1-ray@ameretat.dev>
        <20200806060119.74587-3-ray@ameretat.dev>
Date:   Thu, 06 Aug 2020 14:00:54 -0700
In-Reply-To: <20200806060119.74587-3-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Thu, 6 Aug 2020 02:01:18 -0400")
Message-ID: <xmqqimdvjxq1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBA899EA-D827-11EA-B71B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> By definition, an intent-to-add index entry can never match the
> worktree, because worktrees have no concept of intent-to-add entries.
> Therefore, "apply --index" should always fail on intent-to-add paths.
>
> Because check_preimage() calls verify_index_match(), it already fails
> for patches other than creation patches, which check_preimage() ignores.
> This patch adds a check to check_preimage()'s rough equivalent for
> creation patches, check_to_create().
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>  apply.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

At first glance, it feels somewhat sad that this check is not done
in check_preimage(); after all, the caller of check_preimage() feeds
it to all kind of patches, without excluding path creation, so the
helper should be allowed to say "heh, you are trying to create path
F with this patch, but there already is F in the index", "you are
renaming into F but there is F already", etc.

But ensuring the state of the path to be patched is done by
check_to_create() for paths that are to be created, even before this
patch, because it simply needs to do different checks from what is
done on modification patch, and also because we need to resolve
patch->is_new bit for non-git patches before being able to perform
the checks done in check_to_create().

So I agree with the location of this additonal logic.

It is somewhat unsatisfactory that we need to do the same
index_name_pos probing twice.  I wonder if we somehow can
consolidate them?

Perhaps something along this line, instead of this patch?

 apply.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index 4cba4ce71a..c5ecb64102 100644
--- a/apply.c
+++ b/apply.c
@@ -3740,6 +3740,7 @@ static int check_preimage(struct apply_state *state,
 
 #define EXISTS_IN_INDEX 1
 #define EXISTS_IN_WORKTREE 2
+#define EXISTS_IN_INDEX_AS_ITA 3
 
 static int check_to_create(struct apply_state *state,
 			   const char *new_name,
@@ -3747,11 +3748,21 @@ static int check_to_create(struct apply_state *state,
 {
 	struct stat nst;
 
-	if (state->check_index && !ok_if_exists) {
-		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
-		if (pos >= 0 &&
-		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
-			return EXISTS_IN_INDEX;
+	if (state->check_index && (!ok_if_exists || !state->cached)) {
+		int pos;
+
+		pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
+		if (pos >= 0) {
+			struct cache_entry *ce = state->repo->index->cache[pos];
+
+			/* allow ITA, as they do not yet exist in the index */
+			if (!ok_if_exists && !(ce->ce_flags & CE_INTENT_TO_ADD))
+				return EXISTS_IN_INDEX;
+
+			/* ITA entries can never match working tree files */
+			if (!state->cached && (ce->ce_flags & CE_INTENT_TO_ADD))
+				return EXISTS_IN_INDEX_AS_ITA;
+		}
 	}
 
 	if (state->cached)
@@ -3938,6 +3949,9 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		case EXISTS_IN_INDEX:
 			return error(_("%s: already exists in index"), new_name);
 			break;
+		case EXISTS_IN_INDEX_AS_ITA:
+			return error(_("%s: does not match index"), new_name);
+			break;
 		case EXISTS_IN_WORKTREE:
 			return error(_("%s: already exists in working directory"),
 				     new_name);
