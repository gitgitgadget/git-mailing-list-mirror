From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening
 refs/remotes/origin/HEAD to origin
Date: Sun, 5 May 2013 13:56:11 +0200
Message-ID: <CAKPyHN0fyrZm=PBZSLhiWzcWO8w1Jjgh439pYVYZ_ViqMVO8Cw@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 05 13:56:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYxYM-00045N-6K
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 13:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab3EEL4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 07:56:15 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34035 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3EEL4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 07:56:13 -0400
Received: by mail-la0-f42.google.com with SMTP id fq13so2635976lab.15
        for <git@vger.kernel.org>; Sun, 05 May 2013 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=o3Do3RrMlTcF1sVFliF30VIdlKT1F8eI9+J3RzLXsuw=;
        b=w+jtsT8vPqNqwyjAfwXowpCoLyEnVOtnR+IoTvRShrfxgBGk0gQCC3J8xfthiISWUs
         QAbWgnCxrraiW0DJ15p71rdSupcKOckt7IChCAqZG5DObmHdi3e3KrlrJ1IfjuErgpxe
         PMfBTwL9sx7gDP1bFbL8mEBSbuk5d5mlQBcE01Pid5jYddkgyKrwcebx2COnCEAisX/m
         0Ysk6ULaKM1642NgGakqMKC49eE//4dgE6VwbB9R+asA7Ajpz7LMhFfoQ52G+proi4fl
         K4VKu1DO3x/DmTY00BQCmqo/gyLGKggWH3IEJg7+E4a66r0I/3uSJZswviKBEOnKBlWE
         F+ww==
X-Received: by 10.112.146.133 with SMTP id tc5mr6575813lbb.88.1367754971931;
 Sun, 05 May 2013 04:56:11 -0700 (PDT)
Received: by 10.112.163.97 with HTTP; Sun, 5 May 2013 04:56:11 -0700 (PDT)
In-Reply-To: <1367711749-8812-2-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223398>

On Sun, May 5, 2013 at 1:55 AM, Johan Herland <johan@herland.net> wrote:
> When expanding shorthand refs to full ref names (e.g. in dwim_ref()),
> we use the ref_rev_parse_rules list of expansion patterns. This list
> allows "origin" to be expanded into "refs/remotes/origin/HEAD", by
> using the "refs/remotes/%.*s/HEAD" pattern from that list.
>
> shorten_unambiguous_ref() exists to provide the reverse operation:
> turning a full ref name into a shorter (but still unambiguous) name.
> It does so by matching the given refname against each pattern from
> the ref_rev_parse_rules list (in reverse), and extracting the short-
> hand name from the matching rule.
>
> However, when given "refs/remotes/origin/HEAD" it fails to shorten it
> into "origin", because we misuse the sscanf() function when matching
> "refs/remotes/origin/HEAD" against "refs/remotes/%.*s/HEAD": We end
> up calling sscanf like this:
>
>   sscanf("refs/remotes/origin/HEAD", "refs/remotes/%s/HEAD", short_name)
>
> In this case, sscanf() will match the initial "refs/remotes/" part, and
> then match the remainder of the refname against the "%s", and place it
> ("origin/HEAD") into short_name. The part of the pattern following the
> "%s" format is never verified, because sscanf() apparently does not
> need to do that (it has performed the one expected format extraction,
> and will return 1 correspondingly; see [1] for more details).
>
> This patch replaces the misuse of sscanf() with a fairly simple function
> that manually matches the refname against patterns, and extracts the
> shorthand name.
>
> Also a testcase verifying "refs/remotes/origin/HEAD" -> "origin" has
> been added.
>
> [1]: If we assume that sscanf() does not do a verification pass prior
> to format extraction, there is AFAICS _no_ way for sscanf() - having
> already done one or more format extractions - to indicate to its caller
> that the input fails to match the trailing part of the format string.
> In other words, AFAICS, the scanf() family of function will only verify
> matching input up to and including the last format specifier in the
> format string. Any data following the last format specifier will not be
> verified. Yet another reason to consider the scanf functions harmful...
>
> Cc: Bert Wesarg <bert.wesarg@googlemail.com>

Looks good, thanks.

