From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/10] branch: refactor width computation
Date: Mon, 10 Aug 2015 21:58:10 -0400
Message-ID: <CAPig+cRHvkAEM1ayVc5nj6RCih52x1+Bn9YTQPV93ej=3arK2Q@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
	<1438693282-15516-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:58:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOypW-0003LE-2F
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 03:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933448AbbHKB6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 21:58:12 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34494 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbbHKB6L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 21:58:11 -0400
Received: by ykdt205 with SMTP id t205so75130498ykd.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zYg//uOab41TeKxPOBn8PXG0Yiz8KoyMwzwh+KsKbzM=;
        b=xz46sy1933iC5Miodn1KBbA5e10VfA0JjegTP4Y1pgnnyFFunrv9+MOGAYHHWYFWAt
         ONQyRziFJBkhUjb7+cIpqDjvAW7OOejLvImE+3wQmMNrJCr5F2R17zFzdvDMBlaRhNNE
         XMWS6wLPScwVLZd+/CvLaZqJK93w0Zt6qqVqCDt7uh8UIYb7jS0oTwvAFRjAhYyRoQHA
         qxnM4IIWqntWuJmjB1nmDny3DibBSjplI1wcYszNq+f2DdCCm8PdO3ixFmNgbYcBTn9t
         ig96yIR7BcjXt84Tiaw++6XHLNLO2pvsfiPy+vaCYnOBULhatNpvW1tu/dy3GZxMfUCg
         QrgA==
X-Received: by 10.13.220.132 with SMTP id f126mr24819665ywe.39.1439258290212;
 Mon, 10 Aug 2015 18:58:10 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 18:58:10 -0700 (PDT)
In-Reply-To: <1438693282-15516-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: y43xm68BkUKK0dM-Gs0xmPN7XXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275667>

On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Remove unnecessary variables from ref_list and ref_item which were
> used for width computation. This is to make ref_item similar to
> ref-filter's ref_array_item. This will ensure a smooth port of
> branch.c to use ref-filter APIs in further patches.
>
> Previously the maxwidth was computed when inserting the refs into the
> ref_list. Now, we obtain the entire ref_list and then compute
> maxwidth.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4fc8beb..b058b74 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -557,16 +552,21 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
> -static int calc_maxwidth(struct ref_list *refs)
> +static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
>  {
> -       int i, w = 0;
> +       int i, max = 0;
>         for (i = 0; i < refs->index; i++) {
> +               struct ref_item *it = &refs->list[i];
> +               int w = utf8_strwidth(it->name);
> +
>                 if (refs->list[i].ignore)
>                         continue;

Nit: Unnecessary work. You compute the width and then immediately
throw it away when 'ignore' is true.

Also, you use 'it' elsewhere rather than 'refs->list[i]' but not this
line, which makes it seem out of place. I would have expected to see:

    if (it->ignore)
        continue;

(Despite the noisier diff, the end result will be more consistent.)

> -               if (refs->list[i].width > w)
> -                       w = refs->list[i].width;
> +               if (it->kind == REF_REMOTE_BRANCH)
> +                       w += remote_bonus;
> +               if (w > max)
> +                       max = w;
>         }
> -       return w;
> +       return max;
>  }


