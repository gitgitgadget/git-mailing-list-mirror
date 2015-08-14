From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/4] notes: add notes.mergestrategy option to select
 default strategy
Date: Fri, 14 Aug 2015 14:07:03 -0400
Message-ID: <CAPig+cQN9bszBiW4dxp8cz+aJUf=70V-vLQio_6OX9ry1cOYRw@mail.gmail.com>
References: <1439574620-25249-1-git-send-email-jacob.e.keller@intel.com>
	<1439574620-25249-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 20:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQJNp-0003B3-66
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 20:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbbHNSHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 14:07:06 -0400
Received: from mail-yk0-f196.google.com ([209.85.160.196]:32940 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbbHNSHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 14:07:04 -0400
Received: by ykek5 with SMTP id k5so1647942yke.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5ZoqaFYiPLlUGSywLwtbhBdaCA9IxfoV5X48CPVX5sg=;
        b=IFnaRFLKxLdAd1V6BiuVQujtjgAg5j0MfT3llpThR4Rjm6mBZOoCZaVi8YEI812dg7
         S4DVmsu6EnGS2DPqTkaQKLQJkT2S4Cx39esE4/gPStmU8Thh7YFI/uA3HpTTkl0uDaQX
         tpsIPiq8J3T4mMfQywBNFvAq5+fmIqgdc1Wh+45mFrIiZX0ctd67W+LYg2Pyy4obvyMO
         WuqB3IObnfsKM4iCod3AEvfRGt5GEF1uoZPJs7Oq3+qYb2vt1gUDSYgDha5oSbhhOj7L
         cGcH3DJ3WJHs/CbhVWjCr6O9QtTxR2UBQz+JFmTeF+Wuyk/eww1FRiBx9tvtnr2StNod
         RY6g==
X-Received: by 10.13.202.80 with SMTP id m77mr19431303ywd.166.1439575623336;
 Fri, 14 Aug 2015 11:07:03 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 11:07:03 -0700 (PDT)
In-Reply-To: <1439574620-25249-4-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: 7lBgiGiSheykZnwSewFgQYP9N6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275921>

On Fri, Aug 14, 2015 at 1:50 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Teach git-notes about "notes.mergestrategy" to select a general strategy
> for all notes merges. This enables a user to always get expected merge
> strategy such as "cat_sort_uniq" without having to pass the "-s" option
> manually.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 042348082709..97109f8d419c 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -796,21 +814,16 @@ static int merge(int argc, const char **argv, const char *prefix)
>         expand_notes_ref(&remote_ref);
>         o.remote_ref = remote_ref.buf;
>
> +       git_config_get_string_const("notes.mergestrategy", &configured_strategy);
> +
>         if (strategy) {
> -               if (!strcmp(strategy, "manual"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> -               else if (!strcmp(strategy, "ours"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_OURS;
> -               else if (!strcmp(strategy, "theirs"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> -               else if (!strcmp(strategy, "union"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_UNION;
> -               else if (!strcmp(strategy, "cat_sort_uniq"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> -               else {
> +               if (parse_notes_strategy(strategy, &o.strategy)) {
>                         error("Unknown -s/--strategy: %s", strategy);

This error message points the user at the source of the problem
("--strategy"). Good.

>                         usage_with_options(git_notes_merge_usage, options);
>                 }
> +       } else if (configured_strategy) {
> +               if (parse_notes_strategy(configured_strategy, &o.strategy))
> +                       die("Unknown notes merge strategy: %s", configured_strategy);

This error message doesn't. Perhaps it should mention the config
variable "notes.mergestrategy" to help the user track down the problem
more quickly?

>         }
>
>         t = init_notes_check("merge");
