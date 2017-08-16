Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73121F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdHPS3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:29:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752413AbdHPS2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:28:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FA3AAEA03;
        Wed, 16 Aug 2017 14:28:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EufJYEpEZ0LmibJCKMpjNpsLras=; b=J7ekwuSiS8AjcF3QNyGW
        36ocD1HHPw4NvjEcA0WcKUSAi8tFc2NdiggDenK2c+Eqd8tziiMBt1zaizn7RSE/
        jK+xq0cHHIApAVVUo19tQ39B4s67Pz1E+vyVoH7YJAMqpYRG7Bo8BpYomO6AQiZt
        tGzUPDyJdt++K02+Vp7XZEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ueZBHD6kLMwgIS8sR4QzD896rdrgiCxfq9Xn4oV9/aDWM0
        WJ4hxd5xY12Us9Va1d3s+YLBFKETey56QSaCZByghRjmyIzmt1lBBPN8c/9P85wc
        CfLuskOT/cxn8MBQ8YNn3lB7uzNdLP8lPJKSa6vH5k+LPsKl/hzTBMbIW8OW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 754A1AEA02;
        Wed, 16 Aug 2017 14:28:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB2E0AEA00;
        Wed, 16 Aug 2017 14:28:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/RFC 2/2] File commited with CRLF should roundtrip diff and apply
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
Date:   Wed, 16 Aug 2017 11:28:43 -0700
Message-ID: <xmqq4lt7mko4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC9EE048-82B0-11E7-8EFA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll be sending a few patches that apply on top of applying these
two patches to show what I meant in my previous review comments.
The net change to apply.c, when you combine your 2/2 with these,
would become like the attached, which I think makes more sense.

Instead of queuing a squashed result, I thought it may help to send
them as incremental fixes with their own justification.

diff --git a/apply.c b/apply.c
index f2d599141d..c06f7014a2 100644
--- a/apply.c
+++ b/apply.c
@@ -220,6 +220,7 @@ struct patch {
 	unsigned int recount:1;
 	unsigned int conflicted_threeway:1;
 	unsigned int direct_to_threeway:1;
+	unsigned int crlf_in_old:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -1662,6 +1663,19 @@ static void check_whitespace(struct apply_state *state,
 	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
+/*
+ * Check if the patch has context lines with CRLF or
+ * the patch wants to remove lines with CRLF.
+ */
+static void check_old_for_crlf(struct patch *patch, const char *line, int len)
+{
+	if (len >= 2 && line[len-1] == '\n' && line[len-2] == '\r') {
+		patch->ws_rule |= WS_CR_AT_EOL;
+		patch->crlf_in_old = 1;
+	}
+}
+
+
 /*
  * Parse a unified diff. Note that this really needs to parse each
  * fragment separately, since the only way to know the difference
@@ -1712,11 +1726,14 @@ static int parse_fragment(struct apply_state *state,
 			if (!deleted && !added)
 				leading++;
 			trailing++;
+			check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action == correct_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
+			if (!state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
 			if (state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -1725,6 +1742,8 @@ static int parse_fragment(struct apply_state *state,
 			trailing = 0;
 			break;
 		case '+':
+			if (state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -2268,8 +2287,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 		add, pluses, del, minuses);
 }
 
-static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
+static int read_old_data(struct stat *st, const char *path, struct strbuf *buf,
+			 struct patch *patch)
 {
+	enum safe_crlf safe_crlf = (patch->crlf_in_old
+				    ? SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_FALSE);
+
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2278,7 +2301,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
+		convert_to_git(&the_index, path, buf->buf, buf->len, buf, safe_crlf);
 		return 0;
 	default:
 		return -1;
@@ -3384,6 +3407,7 @@ static int load_patch_target(struct apply_state *state,
 			     struct strbuf *buf,
 			     const struct cache_entry *ce,
 			     struct stat *st,
+			     struct patch *patch,
 			     const char *name,
 			     unsigned expected_mode)
 {
@@ -3399,7 +3423,7 @@ static int load_patch_target(struct apply_state *state,
 		} else if (has_symlink_leading_path(name, strlen(name))) {
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
-			if (read_old_data(st, name, buf))
+			if (read_old_data(st, name, buf, patch))
 				return error(_("failed to read %s"), name);
 		}
 	}
@@ -3432,7 +3456,7 @@ static int load_preimage(struct apply_state *state,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(state, &buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st, patch,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3520,7 +3544,7 @@ static int load_current(struct apply_state *state,
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(state, &buf, ce, &st, name, mode);
+	status = load_patch_target(state, &buf, ce, &st, patch, name, mode);
 	if (status < 0)
 		return status;
 	else if (status)
