Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66B71F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdHPSaI (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:30:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65170 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751611AbdHPSaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:30:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6338EA3E46;
        Wed, 16 Aug 2017 14:30:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=mok8wGoiDVCPGP0BZLN12sLW7Ho=; b=q6hMkzlj70JKYL6GiT17
        cg6x2/i9iWtw++F4u5J7QzXACoYEbcTPGwn+XlXzEXTYQNY8pgLoTwcrH7Xz6JOI
        3m0w+QsQjVgEKBSJQupg2q5OrvzcbAFLt+uuntMWKJnEq38usMpTO3WehiLB8/Tg
        Q8oPbZ49yPUpcBrTi6RyaNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Crx2GVnwKS8v7IQ0FiLL6AshgbTdItlWp4PZAfylxUHE0F
        jJMbhW/J1r+08+r7hJngRnRWwHidNE3BEakEmT8eXhVDL1O0uJVygMewfsQk4ZsC
        2DqDR5IbTXU5GS1jsWdUq16PzgvdhUUMa4YbkGEVACZ+7qVaB2Jg1nUcM6Me8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C2F5A3E45;
        Wed, 16 Aug 2017 14:30:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 833B4A3E42;
        Wed, 16 Aug 2017 14:30:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: [PATCH/FIXUP 5/2] apply: localize the CRLF business to read_old_data()
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
Date:   Wed, 16 Aug 2017 11:30:03 -0700
Message-ID: <xmqqinhnl61g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECB9C0EA-82B0-11E7-B352-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous changes passed a new APPLY_FLAGS_CR_AT_EOL option down from
load_preimage() to read_old_data(), because the last function in
that callchain needs to decide how its call to convert_to_git()
function is made on the data read from the working tree.

The load_preimage() function and its direct callees, however, are
not limited to the case where the patch is applied to the data in
the working tree (i.e. "git apply" that is working as a better
"patch -p1"), unlike read_old_data(), which deals only with the
patch target in the working tree.  They are also responsible for
driving "git apply --cached" and "git apply --index", both of which
take the current index contents into account and do not need the new
special-casing of CRLF.  Exposing APPLY_FLAGS_CR_AT_EOL bit to them
is misleading.

Instead, just pass the "struct patch" down the same callchain, and
have read_old_data() look at its crlf_in_old member to make the
necessary decision.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This is what I care about the most in these fix-ups.

 apply.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/apply.c b/apply.c
index 995973da3d..c06f7014a2 100644
--- a/apply.c
+++ b/apply.c
@@ -2287,12 +2287,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 		add, pluses, del, minuses);
 }
 
-#define APPLY_FLAGS_CR_AT_EOL   (1<<0)
-
-static int read_old_data(struct stat *st, const char *path, struct strbuf *buf, int flags)
+static int read_old_data(struct stat *st, const char *path, struct strbuf *buf,
+			 struct patch *patch)
 {
-	enum safe_crlf safe_crlf = flags & APPLY_FLAGS_CR_AT_EOL ?
-		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_FALSE;
+	enum safe_crlf safe_crlf = (patch->crlf_in_old
+				    ? SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_FALSE);
+
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -3407,9 +3407,9 @@ static int load_patch_target(struct apply_state *state,
 			     struct strbuf *buf,
 			     const struct cache_entry *ce,
 			     struct stat *st,
+			     struct patch *patch,
 			     const char *name,
-			     unsigned expected_mode,
-			     int flags)
+			     unsigned expected_mode)
 {
 	if (state->cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
@@ -3423,7 +3423,7 @@ static int load_patch_target(struct apply_state *state,
 		} else if (has_symlink_leading_path(name, strlen(name))) {
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
-			if (read_old_data(st, name, buf, flags))
+			if (read_old_data(st, name, buf, patch))
 				return error(_("failed to read %s"), name);
 		}
 	}
@@ -3447,7 +3447,6 @@ static int load_preimage(struct apply_state *state,
 	char *img;
 	struct patch *previous;
 	int status;
-	int flags = patch->crlf_in_old ? APPLY_FLAGS_CR_AT_EOL : 0;
 
 	previous = previous_patch(state, patch, &status);
 	if (status)
@@ -3457,8 +3456,8 @@ static int load_preimage(struct apply_state *state,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(state, &buf, ce, st,
-					   patch->old_name, patch->old_mode, flags);
+		status = load_patch_target(state, &buf, ce, st, patch,
+					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
 		else if (status == SUBMODULE_PATCH_WITHOUT_INDEX) {
@@ -3518,8 +3517,7 @@ static int three_way_merge(struct image *image,
  */
 static int load_current(struct apply_state *state,
 			struct image *image,
-			struct patch *patch,
-			int flags)
+			struct patch *patch)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status, pos;
@@ -3546,7 +3544,7 @@ static int load_current(struct apply_state *state,
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(state, &buf, ce, &st, name, mode, flags);
+	status = load_patch_target(state, &buf, ce, &st, patch, name, mode);
 	if (status < 0)
 		return status;
 	else if (status)
@@ -3597,8 +3595,7 @@ static int try_threeway(struct apply_state *state,
 
 	/* our_oid is ours */
 	if (patch->is_new) {
-		int flags = 0;
-		if (load_current(state, &tmp_image, patch, flags))
+		if (load_current(state, &tmp_image, patch))
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->new_name);
 	} else {
@@ -3644,6 +3641,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 		      struct stat *st, const struct cache_entry *ce)
 {
 	struct image image;
+
 	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
-- 
2.14.1-331-g7631d96230


