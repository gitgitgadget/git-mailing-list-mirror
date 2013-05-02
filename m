From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/9] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Thu, 2 May 2013 11:57:17 -0500
Message-ID: <CAMP44s2j3TD67NX=OF5Qit7=_gi_cgyBrwuakLU4jwQvOhkFzA@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<1367501974-6879-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwrl-0005QV-SB
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761500Ab3EBRAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:00:16 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40552 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab3EBQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 12:57:19 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so740302lab.10
        for <git@vger.kernel.org>; Thu, 02 May 2013 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zyf2MoEJWHD+2nRmTA30blXPM+QppVtva8LtVliD6Ww=;
        b=WkkSizODITQOo7tISPxSFp8Hpx53NFWKptikbilViVLkb4agP5CcDPRIpKasrZkwoG
         L/5Ta90nBeLN/bwUjkghXRPl5u4WvC8bvtnDfr1WV6D6dWDTr/DJPwYFdzv1qMwx8rDD
         cxBV05P9j1sjtr1AlutfW33j1JoYI96lIkkv0K8i4pgCrGlyWuaietCZV9+6TOnxEvRh
         OC2dTcaOdYmdR/Ji9g5VDYUnuDHA1w1gdHKWW2abBP5FniHdSSSiys/ZHUdhIF2Exa/W
         Dzl/njex2w0LncfNfKtkOqreaoFJwYJE1m1w6My2t6I/v8ptrxZN/cweKHS7o2XT8p5m
         leeg==
X-Received: by 10.112.146.133 with SMTP id tc5mr2969413lbb.88.1367513837306;
 Thu, 02 May 2013 09:57:17 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 09:57:17 -0700 (PDT)
In-Reply-To: <1367501974-6879-8-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223223>

On Thu, May 2, 2013 at 8:39 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:

>     $ git symbolic-ref M refs/heads/master
>     $ git show M@{u}
>     $ git branch -u ram/master M
>
> This patch fixes branch_get() directly, making these work.

It's not a fix, it's implementing brand new functionality, and
changing old behaviors.

> --- a/remote.c
> +++ b/remote.c
> @@ -1463,13 +1463,30 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>
>  struct branch *branch_get(const char *name)
>  {
> -       struct branch *ret;
> +       struct branch *ret = NULL;
> +
> +       /* Setup */

I thought the preferred style for these kinds of comments was:

  /* setup */

> +       git_config(handle_config, NULL);
> +       alias_all_urls();
>
> -       read_config();
>         if (!name || !*name || !strcmp(name, "HEAD"))

I still see "HEAD" there. Didn't you say your patch makes "HEAD" less
of a special ref? Why is it still here?

> -               ret = current_branch;
> +               name = "HEAD";
>         else
>                 ret = make_branch(name, 0);
> +
> +       if (!ret || !ret->remote_name) {
> +               /* Is this a symbolic-ref like HEAD, pointing to a
> +                * valid branch?
> +                */

The style is:

  /*
   * This is the preferred style for multi-line
   * comments in the Linux kernel source code.
   * Please use it consistently.
   *
   * Description:  A column of asterisks on the left side,
   * with beginning and ending almost-blank lines.
   */

-- 
Felipe Contreras