Reviewed-by: Bert Wesarg <bert.wesarg@googlemail.com>

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  refs.c                  | 82 +++++++++++++++++++------------------------------
>  t/t6300-for-each-ref.sh | 12 ++++++++
>  2 files changed, 43 insertions(+), 51 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d17931a..7231f54 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2945,80 +2945,60 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
>         return NULL;
>  }
>
> -/*
> - * generate a format suitable for scanf from a ref_rev_parse_rules
> - * rule, that is replace the "%.*s" spec with a "%s" spec
> - */
> -static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
> +int shorten_ref(const char *refname, const char *pattern, char *short_name)
>  {
> -       char *spec;
> -
> -       spec = strstr(rule, "%.*s");
> -       if (!spec || strstr(spec + 4, "%.*s"))
> -               die("invalid rule in ref_rev_parse_rules: %s", rule);
> -
> -       /* copy all until spec */
> -       strncpy(scanf_fmt, rule, spec - rule);
> -       scanf_fmt[spec - rule] = '\0';
> -       /* copy new spec */
> -       strcat(scanf_fmt, "%s");
> -       /* copy remaining rule */
> -       strcat(scanf_fmt, spec + 4);
> -
> -       return;
> +       /*
> +        * pattern must be of the form "[pre]%.*s[post]". Check if refname
> +        * starts with "[pre]" and ends with "[post]". If so, write the
> +        * middle part into short_name, and return the number of chars
> +        * written (not counting the added NUL-terminator). Otherwise,
> +        * if refname does not match pattern, return 0.
> +        */
> +       size_t pre_len, post_start, post_len, match_len;
> +       size_t ref_len = strlen(refname);
> +       char *sep = strstr(pattern, "%.*s");
> +       if (!sep || strstr(sep + 4, "%.*s"))
> +               die("invalid pattern in ref_rev_parse_rules: %s", pattern);
> +       pre_len = sep - pattern;
> +       post_start = pre_len + 4;
> +       post_len = strlen(pattern + post_start);
> +       if (pre_len + post_len >= ref_len)
> +               return 0; /* refname too short */
> +       match_len = ref_len - (pre_len + post_len);
> +       if (strncmp(refname, pattern, pre_len) ||
> +           strncmp(refname + ref_len - post_len, pattern + post_start, post_len))
> +               return 0; /* refname does not match */
> +       memcpy(short_name, refname + pre_len, match_len);
> +       short_name[match_len] = '\0';
> +       return match_len;
>  }
>
>  char *shorten_unambiguous_ref(const char *refname, int strict)
>  {
>         int i;
> -       static char **scanf_fmts;
> -       static int nr_rules;
>         char *short_name;
>
> -       /* pre generate scanf formats from ref_rev_parse_rules[] */
> -       if (!nr_rules) {
> -               size_t total_len = 0;
> -
> -               /* the rule list is NULL terminated, count them first */
> -               for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
> -                       /* no +1 because strlen("%s") < strlen("%.*s") */
> -                       total_len += strlen(ref_rev_parse_rules[nr_rules]);
> -
> -               scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
> -
> -               total_len = 0;
> -               for (i = 0; i < nr_rules; i++) {
> -                       scanf_fmts[i] = (char *)&scanf_fmts[nr_rules]
> -                                       + total_len;
> -                       gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
> -                       total_len += strlen(ref_rev_parse_rules[i]);
> -               }
> -       }
> -
> -       /* bail out if there are no rules */
> -       if (!nr_rules)
> -               return xstrdup(refname);
> -
>         /* buffer for scanf result, at most refname must fit */
>         short_name = xstrdup(refname);
>
>         /* skip first rule, it will always match */
> -       for (i = nr_rules - 1; i > 0 ; --i) {
> +       for (i = ARRAY_SIZE(ref_rev_parse_rules) - 1; i > 0 ; --i) {
>                 int j;
>                 int rules_to_fail = i;
>                 int short_name_len;
>
> -               if (1 != sscanf(refname, scanf_fmts[i], short_name))
> +               if (!ref_rev_parse_rules[i] ||
> +                   !(short_name_len = shorten_ref(refname,
> +                                                  ref_rev_parse_rules[i],
> +                                                  short_name)))
>                         continue;
>
> -               short_name_len = strlen(short_name);
> -
>                 /*
>                  * in strict mode, all (except the matched one) rules
>                  * must fail to resolve to a valid non-ambiguous ref
>                  */
>                 if (strict)
> -                       rules_to_fail = nr_rules;
> +                       rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules);
>
>                 /*
>                  * check if the short name resolves to a valid ref,
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 752f5cb..57e3109 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -466,4 +466,16 @@ test_expect_success 'Verify sort with multiple keys' '
>                 refs/tags/bogo refs/tags/master > actual &&
>         test_cmp expected actual
>  '
> +
> +cat >expected <<\EOF
> +origin
> +origin/master
> +EOF
> +
> +test_expect_success 'Check refs/remotes/origin/HEAD shortens to origin' '
> +       git remote set-head origin master &&
> +       git for-each-ref --format="%(refname:short)" refs/remotes >actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
> 1.8.1.3.704.g33f7d4f
>
