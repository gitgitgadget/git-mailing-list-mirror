Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563AFC4332F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0F61057
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhJZBig (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:38:36 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56260 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJZBie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 21:38:34 -0400
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635212170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9SgceT0wI88dfDWZ30KVwiUMHCsAn71fl8Qt1Wq0lM=;
        b=Q777PZIBUYB1CFwYuZ8arZ+rYrfTNS6zcO/lvS6BLWAv+zYxgMOdkXEzX9w1Zno0fU+skT
        ye8kNTIR4+If1brjc/F9Sgtj5HVW8jk7zySA1urG8xhj2UQvTypzWcxLEljasjYlBCyzic
        b/Qse/SbkBnx0j69VitIlFIJWT1y0aDx8uXWvNf+2Ald0TDxsgD93gVcJbWpi0TyeGMGD5
        vYwdJoc5armqNuwpW63IkwgPlfGjhbngXAwyIPxHA7leOmqRU8EEMrGvxKUUCmHGWqtd0F
        BLanl52hlylT8AQCFfctq39hlWb1Q1Jk168a2V2yKpvWokfD/7KDFUWVSE9OQ13dO4oB9f
        lFuj/jCDsYpnNo1hAePg8uSfF40o0Xi8ipBRyRLaMPnN3Fs1qW971nrbRGmeAL8Giv2c0F
        SaNjrN1fFkq/aaNExsL3cD5NIC8UI9M9f9x+s4/3Tgtp9tjvc8abmLWcy6ykU/F9tnNCRv
        4D8+Vu4DjhL1NNBZw6Ha3LTYhLihj9Zg5q7g7ti/y9Wf285utuuykqdKqmhrbbPWyX0lBS
        oRrOOIiW6wUXV1WrWJ6WUPCAQZ3dLznEAOEVQ72oISIpyOMXIVT43QNIvg1Re/4BuBAbmV
        SHmxG2rRnsytXYiwUD3S+7nRv2GrfcO6ZKvYsFQXJGS0/9V8SV9Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635212170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9SgceT0wI88dfDWZ30KVwiUMHCsAn71fl8Qt1Wq0lM=;
        b=iMgkDFDcAedLA9YIAeCoxuio9E+cm5EB7Uf3B2uaK5T3SpzRID0o1Moyqd2/rL42rjBDhp
        id78/e1EmfVNDqDw==
To:     git@vger.kernel.org
Subject: [PATCH v2 2/3] pretty: add tag option to %(describe)
Date:   Mon, 25 Oct 2021 21:34:51 -0400
Message-Id: <20211026013452.1372122-3-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211026013452.1372122-1-eschwartz@archlinux.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
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
 Documentation/pretty-formats.txt | 12 +++++++-----
 pretty.c                         | 14 +++++++++++++-
 t/t4205-log-pretty-formats.sh    |  8 ++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index ef6bd420ae..86ed801aad 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -220,6 +220,8 @@ The placeholders are:
 			  inconsistent when tags are added or removed at
 			  the same time.
 +
+** 'tags[=<BOOL>]': Instead of only considering annotated tags,
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
 
+The boolean options accept an optional value `[=<BOOL>]`. The values
+`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
+sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
+option is given with no value, it's enabled.
+
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
diff --git a/pretty.c b/pretty.c
index f8b254d2ff..16b5366fed 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1218,8 +1218,9 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 {
 	struct {
 		char *name;
-		enum { OPT_STRING } type;
+		enum { OPT_BOOL, OPT_STRING, } type;
 	}  option[] = {
+		{ "tags", OPT_BOOL},
 		{ "exclude", OPT_STRING },
 		{ "match", OPT_STRING },
 	};
@@ -1229,10 +1230,21 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 		int found = 0;
 		const char *argval;
 		size_t arglen = 0;
+		int optval = 0;
 		int i;
 
 		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
 			switch(option[i].type) {
+			case OPT_BOOL:
+				if(match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {
+					if (optval) {
+						strvec_pushf(args, "--%s", option[i].name);
+					} else {
+						strvec_pushf(args, "--no-%s", option[i].name);
+					}
+					found = 1;
+				}
+				break;
 			case OPT_STRING:
 				if (match_placeholder_arg_value(arg, option[i].name, &arg,
 								&argval, &arglen) && arglen) {
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

