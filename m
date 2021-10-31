Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B3C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF760F4C
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhJaRSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 13:18:12 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56368 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJaRSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 13:18:10 -0400
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635700537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ckWtLg/5cV01Im+qd6/g3sz7EhMh7YEFHLUwOtzy0k=;
        b=sUHXsrNF4I/AQPRImDEcrwLDwqAJfnT4KuWkmW12lVknMUuEzgyRicjhPk3YiLzvDd23mJ
        YQIfBmlfIoF428qIbhv9Fhh+QxmbM3OI913T6BiyfXKIRHLywcxZZntJCdhI6u/uekCPVA
        0MrVNVIPspvtRudQzJ3PTSn9CcncXT/0vaV0oW34cqfB0aNGX6su8ml0pdu3QxQDBXRIQL
        aidXicuD7G8uaSNZ+o3ANBdyxbIyKJvFpevk4bzzelxkfo5hDhwugGlYO4X7xlY06bHglk
        ndmyfcl9hs+0mKh5Aw2bh3ItKmdTIVf3SbP3mBh44HVFVxJKBjkQs1PSFcnebrE4PUGPUJ
        ri+BYJj765lWKxV2UekKDn1UFVxnWLRlObwS2Sxytjt+GbB80mNpES1A3rguYuD466Egpn
        VrgKbNv1GHXobGTLO0zchVQHjGrSKKP1koisP7BTTxSBGd5NUVns9loNeeZ6rZRylge4bV
        WxATNK1g+ZuMfS8lODPBYT8ytw9NxxfXOm+OjDl/Y8HMll6otQexa2LV61TB82W5XJqRR7
        m7rqZgzwyYFAPZUo4tH5V8ucSF1h+EUn+p5dC+9qbP5JOI/tk8nMZqK7iIgAmFUOCHuwLs
        VoVBpIIFMDaC7iOEClMQ5Q3a7+UJ0DXXNyZ16CGnZBfhAguWr/eN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635700537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ckWtLg/5cV01Im+qd6/g3sz7EhMh7YEFHLUwOtzy0k=;
        b=acwwqvY8VsegbCrs4kKZmfKRVe1RxrzUNAcYFk6t0dO+HRidj4c/vLBxOAh59U1Q9o1SV1
        hjEABcLPZUt44UDw==
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/3] pretty: add tag option to %(describe)
Date:   Sun, 31 Oct 2021 13:15:09 -0400
Message-Id: <20211031171510.1646396-3-eschwartz@archlinux.org>
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

The %(describe) placeholder by default, like `git describe`, only
supports annotated tags. However, some people do use lightweight tags
for releases, and would like to describe those anyway. The command line
tool has an option to support this.

Teach the placeholder to support this as well.

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---

I use lowercase "bool" here not "boolean-value" because I don't see
utility in the word "value" here.

 Documentation/pretty-formats.txt | 12 +++++++-----
 pretty.c                         | 12 ++++++++++++
 t/t4205-log-pretty-formats.sh    |  8 ++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index ef6bd420ae..1ee47bd4a3 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -220,6 +220,8 @@ The placeholders are:
 			  inconsistent when tags are added or removed at
 			  the same time.
 +
+** 'tags[=<bool>]': Instead of only considering annotated tags,
+   consider lightweight tags as well.
 ** 'match=<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
 ** 'exclude=<pattern>': Do not consider tags matching the given
@@ -273,11 +275,6 @@ endif::git-rev-list[]
 			  If any option is provided multiple times the
 			  last occurrence wins.
 +
-The boolean options accept an optional value `[=<BOOL>]`. The values
-`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
-sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
-option is given with no value, it's enabled.
-+
 ** 'key=<K>': only show trailers with specified key. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
@@ -313,6 +310,11 @@ insert an empty string unless we are traversing reflog entries (e.g., by
 decoration format if `--decorate` was not already provided on the command
 line.
 
+The boolean options accept an optional value `[=<bool>]`. The values
+`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
+sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
+option is given with no value, it's enabled.
+
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
diff --git a/pretty.c b/pretty.c
index c38acda8cb..403d89725a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1215,9 +1215,11 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 	struct {
 		char *name;
 		enum {
+			DESCRIBE_ARG_BOOL,
 			DESCRIBE_ARG_STRING,
 		} type;
 	}  option[] = {
+		{ "tags", DESCRIBE_ARG_BOOL},
 		{ "exclude", DESCRIBE_ARG_STRING },
 		{ "match", DESCRIBE_ARG_STRING },
 	};
@@ -1227,10 +1229,20 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 		int found = 0;
 		const char *argval;
 		size_t arglen = 0;
+		int optval = 0;
 		int i;
 
 		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
 			switch (option[i].type) {
+			case DESCRIBE_ARG_BOOL:
+				if (match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {
+					if (optval)
+						strvec_pushf(args, "--%s", option[i].name);
+					else
+						strvec_pushf(args, "--no-%s", option[i].name);
+					found = 1;
+				}
+				break;
 			case DESCRIBE_ARG_STRING:
 				if (match_placeholder_arg_value(arg, option[i].name, &arg,
 								&argval, &arglen)) {
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5865daa8f8..d4acf8882f 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1002,4 +1002,12 @@ test_expect_success '%(describe:exclude=...) vs git describe --exclude ...' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(describe:tags) vs git describe --tags' '
+	test_when_finished "git tag -d tagname" &&
+	git tag tagname &&
+	git describe --tags >expect &&
+	git log -1 --format="%(describe:tags)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.1

