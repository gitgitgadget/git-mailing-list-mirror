From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] tag: support mixing --sort=<spec> and -n
Date: Sat, 5 Sep 2015 15:25:36 -0700
Message-ID: <CA+P7+xo=4mC0fKkbtL+fkMXGxdUNcdUGUYHdaJ58MF9jVUUziw@mail.gmail.com>
References: <20150905175202.GC7050@zero.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Rudy Matela <rudy@matela.com.br>
X-From: git-owner@vger.kernel.org Sun Sep 06 00:26:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYLuf-0004Du-SQ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 00:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbbIEWZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 18:25:58 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36388 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbbIEWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 18:25:56 -0400
Received: by igcrk20 with SMTP id rk20so33793155igc.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wPlZSDlHIyATR/j8ou8FbSPqc4LAQv5I91whG81e4r4=;
        b=Ri3zYqzekSAwaolBrmNQYtDBZNHON37irHvs8BSuUZQTupKb0wsTRyFwIK8CSd1x9e
         tGyEGPwn8vF6GG3ZKJs+LoST/MVf7QnmuL85iBPgsDOYETIMMd1y2rOCtUywSPZi1sBI
         V+C3os16qji2MbJ/2XsqQjyd2iM+Dv3HThfRuDGWZhZ8lMQpFQfIwnfvR14NFlkxnSnc
         7meI71CzlNDVmNSOZvXITSdoUzrHhEO/kTRKupiZJ4+Q7R9ByQQwzp9i+RGPqItLk8jk
         JY3DRtid9Yc6bBTJfl4+5ntVDra4nOw3HPi+CqcosPo7lLAzYjpl9zBBIbZgs7iMTXnp
         3fdw==
X-Received: by 10.50.3.66 with SMTP id a2mr19573051iga.92.1441491955958; Sat,
 05 Sep 2015 15:25:55 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 5 Sep 2015 15:25:36 -0700 (PDT)
In-Reply-To: <20150905175202.GC7050@zero.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277412>

On Sat, Sep 5, 2015 at 10:52 AM, Rudy Matela <rudy@matela.com.br> wrote:
>
> Allow -n and --sort=version:refname to be used together
> instead of failing with:
>
>   fatal: --sort and -n are incompatible
>
> Signed-off-by: Rudy Matela <rudy@matela.com.br>

Nice! I've been wondering about this one for a while. Especially since
implementing tag.sort configuration which made -n not work at all.

Note that it may be worth rebasing this on top of Karthik's part tag
to use ref-filter series, since I think there will be plenty of merge
conflicts there...

I also suggest adding some tests for this, as sort and -n didn't even
have a test before, but now we could add a test that shows it works.

