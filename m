Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF4EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGRW3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGRW3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:29:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3861995
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:29:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 362A2363E3;
        Tue, 18 Jul 2023 18:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=n
        IcB9bdbPkqa4DNyp7+W8mb0VsRNltYWKCuPLbT0fJA=; b=qySv/P6Y3QqbkfILQ
        sNZ65NCE4q/PMJ6Tt9gr3IDuckdWi6oJnE7iJMPVFUCPANinezWhaIImDSdR5fXL
        uKPbOxN81BUdAmrPFk6kkv7vFUieqLW7SzgwAciiyG9wCYAzlIOwSbTb88uymGxl
        I+H8avQpu+dtfd6RB7/neKVyII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FBDA363E2;
        Tue, 18 Jul 2023 18:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A8DE4363E1;
        Tue, 18 Jul 2023 18:29:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] short help: allow multi-line opthelp
Date:   Tue, 18 Jul 2023 15:29:32 -0700
Message-ID: <xmqq5y6gg8fn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91E74DBE-25BA-11EE-8028-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "-h" triggers the short-help in a command that implements its
option parsing using the parse-options API, the option help text is
shown with a single fprintf() as a long line.  When the text is
multi-line, the second and subsequent lines are not left padded,
that breaks the alignment across options.

Borrowing the idea from the advice API where its hint strings are
shown with (localized) "hint:" prefix, let's internally split the
(localized) help text into lines, and showing the first line, pad
the remaining lines to align.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index f8a155ee13..817416db99 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1109,6 +1109,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	for (; opts->type != OPTION_END; opts++) {
 		size_t pos;
 		int pad;
+		const char *cp, *np;
 
 		if (opts->type == OPTION_SUBCOMMAND)
 			continue;
@@ -1157,7 +1158,16 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 				   (const char *)opts->value);
 			continue;
 		}
-		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
+
+		for (cp = _(opts->help); *cp; cp = np) {
+			np = strchrnul(cp, '\n');
+			fprintf(outfile,
+				"%*s%.*s\n", pad + USAGE_GAP, "",
+				(int)(np - cp), cp);
+			if (*np)
+				np++;
+			pad = USAGE_OPTS_WIDTH;
+		}
 	}
 	fputc('\n', outfile);
 
-- 
2.41.0-376-gcba07a324d

