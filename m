From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/10] ref-filter: add option to match literal pattern
Date: Sun, 26 Jul 2015 01:15:35 -0400
Message-ID: <CAPig+cTAYAxg4aWpaPrHe6Hfz3wCEiypoXZxS_Lir4yNOFzSNA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJEHq-0002lc-P9
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbbGZFPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:15:37 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36073 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbGZFPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:15:36 -0400
Received: by ykay190 with SMTP id y190so47365997yka.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=E/cV/m/no/bhp2idqmDy1ir1BBF0eWeecET+6X7LFUo=;
        b=vIKJtVjK04+prmv3vuYhAhYLPaRr9LEky5FdjIGPB5cXvigK3K1ClIEfg7oe6Yqn+T
         xTS78+gLBb9meFnos2NbIE7y2p632TD8qpa5geU03lTes2GONd1bkhfIdrYrvZe4516I
         BJgd6G09XRvrfC3J1jcX13LA2Lo7InyggI0XeATjz0FN+9fqRIxjeu0+SvDjBXOUg8z0
         4WMYOYV0ozL8TBRzG8AyhEfIil7U0E/uURG8/DMM7MqAcWgJ6iEu01MGRc3TyYvOk1qn
         WbwYs8qol2Y8D6ELRdx+7pESvAq7S/tl97KaTy/Z3yMwFZw1L/oUytiJq10/oaI2DwGe
         1qqA==
X-Received: by 10.13.207.1 with SMTP id r1mr23668588ywd.166.1437887735809;
 Sat, 25 Jul 2015 22:15:35 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 25 Jul 2015 22:15:35 -0700 (PDT)
In-Reply-To: <1437764685-8633-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: LQ4B1GYAxliFJM0173lKdluMBnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274633>

On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
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
> index 8f2148f..0a64b84 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -951,6 +951,31 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>
>  /*
>   * Return 1 if the refname matches one of the patterns, otherwise 0.
> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
> + * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
> + * matches "refs/heads/mas*", too).
> + */
> +static int match_pattern(const char **patterns, const char *refname)
> +{
> +       for (; *patterns; patterns++) {
> +               /*
> +                * When no '--format' option is given we need to skip the prefix
> +                * for matching refs of tags and branches.
> +                */
> +               if (!starts_with(*patterns, "refs/tags/"))
> +                       skip_prefix(refname, "refs/tags/", &refname);
> +               if (!starts_with(*patterns, "refs/heads/"))
> +                       skip_prefix(refname, "refs/heads/", &refname);
> +               if (!starts_with(*patterns, "refs/remotes/"))
> +                       skip_prefix(refname, "refs/remotes/", &refname);

Note the inefficiency here: You're performing an "expensive"
starts_with() on each pattern for each refname even though the
patterns will never change. You could instead compute starts_with()
for each pattern just once, in a preprocessing step, and remember each
result as a boolean, and then use the computed booleans here in place
of starts_with(). For a few refnames, this may not make a difference,
but for a project with a huge number, it could. Whether such an
optimization is worth the complexity (at this time or ever) is
something that can be answered by taking measurements.

Also, the repetition in the code is not all that pretty. You could
instead place "refs/tags/", "refs/heads/", and "refs/remotes/" in a
table and then loop over them rather than repeating the code for each
one, though whether that would be an improvement is likely a judgment
call (so not something I'd insist upon).

> +               if (!wildmatch(*patterns, refname, 0, NULL))
> +                       return 1;
> +       }
> +       return 0;
> +}
