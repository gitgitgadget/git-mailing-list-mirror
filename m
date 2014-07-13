From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Sat, 12 Jul 2014 23:29:40 -0400
Message-ID: <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	<1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 05:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6AU2-0000bK-9I
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 05:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaGMD3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 23:29:44 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45877 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaGMD3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 23:29:42 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so1955324lbd.19
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 20:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IkLfKuQVyzESXnvb3qcFA0P8Ycy4drlz8kg7qKvp2VM=;
        b=1JZ4Pc3kzKO1OlXuXclGXPoUe82DKdcwRb1I9deNlTpaKjxnjxoMXMjJe2cdgWrnqk
         rX8RkWnrTbZlg2UZXJ/DE2WZNvHRzrh7hW9NnPjyWXXZBCiYDlZV8FtSeyOYDfuhWjY2
         W5INkEZm92pc+YZfAeRAwdWh/XivzbNwEmPb+sfp2yUZ6YCY2yGOVEtj+8TLVVa/0T/b
         bY+Z1oP86ZdUwBzI/umd+xN8Op3vTtURVgdlBS/zOYU/KK2wKSmpZb6BQ0Ontb8sLVxh
         2vNrgJZB6hkke9FIQ8eHDtB26nUCYsW1FBAT5uhdHdINIlWqc8ptcNMVTvCoEvGPkloS
         i3zw==
X-Received: by 10.112.140.41 with SMTP id rd9mr6826586lbb.31.1405222180428;
 Sat, 12 Jul 2014 20:29:40 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Sat, 12 Jul 2014 20:29:40 -0700 (PDT)
In-Reply-To: <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: Wb85Cn3oeal4Vcc8od-CKieB7rU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253400>

On Fri, Jul 11, 2014 at 6:55 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Add support for configuring default sort ordering for git tags. Command
> line option will override this configured value, using the exact same
> syntax.
>
> Cc: Jeff King <peff@peff.net>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Made parse_sort_string take a "var" parameter, and if given will only warn
> about invalid parameter, instead of error.

This seems unnecessarily ugly since it's hard-coding specialized
knowledge of the callers' error-reporting requirements into what
should be a generalized parsing function. If you instead make
parse_sort_string() responsible only for attempting to parse the
value, but leave error-reporting to the callers, then this ugliness
goes away. See below.

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9d7643f127e7..97c5317c28e5 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -32,6 +32,8 @@ static const char * const git_tag_usage[] = {
>  #define SORT_MASK       0x7fff
>  #define REVERSE_SORT    0x8000
>
> +static int tag_sort;
> +
>  struct tag_filter {
>         const char **patterns;
>         int lines;
> @@ -346,9 +348,49 @@ static const char tag_template_nocleanup[] =
>         "Lines starting with '%c' will be kept; you may remove them"
>         " yourself if you want to.\n");
>
> +/*
> + * Parse a sort string, and return 0 if parsed successfully. Will return
> + * non-zero when the sort string does not parse into a known type.
> + */
> +static int parse_sort_string(const char *var, const char *value, int *sort)
> +{
> +       int type = 0, flags = 0;
> +
> +       if (skip_prefix(value, "-", &value))
> +               flags |= REVERSE_SORT;
> +
> +       if (skip_prefix(value, "version:", &value) || skip_prefix(value, "v:", &value))
> +               type = VERCMP_SORT;
> +       else
> +               type = STRCMP_SORT;
> +
> +       if (strcmp(value, "refname")) {
> +               if (!var)
> +                       return error(_("unsupported sort specification '%s'"), value);
> +               else {
> +                       warning(_("unsupported sort specification '%s' in variable '%s'"),
> +                               var, value);
> +                       return -1;

Just return -1 here, but don't print any diagnostics. Let the callers
do that. (See below.)

> +               }
> +       }
> +
> +       *sort = (type | flags);
> +
> +       return 0;
> +}
> +
>  static int git_tag_config(const char *var, const char *value, void *cb)
>  {
> -       int status = git_gpg_config(var, value, cb);
> +       int status;
> +
> +       if (!strcmp(var, "tag.sort")) {
> +               if (!value)
> +                       return config_error_nonbool(var);
> +               parse_sort_string(var, value, &tag_sort);

    if (parse_sort_string(value, &tag_sort))
        warning(_("unsupported sort specification '%s' in variable '%s'"),
            var, value);

> +               return 0;
> +       }
> +
> +       status = git_gpg_config(var, value, cb);
>         if (status)
>                 return status;
>         if (starts_with(var, "column."))
> @@ -522,20 +564,8 @@ static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
>  static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
>  {
>         int *sort = opt->value;
> -       int flags = 0;
>
> -       if (skip_prefix(arg, "-", &arg))
> -               flags |= REVERSE_SORT;
> -
> -       if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
> -               *sort = VERCMP_SORT;
> -       else
> -               *sort = STRCMP_SORT;
> -
> -       if (strcmp(arg, "refname"))
> -               die(_("unsupported sort specification %s"), arg);
> -       *sort |= flags;
> -       return 0;
> +       return parse_sort_string(NULL, arg, sort);

    if (parse_sort_string(arg, sort))
        return error(_("unsupported sort specification '%s'"), arg);
    return 0;

>  }
>
>  int cmd_tag(int argc, const char **argv, const char *prefix)
> @@ -548,7 +578,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>         struct create_tag_options opt;
>         char *cleanup_arg = NULL;
>         int annotate = 0, force = 0, lines = -1;
> -       int cmdmode = 0, sort = 0;
> +       int cmdmode = 0;
>         const char *msgfile = NULL, *keyid = NULL;
>         struct msg_arg msg = { 0, STRBUF_INIT };
>         struct commit_list *with_commit = NULL;
> @@ -574,7 +604,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>                 OPT__FORCE(&force, N_("replace the tag if exists")),
>                 OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
>                 {
> -                       OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
> +                       OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
>                         PARSE_OPT_NONEG, parse_opt_sort
>                 },
>
> @@ -630,9 +660,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>                         copts.padding = 2;
>                         run_column_filter(colopts, &copts);
>                 }
> -               if (lines != -1 && sort)
> +               if (lines != -1 && tag_sort)
>                         die(_("--sort and -n are incompatible"));
> -               ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, sort);
> +               ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, tag_sort);
>                 if (column_active(colopts))
>                         stop_column_filter();
>                 return ret;
