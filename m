Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B35C433FE
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7596460F59
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJaRSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhJaRSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 13:18:11 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488AC061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 10:15:39 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635700538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIaURuEBsurzwcGCN8gKIjLp5vQiV+LE+ytGN/eif/w=;
        b=CdLM0aoYEeHfGZvu9T8nB2AGTwzsiddFh0G3vNT9duG2L9eyUoD6zKVxq7du3FdgOcxFWH
        txPMwA/iHaKQGDBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635700538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIaURuEBsurzwcGCN8gKIjLp5vQiV+LE+ytGN/eif/w=;
        b=fXgABB5I38Rvd5JPMOC95a45RaEjTu+KdmctXw7gskTJmZ7U9neXPcQKBfDqwMR5Up8WK6
        HyBZ870xDiFlTMHjE/FZvZmiWSMnHRDBz8zyHKar9wh9slNVlskTcnqCBdODaw+CZU4Ign
        puSEi//gq74I8PfhzJez4pr2MmfYlTWJxqVBKNqx71EOMRaAoOe/gfqF32ebPOcyEapzfI
        bMQX9N5/YOdFypTDtQ17yf2GDNYhfRstFGaynSTH8ifbJPeaDJciEGXxcSJnqOcQaPRYi2
        MwWJXaSpnl/EzPwIl4XJr4WtCHugoXxhDgjTHrx0xeFnpnzU57x1iC80egtOEJfdpO7ngT
        5CpBGrxqA/IaQ13T/NRpJEBfJMU5LqhL9Y4sCMIrJHsLlKfF1FELRAvpVknpbAKHcG2/XO
        BBIIRr5hv3AA5vQ8p12bmihhAy75Pv3zaGKNVhwNAE8hAsIco5g0xwjNIccHJOlP85OpTQ
        3p8Ajliu/1hIhxz+kN8hSKaYmgvD/IsH6KmmR41TLSPZszqf0DYYMmBudf2euG5NdFc2S6
        liOFyrm93DbtW0+qmZ2OQnueLMbkLpQrO6Pw6TAuXeEOksAOnoldXWzAyKj/a5nlr3xiag
        hhMDqyChM0kfqZNQTgYCuZiXWvB4C0ziINXTfwLCRW/CMngRcDsAI=
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 3/3] pretty: add abbrev option to %(describe)
Date:   Sun, 31 Oct 2021 13:15:10 -0400
Message-Id: <20211031171510.1646396-4-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211031171510.1646396-1-eschwartz@archlinux.org>
References: <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211031171510.1646396-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(describe) placeholder by default, like `git describe`, uses a
seven-character abbreviated commit object name. This may not be
sufficient to fully describe all commits in a given repository,
resulting in a placeholder replacement changing its length because the
repository grew in size.  This could cause the output of git-archive to
change.

Add the --abbrev option to `git describe` to the placeholder interface
in order to provide tools to the user for fine-tuning project defaults
and ensure reproducible archives.

One alternative would be to just always specify --abbrev=40 but this may
be a bit too biased...

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 Documentation/pretty-formats.txt |  4 ++++
 pretty.c                         | 15 +++++++++++++++
 t/t4205-log-pretty-formats.sh    |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1ee47bd4a3..9e943fb74b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -222,6 +222,10 @@ The placeholders are:
 +
 ** 'tags[=<bool>]': Instead of only considering annotated tags,
    consider lightweight tags as well.
+** 'abbrev=<number>': Instead of using the default number of hexadecimal digits
+   (which will vary according to the number of objects in the repository with a
+   default of 7) of the abbreviated object name, use <number> digits, or as many
+   digits as needed to form a unique object name.
 ** 'match=<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
 ** 'exclude=<pattern>': Do not consider tags matching the given
diff --git a/pretty.c b/pretty.c
index 403d89725a..fa9bfea273 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1216,10 +1216,12 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 		char *name;
 		enum {
 			DESCRIBE_ARG_BOOL,
+			DESCRIBE_ARG_INTEGER,
 			DESCRIBE_ARG_STRING,
 		} type;
 	}  option[] = {
 		{ "tags", DESCRIBE_ARG_BOOL},
+		{ "abbrev", DESCRIBE_ARG_INTEGER },
 		{ "exclude", DESCRIBE_ARG_STRING },
 		{ "match", DESCRIBE_ARG_STRING },
 	};
@@ -1243,6 +1245,19 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 					found = 1;
 				}
 				break;
+			case DESCRIBE_ARG_INTEGER:
+				if (match_placeholder_arg_value(arg, option[i].name, &arg,
+								&argval, &arglen)) {
+					char *endptr;
+					if (!arglen)
+						return 0;
+					strtol(argval, &endptr, 10);
+					if (endptr - argval != arglen)
+						return 0;
+					strvec_pushf(args, "--%s=%.*s", option[i].name, (int)arglen, argval);
+					found = 1;
+				}
+				break;
 			case DESCRIBE_ARG_STRING:
 				if (match_placeholder_arg_value(arg, option[i].name, &arg,
 								&argval, &arglen)) {
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d4acf8882f..35eef4c865 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1010,4 +1010,12 @@ test_expect_success '%(describe:tags) vs git describe --tags' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
+	test_when_finished "git tag -d tagname" &&
+	git tag -a -m tagged tagname &&
+	git describe --abbrev=15 >expect &&
+	git log -1 --format="%(describe:abbrev=15)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.1

