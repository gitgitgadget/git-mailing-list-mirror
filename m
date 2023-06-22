Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87782EB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjFVVf3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Jun 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFVVf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:35:28 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855D1BFA
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:35:27 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7625719bac0so57483885a.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687469726; x=1690061726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHE+toELkNdBBKaLKsWSD+NxffXU09vIXEsFhKpJgMM=;
        b=iGYOt2dRMPAjJ5cakKj7mzCLbm66WTM9FR5+zLXv8mnbN28od8s29lTxY2/xGED8AD
         CGN16sVYdFsDNLIEQcRPksTfYnyQIShh6+qrfGZZv4+n/0r0GZ7a9w2ZEWOLM08eFpi8
         gkhOFIzXN6aUpueh+A7GfUDeYoAb3++NWpECrNoCWjqxXK92Fx6QgFKpSlATm1N+1xgA
         OldGBSVTJlpjulL5p3Lm9eQE+XWebbh0RqfkiZ2bJ2rwGHDJerG4jDYXkn8DMKEbdKnA
         233Yqs4O/CZEyYdzJayyBloUzJsJr++weH8u70GFGaUE5OOlITK/Q5KeWKy4YcK/raio
         GgUw==
X-Gm-Message-State: AC+VfDxPzLdiqzcLtOxwe7pyIXXVvFPtFHQY2ZKdND/kp83+gHV7doiU
        lpC2XzH5uG1OKwHSUrFUym142nTFo9QK80oeM1s=
X-Google-Smtp-Source: ACHHUZ7CjgzupW0XJa30VX9cAWn/fRiinUV+v08LJbffD9yDFiRZS3flPzWGSuM5rFRfzlHlDQWuEE0Fix12rQANBOw=
X-Received: by 2002:a05:6214:f29:b0:62d:ec71:129a with SMTP id
 iw9-20020a0562140f2900b0062dec71129amr23946828qvb.7.1687469726223; Thu, 22
 Jun 2023 14:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230622195059.320593-1-sandals@crustytoothpaste.net> <20230622195059.320593-4-sandals@crustytoothpaste.net>
In-Reply-To: <20230622195059.320593-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Jun 2023 17:35:15 -0400
Message-ID: <CAPig+cTmqUfzrA14xBo1jQSR9kLufze_DFZSf_PC2aCNnOHFcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] var: add config file locations
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 4:06 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Much like with attributes files, sometimes programs would like to know
> the location of configuration files at the global or system levels.
> However, it isn't always clear where these may live, especially for the
> system file, which may have been hard-coded at compile time or computed
> dynamically based on the runtime prefix.
>
> Since other parties cannot intuitively know how Git was compiled and
> where it looks for these files, help them by providing variables that
> can be queried.  Because we have multiple paths for global config
> values, print them in order from highest to lowest priority, and be sure
> to split on newlines so that "git var -l" produces two entries for the
> global value.
>
> However, be careful not to split all values on newlines, since our
> editor values could well contain such characters, and we don't want to
> split them in such a case.
>
> Note in the documentation that some values may contain multiple paths
> and that callers should be prepared for that fact.  This helps people
> write code that will continue to work in the event we allow multiple
> items elsewhere in the future.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
> diff --git a/builtin/var.c b/builtin/var.c
> @@ -62,21 +62,59 @@ static const char *git_attr_val_global(int flag)
>  struct git_var {
>         const char *name;
>         const char *(*read)(int);
> +       int multivalued;
>         int free;
>  };
>  static struct git_var git_vars[] = {
> +       { "GIT_COMMITTER_IDENT", git_committer_info, 0, 0 },
> +       { "GIT_AUTHOR_IDENT",   git_author_info, 0, 0 },
> +       { "GIT_EDITOR", editor, 0, 0 },
> +       { "GIT_SEQUENCE_EDITOR", sequence_editor, 0, 0 },
> +       { "GIT_PAGER", pager, 0, 0 },
> +       { "GIT_DEFAULT_BRANCH", default_branch, 0, 9 },

Why "9"?

> +       { "GIT_SHELL_PATH", shell_path, 0, 0 },
> +       { "GIT_ATTR_SYSTEM", git_attr_val_system, 0, 1 },
> +       { "GIT_ATTR_GLOBAL", git_attr_val_global, 0, 1 },
> +       { "GIT_CONFIG_SYSTEM", git_config_val_system, 0, 1 },
> +       { "GIT_CONFIG_GLOBAL", git_config_val_global, 1, 1 },
>         { "", NULL },
>  };
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> @@ -179,6 +179,49 @@ test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
> +test_expect_success 'GIT_CONFIG_SYSTEM points to the correct location' '
> +       TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&

Same comment as in [2/3]: $(pwd) is unnecessary. Simpler:

    TRASHDIR="$(test-tool path-utils normalize_path_copy .)" &&

> +       test_must_fail env GIT_CONFIG_NOSYSTEM=1 git var GIT_CONFIG_SYSTEM &&
> +       (
> +               sane_unset GIT_CONFIG_NOSYSTEM &&
> +               git var GIT_CONFIG_SYSTEM >path &&
> +               test "$(cat path)" != "" &&
> +               GIT_CONFIG_SYSTEM=/dev/null git var GIT_CONFIG_SYSTEM >path &&
> +               if test_have_prereq MINGW
> +               then
> +                       test "$(cat path)" = "nul"
> +               else
> +                       test "$(cat path)" = "/dev/null"
> +               fi &&
> +               GIT_CONFIG_SYSTEM="$TRASHDIR/gitconfig" git var GIT_CONFIG_SYSTEM >path &&
> +               test "$(cat path)" = "$TRASHDIR/gitconfig"
> +       )
> +'

Ditto regarding unnecessary temporary file.

> +test_expect_success 'GIT_CONFIG_GLOBAL points to the correct location' '
> +       TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&

Ditto regarding $(pwd).

> @@ -196,6 +239,29 @@ test_expect_success 'git var -l lists config' '
> +test_expect_success 'git var -l does not split multiline editors' '
> +       (
> +               GIT_EDITOR="!f() {
> +                       echo Hello!
> +               }; f" &&
> +               export GIT_EDITOR &&
> +               echo "GIT_EDITOR=$GIT_EDITOR" >expected &&
> +               git var -l >var &&
> +               cat var &&

Is this `cat` leftover debugging code?

> +               sed -n -e "/^GIT_EDITOR/,\$p" var | head -n 3 >actual &&
> +               test_cmp expected actual
> +       )
> +'
