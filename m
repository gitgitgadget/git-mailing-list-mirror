From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 15/15] for-each-ref: use get_pretty_userformat in --pretty
Date: Tue, 4 Jun 2013 19:57:54 +0700
Message-ID: <CACsJy8ABNVW=KT9mR4oqiXisEwb5Q3ri4zM467dB-N5ELn=FYQ@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com> <1370349337-20938-16-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujqoo-00014R-Dv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab3FDM60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:58:26 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47510 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab3FDM6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:58:25 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so278058obq.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5RmCsdeTp/5ZBoRX8pNa0NHXb1Ow0fguRPIIUQvc1vQ=;
        b=Cu3hPdQlc5lYl/TEMHnR8yPPrZrbVaoTwBnxeCqi6Ro2WJs+2r9ODe80NBw44HFpTm
         bRg7N88B3f5c5riDUeNYKLBZFst/I6K1cY35sp10JIss952a0rW+Ct4o+npe7+/AW10B
         fzlVpNvSEL9pj9aSlyt8bQkSFfzEDgZIG1EuFT/muLa1dB7Ps7b/SLJMvgB9S/6yfTDw
         JaCdn+OtLNtBZk3YD9T0OuCuSwUvFDwwqqK1VS3iq5pjoTBSIM+JwN5sU7YXh1nWbGmI
         vDWUU+kakQTCbZGosEMy1X2wFbjof87KNovOTyDywfdOUmFN0Hz/iEOjBThlZcw30Mu5
         eygw==
X-Received: by 10.60.62.162 with SMTP id z2mr11870693oer.140.1370350704716;
 Tue, 04 Jun 2013 05:58:24 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 4 Jun 2013 05:57:54 -0700 (PDT)
In-Reply-To: <1370349337-20938-16-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226364>

On Tue, Jun 4, 2013 at 7:35 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Use get_pretty_userformat() to interpret the --pretty string.  This
> means that leading you can now reference a format specified in a pretty.*
> configuration variable as an argument to 'git for-each-ref --pretty='.
> There are two caveats:
>
> 1. A leading "format:" or "tformat:" is automatically stripped and
>    ignored.  Separator semantics are not configurable (yet).
>
> 2. No built-in formats are available.  The ones specified in
>    pretty-formats (oneline, short etc) don't make sense when displaying
>    refs anyway.
>

I spoke too early about the concern with this patch. At first it
looked like you replace default formats with config keys. But nope,
this is brilliant.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  3 +++
>  builtin/for-each-ref.c             | 16 +++++++++-------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 05ff7ba..7f3cba5 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -60,6 +60,9 @@ calculated.
>  +
>  Caveats:
>
> +0. No built-in formats from PRETTY FORMATS (like oneline, short) are
> +   available.
> +
>  1. Many of the placeholders in "PRETTY FORMATS" are designed to work
>     specifically on commit objects: when non-commit objects are
>     supplied, those placeholders won't work.
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index edaa6b2..c00ab05 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -1146,7 +1146,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>         int num_refs;
>         const char *default_format = "%(objectname) %(objecttype)\t%(refname)";
>         const char *format = default_format;
> -       const char *pretty = NULL;
> +       const char *pretty_raw = NULL, *pretty_userformat = NULL;
>         struct ref_sort *sort = NULL, **sort_tail = &sort;
>         int maxcount = 0, quote_style = 0;
>         struct refinfo **refs;
> @@ -1165,13 +1165,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>                 OPT_GROUP(""),
>                 OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
>                 OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
> -               OPT_STRING(  0 , "pretty", &pretty, N_("format"), N_("alternative format to use for the output")),
> +               OPT_STRING(  0 , "pretty", &pretty_raw, N_("format"), N_("alternative format to use for the output")),
>                 OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
>                             N_("field name to sort on"), &opt_parse_sort),
>                 OPT_END(),
>         };
>
>         parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
> +       if (pretty_raw)
> +               pretty_userformat = get_pretty_userformat(pretty_raw);
>         if (maxcount < 0) {
>                 error("invalid --count argument: `%d'", maxcount);
>                 usage_with_options(for_each_ref_usage, opts);
> @@ -1180,10 +1182,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>                 error("more than one quoting style?");
>                 usage_with_options(for_each_ref_usage, opts);
>         }
> -       if (format != default_format && pretty)
> +       if (format != default_format && pretty_userformat)
>                 die("--format and --pretty cannot be used together");
> -       if ((pretty && verify_format(pretty, 1)) ||
> -           (!pretty && verify_format(format, 0)))
> +       if ((pretty_userformat && verify_format(pretty_userformat, 1)) ||
> +           (!pretty_userformat && verify_format(format, 0)))
>                 usage_with_options(for_each_ref_usage, opts);
>
>         if (!sort)
> @@ -1204,8 +1206,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>         if (!maxcount || num_refs < maxcount)
>                 maxcount = num_refs;
>
> -       if (pretty)
> -               show_pretty_refs(refs, maxcount, pretty, quote_style);
> +       if (pretty_userformat)
> +               show_pretty_refs(refs, maxcount, pretty_userformat, quote_style);
>         else
>                 show_refs(refs, maxcount, format, quote_style);
>         return 0;
> --
> 1.8.3.GIT
>



--
Duy
