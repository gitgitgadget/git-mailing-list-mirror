From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 2/3] rebase -i: Teach "--edit-todo" action
Date: Sun, 16 Sep 2012 23:11:06 -0700
Message-ID: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
References: <7vwqzuxxmp.fsf@alter.siamese.dyndns.org>
	<1347808623-1058-1-git-send-email-andrew.kw.w@gmail.com>
	<1347808623-1058-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 08:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDUYp-00072U-0V
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 08:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab2IQGLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 02:11:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59652 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab2IQGLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 02:11:07 -0400
Received: by iahk25 with SMTP id k25so5094863iah.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ztXRqfiwgPusEk3OFjN5qKMP4DxHcAfHCuI5C7lhkTQ=;
        b=ykp9cKYIkkTInwxJp06HFIk1zax8Rgc377iiq+Du+NZBYiFTY115I2x/x8ZZyHd5Be
         yA2TzrjpCtCPl2Gg8AYioyZFgFnqOn8Gt0maC1AyMxPjnC4rSbANYxZ1ETrwgpdsajTr
         n+ZsR211lS7blPfwiA0u1A5S3Z0IAgaY54/czyU06DgFde7wXI7JuD4JGD3m4xDMhiSC
         Yz0MvpjK1tMEThJTCKeGFoWD38u5ciM3pXI+7P9FilrWa5ovQA/+4lQt+216W7d/rjKV
         KhdAJdPQNCshUM/PT5/faBNT0Hm45dH06GLlu1P8Baw/TlbdyChfTJyJOMxExAC4aq97
         ZMkw==
Received: by 10.50.0.166 with SMTP id 6mr5645779igf.17.1347862266402; Sun, 16
 Sep 2012 23:11:06 -0700 (PDT)
Received: by 10.64.36.138 with HTTP; Sun, 16 Sep 2012 23:11:06 -0700 (PDT)
In-Reply-To: <1347808623-1058-2-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205655>

On Sun, Sep 16, 2012 at 8:17 AM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index fd535b0..da067ec 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>         [<upstream>] [<branch>]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>         --root [<branch>]
> -'git rebase' --continue | --skip | --abort
> +'git rebase' --continue | --skip | --abort | --edit-todo

I guess you should add --edit-todo to OPTIONS_SPEC in git-rebase.sh as
well. The OPTIONS_SPEC needs another little update too. I have
included a patch at the end of this email that you include in a
re-roll.

> +       git_sequence_editor "$todo" ||
> +       die_abort "Could not execute editor"

die_abort seems a little harsh -- it will discard the rebase state.
Plain "die" would be better, I think.

Also, if you even need to break the line after the || operator, you
might want to indent the remainder by one tab. This file is quite
consistent in using that style, although I don't know what the
preferred style is in general in git.

>  git var GIT_COMMITTER_IDENT >/dev/null ||
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 15da926..e5a289c 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -194,6 +195,10 @@ do
>                 test $total_argc -eq 2 || usage
>                 action=${1##--}
>                 ;;
> +       --edit-todo)
> +               test $total_argc -eq 2 || usage
> +               action=${1##--}
> +               ;;

It looks like this could be trivially combined with the previous case
arm, making the match "--continue|--skip|--abort|--edit-todo)".


-->8--
Author: Martin von Zweigbergk <martinvonz@gmail.com>

    rebase usage: subcommands can not be combined with -i

    Since 95135b0 (rebase: stricter check of standalone sub command,
    2011-02-06), git-rebase has not allowed to use -i together with
    e.g. --continue. Yet, when rebase started using OPTIONS_SPEC in
    45e2acf (rebase: define options in OPTIONS_SPEC, 2011-02-28), the
    usage message included

      git-rebase [-i] --continue | --abort | --skip

    Remove the "[-i]" from this line.

    Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>

diff --git a/git-rebase.sh b/git-rebase.sh
index 15da926..e6b43a2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -8,7 +8,7 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>]
[<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase [-i] --continue | --abort | --skip
+git-rebase --continue | --abort | --skip
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
