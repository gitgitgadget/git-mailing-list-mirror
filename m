Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A70CC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AF3610A0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhJ2SsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhJ2Srz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:55 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1730AC061767
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:45:26 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635533124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdqJ83aV+pbBmZHr/NZgKq4XPCpZ6hsBtSTp2JmpMKo=;
        b=Djf21ZTUcoO4Lm8yvbpfZGXohCMBhLJ8U+IHA8zzSrD6J6UniVPMyAlay5Z8XSQDvHL3m2
        dVDIqTySCA9skDIXLQiU4bs+16yQAbWG2Tx0PNsMK61of7BdnHsKQDo8iMmufYyFyc874t
        RfksL4YvWaq1QkspTVKr1mBXZQ/sJDZmyYrqBSVO6Fdm2QLo2OgPuy79pKpTjmONg+lLBt
        chhXEhP4vVFCa0fMlv4dhpsDENcvzM401upmPwSDDd399FHjKJygWpyzBUyTAX5cYs5tWW
        CgDggOS9DbdFoYuKRGlJEUlGr0MhGwK19C782LqVBJsX5mRuAqRMk0IOtdrBG8aTA4S9g7
        oZyKafQIHWL0k+/JaforIZ4+s+YwjA83ZBzkBxibbme+w7+NUsNlHyVZA4cZBrsiR60ZDt
        iyG9GGxL41o6zUuWhuu4U0WSa/N8jVVJvjdDmh1H5einn0LvgrZ4g6v4vGcJV4gspbzU9N
        GQlegQXtv6sOdDkwT7iGi/REJdgaCII6DKCxfh2mhyoyDe56+s/8g0+lSCRFpnW9RmScOG
        dlT4L1UszUGHffWd0wGBdimw1eWscX3f8BvB2vVWlFUkpLOy0VOxDR7oEVp7CexFOnREAa
        10vqb2/Y5FyblY+nuW7Z4aC8tXu96V2u1XLVsIpqii835zKRCx2lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635533124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdqJ83aV+pbBmZHr/NZgKq4XPCpZ6hsBtSTp2JmpMKo=;
        b=79i1DkXPgLxxE4ky0kJ5C/WLoRQf7blnMtK3wOXCu7+q4Q2ZKrHxILBcUukfsWlQ6u7AOD
        Buv1l4wJJrNWo5Cg==
To:     git@vger.kernel.org
Subject: [PATCH v3 2/3] pretty: add tag option to %(describe)
Date:   Fri, 29 Oct 2021 14:45:11 -0400
Message-Id: <20211029184512.1568017-3-eschwartz@archlinux.org>
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

The %(describe) placeholder by default, like `git describe`, only
supports annotated tags. However, some people do use lightweight tags
for releases, and would like to describe those anyway. The command line
tool has an option to support this.

Teach the placeholder to support this as well.

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 Documentation/pretty-formats.txt | 12 +++++++-----
 pretty.c                         | 13 ++++++++++++-
 t/t4205-log-pretty-formats.sh    |  8 ++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

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
index 2ec023a0d0..a105ef2a15 100644
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
@@ -1229,10 +1230,20 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 		int found = 0;
 		const char *argval;
 		size_t arglen = 0;
+		int optval = 0;
 		int i;
 
 		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
 			switch (option[i].type) {
+			case OPT_BOOL:
+				if (match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {
+					if (optval)
+						strvec_pushf(args, "--%s", option[i].name);
+					else
+						strvec_pushf(args, "--no-%s", option[i].name);
+					found = 1;
+				}
+				break;
 			case OPT_STRING:
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

