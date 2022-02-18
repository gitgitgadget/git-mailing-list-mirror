Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECA5C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 22:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiBRWcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 17:32:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiBRWce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 17:32:34 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E51D314
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 14:32:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id b9-20020a63e709000000b00362f44b02aeso5419048pgi.17
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=OVb9ZGxwHN5KLCsJCCY5v6HBCSCfhByqJ2g1MKcN0VA=;
        b=ooNzdXkFNFIaRi37qcgz83WTzUPoWwqs40muGqcj/q2dUPMEAzBe5GdaC+ts8agx3l
         gulVPvphFy4c7JkA0WKDijbZ0ptLoFIpa7821KNvnu7YzWo/xKKxXh2oAW5eqZs89Y31
         sLGgPN25c9PuglebSxf8JIKb2LCDB/1MyGgKTq6ORYy/qVJc8U9LNCo49iO7nSpQ5ZLj
         HSGSZtrIB2gNNDPKgII6XTjxth+0EAsbAQaPCfePyJo+O7Topueq6AVllkljYSqC60/i
         fz92+dY4JrlcVLCWMKBazRI7MMOxW3mLsuSumJa6Ala5QbRl+LHVkyET/CyTiTxkVSZO
         /n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=OVb9ZGxwHN5KLCsJCCY5v6HBCSCfhByqJ2g1MKcN0VA=;
        b=l6B54AdhfHgKzhatRQ+gWK02Faq4CBKqzAOuMsFdjmRJzrhuqeB6WEHiC30SEBClq0
         mDpR3vok+Ff/4Pp3qLxGvPUFMmUv32+zA/9wlryX85oWtNSjpYk4txpqr+Wq4kmbFwXk
         vtCpLArWSrAh9EPOIVOZ9I6m4q4zuxPD8VVDsPY9TdzrncWpKcbugH/FiAbn4LZrTKIy
         LIei3wimI9sPds7pAbkVRB6P5gtkki73OFNHSFGLg6GCAuE5L1/kcWIsjLQM2wZM3OdK
         TLXYkrrnai4EKbGR2mcNauLINWnW7j+CkzA6CGEjVMLQb6vWLYrfvlFQp4BMmRjYhV2s
         82aA==
X-Gm-Message-State: AOAM5339AYln9FCnR4ijLUiSSnbjVYQ8eLibkCoeKQxUw9iqOPdAWGC3
        WVBx7m4dmO8G0AkQAcgCWxYqPRbCx6qZwlESrcyap4JFh24lk+Efc6XBylIt/UYpn1hQTvDCEcH
        JiUmH6G3touwopCyEU5070RPlEd20wgFQ7Bmg8WmHKkTL8BE41XcZ8Vg1xKdGcfPvl9ablJTaCj
        Mr
X-Google-Smtp-Source: ABdhPJzYXkbjTiQR3hxT/7g/vF3ocwuOVaGOZtWiJ1H/MkpGCdV/fn8e89ZrloseNPk3mFjjSF/bAI1Eu1fBzfvIXBOg
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:2305:b0:4e1:56d7:a69b with
 SMTP id h5-20020a056a00230500b004e156d7a69bmr9911981pfh.11.1645223536798;
 Fri, 18 Feb 2022 14:32:16 -0800 (PST)
Date:   Fri, 18 Feb 2022 14:32:11 -0800
Message-Id: <20220218223212.1139366-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH] ls-files: support --recurse-submodules --stage
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e77aa336f1 ("ls-files: optionally recurse into submodules", 2016-10-10)
taught ls-files the --recurse-submodules argument, but only in a limited
set of circumstances. In particular, --stage was unsupported, perhaps
because there was no repo_find_unique_abbrev(), which was only
introduced in 8bb95572b0 ("sha1-name.c: add
repo_find_unique_abbrev_r()", 2019-04-16). This function is needed for
using --recurse-submodules with --stage.

Now that we have repo_find_unique_abbrev(), teach support for this
combination of arguments.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I got the similar-hashing object contents from =C3=86var's work in [1].

[1] https://lore.kernel.org/git/patch-v7-1.6-28c01b7f8a5-20220111T130811Z-a=
varab@gmail.com/
---
 Documentation/git-ls-files.txt         |  2 +-
 builtin/ls-files.c                     |  4 ++--
 t/t3007-ls-files-recurse-submodules.sh | 20 +++++++++++++++++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.tx=
t
index 48cc7c0b6f..0dabf3f0dd 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -156,7 +156,7 @@ a space) at the start of each line:
=20
 --recurse-submodules::
 	Recursively calls ls-files on each active submodule in the repository.
-	Currently there is only support for the --cached mode.
+	Currently there is only support for the --cached and --stage modes.
=20
 --abbrev[=3D<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f7ea56cc63..e791b65e7e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -244,7 +244,7 @@ static void show_ce(struct repository *repo, struct dir=
_struct *dir,
 			printf("%s%06o %s %d\t",
 			       tag,
 			       ce->ce_mode,
-			       find_unique_abbrev(&ce->oid, abbrev),
+			       repo_find_unique_abbrev(repo, &ce->oid, abbrev),
 			       ce_stage(ce));
 		}
 		write_eolinfo(repo->index, ce, fullname);
@@ -726,7 +726,7 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
 		setup_work_tree();
=20
 	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
+	    (show_deleted || show_others || show_unmerged ||
 	     show_killed || show_modified || show_resolve_undo || with_tree))
 		die("ls-files --recurse-submodules unsupported mode");
=20
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recu=
rse-submodules.sh
index 4a08000713..3d2da360d1 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,25 @@ test_expect_success 'ls-files correctly outputs files in=
 submodule' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--stage' '
+	# In order to test hash abbreviation, write two objects that have the
+	# same first 4 hexadecimal characters in their (SHA-1) hashes.
+	echo brocdnra >submodule/c &&
+	git -C submodule commit -am "update c" &&
+	echo brigddsv >submodule/c &&
+	git -C submodule commit -am "update c again" &&
+
+	cat >expect <<-\EOF &&
+	100644 6da7 0	.gitmodules
+	100644 7898 0	a
+	100644 6178 0	b/b
+	100644 dead9 0	submodule/c
+	EOF
+
+	git ls-files --stage --recurse-submodules --abbrev=3D4 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-files correctly outputs files in submodule with -z=
' '
 	lf_to_nul >expect <<-\EOF &&
 	.gitmodules
@@ -292,7 +311,6 @@ test_incompatible_with_recurse_submodules () {
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
-test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
=20
--=20
2.35.1.473.g83b2b277ed-goog

