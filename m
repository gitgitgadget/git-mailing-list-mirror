Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E73CEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGRWyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGRWyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:54:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97EA1
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:54:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D90428EB8;
        Tue, 18 Jul 2023 18:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=llsAKvq5x9dwef7miKDw3tGeJGQfULVatQYujp
        4Xc5g=; b=HPJjohvuTtuGNFhStYvTxDeXYVoB1h2CPMty9kZdQIhLL/E8r5doOw
        /ZK8DzL46CiAi4vfyQ+jhOezFvxgaxoTASD7NXB8Kn73s0KfcAje7a7J33bGLzsv
        VSDlb1v3t4np9fwxDHnn3wTGFgfKvKzQ9t/0vsks+7EfXQ393HbeI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 072C428EB7;
        Tue, 18 Jul 2023 18:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8997028EB4;
        Tue, 18 Jul 2023 18:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] short help: allow multi-line opthelp
References: <xmqq5y6gg8fn.fsf@gitster.g>
Date:   Tue, 18 Jul 2023 15:54:04 -0700
In-Reply-To: <xmqq5y6gg8fn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Jul 2023 15:29:32 -0700")
Message-ID: <xmqqttu0esqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF35041C-25BD-11EE-89C1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
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
 * With a new test.

 parse-options.c          | 12 +++++++++++-
 t/t0040-parse-options.sh |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

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
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 7d7ecfd571..83e5d4eeb6 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -35,6 +35,8 @@ String options
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
+    --longhelp            help text of this entry
+                          spans multiple lines
     --list <str>          add str to list
 
 Magic arguments
-- 
2.41.0-376-gcba07a324d

