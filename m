From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 5/7] rebase -i: return control to the caller, for housekeeping
Date: Tue, 23 Apr 2013 09:51:28 -0700
Message-ID: <CANiSa6hmh1d7ECBCAm+AKFV4KXh7eoHfk7pL0RjaqZj4XbKhpw@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgRL-0001xw-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555Ab3DWQva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:51:30 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:59655 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549Ab3DWQva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:51:30 -0400
Received: by mail-we0-f180.google.com with SMTP id x43so789093wey.25
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EdekOYg8JZ899uyh1iCONrZbAne1nMnzpzyK/1tHTwM=;
        b=AzYyVINTYnLMtjaKfLsGjG5ps1OPvyFa+X39koPdtihxtkOGBvPT1NMtGMKuiA4CVn
         ZC6OGAdzNt/WirwlOAhgPipKFhZ1gL5jACHnciHOuTMD4cTizSTnsYHhpOVrqYe64CDi
         Y+MgN7Gr3Q+MzcqqRiyJinr0uI6PPwJGK7D/wIxHkxXrsGgrD+35UoA8eyVgeoaKq0Rm
         rUsNLLGR3Iu/Zzz98KD49AVQbAzghkC15aoq2QVZinnK2Qxzy9v3qtr6IVvQVcW69K0l
         roN8ZViGnlHQ5M/7lh56Tqye7bqWY9Nbf58dbLsO9zAJiWmHsh4lxPVfjw5EkU/+W+vC
         kG2A==
X-Received: by 10.180.189.205 with SMTP id gk13mr75966899wic.25.1366735888702;
 Tue, 23 Apr 2013 09:51:28 -0700 (PDT)
Received: by 10.180.19.198 with HTTP; Tue, 23 Apr 2013 09:51:28 -0700 (PDT)
In-Reply-To: <1366725724-1016-6-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222193>

On Tue, Apr 23, 2013 at 7:02 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index cc3a9a7..9514e31 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -597,7 +597,7 @@ do_next () {
>                 fi
>                 ;;
>         esac
> -       test -s "$todo" && return
> +       test -s "$todo" && return 1

Unlike the other cases below, this seems to be replacing success by
failure. What does it mean in practice that $todo is empty?

>         comment_for_reflog finish &&
>         newhead=$(git rev-parse HEAD) &&
> @@ -623,17 +623,15 @@ do_next () {
>                 "$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
>                 true # we don't care if this hook failed
>         fi &&
> -       rm -rf "$state_dir" &&
> -       git gc --auto &&
>         warn "Successfully rebased and updated $head_name."
>
> -       exit
> +       return 0

So after this patch, the "warning" will coming before gc is run. It's
a change, but it seems fine. gc usually only prints a few line, right?

>  }
>
>  do_rest () {
>         while :
>         do
> -               do_next
> +               do_next && break
>         done
>  }

Normally one would break if unsuccessful. What would fail if this was
replaced by "do_next || break" and the above ".. && return 1" was "..
&& return". I assume that was your first attempt, but why did it not
work?
