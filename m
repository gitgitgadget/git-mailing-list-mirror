Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2592047F
	for <e@80x24.org>; Thu, 21 Sep 2017 09:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdIUJId convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Sep 2017 05:08:33 -0400
Received: from mail5.fer.hr ([161.53.72.235]:47176 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751724AbdIUJId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 05:08:33 -0400
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.361.1;
 Thu, 21 Sep 2017 11:08:30 +0200
Received: from mail-yw0-f176.google.com (209.85.161.176) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Sep
 2017 11:08:30 +0200
Received: by mail-yw0-f176.google.com with SMTP id p10so3619664ywh.8
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 02:08:30 -0700 (PDT)
X-Gm-Message-State: AHPjjUjK1I1zp645yFjyq5JCzfgAIuZYwP38k8DO2T3FlIWok/jP4S5e
        Mbrm+LdDj+h4vdne5/oiYACTe1IXJQWUCuxXKck=
X-Google-Smtp-Source: AOwi7QDTAFW5mwO6vKqkwef7i1cgkD7/4RmKruXcX1y6OBUEeF9NqE0tsL/rYowInXgrGpKBej9vYJK9Y6cJXNyBNxg=
X-Received: by 10.13.235.197 with SMTP id u188mr1092825ywe.349.1505984908514;
 Thu, 21 Sep 2017 02:08:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.138 with HTTP; Thu, 21 Sep 2017 02:07:48 -0700 (PDT)
In-Reply-To: <20170920235502.6214-1-jonathantanmy@google.com>
References: <CAEPqvoyVJFe2EOvhnZD4vdF=1-VuoZrMP92TeGJ2WAE0X+B5Tw@mail.gmail.com>
 <20170920235502.6214-1-jonathantanmy@google.com>
From:   =?UTF-8?B?SnVyYWogT3LFoXVsacSH?= <juraj.orsulic@fer.hr>
Date:   Thu, 21 Sep 2017 11:07:48 +0200
X-Gmail-Original-Message-ID: <CAEPqvox03p3jVSy4e9q+e_rE+oEudE=Y3FtX+AXahaYs9hYX9A@mail.gmail.com>
Message-ID: <CAEPqvox03p3jVSy4e9q+e_rE+oEudE=Y3FtX+AXahaYs9hYX9A@mail.gmail.com>
Subject: Re: [PATCH] fast-export: do not copy from modified file
To:     Jonathan Tan <jonathantanmy@google.com>
CC:     <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [209.85.161.176]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, Jonathan!

On Thu, Sep 21, 2017 at 1:55 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> When run with the "-C" option, fast-export writes 'C' commands in its
> output whenever the internal diff mechanism detects a file copy,
> indicating that fast-import should copy the given existing file to the
> given new filename. However, the diff mechanism works against the
> prior version of the file, whereas fast-import uses whatever is current.
> This causes issues when a commit both modifies a file and uses it as the
> source for a copy.
>
> Therefore, teach fast-export to refrain from writing 'C' when it has
> already written a modification command for a file.
>
> An existing test in t9350-fast-export is also fixed in this patch. The
> existing line "C file6 file7" copies the wrong version of file6, but it
> has coincidentally worked because file7 was subsequently overridden.
>
> Reported-by: Juraj Oršulić <juraj.orsulic@fer.hr>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I tested this with the reproduction commands given by Juraj Oršulić and
> it works.
>
> I also have a version that prints the redundant 'C' (and does not
> require the change to t9350), omitting it only if it would cause a wrong
> result. That seems imprecise to me, but I can send that out if the
> redundant 'C' is preferred.
> ---
>  builtin/fast-export.c  | 46 ++++++++++++++++++++++++++++++++--------------
>  t/t9350-fast-export.sh | 20 +++++++++++++++++++-
>  2 files changed, 51 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d412c0a8f..da42ee5e6 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -344,6 +344,7 @@ static void show_filemodify(struct diff_queue_struct *q,
>                             struct diff_options *options, void *data)
>  {
>         int i;
> +       struct string_list *changed = data;
>
>         /*
>          * Handle files below a directory first, in case they are all deleted
> @@ -359,20 +360,31 @@ static void show_filemodify(struct diff_queue_struct *q,
>                 case DIFF_STATUS_DELETED:
>                         printf("D ");
>                         print_path(spec->path);
> +                       string_list_insert(changed, spec->path);
>                         putchar('\n');
>                         break;
>
>                 case DIFF_STATUS_COPIED:
>                 case DIFF_STATUS_RENAMED:
> -                       printf("%c ", q->queue[i]->status);
> -                       print_path(ospec->path);
> -                       putchar(' ');
> -                       print_path(spec->path);
> -                       putchar('\n');
> -
> -                       if (!oidcmp(&ospec->oid, &spec->oid) &&
> -                           ospec->mode == spec->mode)
> -                               break;
> +                       /*
> +                        * If a change in the file corresponding to ospec->path
> +                        * has been observed, we cannot trust its contents
> +                        * because the diff is calculated based on the prior
> +                        * contents, not the current contents.  So, declare a
> +                        * copy or rename only if there was no change observed.
> +                        */
> +                       if (!string_list_has_string(changed, ospec->path)) {
> +                               printf("%c ", q->queue[i]->status);
> +                               print_path(ospec->path);
> +                               putchar(' ');
> +                               print_path(spec->path);
> +                               string_list_insert(changed, spec->path);
> +                               putchar('\n');
> +
> +                               if (!oidcmp(&ospec->oid, &spec->oid) &&
> +                                   ospec->mode == spec->mode)
> +                                       break;
> +                       }
>                         /* fallthrough */
>
>                 case DIFF_STATUS_TYPE_CHANGED:
> @@ -393,6 +405,7 @@ static void show_filemodify(struct diff_queue_struct *q,
>                                        get_object_mark(object));
>                         }
>                         print_path(spec->path);
> +                       string_list_insert(changed, spec->path);
>                         putchar('\n');
>                         break;
>
> @@ -528,7 +541,8 @@ static void anonymize_ident_line(const char **beg, const char **end)
>         *end = out->buf + out->len;
>  }
>
> -static void handle_commit(struct commit *commit, struct rev_info *rev)
> +static void handle_commit(struct commit *commit, struct rev_info *rev,
> +                         struct string_list *paths_of_changed_objects)
>  {
>         int saved_output_format = rev->diffopt.output_format;
>         const char *commit_buffer;
> @@ -615,6 +629,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>         if (full_tree)
>                 printf("deleteall\n");
>         log_tree_diff_flush(rev);
> +       string_list_clear(paths_of_changed_objects, 0);
>         rev->diffopt.output_format = saved_output_format;
>
>         printf("\n");
> @@ -630,14 +645,15 @@ static void *anonymize_tag(const void *old, size_t *len)
>         return strbuf_detach(&out, len);
>  }
>
> -static void handle_tail(struct object_array *commits, struct rev_info *revs)
> +static void handle_tail(struct object_array *commits, struct rev_info *revs,
> +                       struct string_list *paths_of_changed_objects)
>  {
>         struct commit *commit;
>         while (commits->nr) {
>                 commit = (struct commit *)commits->objects[commits->nr - 1].item;
>                 if (has_unshown_parent(commit))
>                         return;
> -               handle_commit(commit, revs);
> +               handle_commit(commit, revs, paths_of_changed_objects);
>                 commits->nr--;
>         }
>  }
> @@ -977,6 +993,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>         char *export_filename = NULL, *import_filename = NULL;
>         uint32_t lastimportid;
>         struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
> +       struct string_list paths_of_changed_objects = STRING_LIST_INIT_DUP;
>         struct option options[] = {
>                 OPT_INTEGER(0, "progress", &progress,
>                             N_("show progress after <n> objects")),
> @@ -1049,14 +1066,15 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>         if (prepare_revision_walk(&revs))
>                 die("revision walk setup failed");
>         revs.diffopt.format_callback = show_filemodify;
> +       revs.diffopt.format_callback_data = &paths_of_changed_objects;
>         DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
>         while ((commit = get_revision(&revs))) {
>                 if (has_unshown_parent(commit)) {
>                         add_object_array(&commit->object, NULL, &commits);
>                 }
>                 else {
> -                       handle_commit(commit, &revs);
> -                       handle_tail(&commits, &revs);
> +                       handle_commit(commit, &revs, &paths_of_changed_objects);
> +                       handle_tail(&commits, &revs, &paths_of_changed_objects);
>                 }
>         }
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 8dcb05c4a..866ddf605 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -234,7 +234,7 @@ test_expect_success 'fast-export -C -C | fast-import' '
>         mkdir new &&
>         git --git-dir=new/.git init &&
>         git fast-export -C -C --signed-tags=strip --all > output &&
> -       grep "^C file6 file7\$" output &&
> +       grep "^C file2 file4\$" output &&
>         cat output |
>         (cd new &&
>          git fast-import &&
> @@ -522,4 +522,22 @@ test_expect_success 'delete refspec' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'when using -C, do not declare copy when source of copy is also modified' '
> +       test_create_repo src &&
> +       echo a_line >src/file.txt &&
> +       git -C src add file.txt &&
> +       git -C src commit -m 1st_commit &&
> +
> +       cp src/file.txt src/file2.txt &&
> +       echo another_line >>src/file.txt &&
> +       git -C src add file.txt file2.txt &&
> +       git -C src commit -m 2nd_commit &&
> +
> +       test_create_repo dst &&
> +       git -C src fast-export --all -C | git -C dst fast-import &&
> +       git -C src show >expected &&
> +       git -C dst show >actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
> 2.14.1.821.g8fa685d3b7-goog
>