On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Remove unnecessary variables from ref_list and ref_item which were
> used for width computation. This is to make ref_item similar to
> ref-filter's ref_array_item. This will ensure a smooth port of
> branch.c to use ref-filter APIs in further patches.
>
> Previously the maxwidth was computed when inserting the refs into the
> ref_list. Now, we obtain the entire ref_list and then compute
> maxwidth.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/branch.c | 61 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4fc8beb..b058b74 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -282,14 +282,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  struct ref_item {
>         char *name;
>         char *dest;
> -       unsigned int kind, width;
> +       unsigned int kind;
>         struct commit *commit;
>         int ignore;
>  };
>
>  struct ref_list {
>         struct rev_info revs;
> -       int index, alloc, maxwidth, verbose, abbrev;
> +       int index, alloc, verbose, abbrev;
>         struct ref_item *list;
>         struct commit_list *with_commit;
>         int kinds;
> @@ -386,15 +386,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
>         newitem->name = xstrdup(refname);
>         newitem->kind = kind;
>         newitem->commit = commit;
> -       newitem->width = utf8_strwidth(refname);
>         newitem->dest = resolve_symref(orig_refname, prefix);
>         newitem->ignore = 0;
> -       /* adjust for "remotes/" */
> -       if (newitem->kind == REF_REMOTE_BRANCH &&
> -           ref_list->kinds != REF_REMOTE_BRANCH)
> -               newitem->width += 8;
> -       if (newitem->width > ref_list->maxwidth)
> -               ref_list->maxwidth = newitem->width;
>
>         return 0;
>  }
> @@ -505,11 +498,12 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
>  }
>
>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
> -                          int abbrev, int current, char *prefix)
> +                          int abbrev, int current, const char *remote_prefix)
>  {
>         char c;
>         int color;
>         struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
> +       const char *prefix = "";
>
>         if (item->ignore)
>                 return;
> @@ -520,6 +514,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>                 break;
>         case REF_REMOTE_BRANCH:
>                 color = BRANCH_COLOR_REMOTE;
> +               prefix = remote_prefix;
>                 break;
>         default:
>                 color = BRANCH_COLOR_PLAIN;
> @@ -557,16 +552,21 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>         strbuf_release(&out);
>  }
>
> -static int calc_maxwidth(struct ref_list *refs)
> +static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
>  {
> -       int i, w = 0;
> +       int i, max = 0;
>         for (i = 0; i < refs->index; i++) {
> +               struct ref_item *it = &refs->list[i];
> +               int w = utf8_strwidth(it->name);
> +
>                 if (refs->list[i].ignore)
>                         continue;
> -               if (refs->list[i].width > w)
> -                       w = refs->list[i].width;
> +               if (it->kind == REF_REMOTE_BRANCH)
> +                       w += remote_bonus;
> +               if (w > max)
> +                       max = w;
>         }
> -       return w;
> +       return max;
>  }
>
>  static char *get_head_description(void)
> @@ -600,21 +600,18 @@ static char *get_head_description(void)
>         return strbuf_detach(&desc, NULL);
>  }
>
> -static void show_detached(struct ref_list *ref_list)
> +static void show_detached(struct ref_list *ref_list, int maxwidth)
>  {
>         struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
>
>         if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
>                 struct ref_item item;
>                 item.name = get_head_description();
> -               item.width = utf8_strwidth(item.name);
>                 item.kind = REF_LOCAL_BRANCH;
>                 item.dest = NULL;
>                 item.commit = head_commit;
>                 item.ignore = 0;
> -               if (item.width > ref_list->maxwidth)
> -                       ref_list->maxwidth = item.width;
> -               print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
> +               print_ref_item(&item, maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
>                 free(item.name);
>         }
>  }
> @@ -624,6 +621,16 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>         int i;
>         struct append_ref_cb cb;
>         struct ref_list ref_list;
> +       int maxwidth = 0;
> +       const char *remote_prefix = "";
> +
> +       /*
> +        * If we are listing more than just remote branches,
> +        * then remote branches will have a "remotes/" prefix.
> +        * We need to account for this in the width.
> +        */
> +       if (kinds != REF_REMOTE_BRANCH)
> +               remote_prefix = "remotes/";
>
>         memset(&ref_list, 0, sizeof(ref_list));
>         ref_list.kinds = kinds;
> @@ -667,26 +674,22 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>                         clear_commit_marks(item->commit, ALL_REV_FLAGS);
>                 }
>                 clear_commit_marks(filter, ALL_REV_FLAGS);
> -
> -               if (verbose)
> -                       ref_list.maxwidth = calc_maxwidth(&ref_list);
>         }
> +       if (verbose)
> +               maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>
>         qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>
>         detached = (detached && (kinds & REF_LOCAL_BRANCH));
>         if (detached && match_patterns(pattern, "HEAD"))
> -               show_detached(&ref_list);
> +               show_detached(&ref_list, maxwidth);
>
>         for (i = 0; i < ref_list.index; i++) {
>                 int current = !detached &&
>                         (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
>                         !strcmp(ref_list.list[i].name, head);
> -               char *prefix = (kinds != REF_REMOTE_BRANCH &&
> -                               ref_list.list[i].kind == REF_REMOTE_BRANCH)
> -                               ? "remotes/" : "";
> -               print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
> -                              abbrev, current, prefix);
> +               print_ref_item(&ref_list.list[i], maxwidth, verbose,
> +                              abbrev, current, remote_prefix);
>         }
>
>         free_ref_list(&ref_list);
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
