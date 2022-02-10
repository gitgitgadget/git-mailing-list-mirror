Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6FFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiBJJ2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:28:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbiBJJ2t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:28:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AEBD95
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:50 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id iy10-20020a17090b16ca00b001b8a7ed5b2cso5800143pjb.7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=CB41Hx9KQblKQQyGOHxaQcsrTVonFagZUhdzStudoQs=;
        b=FhZo3LOxdYdDZ5zDafUm5VvtLg816sVE1lD2di+nbpf1qa9T4s3VFt7IGDD83a6Hcz
         53LE6kW+zbHnq3DeJcd2JC0V8G7cbaY1zuRtoh7O3lgsdvsRNJdCbElhCe6/r+UxuHHt
         80RaQqv5aoZaBgbgWey1uBZX8cF1Uw8evQERAwkGL4hM+xGUkkuw2eLSe3P2fRtCGM0I
         Txl63hi547eTWR28Lm4TaFpKePt6ld4SdlIxKFHTkX9Quks1ZUT4DdnSXn2V05klqhIf
         BpUqw3SBqZkXOkF95DTK9V42nYp/k2oN9M3ql26eLyQujn0ewS5m3OS92kcAB+uaJC0F
         OcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=CB41Hx9KQblKQQyGOHxaQcsrTVonFagZUhdzStudoQs=;
        b=U/m43t8q/Khf1eXVCo2FhflcX3X0UU3LjpNFC/oLbUttZl021cGFE0TcTVoFDU5ms9
         SbZzjb8r6VpKminKMCzvYKU/uLwpUpkMDPGlRfwYxtWBY5vYJ76038twtI1gIE5piVhE
         Le8Oo0wG+9jhUpic2LGso5FYVPamUmJPYOZ3XfTuhEqot42oam0PKOmsE3pp14k4WdTE
         8JSUNzw8bwnEpgFE8zJMHlZUSiahscEB3fSL9yFd4GnbPX4s9VdInWEw9ummRHHdRCoG
         C3e0Fme+mUplOVxBUhW0OJrrShJXBWhM2Cl+x13LotABJ1dWmV1G8823A3K6uPYU1V1q
         Kbwg==
X-Gm-Message-State: AOAM530UGl7XiDkCOcvQTzyNll0Beky4O6eKBjuskviLnTAbmmy6ckge
        orpwMHwY0lfWe8/lf2ebihjr2wechvzCOgKHadG6eaHel8mTxB7jcdXme3Vau1hXwu2n8SdpHh0
        gvDe60iD0KztVjeefKXDb1qgYmyiAd/Wh/9TWg1VYl8WbfNsm+ngfNfJKPfA9Y00=
X-Google-Smtp-Source: ABdhPJxffx9g93mKZQZ1Lc93kLCMXaYsDQ8Saw39X7GpG8mxFo72Xnbe7o4FtrNSUWEsnXlQ2Fm5DCcZjst5vA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:564f:: with SMTP id
 m15mr5398076pgs.368.1644485330012; Thu, 10 Feb 2022 01:28:50 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:14 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 01/20] submodule--helper: get remote names from any repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

So let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817..4c7c1e1432 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,11 +29,14 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
=20
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo)
 {
 	char *dest =3D NULL, *ret;
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	struct ref_store *store =3D get_main_ref_store(repo);
+	int ignore_errno;
+	const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+						      NULL, &ignore_errno);
=20
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -46,7 +49,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
=20
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret =3D xstrdup("origin");
 	else
 		ret =3D dest;
@@ -55,6 +58,19 @@ static char *get_default_remote(void)
 	return ret;
 }
=20
+static char *get_default_remote_submodule(const char *module_path)
+{
+	struct repository subrepo;
+
+	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	return repo_get_default_remote(&subrepo);
+}
+
+static char *get_default_remote(void)
+{
+	return repo_get_default_remote(the_repository);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *p=
refix)
 {
 	char *remote;
@@ -1341,9 +1357,8 @@ static void sync_submodule(const char *path, const ch=
ar *prefix,
 {
 	const struct submodule *sub;
 	char *remote_key =3D NULL;
-	char *sub_origin_url, *super_config_url, *displaypath;
+	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb =3D STRBUF_INIT;
-	struct child_process cp =3D CHILD_PROCESS_INIT;
 	char *sub_config_path =3D NULL;
=20
 	if (!is_submodule_active(the_repository, path))
@@ -1382,21 +1397,15 @@ static void sync_submodule(const char *path, const =
char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
=20
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd =3D 1;
-	cp.dir =3D path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	default_remote =3D get_default_remote_submodule(path);
+	if (!default_remote)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
=20
-	strbuf_strip_suffix(&sb, "\n");
-	remote_key =3D xstrfmt("remote.%s.url", sb.buf);
+	remote_key =3D xstrfmt("remote.%s.url", default_remote);
+	free(default_remote);
=20
-	strbuf_reset(&sb);
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
=20
--=20
2.33.GIT

