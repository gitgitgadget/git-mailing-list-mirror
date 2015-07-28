From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Tue, 28 Jul 2015 17:49:30 -0400
Message-ID: <CAPig+cSiCR3OdYf=4BnaiS8PuSKxd7OPPxOUQYyZpBjkQ15LQQ@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:49:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCki-00072V-I5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbbG1Vtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:49:33 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36609 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbG1Vtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 17:49:31 -0400
Received: by ioeg141 with SMTP id g141so1890997ioe.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WJm972WUKarJpQstnuCF+RlrU1OjFT8qafQqDLQELnY=;
        b=cfBTVJ+DKu13mskoYA3D6N+sAmc1tVNy5IH7ob6uNSU+/jM8noqH7cvM83mMLOu7oP
         AfFdcpjxbAqciUu2bodrCznVzZLef6T5AUbE5i4LIR6/sXZybqdkbllc7Ux8qY2fOr6s
         rqPSpSD5kvNMSnKiLrKeshVmwthCafsP+pmwY86hzP1lmt7MWeYm3H+z1Y4gKTeQBVLz
         pFoqC7JJNjuY1R9Vc89Pvn2Xw+uf+VEMm38U8xSJ4byHWO2UN6/mY2ymF7+sToH1T7s5
         hzvrrDvLmULysawIgK96apbVw2DDb8Hg163uBvtjpwOkpT133A1jzHx7G+tRbJBqDcq5
         FHCg==
X-Received: by 10.107.16.223 with SMTP id 92mr62923312ioq.14.1438120170931;
 Tue, 28 Jul 2015 14:49:30 -0700 (PDT)
Received: by 10.79.107.137 with HTTP; Tue, 28 Jul 2015 14:49:30 -0700 (PDT)
In-Reply-To: <1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: ksa3MBNArx0Zmiy_B5QSwc6f_6s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274856>

On Mon, Jul 27, 2015 at 3:27 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
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
> index 26eb26c..597b189 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>
>  /*
>   * Return 1 if the refname matches one of the patterns, otherwise 0.
> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
> + * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
> + * matches "refs/heads/mas*", too).
> + */
> +static int match_pattern(const char **patterns, const char *refname)
> +{
> +       /*
> +        * When no '--format' option is given we need to skip the prefix
> +        * for matching refs of tags and branches.
> +        */
> +       if (skip_prefix(refname, "refs/tags/", &refname))
> +               ;
> +       else if (skip_prefix(refname, "refs/heads/", &refname))
> +               ;
> +       else if (skip_prefix(refname, "refs/remotes/", &refname))
> +               ;

Or, more concisely:

    skip_prefix(refname, "refs/tags/", &refname) ||
    skip_prefix(refname, "refs/heads/", &refname) ||
    skip_prefix(refname, "refs/remotes/", &refname);

since || short-circuits. No need for the 'if' or cascading 'else if's.

> +       for (; *patterns; patterns++) {
> +               if (!wildmatch(*patterns, refname, 0, NULL))
> +                       return 1;
> +       }
> +       return 0;
> +}
