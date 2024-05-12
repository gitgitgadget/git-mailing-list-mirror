Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F7F4E2
	for <git@vger.kernel.org>; Sun, 12 May 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715495112; cv=none; b=bu4ek8iak3dKEdr/SnfmjdHeSmSUsBAECo8IpPXePx3p5OwcwRqvdkW3f7aj+ohHUkRciVJV82Kn6NjTHkFHZHnWLxD20AbsxDaS1wAw5K7YtdfU30Q7eQJCFeDMQ9Hyfn85zPFotO9LGKhRrTxDk7ppmMCDEuPC55JLGh//zOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715495112; c=relaxed/simple;
	bh=F7q5ONXq+BaxfM7yp2cpImZ4GnB1OEEtCH2pKftpobM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCK3sQvL8Cj+u5O+Fh5Vmme+RI95KG+MBy7yft44CBnnBDsfT6z40leB+gOa9j1JsZPR1ep2zIWiJyHm3N9UcJ3fmjUl6HcQpeBpoKOZTM2SqwDZJbOjAtBW9RdUtxfdqwgddOdNl71i0rYFRcJxjioGEsNY4gplpjVTM3rjF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n1wLMfLJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n1wLMfLJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC3C32763F;
	Sun, 12 May 2024 02:25:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	7q5ONXq+BaxfM7yp2cpImZ4GnB1OEEtCH2pKftpobM=; b=n1wLMfLJJlWrRb977
	NoXbO4thPUFWnBOEnasMGOKhW32p6shZbAbNRR9Gw6TBYhu52WMW9TDZYJTYLgmi
	6nKUHOL0yx/b/bh1YIchUfJ5GxzF+EkZdIv/NpuuG0PYswDvAqvd8184iNkgrb/w
	LadFykT2CZtC2Lwuuu6FugG+Xo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E64D92763E;
	Sun, 12 May 2024 02:25:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69C1827638;
	Sun, 12 May 2024 02:25:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] compat/regex: fix argument order to calloc(3)
Date: Sat, 11 May 2024 23:25:04 -0700
Message-ID: <xmqqbk5bim2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FD79654-1028-11EF-87DB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Windows compiler suddenly started complaining that calloc(3) takes
its arguments in <nmemb, size> order.  Indeed, there are many calls
that has their arguments in a _wrong_ order.

Fix them all.

A sample breakage can be seen at

  https://github.com/git/git/actions/runs/9046793153/job/24857988702#step:4:272

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I wonder if there is an easier way to deal with toolchain and/or
   platform changes (I am assuming that is what caused this
   breakage) than just seeing and then reacting to a breakage after
   it happens.

 compat/regex/regcomp.c        | 12 ++++++------
 compat/regex/regex_internal.c |  4 ++--
 compat/regex/regexec.c        | 10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d1bc09e49b..2bc0f1187a 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -868,7 +868,7 @@ init_dfa (re_dfa_t *dfa, size_t pat_len)
     if (table_size > pat_len)
       break;
 
-  dfa->state_table = calloc (sizeof (struct re_state_table_entry), table_size);
+  dfa->state_table = calloc (table_size, sizeof (struct re_state_table_entry));
   dfa->state_hash_mask = table_size - 1;
 
   dfa->mb_cur_max = MB_CUR_MAX;
@@ -936,7 +936,7 @@ init_dfa (re_dfa_t *dfa, size_t pat_len)
 	{
 	  int i, j, ch;
 
-	  dfa->sb_char = (re_bitset_ptr_t) calloc (sizeof (bitset_t), 1);
+	  dfa->sb_char = (re_bitset_ptr_t) calloc (1, sizeof (bitset_t));
 	  if (BE (dfa->sb_char == NULL, 0))
 	    return REG_ESPACE;
 
@@ -3079,9 +3079,9 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
 						   _NL_COLLATE_SYMB_EXTRAMB);
     }
 #endif
