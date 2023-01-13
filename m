Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB0CC61DB3
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 14:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjAMO2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjAMO10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 09:27:26 -0500
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4367493C2F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 06:17:40 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id 7so15082598pga.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 06:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oAXYNX3RKvOwaowgtf12hbETAaGqbNog2rVl5Bz75M=;
        b=Bd90GoADmJgp/gf4wOiQ/FnXkUtqq7DWZFQnw7LWdLTA8aMQabiqSmA7sUu3a8ze6K
         kHC2fQuKmPqooWFRqxfcRriyFFrHR0RGC75SXO7IGP0lsFUTajdYUUBQLSXkGvaenC8W
         lbGjcOMg/7Mq0S24mjgeAGmaSW/yrbgIkYkx1omXwAMe1BTI8Kx0E2quh6Yiuoesc67h
         7/muCIETv1cvCJIz3XEX8VtOIJNcZAhAr3tKeEHtvskqZLMGfBURwUk4yEjw7rVPWyP/
         Ei7BGD/Ff6DFQftRl0VB14AtegyzhTE3mwO6QznFKswRCxzHxlErWmB1KqG7l8xJ67vh
         BlIA==
X-Gm-Message-State: AFqh2koiVOUYZ0ZChZUqb7Rs8b8DnecvQT54AfeGoKuYkAfoYACPJLfj
        TyI4wqOysRjmY+3aSeyDLDnAO+6Urqkp3tm//eE=
X-Google-Smtp-Source: AMrXdXto5aCRm/eyaFKs6NwkbFy0QDpW1Z1ag8YPA2HRNW0z2+BMA//qX7Aarz22u/2pZmbJTXh6dtRLLdO0TcX/yGU=
X-Received: by 2002:a63:56:0:b0:4ac:1607:51a2 with SMTP id 83-20020a630056000000b004ac160751a2mr1731604pga.514.1673619435908;
 Fri, 13 Jan 2023 06:17:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
In-Reply-To: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Jan 2023 09:17:04 -0500
Message-ID: <CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com>
Subject: Re: [PATCH] ls-tree: add --sparse-filter-oid argument
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 12:05 PM William Sprent via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
> which takes the object id of a blob containing sparse checkout patterns
> that filters the output of 'ls-tree'. When filtering with given sparsity
> patterns, 'ls-tree' only outputs blobs and commit objects that
> match the given patterns.
> [...]
> Signed-off-by: William Sprent <williams@unity3d.com>

This is not a proper review, but rather just some comments about
issues I noticed while quickly running my eye over the patch. Many are
just micro-nits about style; a few regarding the tests are probably
actionable.

>     Note that one of the tests only pass when run on top of commit
>     5842710dc2 (dir: check for single file cone patterns, 2023-01-03), which
>     was submitted separately and is currently is merged to 'next'.

Thanks for mentioning this. It's exactly the sort of information the
maintainer needs when applying your patch to his tree. And it can be
helpful for reviewers too.

> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> @@ -48,6 +48,11 @@ OPTIONS
> +--sparse-filter-oid=<blob-ish>::
> +       Omit showing tree objects and paths that do not match the
> +       sparse-checkout specification contained in the blob
> +       (or blob-expression) <blob-ish>.

Good to see a documentation update. The SYNOPSIS probably deserves an
update too.

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> @@ -329,12 +331,79 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
> +static void sparse_filter_data__init(
> +       struct sparse_filter_data **d,
> +       const char *sparse_oid_name, read_tree_fn_t fn)
> +{
> +       struct object_id sparse_oid;
> +       struct object_context oc;
> +
> +       (*d) = xcalloc(1, sizeof(**d));
> +       (*d)->fn = fn;
> +       (*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
> +
> +       strbuf_init(&(*d)->full_path_buf, 0);
> +
> +

Nit: too many blank lines.

> +       if (get_oid_with_context(the_repository,
> +                                sparse_oid_name,
> +                                GET_OID_BLOB, &sparse_oid, &oc))

Pure nit: somewhat odd choice of wrapping; I'd have expected something
along the lines of:

    if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
                    &sparse_oid, &oc))

or:

    if (get_oid_with_context(the_repository, sparse_oid_name,
                    GET_OID_BLOB, &sparse_oid, &oc))

> +static void sparse_filter_data__free(struct sparse_filter_data *d)
> +{
> +       clear_pattern_list(&d->pl);
> +       strbuf_release(&d->full_path_buf);
> +       free(d);
> +}

Is the double-underscore convention in function names imported from
elsewhere? I don't recall seeing it used in this codebase.

> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
> +{
> +       enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
> +       return match > 0;
> +}
> +
> +

Nit: too many blank lines

