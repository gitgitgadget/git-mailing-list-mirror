From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] cat-file: add --literally option.
Date: Wed, 25 Feb 2015 17:14:15 -0500
Message-ID: <CAPig+cQeHxH=Bc2EyQXOfX=m33XFfUViS2VDi4K+yQoweBo1Nw@mail.gmail.com>
References: <54EDACC9.5080204@gmail.com>
	<1424862485-13576-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 23:14:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQkDl-0000ll-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 23:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbbBYWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 17:14:17 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:40629 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbbBYWOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 17:14:16 -0500
Received: by yhot59 with SMTP id t59so2543983yho.7
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 14:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4EKJ7mmXOyZ6xfgg0V72VtOU8SMpkl5Qz3ulJ3VxJAw=;
        b=O7/NyyX4bC8dxTRdPYMBTKKJ5RvwCN/FxG/l7TlOPcRjBiGafaB6mqwRTJma5T2Rld
         iaRpdvYgFvcA5uqcQSIYQbOk9P3X5gjJ/SrXQDLtF6dd/Bif96CcqTxGvhPa8Jkylne6
         dBbbxFRKGlDvKMcShfSDrnGoofZa+rG8lFo9pFnOllmqwmt7Q+YvEoGBUEFX/EqHJivf
         YPQuZKPe9GAHYQOflyIeaNa7JIeOXGrfJIOc7FC9M5RxjBvcdwl5tZxw43iAULzau9OP
         S2YEO0eT4wm64W8aGu5FHc7OETm90KOT1F2mo1T2JR7sJdoDYy4tYuQOoaXZRXcFWj2c
         I/fg==
X-Received: by 10.236.10.5 with SMTP id 5mr5381409yhu.148.1424902455582; Wed,
 25 Feb 2015 14:14:15 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 25 Feb 2015 14:14:15 -0800 (PST)
In-Reply-To: <1424862485-13576-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: 8pz9WIq7mZ39eBo-9P6wYt04Lws
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264419>

On Wed, Feb 25, 2015 at 6:08 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> cat-file: add --literally option.

Style: drop terminating period.

> Add --literally option which when used with -t option
> gives the type of the object given, irrelevant of the type
> and its contents.

Confusing: "gives the type [...] irrelevant of the type"?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..1db94fe 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -107,6 +107,29 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>         return 0;
>  }
>
> +static int cat_one_file_literally(int opt, const char *exp_type, const char *obj_name)

Unused arguments: 'opt' and 'exp_type'

This function duplicates enough functionality of cat_one_file() that
it almost seems that it could be folded into the 't' case in that
function, but for the sake of review, let's assume that you'll keep it
separate.

> +{
> +       unsigned char sha1[20];
> +       unsigned char type[32];
> +       struct object_context obj_context;
> +       struct object_info oi = {NULL};

Unused variable: 'oi'

> +       int retval = 0;
> +
> +       if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))

You never take advantage of the extra context in 'obj_context', so
perhaps get_sha1() would be preferable?

> +               die("Not a valid object name %s", obj_name);
> +
> +       retval = has_sha1_file(sha1);
> +       if (!retval)
> +               return retval;

Shouldn't this case be emitting some sort of diagnostic rather than
exiting silently?

> +       if(sha1_object_type_literally(sha1, type))

Style: space after 'if'

> +               die("git cat-file -t --literally %s: invalid object", obj_name);

Inconsistent error message style with the die() just above this one.
(cat_one_file() has its own inconsistencies, but new code need not
follow suit.)

> +
> +       printf("%s\n", type);
> +
> +       return retval;
> +}
> +
>  struct expand_data {
>         unsigned char sha1[20];
>         enum object_type type;
> @@ -324,7 +347,7 @@ static int batch_objects(struct batch_options *opt)
>
>  static const char * const cat_file_usage[] = {
>         N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> -       N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
> +       N_("git cat-file (-t|-s|-e|-p|<type>|--textconv|-t --literally) <object>"),

This is strange. According to this diff, you've removed the --batch
and --batch-check options; and you're showing the -t, -s, -e, etc.
options twice.

>         NULL
>  };
>
> @@ -359,6 +382,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>         int opt = 0;
>         const char *exp_type = NULL, *obj_name = NULL;
>         struct batch_options batch = {0};
> +       int literally = 0;

Mental note: 'literally' is initialized to false (0).

>         const struct option options[] = {
>                 OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
> @@ -369,6 +393,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>                 OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>                 OPT_SET_INT(0, "textconv", &opt,
>                             N_("for blob objects, run textconv on object's content"), 'c'),
> +               OPT_BOOL( 0, "literally", &literally,
> +                         N_("show the type of the gicen loose object, use for debugging")),

s/gicen/given/

>                 { OPTION_CALLBACK, 0, "batch", &batch, "format",
>                         N_("show info and content of objects fed from the standard input"),
>                         PARSE_OPT_OPTARG, batch_option_callback },
> @@ -380,7 +406,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>
>         git_config(git_cat_file_config, NULL);
>
> -       if (argc != 3 && argc != 2)
> +       if (argc != 3 && argc != 2 && (!literally && argc != 4))

This can't be correct. At this point, 'literally' is unconditionally
false (0). It's value won't (potentially) change until the options are
processed, which doesn't happen until parse_options() is invoked
_after_ this conditional.

>                 usage_with_options(cat_file_usage, options);
>
>         argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
> @@ -405,5 +431,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>         if (batch.enabled)
>                 return batch_objects(&batch);
>
> +       if (literally && opt == 't')
> +               return cat_one_file_literally(opt, exp_type, obj_name);
> +       else if (literally)
> +               usage_with_options(cat_file_usage, options);
> +
>         return cat_one_file(opt, exp_type, obj_name);
>  }
> --
> 2.3.1.129.g11acff1.dirty
