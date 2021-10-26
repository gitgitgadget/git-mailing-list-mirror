Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BEAC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E00761057
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhJZBij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:38:39 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56262 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhJZBif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 21:38:35 -0400
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635212171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/f0sQnfvMoa7873ED7GwcmfI6yYxjM2uA2Xr82KtVI=;
        b=HnDdrtynY5S03jJ6AJDYxDlvJVtmColEvAjv6IqjWIvnzO1gtHYzKT5CSQW9ujIu8OZ14u
        0tWFIaisJvSuoMpywpzOjhBsBvVmbXZxtuXhms0f7uXwcj2YVVnS9lexHAmKCWQtiEeMqQ
        bdDpKVszykjG9KlSHBLRwwLywTBPziEMfryRiB/ulF///p68Y31AdZvIx99/055EgFIy0l
        ZUOVEvpr4/9lt1rsoB+g2lo46mpUgqMgYpjYoktoPImTAn5p0oBmhiZthDdVAjwksllkAb
        7X/d7IQJHkOQwsuR68gE7t/DIEXj4IwnqCHYYRhaxGWnABEnB373oNxxXuth5pOe+Z6YC4
        plB+6lMyt24Leyi7BQB5Ov7KH6h4v3NHIOTPbi/mmrDT6fRtLilmtlnYd8hZ6enZfCJm/s
        ATicl2+y3X9cT+zI/TWoxvnz9enuueEbGn5gnU6kQJI4KLq7Q6AkaaFmhWykhvH2UPc49n
        S13Ft5X8invcLFkgGfi1lXydu+NV1vLoVwnCS3sMvJJexv6qvejt0tXX9ZEVjR0Ks+DBBL
        IU0AAX7IvnB/O3dFrKfoXPgRRra4AQx/DHn7dmIJFTL47mzxFF3Q0lDYTV1GNSX3Gv3vX/
        /fmXyqCeUPGH4lS5hJfNDtjaEwiqb4/v0uerIccd4pDzWTtMpzFbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635212171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/f0sQnfvMoa7873ED7GwcmfI6yYxjM2uA2Xr82KtVI=;
        b=GYcMYCIjWG8NHmRH9HFH9Hx3lthZpqhRMrAUjaLy80KVjoBfxPM6USykQq53Kk4PodDOI3
        OQRBNxBMUtPwuABg==
To:     git@vger.kernel.org
Subject: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
Date:   Mon, 25 Oct 2021 21:34:52 -0400
Message-Id: <20211026013452.1372122-4-eschwartz@archlinux.org>
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

Notes:
    With regard to validating that an integer is passed, I attempt to parse the
    result using the same mechanism git-describe itself does in the abbrev
    callback, just with slightly different validation of what we have at the end...
    because of course here argval is the entire rest of the format string,
    including the ")".
    
    While testing that this actually does what it's supposed to do, I noticed that
    it doesn't validate junk like leading whitespace or plus signs... this is a
    problem for `git describe --abbrev='    +15'` too so I guess it's not my
    problem to fix...

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
index 16b5366fed..44bfc49b38 100644
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
@@ -1245,6 +1246,19 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 					found = 1;
 				}
 				break;
+			case OPT_INTEGER:
+				if (match_placeholder_arg_value(arg, option[i].name, &arg,
+								&argval, &arglen) && arglen) {
+					if (!arglen)
+						return 0;
+					char* endptr;
+					strtol(argval, &endptr, 10);
+					if (endptr - argval != arglen)
+						return 0;
+					strvec_pushf(args, "--%s=%.*s", option[i].name, (int)arglen, argval);
+					found = 1;
+				}
+				break;
 			case OPT_STRING:
 				if (match_placeholder_arg_value(arg, option[i].name, &arg,
 								&argval, &arglen) && arglen) {
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

