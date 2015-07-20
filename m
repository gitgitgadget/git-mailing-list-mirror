From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/9] ref-filter: add option to match literal pattern
Date: Mon, 20 Jul 2015 02:24:54 -0400
Message-ID: <CAPig+cSTQgaL-nYfOCWdTaCEpM_23E5TZOPQpnWXEZ8YCcvbZg@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 08:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH4VX-0002mO-3a
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 08:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbbGTGYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 02:24:55 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34284 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbbGTGYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 02:24:54 -0400
Received: by ykax123 with SMTP id x123so132220058yka.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oGCo+XYEyARrGRj0AFBKVh6TnegKHpWYzgoCKOxJCow=;
        b=MvrmAA5a3h4RiIeIrDJXaOAaGoFahJlujKfH/dGXG2bG1wBk8FuS6p/cfywg0RcyL9
         q0hlJHdxmlZ2yOF8DtTmbrvEKcDHNkgO86Cgozcs9qejRAAlzVOjbJriSTqURxYgHd3w
         p3/DY1cfNEpB1UwCzh9pwBQXPttHwUZqDmhKq1BNR+agF6DpoYmXrgFCMe5JTu4+Q2xv
         e1RXGoU0GlwUFwbtER+A40t7CCJ0ExjYsdjOeI23pGQjhp2expQVanFav+iGXok2L2wH
         oQM1D0j/IXF6Zy3yL9FpAO9/g1ZHxKOmHAC4GzwvXhsBnqR2u9cSb6oOJLH4DLDC+WPv
         Q1fw==
X-Received: by 10.170.63.196 with SMTP id f187mr26917746ykf.82.1437373494060;
 Sun, 19 Jul 2015 23:24:54 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 23:24:54 -0700 (PDT)
In-Reply-To: <1437246749-14423-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: mioVbK_kitMXFKlU_iSJ-7NGowA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274316>

On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Since 'ref-filter' only has an option to match path names add an
> option for plain fnmatch pattern-matching.
>
> This is to support the pattern matching options which are used in `git
> tag -l` and `git branch -l` where we can match patterns like `git tag
> -l foo*` which would match all tags which has a "foo*" pattern.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 85c561e..7ff3ded 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -966,6 +980,15 @@ static int match_name_as_path(const char **pattern, const char *refname)
>         return 0;
>  }
>
> +static int filter_pattern_match(struct ref_filter *filter, const char *refname)
> +{
> +       if (!*filter->name_patterns)
> +               return 1;
> +       if (filter->match_as_path)
> +               return match_name_as_path(filter->name_patterns, refname);
> +       return match_pattern(filter->name_patterns, refname);
> +}
> +
>  /*
>   * Given a ref (sha1, refname), check if the ref belongs to the array
>   * of sha1s. If the given ref is a tag, check if the given tag points
> @@ -1034,7 +1057,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>                 return 0;
>         }
>
> -       if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
> +       if (!filter_pattern_match(filter, refname))
>                 return 0;

I find it much more difficult to grok the new logic due to
'*filter->name_patterns' having moved into the called function and its
negation inside the function returning 1 which is then negated (again)
upon return here. This sort of twisty logic places a higher cognitive
load on the reader. Retaining the original logic makes the code far
simpler to understand:

    if (*filter->name_patterns &&
        !filter_pattern_match(filter, refname))
        return 0;

although it's a bit less nicely encapsulated, so I dunno...

>         if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
