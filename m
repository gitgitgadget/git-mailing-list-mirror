From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] revision: add --merges={show|only|hide} option
Date: Tue, 7 Apr 2015 01:16:47 -0400
Message-ID: <CAPig+cQ434roQFA0E5wvGAgp5UdGu5oKCq-uNvohMhsdG3S1og@mail.gmail.com>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 07:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfLsc-0003qe-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 07:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbbDGFQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 01:16:49 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36252 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbbDGFQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 01:16:48 -0400
Received: by lbbqq2 with SMTP id qq2so25578050lbb.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 22:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ckAOOpDUacsPMbjSCSRdbg3sWXCcvgdT06paafe2Lgw=;
        b=bb3/z9Ip9Ok5jVtA1y9Fdy2gvHYPH+w6REifvkijikRc+GIFhwV2BLJ+7l7FJzX1av
         56z2D4TA6KNhD8IFjvLcYSxgQoSFiDKBdCpJq1g+h3CxWctIcPrOqRgHf8Gddf1ynQ6a
         nOwU4xL2QWwoGr2ZX4l82RXOFkiePDy5ZR48tpjvBCvnh65tqzAQj7esA5eS9pfE6udc
         CH4h1ROcQQ/9hEIMa6ZUvMlLnJ3OelBjA/myMuRyKwBZwmVjIiIFKJj4pYtE+xVG7NVB
         XvYAchgJVprecfVznTKZ42m2r8mMtdH65kB4+Rsoepeq51Gy4GlvzAXHe5SD0RICzep3
         LLPw==
X-Received: by 10.112.171.65 with SMTP id as1mr16396849lbc.45.1428383807281;
 Mon, 06 Apr 2015 22:16:47 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 22:16:47 -0700 (PDT)
In-Reply-To: <1428110521-31028-1-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: aS_lvvqFgwPbCuD9rBykja5-AwY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266898>

On Fri, Apr 3, 2015 at 9:21 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> revision: add a new option 'merges=' with
> possible values of 'only', 'show' and 'hide'.
> The option is used when showing the list of commits.
> The value 'only' lists only merges. The value 'show'
> is the default behavior which shows the commits as well
> as merges and the value 'hide' makes it just list commit
> items.

A couple very minor comments if you to re-roll this series, otherwise
keep them in mind for future submissions:

Since "revision:" already prefixes the first line of the commit
message (in the Subject:), its reiteration at the start of this
paragraph is unnecessary. It's sufficient to start the paragraph with
"Add new --merges= option...".

The excessively jagged right edge of the paragraph makes it slightly
difficult to read. Try to wrap paragraphs to about 70-72 characters.

> [kk: chose names for options; wrote commit message]
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
>  revision.c | 20 ++++++++++++++++++++
>  revision.h |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 6399a04..c3c3dcc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1678,6 +1678,23 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>         add_grep(revs, pattern, GREP_PATTERN_BODY);
>  }
>
> +int parse_merges_opt(struct rev_info *revs, const char *param)
> +{
> +       if (!strcmp(param, "show")) {
> +               revs->min_parents = 0;
> +               revs->max_parents = -1;
> +       } else if (!strcmp(param, "only")) {
> +               revs->min_parents = 2;
> +               revs->max_parents = -1;
> +       } else if (!strcmp(param, "hide")) {
> +               revs->min_parents = 0;
> +               revs->max_parents = 1;
> +       } else {
> +               return -1;
> +       }
> +       return 0;
> +}
> +
>  static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
>                                int *unkc, const char **unkv)
>  {
> @@ -1800,6 +1817,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>                 revs->show_all = 1;
>         } else if (!strcmp(arg, "--remove-empty")) {
>                 revs->remove_empty_trees = 1;
> +       } else if (starts_with(arg, "--merges=")) {
> +               if (parse_merges_opt(revs, arg + 9))
> +                       die("unknown option: %s", arg);
>         } else if (!strcmp(arg, "--merges")) {
>                 revs->min_parents = 2;
>         } else if (!strcmp(arg, "--no-merges")) {
> diff --git a/revision.h b/revision.h
> index 0ea8b4e..f9df58c 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -240,6 +240,7 @@ extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
>  extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>                                const struct option *options,
>                                const char * const usagestr[]);
> +extern int parse_merges_opt(struct rev_info *, const char *);
>  #define REVARG_CANNOT_BE_FILENAME 01
>  #define REVARG_COMMITTISH 02
>  extern int handle_revision_arg(const char *arg, struct rev_info *revs,
> --
> 2.3.3.263.g095251d.dirty
