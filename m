From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/19] ref-filter: add parse_opt_merge_filter()
Date: Sun, 21 Jun 2015 17:55:01 -0700
Message-ID: <CAPc5daUkHb5sQ_d-g0EeFwXTkFUf4=PVV=QcV-nekObKSJL27g@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 02:55:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6q1Y-0002HI-Ht
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 02:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbbFVAzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 20:55:22 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34180 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbFVAzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 20:55:21 -0400
Received: by obbkm3 with SMTP id km3so11004164obb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ewuLF0upkZyobH1JrDe85mLpQB7SXg6ZdUvjjTBy+Xw=;
        b=ry49gqeI5SarwNvI3A8f7MLQuK5KbSNkybcYWq9GapTIvs2uBE+tNitqCVQfVe17i6
         MhU1W500MtlW7jgUuItb07vdfy4OlAnlCD9mWKkbD6S5S0/R/LvyqOQDmiEO7A9J806j
         Cl6Twsf2IIKYVI/CnPNFcK09gNY7oPxVSVcc4MWeDRcUQJBrHpBsaN3lPdQZ39rvxcJY
         5MlT/imwO+Blhr49OddT6Eu6sGL4zX45QdJG3Ual4YxpouJrMTHdnFN9KSv4AB6hezQM
         OoXfWgdeBlnYgSF1lpYodQousi60fAJ8SKMMbSSVne8mLge4KRSq5MgOr2/PxbNu94FB
         N7ZQ==
X-Received: by 10.202.4.212 with SMTP id 203mr16520278oie.93.1434934520504;
 Sun, 21 Jun 2015 17:55:20 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 17:55:01 -0700 (PDT)
In-Reply-To: <1434919705-4884-5-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: -FFNDO7F87ZXPOENAByktkav8mc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272311>

On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add 'parse_opt_merge_filter()' to parse '--merged' and '--no-merged'
> options and write MACROS for the same.

Why SHOUT here?

>
> This is copied from 'builtin/branch.c' which will eventually be removed
> when we port 'branch.c' to use ref-filter APIs.

Hmph. I somehow thought Matthieu's instruction was to finish tag.c
side first and then
do branch (i.e. with 3 and 4 you brought things from tag to
for-each-ref, now it is a time
to rewrite tag by using what you wrote for for-each-ref with 3 and 4,
before moving to
this patch)? Was that plan scrapped or found inappropriate or something?

> +int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
> +{
> +       struct ref_filter *rf = opt->value;
> +       unsigned char sha1[20];
> +
> +       rf->merge = starts_with(opt->long_name, "no")
> +               ? REF_FILTER_MERGED_OMIT
> +               : REF_FILTER_MERGED_INCLUDE;
> +
> +       if (!arg)
> +               arg = "HEAD";

When does this trigger? You have lastarg-default with "HEAD", and I am
having trouble guessing when "arg" upon entry to this function can ever
be NULL.

> +       if (get_sha1(arg, sha1))
> +               die(_("malformed object name %s"), arg);
> +
> +       rf->merge_commit = lookup_commit_reference_gently(sha1, 0);

Can --merged (or --no-merged) be given more than once? Is the rule
"the last one wins"?
Does the old value of rf->merge_commit leak (no, it does not, but I am
just asking for
completeness)?
