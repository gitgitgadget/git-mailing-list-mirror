From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC2014] changed logical chain in branch.c to lookup tables
Date: Mon, 10 Mar 2014 17:25:52 -0400
Message-ID: <CAPig+cS3H_8gZOuyro_Vt0ay3xphvsB92zFgwFfCdgKsXjU0Gg@mail.gmail.com>
References: <1394478262-17911-1-git-send-email-tamertas@outlook.com>
	<BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: TamerTas <tamertas@outlook.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN7hu-00049u-IS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbaCJVZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:25:54 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:36096 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbaCJVZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 17:25:53 -0400
Received: by mail-yh0-f45.google.com with SMTP id i57so7664274yha.4
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=25rtERbPU2XgjFN4dA/Fuu/GBBHj1exJzmpzeJr4/g4=;
        b=tbTaIm077MnPuqtPNwzCebWS7o7VrKnRiEjd0g2Alj4TCfCJ3dJgU0rriCfw8WGn1M
         OBHLjRS38UHpxsjr9Rwhui1jAwTSikOXGbTUCVV6KbycfMzuYDr7Q5CWpnFLYvscud4u
         O5qyh0o935aWOh3WG2yBwUz71X1RAMX1rxuAtdMM2iJBKl4yaWh+MpgNDFw2rDb2Jd64
         ATWq/BsabBKIjGbemRK4kbTugTU0sP1sZt9FpEeFWio7dM88DjmqQddth+YzSQZNA26w
         DYkmeseahi4qvkBQbxnEGKhDPRavtHbMF/z1dZgXsRTkVzxPhzGZUs/vdqone7rDikPX
         0G6Q==
X-Received: by 10.236.7.47 with SMTP id 35mr24396703yho.23.1394486752781; Mon,
 10 Mar 2014 14:25:52 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 14:25:52 -0700 (PDT)
In-Reply-To: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
X-Google-Sender-Auth: 8E1ooXRc8QmciUDXHDIVgkNhHOo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243819>

On Mon, Mar 10, 2014 at 3:04 PM, TamerTas <tamertas@outlook.com> wrote:
> Signed-off-by: TamerTas <tamertas@outlook.com>

Thanks for the submission. It appears to be well executed. Read below
for a concern about the approach taken.

> ---
>  branch.c |   31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..397edd3 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -50,6 +50,9 @@ static int should_setup_rebase(const char *origin)
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
>         const char *shortname = remote + 11;
> +       const char *location[] = {"local", "remote"};
> +       const char *type[] = {"branch", "ref"};
> +
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> @@ -77,29 +80,11 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +
> +        printf_ln(rebasing ?
> +              _("Branch %s set up to track %s %s %s by rebasing.") :
> +              _("Branch %s set up to track %s %s %s."),
> +              local, location[!origin], type[remote_is_branch], remote);

The GSoC microproject talks about the _() function used for
internationalization and the limitations it places on string
composition. This change assumes, probably incorrectly, that strings
"local", "remote", "branch" and "ref" do not need to be localized.
Even allowing internationalization of them (via N_() in the location[]
and type[] tables) might not be sufficient since grammatical rules
differ from language to language.

>         }
>  }
>
> --
> 1.7.9.5
