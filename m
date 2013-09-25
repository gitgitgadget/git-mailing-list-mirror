From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] checkout: allow dwim for branch creation for "git
 checkout $branch --"
Date: Thu, 26 Sep 2013 02:11:43 +0700
Message-ID: <CACsJy8Aj0HtuWn6iW4B3y4ZCeZYGOPN=vNGsC85YXTVjbwivBQ@mail.gmail.com>
References: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
 <CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com> <vpqob7huhyw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, jc@sahnwaldt.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOuVX-0006zO-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab3IYTMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:12:15 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:46773 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab3IYTMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:12:14 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so223109obc.32
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Rkl++gHCAvp122h+4KloiGfz/rk9fcrLPTcnuPfS9Dg=;
        b=ZbIyfuVxBRokjxjQAtiX2AzCEfCzOA5RVZUlMspBmnSKxws3gbUWtyKNZSe0qRhWWe
         k83UNKrSS9+IhRayaOedDgWcqNgSjA8TpZxTzNl4Iob+Bm7pRJ5cqWr4u2Sunb5zF+Nz
         vT00NNG/nz7mEVn7UZ+maf0l3U8j06I8rBucdW2+4GKoqLSWf5RBDTRuMa9+AsZF9dcW
         35aunB+QbOLVwpazpeJHIPRuKQJxkGBZBsYglh9aoD18E7HZOFPPw8V7lnzIRQru7kTP
         1RAFXln2b6PRLiOjzl7LAxZTwL0NWG+2gtwosoplylrkhlZ0SUatVj+tSNOBfjTgQ+GM
         g8FQ==
X-Received: by 10.182.247.68 with SMTP id yc4mr2126188obc.67.1380136334131;
 Wed, 25 Sep 2013 12:12:14 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 25 Sep 2013 12:11:43 -0700 (PDT)
In-Reply-To: <vpqob7huhyw.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235365>

On Wed, Sep 25, 2013 at 8:52 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> @@ -925,7 +926,15 @@ static int parse_branchname_arg(int argc, const char **argv,
>                 return 1;
>
>         arg = argv[0];
> -       has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
> +       has_dash_dash = 0;
> +       for (i = 0; i < argc; i++) {
> +               if (!strcmp(argv[i], "--")) {
> +                       has_dash_dash = i;
> +                       break;
> +               }
> +       }
> +       if (has_dash_dash >= 2)
> +               die("only one reference expected, %d given.", has_dash_dash);

The translator in me says this string should be marked for translation
like others in git-checkout...

>
>         if (!strcmp(arg, "-"))
>                 arg = "@{-1}";
> diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
> index 7cc0a35..2836a3e 100755
> --- a/t/t2010-checkout-ambiguous.sh
> +++ b/t/t2010-checkout-ambiguous.sh
> @@ -47,4 +47,10 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
>         git diff --exit-code --quiet
>  '
>
> +test_expect_success 'accurate error message with more than one ref' '
> +       test_must_fail git checkout HEAD master -- 2>actual &&
> +       echo "fatal: only one reference expected, 2 given." >expect &&
> +       test_cmp expect actual
> +'
> +
>  test_done

which makes C_LOCALE_OUTPUT a prerequisite for this test because it
needs the untranslated version of the string.

>
> I'll resend, together with tweaks to the first patch.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
Duy
