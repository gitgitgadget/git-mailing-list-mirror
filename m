Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50846C4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 04:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3729260C3F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 04:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhG1Eam (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 00:30:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57314 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhG1Eal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 00:30:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D6F2DE48B;
        Wed, 28 Jul 2021 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tydteJHKURzTpRqUA+lIxhOSPpS/Jf/8UgYoin
        z2prQ=; b=xw3QYs3SvwaPFqq+vGTstXjY6WX20IKVu62p6+46nv/nM/8Xh1bmvK
        3KQmbsw7/gsQarGuYwAfZbLg3iEO4B6JymghSLLljxmX6cJbSqgcszmc6hRLANAJ
        r+pbJ11I9r/W2QhtnkATXCHmCjyiGEtZQpn6BrENRypjf2zIduidY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33FAEDE48A;
        Wed, 28 Jul 2021 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0884DE489;
        Wed, 28 Jul 2021 00:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, lilinchao@oschina.cn
Subject: Re: [PATCH] git-apply: fix --3way with binary patch
References: <20210728024434.20230-1-jerry@skydio.com>
Date:   Tue, 27 Jul 2021 21:30:38 -0700
In-Reply-To: <20210728024434.20230-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 27 Jul 2021 19:44:34 -0700")
Message-ID: <xmqqh7gfawlt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F653E52-EF5C-11EB-8745-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Binary patches applied with "--3way" will
> always return a conflict even if the patch
> should cleanly apply because the low level
> merge function considers all binary merges
> without a variant to be conflicting.
>
> Fix by falling back to normal patch application
> for all binary patches.
>
> Add tests for --3way and normal applications
> of binary patches.
>
> Fixes: 923cd87ac8 ("git-apply: try threeway first when "--3way" is used")
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
>  apply.c                   |  3 ++-
>  t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 1d2d7e124e..78e52f0dc1 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3638,7 +3638,8 @@ static int apply_data(struct apply_state *state, struct patch *patch,
>  	if (load_preimage(state, &image, patch, st, ce) < 0)
>  		return -1;
>  
> -	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
> +	if (!state->threeway || patch->is_binary ||
> +		try_threeway(state, &image, patch, st, ce) < 0) {

Thanks for a quick turnaround.  However.

Because apply.c::three_way_merge() calls into ll_merge() that lets
the low-level custom merge drivers to take over the actual merge, I
do not think your "if binary, bypass and never call try_threway() at
all" is the right solution.  The custom merge driver user uses for
the path may successfully perform such a "trivial" three-way merge
and return success.

Why does the current code that lets threeway tried first fails to
fall back to direct application?  The code before your change, if
fed a binary patch that does not apply, would have failed the direct
application first *and* then fell back to the threeway (if only to
fail because we do not let binary files be merged), no?

Is it that try_threeway()'s way to express failure slightly
different from how direct application reports failure, but your
change used the same "only if it is negative, we fail and fallback"
logic?  IIRC, apply_fragments() which is the meat of the direct
application logic reports failures by negative, but try_threeway()
can return positive non-zero to signal a "recoverable" failure (aka
"conflicted merge").  Which should lead us to explore a different
approach, which is ...

    Would it be possible for a patch to leave conflicts when
    try_threeway() was attempted, but will cleanly apply if direct
    application is done?

If so, perhaps

 - we first run try_threeway() and see if it cleanly resolves; if
   so, we are done.

 - then we try direct application and see if it cleanly applies; if
   so, we are done.

 - finally we run try_threeway() again and let it fail with
   conflict.

might be the right sequence?  We theoretically could omit the first
of these three steps, but that would mean we'd write 923cd87a
(git-apply: try threeway first when "--3way" is used, 2021-04-06)
off as a failed experiment and revert it, which would not be ideal.


Also, independent from this "if we claim we try threeway first and
fall back to direct application, we really should do so" fix we are
discussing, I think our default binary merge can be a bit more
lenient and resolve this particular case of applying the binary
patch taken from itself (i.e. a patch that takes A to B gets applied
using --3way option to A).  I wonder if it can be as simple as the
attached patch.  FWIW, this change is sufficient (without the change
to apply.c we are reviewing here) to make your new tests in t4108
pass.

---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
Subject: ll-merge: teach ll_binary_merge() a trivial three-way merge

The low-level binary merge code assumed that the caller will not
feed trivial merges that would have been resolved at the tree level;
because of this, ll_binary_merge() assumes the ancestor is different
from either side, always failing the merge in conflict unless -Xours
or -Xtheirs is in effect.

But "git apply --3way" codepath could ask us to perform three-way
merge between two binaries A and B using A as the ancestor version.
The current code always fails such an application, but when given a
binary patch that turns A into B and asked to apply it to A, there
is no reason to fail such a request---we can trivially tell that the
result must be B.

Arguably, this fix may belong to one level higher at ll_merge()
function, which dispatches to lower-level merge drivers, possibly
even before it renormalizes the three input buffers.  But let's
first see how this goes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ll-merge.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git c/ll-merge.c w/ll-merge.c
index 261657578c..bc8038d404 100644
--- c/ll-merge.c
+++ w/ll-merge.c
@@ -46,6 +46,13 @@ void reset_merge_attributes(void)
 	merge_attributes = NULL;
 }
 
+static int same_mmfile(mmfile_t *a, mmfile_t *b)
+{
+	if (a->size != b->size)
+		return 0;
+	return !memcmp(a->ptr, b->ptr, a->size);
+}
+
 /*
  * Built-in low-levels
  */
@@ -58,9 +65,18 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   const struct ll_merge_options *opts,
 			   int marker_size)
 {
+	int status;
 	mmfile_t *stolen;
 	assert(opts);
 
+	/*
+	 * With -Xtheirs or -Xours, we have cleanly merged;
+	 * otherwise we got a conflict, unless 3way trivially
+	 * resolves.
+	 */
+	status = (opts->variant == XDL_MERGE_FAVOR_OURS ||
+		  opts->variant == XDL_MERGE_FAVOR_THEIRS) ? 0 : 1;
+
 	/*
 	 * The tentative merge result is the common ancestor for an
 	 * internal merge.  For the final merge, it is "ours" by
@@ -68,18 +84,30 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	 */
 	if (opts->virtual_ancestor) {
 		stolen = orig;
+		status = 0;
 	} else {
-		switch (opts->variant) {
-		default:
-			warning("Cannot merge binary files: %s (%s vs. %s)",
-				path, name1, name2);
-			/* fallthru */
-		case XDL_MERGE_FAVOR_OURS:
-			stolen = src1;
-			break;
-		case XDL_MERGE_FAVOR_THEIRS:
+		if (same_mmfile(orig, src1)) {
 			stolen = src2;
-			break;
+			status = 0;
+		} else if (same_mmfile(orig, src2)) { 
+			stolen = src1;
+			status = 0;
+		} else if (same_mmfile(src1, src2)) {
+			stolen = src1;
+			status = 0;
+		} else {
+			switch (opts->variant) {
+			default:
+				warning("Cannot merge binary files: %s (%s vs. %s)",
+					path, name1, name2);
+				/* fallthru */
+			case XDL_MERGE_FAVOR_OURS:
+				stolen = src1;
+				break;
+			case XDL_MERGE_FAVOR_THEIRS:
+				stolen = src2;
+				break;
+			}
 		}
 	}
 
@@ -87,13 +115,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	result->size = stolen->size;
 	stolen->ptr = NULL;
 
-	/*
-	 * With -Xtheirs or -Xours, we have cleanly merged;
-	 * otherwise we got a conflict.
-	 */
-	return opts->variant == XDL_MERGE_FAVOR_OURS ||
-	       opts->variant == XDL_MERGE_FAVOR_THEIRS ?
-	       0 : 1;
+	return status;
 }
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
