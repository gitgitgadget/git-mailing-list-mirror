Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCB820987
	for <e@80x24.org>; Tue,  4 Oct 2016 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbcJDWzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:55:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51259 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751602AbcJDWzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:55:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 480CE43EBB;
        Tue,  4 Oct 2016 18:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=UQuP
        CT2/5Ek5DwCCnQ3qUl0yR1Y=; b=iWZ6EfsqBCXhY3hmXFBu1cUA8Z+wNojbFp02
        HY61PRIVjCcKy/f773IGiFvLRh0xg6LC98YK6xtlXoSihkOy8TqgTRSIHFN7JDUr
        IVnWYUfNSre9Fs7vQ9AWiuIR64SuWUlmGTokpcwniN0Dl5V7bqQycWUbdlGwJ/mb
        ze3XJII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        eTk7qmP1PbewaqKW1OJGv0v48ebakkb9MFSjti5mcmRL2aIw2ZtjN0ofSOW0e9xL
        aoK7ltqLhTrPtu8Nx0P4ADIlFf0wHEKQ5tnikhfEGf36ZO3GrJrnkqUFWBjLn1xj
        Zuyeuhzhso15TB7164ekFZliNDm5tqv/e9TOXJUzhTk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EF5643EBA;
        Tue,  4 Oct 2016 18:54:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B822143EB9;
        Tue,  4 Oct 2016 18:54:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, strk@kbt.io
Subject: [PATCH 3/4] diff.c: move ws-error-highlight parsing helpers up
Date:   Tue,  4 Oct 2016 15:54:48 -0700
Message-Id: <20161004225449.6759-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-510-g1ef781f2c1
In-Reply-To: <20161004225449.6759-1-gitster@pobox.com>
References: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
 <20161004225449.6759-1-gitster@pobox.com>
X-Pobox-Relay-ID: 9348A5CC-8A85-11E6-9CA3-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These need to be usable from git_diff_ui_config() code to help
parsing a configuration variable, so move them up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 74 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/diff.c b/diff.c
index d346378600..bd625cf3f7 100644
--- a/diff.c
+++ b/diff.c
@@ -163,6 +163,43 @@ long parse_algorithm_value(const char *value)
 	return -1;
 }
 
+static int parse_one_token(const char **arg, const char *token)
+{
+	const char *rest;
+	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest == ',')) {
+		*arg = rest;
+		return 1;
+	}
+	return 0;
+}
+
+static int parse_ws_error_highlight(const char *arg)
+{
+	const char *orig_arg = arg;
+	unsigned val = 0;
+
+	while (*arg) {
+		if (parse_one_token(&arg, "none"))
+			val = 0;
+		else if (parse_one_token(&arg, "default"))
+			val = WSEH_NEW;
+		else if (parse_one_token(&arg, "all"))
+			val = WSEH_NEW | WSEH_OLD | WSEH_CONTEXT;
+		else if (parse_one_token(&arg, "new"))
+			val |= WSEH_NEW;
+		else if (parse_one_token(&arg, "old"))
+			val |= WSEH_OLD;
+		else if (parse_one_token(&arg, "context"))
+			val |= WSEH_CONTEXT;
+		else {
+			return -1 - (int)(arg - orig_arg);
+		}
+		if (*arg)
+			arg++;
+	}
+	return val;
+}
+
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -3656,43 +3693,6 @@ static void enable_patch_output(int *fmt) {
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
-static int parse_one_token(const char **arg, const char *token)
-{
-	const char *rest;
-	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest == ',')) {
-		*arg = rest;
-		return 1;
-	}
-	return 0;
-}
-
-static int parse_ws_error_highlight(const char *arg)
-{
-	const char *orig_arg = arg;
-	unsigned val = 0;
-
-	while (*arg) {
-		if (parse_one_token(&arg, "none"))
-			val = 0;
-		else if (parse_one_token(&arg, "default"))
-			val = WSEH_NEW;
-		else if (parse_one_token(&arg, "all"))
-			val = WSEH_NEW | WSEH_OLD | WSEH_CONTEXT;
-		else if (parse_one_token(&arg, "new"))
-			val |= WSEH_NEW;
-		else if (parse_one_token(&arg, "old"))
-			val |= WSEH_OLD;
-		else if (parse_one_token(&arg, "context"))
-			val |= WSEH_CONTEXT;
-		else {
-			return -1 - (int)(arg - orig_arg);
-		}
-		if (*arg)
-			arg++;
-	}
-	return val;
-}
-
 static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *arg)
 {
 	int val = parse_ws_error_highlight(arg);
-- 
2.10.1-510-g1ef781f2c1

