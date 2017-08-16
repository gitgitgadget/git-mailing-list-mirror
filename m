Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA621F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbdHPS3j (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:29:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51931 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751765AbdHPS3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:29:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F5E7AEA62;
        Wed, 16 Aug 2017 14:29:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+bKUPyIo6ZXfyMwV7HIMBHFgFRg=; b=FOsi5dQtft6rFJ283YaT
        fkc7548/e4V1m9njn2/lsLF+jIZdEHoHN/5+ELY5rohMq1szz/VJKD3Zc/jxZoW7
        SQq8UMN0Fr4SwrHOh4uOe9in2hCmNHVZ20a4VYAmLR3dS1KUpPf9aP+Ur3f1+fdg
        O7ZflIqr2BrdbtLd7k+iYjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=HLBjP9e8/qV3MeD17jx88S9g5J9PAiuA+kjAtdGXqtaJwI
        AJUXCZs1ZbTqm30sy5nU5cE8OUdOrrb9Z7wsTro7FVWB8tmhMw9wXFxnwQ4jmXpP
        eyZCBwWZPHeQG0P2InENEAchqhVkEY/05Pj5TeZF4u90m1iJ0Jrbg9Kc5bEkk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37A93AEA61;
        Wed, 16 Aug 2017 14:29:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92C73AEA5E;
        Wed, 16 Aug 2017 14:29:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: [PATCH/FIXUP 4/2] apply: only pay attention to CRLF in the preimage
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
Date:   Wed, 16 Aug 2017 11:29:36 -0700
Message-ID: <xmqqpobvl627.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC131E30-82B0-11E7-AEEC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The newly added "patch.has_crlf" member wants to indicate if the
incoming patch expects any CRLF line in the patch target, and
parse_fragment() implements that logic for "git apply".

Rename the member to "patch.crlf_in_old" to clarify what it means,
and fix the logic in parse_fragment() so that it also works correctly
when running "git apply -R", where '+' lines correspond to the patch
target.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 There also is an obvious style fix for comment, but I didn't bother
 splitting it out to a separate step.

 apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 7663e63df7..995973da3d 100644
--- a/apply.c
+++ b/apply.c
@@ -220,7 +220,7 @@ struct patch {
 	unsigned int recount:1;
 	unsigned int conflicted_threeway:1;
 	unsigned int direct_to_threeway:1;
-	unsigned int has_crlf:1;
+	unsigned int crlf_in_old:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -1663,13 +1663,15 @@ static void check_whitespace(struct apply_state *state,
 	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
-/* Check if the patch has context lines with CRLF or
-   the patch wants to remove lines with CRLF */
+/*
+ * Check if the patch has context lines with CRLF or
+ * the patch wants to remove lines with CRLF.
+ */
 static void check_old_for_crlf(struct patch *patch, const char *line, int len)
 {
 	if (len >= 2 && line[len-1] == '\n' && line[len-2] == '\r') {
 		patch->ws_rule |= WS_CR_AT_EOL;
-		patch->has_crlf = 1;
+		patch->crlf_in_old = 1;
 	}
 }
 
@@ -1730,7 +1732,8 @@ static int parse_fragment(struct apply_state *state,
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
-			check_old_for_crlf(patch, line, len);
+			if (!state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
 			if (state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -1739,6 +1742,8 @@ static int parse_fragment(struct apply_state *state,
 			trailing = 0;
 			break;
 		case '+':
+			if (state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -3442,7 +3447,7 @@ static int load_preimage(struct apply_state *state,
 	char *img;
 	struct patch *previous;
 	int status;
-	int flags = patch->has_crlf ? APPLY_FLAGS_CR_AT_EOL : 0;
+	int flags = patch->crlf_in_old ? APPLY_FLAGS_CR_AT_EOL : 0;
 
 	previous = previous_patch(state, patch, &status);
 	if (status)
