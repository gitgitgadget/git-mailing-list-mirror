Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD236C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B865461056
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhJ2SsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:48:13 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56302 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhJ2Srz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:55 -0400
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635533125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qzDmFAw+LyZhh61h8K/ihiciA+EUgudTl+H1yRGkLo=;
        b=wgVebFqNEBWr2bAurWHEhyuvrqEshJZ9df8uffajF05XtWoBuCpxdFQkmFqBQD1NCkFT/7
        lWZtUd93R/ltCc3jLL36ndL7YY7CCAWARKBt0NwkzJz9mmH8x9o+kb2+LolVghcVCaFVec
        cFdOPWG6rAAdxh+kfICjlpYGLqmrbDfMaAKNNzeTAE8MuxbtIm2ckUuUNu5JEDM0t2R6+2
        asWDXBo/CLUChYRqZp4J0AGhTgJ8j/Uxm2QmpVvALxcc9yd/oeSeogNPqdcfVBPxeX/+Cb
        UHYymdxOHkbqFe/kxMlQtjYR3t1X0Cc0DT7OlltwNTm+yyW/B55Y1+zQRVXjjm8iMbPzpq
        oDQUPVvRkENIhnodSR+KiNgkeLSvd5uhoYyQRZ9yokaEAOE6duQTxH6TxuJ+657NR/NHrY
        22vKaH6tcWws9LXEwR9DccITDe8e4Ltwfgc5YzOFBth8yRwvejd/cJtcFEoG6ikPcJa2xk
        q3ILgg8lUxfD633ebxek5fqu72Wvfd14UXPNuYe5Gh/QXelEhPbihCQCMNaqYkZXVQRoJ1
        DvFXgiG5hRiOSurTK98Bnx6V/zKESEyyXBBHXs9fV8DD8J8eZNETU92LUhW/z0sab/E2uy
        MhdYZa2JrNPL6MiXzsOsOa0o5zwFNBuXE4ag7oUYZVlQ8tYMMEtVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635533125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qzDmFAw+LyZhh61h8K/ihiciA+EUgudTl+H1yRGkLo=;
        b=yTnVpZlNFH1bZ/BW4KAs7HrdPVxHk6Y1VA9JbimqZwCoPeaqGGTSmF0l+/B+poCBvqxeMw
        WAf+KRPnIg1RX8Ag==
To:     git@vger.kernel.org
Subject: [PATCH v3 3/3] pretty: add abbrev option to %(describe)
Date:   Fri, 29 Oct 2021 14:45:12 -0400
Message-Id: <20211029184512.1568017-4-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029184512.1568017-1-eschwartz@archlinux.org>
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
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
 pretty.c                         | 16 +++++++++++++++-
 t/t4205-log-pretty-formats.sh    |  8 ++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 86ed801aad..57fd84f579 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -222,6 +222,10 @@ The placeholders are:
 +
 ** 'tags[=<BOOL>]': Instead of only considering annotated tags,
    consider lightweight tags as well.
+** 'abbrev=<N>': Instead of using the default number of hexadecimal digits
+   (which will vary according to the number of objects in the repository with a
+   default of 7) of the abbreviated object name, use <n> digits, or as many digits
+   as needed to form a unique object name.
 ** 'match=<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
 ** 'exclude=<pattern>': Do not consider tags matching the given
diff --git a/pretty.c b/pretty.c
index a105ef2a15..5662cb2943 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1218,9 +1218,10 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 {
 	struct {
 		char *name;
-		enum { OPT_BOOL, OPT_STRING, } type;
+		enum { OPT_BOOL, OPT_INTEGER, OPT_STRING, } type;
 	}  option[] = {
 		{ "tags", OPT_BOOL},
+		{ "abbrev", OPT_INTEGER },
 		{ "exclude", OPT_STRING },
 		{ "match", OPT_STRING },
 	};
@@ -1244,6 +1245,19 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 					found = 1;
 				}
 				break;
+			case OPT_INTEGER:
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
 			case OPT_STRING:
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