> ---
>  builtin/tag.c | 64 ++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index cccca99..cdcb373 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -176,13 +176,19 @@ static enum contains_result contains(struct commit *candidate,
>         return contains_test(candidate, want);
>  }
>
> -static void show_tag_lines(const struct object_id *oid, int lines)
> +static char *get_tag_lines(const struct object_id *oid, int lines)
>  {
>         int i;
>         unsigned long size;
>         enum object_type type;
>         char *buf, *sp, *eol;
>         size_t len;
> +       struct strbuf sb;
> +
> +       if (!lines)
> +               return NULL;
> +
> +       strbuf_init(&sb,0);
>
>         buf = read_sha1_file(oid->hash, &type, &size);
>         if (!buf)
> @@ -203,20 +209,21 @@ static void show_tag_lines(const struct object_id *oid, int lines)
>                 size = parse_signature(buf, size);
>         for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
>                 if (i)
> -                       printf("\n    ");
> +                       strbuf_addstr(&sb,"\n    ");
>                 eol = memchr(sp, '\n', size - (sp - buf));
>                 len = eol ? eol - sp : size - (sp - buf);
> -               fwrite(sp, len, 1, stdout);
> +               strbuf_add(&sb, sp, len);
>                 if (!eol)
>                         break;
>                 sp = eol + 1;
>         }
>  free_return:
>         free(buf);
> +       return strbuf_detach(&sb, NULL);
>  }
>
> -static int show_reference(const char *refname, const struct object_id *oid,
> -                         int flag, void *cb_data)
> +static int get_reference_and_tag_lines(const char *refname, const struct object_id *oid,
> +                                      int flag, void *cb_data)
>  {
>         struct tag_filter *filter = cb_data;
>
> @@ -234,16 +241,8 @@ static int show_reference(const char *refname, const struct object_id *oid,
>                 if (points_at.nr && !match_points_at(refname, oid->hash))
>                         return 0;
>
> -               if (!filter->lines) {
> -                       if (filter->sort)
> -                               string_list_append(&filter->tags, refname);
> -                       else
> -                               printf("%s\n", refname);
> -                       return 0;
> -               }
> -               printf("%-15s ", refname);
> -               show_tag_lines(oid, filter->lines);
> -               putchar('\n');
> +               string_list_append(&filter->tags, refname)->util =
> +                       get_tag_lines(oid, filter->lines);
>         }
>
>         return 0;
> @@ -260,6 +259,7 @@ static int list_tags(const char **patterns, int lines,
>                      struct commit_list *with_commit, int sort)
>  {
>         struct tag_filter filter;
> +       int i;
>
>         filter.patterns = patterns;
>         filter.lines = lines;
> @@ -268,20 +268,28 @@ static int list_tags(const char **patterns, int lines,
>         memset(&filter.tags, 0, sizeof(filter.tags));
>         filter.tags.strdup_strings = 1;
>
> -       for_each_tag_ref(show_reference, (void *)&filter);
> -       if (sort) {
> -               int i;
> -               if ((sort & SORT_MASK) == VERCMP_SORT)
> -                       qsort(filter.tags.items, filter.tags.nr,
> -                             sizeof(struct string_list_item), sort_by_version);
> -               if (sort & REVERSE_SORT)
> -                       for (i = filter.tags.nr - 1; i >= 0; i--)
> +       for_each_tag_ref(get_reference_and_tag_lines, (void *)&filter);
> +       if ((sort & SORT_MASK) == VERCMP_SORT)
> +               qsort(filter.tags.items, filter.tags.nr,
> +                     sizeof(struct string_list_item), sort_by_version);

Nice. So we store the items and sort  by the lines.

> +       if (sort & REVERSE_SORT)
> +               for (i = filter.tags.nr - 1; i >= 0; i--)
> +                       if (lines)
> +                               printf("%-15s %s\n",
> +                                       filter.tags.items[i].string,
> +                                       (char*)filter.tags.items[i].util);
> +                       else
>                                 printf("%s\n", filter.tags.items[i].string);
> -               else
> -                       for (i = 0; i < filter.tags.nr; i++)
> +       else
> +               for (i = 0; i < filter.tags.nr; i++)
> +                       if (lines)
> +                               printf("%-15s %s\n",
> +                                       filter.tags.items[i].string,
> +                                       (char*)filter.tags.items[i].util);

I see we print them here (or above depending on whether we reverse sort or not..

Nice! I would maybe suggest if we can rename util to something else so
it is more clear? Maybe I am not understanding why it has to be named
such.

> +                       else
>                                 printf("%s\n", filter.tags.items[i].string);
> -               string_list_clear(&filter.tags, 0);
> -       }
> +       string_list_clear(&filter.tags, 1);
> +
>         return 0;
>  }
>
> @@ -665,8 +673,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>                         copts.padding = 2;
>                         run_column_filter(colopts, &copts);
>                 }
> -               if (lines != -1 && tag_sort)
> -                       die(_("--sort and -n are incompatible"));
>                 ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, tag_sort);
>                 if (column_active(colopts))
>                         stop_column_filter();
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