-  sbcset = (re_bitset_ptr_t) calloc (sizeof (bitset_t), 1);
+  sbcset = (re_bitset_ptr_t) calloc (1, sizeof (bitset_t));
 #ifdef RE_ENABLE_I18N
-  mbcset = (re_charset_t *) calloc (sizeof (re_charset_t), 1);
+  mbcset = (re_charset_t *) calloc (1, sizeof (re_charset_t));
 #endif /* RE_ENABLE_I18N */
 #ifdef RE_ENABLE_I18N
   if (BE (sbcset == NULL || mbcset == NULL, 0))
@@ -3626,9 +3626,9 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
   re_token_t br_token;
   bin_tree_t *tree;
 
-  sbcset = (re_bitset_ptr_t) calloc (sizeof (bitset_t), 1);
+  sbcset = (re_bitset_ptr_t) calloc (1, sizeof (bitset_t));
 #ifdef RE_ENABLE_I18N
-  mbcset = (re_charset_t *) calloc (sizeof (re_charset_t), 1);
+  mbcset = (re_charset_t *) calloc (1, sizeof (re_charset_t));
 #endif /* RE_ENABLE_I18N */
 
 #ifdef RE_ENABLE_I18N
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index ec51cf3446..ec5cc5d2dd 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1628,7 +1628,7 @@ create_ci_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
   reg_errcode_t err;
   re_dfastate_t *newstate;
 
-  newstate = (re_dfastate_t *) calloc (sizeof (re_dfastate_t), 1);
+  newstate = (re_dfastate_t *) calloc (1, sizeof (re_dfastate_t));
   if (BE (newstate == NULL, 0))
     return NULL;
   err = re_node_set_init_copy (&newstate->nodes, nodes);
@@ -1678,7 +1678,7 @@ create_cd_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
   reg_errcode_t err;
   re_dfastate_t *newstate;
 
-  newstate = (re_dfastate_t *) calloc (sizeof (re_dfastate_t), 1);
+  newstate = (re_dfastate_t *) calloc (1, sizeof (re_dfastate_t));
   if (BE (newstate == NULL, 0))
     return NULL;
   err = re_node_set_init_copy (&newstate->nodes, nodes);
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 49358ae475..e92be5741d 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2796,8 +2796,8 @@ get_subexp (re_match_context_t *mctx, int bkref_node, int bkref_str_idx)
 	    continue; /* No.  */
 	  if (sub_top->path == NULL)
 	    {
-	      sub_top->path = calloc (sizeof (state_array_t),
-				      sl_str - sub_top->str_idx + 1);
+	      sub_top->path = calloc (sl_str - sub_top->str_idx + 1,
+				      sizeof (state_array_t));
 	      if (sub_top->path == NULL)
 		return REG_ESPACE;
 	    }
@@ -3361,7 +3361,7 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
       if (ndests == 0)
 	{
 	  state->trtable = (re_dfastate_t **)
-	    calloc (sizeof (re_dfastate_t *), SBC_MAX);
+	    calloc (SBC_MAX, sizeof (re_dfastate_t *));
 	  return 1;
 	}
       return 0;
@@ -3457,7 +3457,7 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
 	 discern by looking at the character code: allocate a
 	 256-entry transition table.  */
       trtable = state->trtable =
-	(re_dfastate_t **) calloc (sizeof (re_dfastate_t *), SBC_MAX);
+	(re_dfastate_t **) calloc (SBC_MAX, sizeof (re_dfastate_t *));
       if (BE (trtable == NULL, 0))
 	goto out_free;
 
@@ -3488,7 +3488,7 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
 	 transition tables, one starting at trtable[0] and one
 	 starting at trtable[SBC_MAX].  */
       trtable = state->word_trtable =
-	(re_dfastate_t **) calloc (sizeof (re_dfastate_t *), 2 * SBC_MAX);
+	(re_dfastate_t **) calloc (2 * SBC_MAX, sizeof (re_dfastate_t *));
       if (BE (trtable == NULL, 0))
 	goto out_free;
 
-- 
2.45.0-119-g0f3415f1f8

