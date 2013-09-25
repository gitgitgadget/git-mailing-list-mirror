From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] checkout: allow dwim for branch creation for "git
 checkout $branch --"
Date: Wed, 25 Sep 2013 20:22:39 +0700
Message-ID: <CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com>
References: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, jc@sahnwaldt.de
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 15:23:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOp3u-0007Pr-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 15:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab3IYNXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 09:23:11 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40219 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3IYNXK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 09:23:10 -0400
Received: by mail-oa0-f49.google.com with SMTP id i4so994076oah.36
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4zc1xrmg/Po55WvrquHOdVDb3GpOpN+Sf/82MuQ2N2s=;
        b=r6sHo/C9d+rKH4dp+qoVKI3WHY0NrHmFonLuZM3z7kXudveZC/J5C4kzGzX2VUFmN7
         0X4vRjJ5xTuOhKrxY12fZU1vfjgWFTRQXEubBN6CBVChlNmMYryLrKZaAclbqkgjL8YY
         RQyz89QLnDjbykS2hWO4e70vmSfnnmNvpfmKyvSQCl8OcQSgQme/BM3gQM99V52Uyj21
         GlKYCkVgHks3B2lVmy4t/vZzMksLrxuQiGN1oPu+K4/Ub70g/LYbrd93cXBtQKZvXNCW
         v4o/PrU/6C0aA8ZAnYy/0x/wBsuEeZQBd7cZAsuhrmzUPjSqODaOcjwxfwRVAImvcAsg
         WnFA==
X-Received: by 10.182.214.98 with SMTP id nz2mr12621242obc.37.1380115389482;
 Wed, 25 Sep 2013 06:23:09 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 25 Sep 2013 06:22:39 -0700 (PDT)
In-Reply-To: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235344>

On Wed, Sep 25, 2013 at 7:49 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>  static int parse_branchname_arg(int argc, const char **argv,
>                                 int dwim_new_local_branch_ok,
>                                 struct branch_info *new,

You may want to update the big comment block about all cases at the
beginning of this function.

> @@ -916,20 +924,28 @@ static int parse_branchname_arg(int argc, const char **argv,
>         if (!strcmp(arg, "-"))
>                 arg = "@{-1}";
>
> -       if (get_sha1_mb(arg, rev)) {
> -               if (has_dash_dash)          /* case (1) */
> -                       die(_("invalid reference: %s"), arg);
> -               if (dwim_new_local_branch_ok &&
> -                   !check_filename(NULL, arg) &&
> -                   argc == 1) {
> +       if (get_sha1_mb(arg, rev)) { /* case (1)? */
> +               int try_dwim = dwim_new_local_branch_ok;
> +
> +               if (check_filename(NULL, arg) && !has_dash_dash)
> +                       try_dwim = 0;
> +               /*
> +                * Accept "git checkout foo" and "git checkout foo --"
> +                * as candidates for dwim.
> +                */
> +               if (!(argc == 1 && !has_dash_dash) &&

has_dash_dash is calculated as (argc > 1) && !strcmp(argv[1], "--"),
so when argc == 1, the has_dash_dash must be zero, the "&&
!has_dash_dash" is redundant. But it makes me wonder what we do with
"git checkout abc def -- xyz". I think both old and new code do not
see "--" as a separator like it should (and should also error about
multiple refs given). Maybe something worth fixing too while you're
updating this code.

> +                   !(argc == 2 && has_dash_dash))
> +                       try_dwim = 0;
> +
-- 
Duy
