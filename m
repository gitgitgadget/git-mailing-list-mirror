From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Sat, 12 Sep 2015 23:19:35 -0400
Message-ID: <CAPig+cT6JLzPPpJKPxAZGGduEQTRzwa57pHtGOJjPYPxCwJV=w@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 05:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaxpM-0003r3-U6
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 05:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbbIMDTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 23:19:36 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36121 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbbIMDTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 23:19:35 -0400
Received: by ykdt18 with SMTP id t18so105439020ykd.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7cSLzu5XjvogUB31NOAjjb083WkrgQG4jA1xQPCgWqU=;
        b=yZgtdyazwGW4UVzJDDocpqKcqZOokiSNqTZ9lX3BLN2ucJlO5KZRD1Z7/jrgMvLDms
         iNfWMf92gM4S7h0utJEdo7+Ia1GuEqXINFikqVwo58ilp+BBhCtqYz4RUNX3i09Kbr5U
         kXKjOECBFqBRWg9IEJxpVvFt5JyF0pxv2zmf766K4PRnSrT+fDq66e+aJbdiJZr3GMfK
         k7iH80UUMkTdNxk2eSd2mrfUoxCkvKl5l/KcJuE+N5YcHRD+26xUKjMBmRkOjDV1HeA/
         Pr/yI1Xuf99A9nvMbLv4JJ8ba+JyVSoGajnvBTckBbH/MUbLvS6zd8za41EBamldwxze
         vtZw==
X-Received: by 10.13.201.130 with SMTP id l124mr6781465ywd.39.1442114375098;
 Sat, 12 Sep 2015 20:19:35 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sat, 12 Sep 2015 20:19:35 -0700 (PDT)
In-Reply-To: <1441402769-35897-3-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: RDDW_dGs_bUVrezjE_ArMZ0W-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277755>

On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> The code formerly in branch.c was largely the basis of the
> get_worktree_list implementation is now moved to worktree.c,
> and the find_shared_symref implementation has been refactored
> to use get_worktree_list

Some comments below in addition to those by Junio...

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/branch.h b/branch.h
> index d3446ed..58aa45f 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -59,12 +59,4 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>   */
>  extern void die_if_checked_out(const char *branch);
>
> -/*
> - * Check if a per-worktree symref points to a ref in the main worktree
> - * or any linked worktree, and return the path to the exising worktree
> - * if it is.  Returns NULL if there is no existing ref.  The caller is
> - * responsible for freeing the returned path.
> - */
> -extern char *find_shared_symref(const char *symref, const char *target);
> -
>  #endif
> diff --git a/worktree.c b/worktree.c
> index 33d2e57..e45b651 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -155,3 +155,43 @@ done:
>         return list;
>  }
>
> +char *find_shared_symref(const char *symref, const char *target)
> +{
> +       char *existing = NULL;
> +       struct strbuf path = STRBUF_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +       struct worktree_list *worktree_list = get_worktree_list();
> +       struct worktree_list *orig_list = worktree_list;
> +       struct worktree *matched = NULL;
> +
> +       while (!matched && worktree_list) {
> +               if (strcmp("HEAD", symref)) {

The result of strcmp() never changes, so this (expensive) check could
be lifted out of the 'while' loop, however...

> +                       strbuf_reset(&path);
> +                       strbuf_reset(&sb);
> +                       strbuf_addf(&path, "%s/%s", worktree_list->worktree->git_dir, symref);
> +
> +                       if (_parse_ref(path.buf, &sb, NULL)) {
> +                               continue;
> +                       }
> +
> +                       if (!strcmp(sb.buf, target))
> +                               matched = worktree_list->worktree;

The original code in branch.c, which this patch removes, did not need
to make a special case of HEAD, so it's not immediately clear why this
replacement code does so. This is the sort of issue which argues in
favor of mutating the existing code (slowly) over the course of
several patches into the final form, rather than having the final form
come into existence out of thin air. When the changes are made
incrementally, it is easier for reviewers to understand why such
modifications are needed, which (hopefully) should lead to fewer
questions such as this one.

> +               } else {
> +                       if (worktree_list->worktree->head_ref && !strcmp(worktree_list->worktree->head_ref, target))
> +                               matched = worktree_list->worktree;
> +               }
> +               worktree_list = worktree_list->next ? worktree_list->next : NULL;
> +       }
> +
> +       if (matched) {
> +               existing = malloc(strlen(matched->path) + 1);
> +               strcpy(existing, matched->path);

A couple issues:

This can be done more concisely and safely with xstrdup().

In this codebase, it probably would be more idiomatic to use goto to
drop out of the loop rather than setting 'matched' and then having to
check 'matched' in the loop condition. So, for instance, each place
which sets 'matched' could instead say:

    existing = xstrdup(...);
    goto done;

> +       }
> +
> +done:

This label doesn't have any matching goto's.

> +       strbuf_release(&path);
> +       strbuf_release(&sb);
> +       worktree_list_release(orig_list);
> +
> +       return existing;
> +}
> diff --git a/worktree.h b/worktree.h
> index 2bc0ab8..320f17e 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -45,4 +45,11 @@ struct worktree *get_worktree(const char *id);
>  extern void worktree_list_release(struct worktree_list *);
>  extern void worktree_release(struct worktree *);
>
> +/*
> + * Look for a symref in any worktree, and return the path to the first
> + * worktree found or NULL if not found.  The caller is responsible for
> + * freeing the returned path.
> + */

For some reason, this comment differs a fair bit from the original in
branch.h which was removed by this patch, however, the original
comment was a bit more explanatory (I think).

As a general rule, it's better to do code movement and code changes in
separate patches since it's hard for reviewers to detect and
comprehend differences in code which has been both moved and changed
at the same time.

> +extern char *find_shared_symref(const char *symref, const char *target);
> +
>  #endif
> --
> 2.5.0
