Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12DC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353358AbiCUUbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbiCUUbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:31:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A982D1A
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:30:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y32-20020a25ad20000000b006339fb8e18cso10310636ybi.9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=aOJ8eg8FnXupTKcnu+mvbwutZh9uOy7HQsx4nGgJ9Ks=;
        b=GDrlJHsq1xptrCCHNHu8Gr4zPxnYrnTPjPFvYRPdIeZIdQ0cr7kWWwwXWrkewH9O5D
         W31rlg5Y/Y7jsQI/vQGEh+D9193V4VSC2l5BN1xJcJshBtN+j9ywaGDINjkNPo+vFYJP
         oXWx85aYILFwBAfjtOpy2ACghpdLsEg9phUgvFQCy9duvA3h/1WT/9QCkRiTlWJYyQEB
         53MBjFvTk6E6B1zlS1cAsIpPAaVI0CfCLC6j4GddWePFU8hfvdPRkJVgAD4I3R2KcwdH
         WGogHXs/bPX/DbnypTOYfLN+DZ0eUUPPDBVNtsRSEIaui7ziqu/GSlnh5FEY5te2/xPU
         fLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=aOJ8eg8FnXupTKcnu+mvbwutZh9uOy7HQsx4nGgJ9Ks=;
        b=A05YQb/OWIMoLoVgQOJo0I1D9icTbFMX/0ttxZokt7ua22jU94ZFsvjV7/4OOh0lMg
         BhdAnMx0JC1Ief95nQGNzXZoB9nPDMDnx2WRYhDOBUdV9fwCTVMWipzYSMW8CCGq7eB9
         okhGCLQCyATZBoiHfaCzsBGq5fS0g98Ke7VCa/X0Ab4ZdCv7OaRPFN4BQZY3GuNf59da
         ff0mgy4gahLrGqoQTjdbAvXNtxtnCa8NZGGW5uSfyXl4uf0MzDaFRz8yD2F8W9U8/Xcj
         L3RoBt58kaCluNgzbzUyUv9HzMKXZeWQlEVcDXoeVPPOFIg3E2ZY3/samRJxHOBRm63c
         Burw==
X-Gm-Message-State: AOAM532ZTg+/+4zWMbzsrmbAY/tcSucbPpSkIX7UUv3o4S9JE0cRxdYn
        Lu5cKKOZmWRTIlvU6tw7KeBUBbfztvnbeoVrQbBP
X-Google-Smtp-Source: ABdhPJxRMwsuWX4tVT/p+NjgmQCCRbIK4mrpIkJWjW8wJKG8V8B+Vfh5gIgOj37FmTexK2co4xka7hw3CvdYFdglB3Lk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c58b:0:b0:629:5064:894c with
 SMTP id v133-20020a25c58b000000b006295064894cmr24271166ybe.590.1647894622775;
 Mon, 21 Mar 2022 13:30:22 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:30:18 -0700
In-Reply-To: <patch-v2-2.2-9d16984898c-20220307T123244Z-avarab@gmail.com>
Message-Id: <20220321203019.2614799-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: Re: [PATCH v2 2/2] hooks: fix an obscure TOCTOU "did we just run a
 hook?" race
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8b8bdad3959..009a1de0a3d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -726,11 +726,13 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
>  	int clean_message_contents =3D (cleanup_mode !=3D COMMIT_MSG_CLEANUP_NO=
NE);
>  	int old_display_comment_prefix;
>  	int merge_contains_scissors =3D 0;
> +	int invoked_hook;
> =20
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
> =20
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit",=
 NULL))
> +	if (!no_verify && run_commit_hook(use_editor, index_file, &invoked_hook=
,
> +					  "pre-commit", NULL))
>  		return 0;
> =20
>  	if (squash_message) {
> @@ -1053,10 +1055,10 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  		return 0;
>  	}
> =20
> -	if (!no_verify && hook_exists("pre-commit")) {
> +	if (!no_verify && invoked_hook) {

This commit causes Git to fail Valgrind (tested using "cd t && sh
t5537*.sh -i -v --valgrind-only=3D10"). You can see here that a caller of
run_commit_hook() expects invoked_hook to be set, but...

> diff --git a/commit.c b/commit.c
> index d400f5dfa2b..396e14d7b32 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1713,7 +1713,7 @@ size_t ignore_non_trailer(const char *buf, size_t l=
en)
>  }
> =20
>  int run_commit_hook(int editor_is_used, const char *index_file,
> -		    const char *name, ...)
> +		    int *invoked_hook, const char *name, ...)
>  {
>  	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>  	va_list args;
> diff --git a/commit.h b/commit.h

The quoted part is the entire diff of commit.c. You can see that we have
a new argument "int *invoked_hook", but don't actually do anything with
it. Could you (=C3=86var) take a look?