> +static int filter_sparse(const struct object_id *oid, struct strbuf *base,
> +                        const char *pathname, unsigned mode, void *context)
> +{
> +
> +       struct sparse_filter_data *data = context;

Nit: unnecessary blank line after "{"

> +       int do_recurse = show_recursive(base->buf, base->len, pathname);
> +       if (object_type(mode) == OBJ_TREE)
> +               return do_recurse;
> +
> +       strbuf_reset(&data->full_path_buf);
> +       strbuf_addbuf(&data->full_path_buf, base);
> +       strbuf_addstr(&data->full_path_buf, pathname);
> +
> +       if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
> +               return 0;
> +
> +       return data->fn(oid, base, pathname, mode, context);
> +}
> +
> +

Nit: too many blank lines

> diff --git a/dir.c b/dir.c
> @@ -1450,45 +1450,51 @@ int init_sparse_checkout_patterns(struct index_state *istate)
> +static int path_in_sparse_checkout_1(const char *path,
> +                                    struct index_state *istate,
> +                                    int require_cone_mode)
> +{
> +
> +       /*

Nit: unnecessary blank line after "{"

> diff --git a/t/t3106-ls-tree-sparse-checkout.sh b/t/t3106-ls-tree-sparse-checkout.sh
> new file mode 100755

We often try to avoid introducing a new test script if the tests being
added can fit well into an existing script. If you didn't find any
existing script where these tests would fit, then creating a new
script may be fine.

> @@ -0,0 +1,103 @@
> +check_agrees_with_ls_files () {
> +       REPO=repo
> +       git -C $REPO submodule deinit -f --all
> +       git -C $REPO cat-file -p ${filter_oid} >${REPO}/.git/info/sparse-checkout
> +       git -C $REPO sparse-checkout init --cone 2>err
> +       git -C $REPO submodule init
> +       git -C $REPO ls-files -t| grep -v "^S "|cut -d" " -f2 >ls-files
> +       test_cmp ls-files actual
> +}

Several comments:

Since the return code of this function is significant and callers care
about it, you should &&-chain all of the code in the function itself
(just like you do within a test) so that failure of any command in the
function is noticed and causes the calling test to fail. It's a good
idea to &&-chain the variable assignments at the top of the function
too (just in case someone later inserts code above the assignments).

It's odd to see a mixture of $VAR and ${VAR}. It's better to be
consistent. We typically use the $VAR form (though it's not exclusive
by any means).

Some shells complain when the pathname following ">" redirection
operator is not quoted, so:

    git -C $REPO cat-file -p ${filter_oid} >"$REPO/.git/info/sparse-checkout" &&

Style: add space around "|" pipe operator

We usually avoid having a Git command upstream of the pipe since its
exit code gets swallowed by the pipe, so we usually do this instead:

    git -C $REPO ls-files -t >out &&
    grep -v "^S " out | cut -d" " -f2 >ls-files &&

Minor: The two-command pipeline `grep -v "^S " | cut -d" " -f2
>ls-files` could be expressed via a single `sed` invocation:

    sed -n "/^S /!s/^. //p" out &&

Nit: The first argument to test_cmp() is typically named "expect".

Error output is captured to file "err" but that file is never consulted.

> +check_same_result_in_bare_repo () {
> +       FULL=repo
> +       BARE=bare
> +       FILTER=$1
> +       git -C repo cat-file -p ${filter_oid}| git -C bare hash-object -w --stdin
> +       git -C bare ls-tree --name-only --filter-sparse-oid=${filter_oid} -r HEAD >bare-result
> +       test_cmp expect bare-result
> +}

Same comments as above, plus:

What is the purpose of the variables FULL, BARE, FILTER? They don't
seem to be used in the function.

I suspect that the function should be using $FILTER internally rather
than $filter_oid.

> +test_expect_success 'setup' '
> +       git init submodule &&
> +       (
> +               cd submodule &&
> +               test_commit file
> +       ) &&

Minor: test_commit() accepts a -C option, so this could be done
without the subshell:

    test_commit -C submodule file

> +       git init repo &&
> +       (
> +               cd repo &&
> +               mkdir dir &&
> +               test_commit dir/sub-file &&
> +               test_commit dir/sub-file2 &&
> +               mkdir dir2 &&
> +               test_commit dir2/sub-file1 &&
> +               test_commit dir2/sub-file2 &&
> +               test_commit top-file &&
> +               git clone ../submodule submodule &&
> +               git submodule add ./submodule &&
> +               git submodule absorbgitdirs &&
> +               git commit -m"add submodule" &&
> +               git sparse-checkout init --cone
> +       ) &&

Here the subshell makes sense since so many commands are run in
directory "repo." Fine.
