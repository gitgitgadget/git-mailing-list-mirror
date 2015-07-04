From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 19/23] checkout: require worktree unconditionally
Date: Fri, 3 Jul 2015 22:33:00 -0400
Message-ID: <CAPig+cRr322OrZkTRfk7fxCR8X2P7mXaBZSDA2_79bxBpWQK6g@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-20-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 04 04:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBDGQ-0001Sv-PL
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 04:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbbGDCdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 22:33:02 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32932 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbbGDCdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 22:33:00 -0400
Received: by ykdv136 with SMTP id v136so108527063ykd.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 19:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1apJykKGJ/roUm28oMegAQkm3wM2BwJs/hsl3/3uFEQ=;
        b=On1C/uhy0K1wAYMb/d8LP9ZrYGDzAItTMZ7x/PEsh2Pi4z/MDu/9kulbYihdNrYsA3
         BRjKTxPZWNL4hB2uObx7BRVSh4QC3Pwi1hr3dq90p6CWNxTI6p7APrw84SDcLKJXLIo9
         65g56jorWGk5masqouOMJgMYZDyo0skVgulVfbxprro26je8iJX5pE4kwLoTPPt+Ulsn
         RmGbohuVBGv9xcoJYRDf6pNVrII1W0Z9M+YPqYRt/MlID43uD3WBVsY4lsnlWKrymcI/
         v1J6aJwvc128HqudnNBWUWeFnhsP+ygg2HnAVXfmgVl/E/uoPBvwH6KeRH7jh0aQUuiD
         Jtag==
X-Received: by 10.13.227.130 with SMTP id m124mr45929313ywe.48.1435977180213;
 Fri, 03 Jul 2015 19:33:00 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 3 Jul 2015 19:33:00 -0700 (PDT)
In-Reply-To: <1435969052-540-20-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: GcGvqYoH_30k8wIfIOk344oZJGU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273345>

On Fri, Jul 3, 2015 at 8:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> In order to allow linked worktree creation via "git checkout -b" from a

s/-b/--to/

> bare repository, 3473ad0 (checkout: don't require a work tree when
> checking out into a new one, 2014-11-30) dropped git-checkout's
> unconditional NEED_WORK_TREE requirement and instead performed worktree
> setup conditionally based upon presence or absence of the --to option.
> Now that --to has been retired and git-checkout is no longer responsible
> for linked worktree creation, the NEED_WORK_TREE requirement can once
> again be unconditional.
>
> This effectively reverts 3473ad0, except for the tests it added which
> now check bare repository behavior of "git worktree add" instead.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/checkout.c | 2 --
>  git.c              | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b1e68b3..5754554 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1218,8 +1218,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>
>         opts.new_worktree_mode = getenv("GIT_CHECKOUT_NEW_WORKTREE") != NULL;
>
> -       setup_work_tree();
> -
>         if (conflict_style) {
>                 opts.merge = 1; /* implied */
>                 git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> diff --git a/git.c b/git.c
> index f227838..21a6398 100644
> --- a/git.c
> +++ b/git.c
> @@ -383,7 +383,7 @@ static struct cmd_struct commands[] = {
>         { "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>         { "check-mailmap", cmd_check_mailmap, RUN_SETUP },
>         { "check-ref-format", cmd_check_ref_format },
> -       { "checkout", cmd_checkout, RUN_SETUP },
> +       { "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
>         { "checkout-index", cmd_checkout_index,
>                 RUN_SETUP | NEED_WORK_TREE},
>         { "cherry", cmd_cherry, RUN_SETUP },
> --
> 2.5.0.rc1.197.g417e668
