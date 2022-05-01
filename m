Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6FAC433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbiEAMcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346975AbiEAMcn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 08:32:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAE5621E
        for <git@vger.kernel.org>; Sun,  1 May 2022 05:29:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b19so16416178wrh.11
        for <git@vger.kernel.org>; Sun, 01 May 2022 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3GJqdEjMdOxiXsWHyj1lOPuCKzXHIlzbWVyf9MgN47Y=;
        b=K26HMHClMhQXd/SAIod35mKebFmDLr5Ox1PIJItYFT+jpp3s9lhL0R924in5QtKooz
         MvhZrv1Xu8PKyAYEG6W/SwPLZ9IG8j+PFEUOr5Qri+nxUrJkEExYpz0CGJ5SGG+oVdky
         qrBAEZB+j2JaO2p0G/96OLuKJLIipl8UoTPFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3GJqdEjMdOxiXsWHyj1lOPuCKzXHIlzbWVyf9MgN47Y=;
        b=hl204QTyY3nxOtptOGGjbzC4KjIC6dm8XX2QYQK9qawS2qpyDYe5XrwI2PjoJbxF1x
         /WJEiM5Oj9sCWxSzP0ukHH4H1il3tUeWQlQlcuE1vnNAlUxcSWms2H1qQSVZ6ET0jR55
         V1eKK64qkGv/6cItgzPFf+HS1vOPSnhpCH0Mqkc+pM8Zo/cw0prYBFiWyszBspdva9vx
         TRjkdhpPGBiuByqtxfSMEZv8dJroxOQd7yP4eU7wC9N0Vjr2gaFJpUwTLKjW3USuLhch
         O+Zyq/NWCF5hZ9CyVTasPvOeWRyq8HG0n9aPMZvPeiCXyZT/uYaklUQi8lMKnEJ8xfi0
         LCFA==
X-Gm-Message-State: AOAM533sb0xvhmmmf2BNjgEgpfFtacRb5TkOV+QxoWzlaXSBoRJS00BK
        tNIBeL48zavPKjW6Uv8KLvBi/SAxLspASg==
X-Google-Smtp-Source: ABdhPJwPRPkZRO9ZNkFxn9+/qUF/GRSzOs8h29Ysq7WZVr9lTh1f331qID8HIZ71NX34EP47ktnNjg==
X-Received: by 2002:adf:fc47:0:b0:20a:d494:3ee5 with SMTP id e7-20020adffc47000000b0020ad4943ee5mr6381297wrs.696.1651408155770;
        Sun, 01 May 2022 05:29:15 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id l9-20020adfb109000000b0020c5253d8d7sm4435160wra.35.2022.05.01.05.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 05:29:15 -0700 (PDT)
Date:   Sun, 1 May 2022 13:29:14 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bisect--helper: warn if we are assuming an unlikely pathspec
Message-ID: <Ym59GmfWpCSV9Bqr@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.3 (d9199322) (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 73c6de06aff8 ("bisect: don't use invalid oid as rev when
starting") changes the behaviour to consider invalid oids as pathspecs
again, as in the old shell implementation.

While that behaviour may be desirable, it can also cause confusion. For
example, while bisecting in a particular repo I encountered this:

    $ git bisect start d93ff48803f0 v6.3
    $

...which led to me sitting for a few moments, wondering why there's no
printout stating the first rev to check.

It turns out that the tag was actually "6.3", not "v6.3", and thus the
bisect was still silently started with only a bad rev, because
d93ff48803f0 was a valid oid and "v6.3" was silently considered to be a
pathspec.

While this behaviour may be desirable, it can be confusing, especially
with different repo conventions either using or not using "v" before
release names, or when a branch name or tag is simply misspelled on the
command line.

In order to avoid this, emit a warning when we are assuming an argument
is a pathspec, but no such path exists in the checkout and this doesn't
look like a pathspec according to looks_like_pathspec:

    $ git bisect start d93ff48803f0 v6.3
    warning: assuming 'v6.3' is a path
    $

If the filename is after the double dash, assume the user knows what
they're doing, just like with other git commands.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 builtin/bisect--helper.c    |  4 ++++
 cache.h                     |  1 +
 setup.c                     |  2 +-
 t/t6030-bisect-porcelain.sh | 18 ++++++++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0..30a73e2a7d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -682,6 +682,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 			die(_("'%s' does not appear to be a valid "
 			      "revision"), arg);
 		} else {
+			if (!has_double_dash &&
+			    !looks_like_pathspec(arg) &&
+			    !check_filename(NULL, arg))
+				warning(_("assuming '%s' is a path"), arg);
 			break;
 		}
 	}
diff --git a/cache.h b/cache.h
index 6226f6a8a5..bae92859a3 100644
--- a/cache.h
+++ b/cache.h
@@ -648,6 +648,7 @@ void verify_filename(const char *prefix,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);
 int path_inside_repo(const char *prefix, const char *path);
+int looks_like_pathspec(const char *arg);
 
 #define INIT_DB_QUIET 0x0001
 #define INIT_DB_EXIST_OK 0x0002
diff --git a/setup.c b/setup.c
index a7b36f3ffb..bafbfb0d5e 100644
--- a/setup.c
+++ b/setup.c
@@ -208,7 +208,7 @@ static void NORETURN die_verify_filename(struct repository *r,
  * but which look sufficiently like pathspecs that we'll consider
  * them such for the purposes of rev/pathspec DWIM parsing.
  */
-static int looks_like_pathspec(const char *arg)
+int looks_like_pathspec(const char *arg)
 {
 	const char *p;
 	int escaped = 0;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5382e5d216..2ea50f4ba4 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1025,4 +1025,22 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 	git bisect visualize -p -- "-hello 2"
 '
 
+test_expect_success 'bisect warning on implicit enoent pathspec' '
+	git bisect reset &&
+	git bisect start "$HASH4" doesnotexist 2>output &&
+	grep -F "assuming '\''doesnotexist'\'' is a path" output
+'
+
+test_expect_success 'bisect fatal on implicit enoent pathspec with dash' '
+	git bisect reset &&
+	test_must_fail git bisect start "$HASH4" doesnotexist -- dne2 2>output &&
+	grep -F "'\''doesnotexist'\'' does not appear to be a valid revision" output
+'
+
+test_expect_success 'bisect no warning on explicit enoent pathspec' '
+	git bisect reset &&
+	git bisect start "$HASH4" -- doesnotexist 2>output &&
+	[ -z "$(cat output)" ]
+'
+
 test_done
-- 
2.36.0

