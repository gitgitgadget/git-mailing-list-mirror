From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 8/8] revert/cherry-pick: add --skip option
Date: Wed, 29 May 2013 17:57:57 +0530
Message-ID: <CALkWK0m02XCVnrnFQ+mF8FFZEMD36_J3Tyjh-E4SuZ++xdcXHQ@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com> <1369799788-24803-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 14:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhfUh-0004f9-5h
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966015Ab3E2M2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:28:38 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39690 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965855Ab3E2M2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:28:37 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so4999212iea.32
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hTdTECJC9T/pfM34BpdLkmUOOFrZmAxZ3JwD3EN+s2g=;
        b=HdatRjdsvtmO85WKsYsr6IfD0YAg60zl4oUw/ILEqsdtu+OujhLIw/MdE/MgLdfqzS
         7xIVorQjC8CF+r9DV2QiaCNRMZzpO2js+AEsUrorJAZs4+wp3SwoHk3jw1Xb6QvHhbsP
         4D1YSvtOq5rt1mjxYfkQVXcZzaAgl3T2In1zZIhJyDCtV8wX35klMvW342xFX7wRFBVU
         4T1lI6NOr4Z6BjrzTNSP5acoEHLQ+ITwq1j/5WvGs9KlcnuwllU3XEyPTSSp1UjQcQfK
         rjHD8rgnVMkAfFxlItfG+4oPpwSrUC8ZV+wGGopqs/Sk5k2/gTZpCwepsqYo6YFVJaiP
         0m7w==
X-Received: by 10.50.141.230 with SMTP id rr6mr9195537igb.89.1369830517222;
 Wed, 29 May 2013 05:28:37 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 05:27:57 -0700 (PDT)
In-Reply-To: <1369799788-24803-9-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225800>

Felipe Contreras wrote:
> Akin to 'am --skip' and 'rebase --skip'.

This ranged-cherry-pick can be useful for small ranges.  As pointed
out by others on the list, it hemorrhages memory quite horribly (and
this problem is non-trivial to fix).  Perhaps we should document this
in limitations or bugs if we intend to make it more useful?

> diff --git a/builtin/revert.c b/builtin/revert.c
> index d63b4a6..6afd990 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -99,11 +99,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>         int remove_state = 0;
>         int contin = 0;
>         int rollback = 0;
> +       int skip = 0;

Ugh, one more integer.  Can't we use an OPT_BIT and store the action
in one variable? No hurry ofcourse: just asking.

> @@ -1201,7 +1203,7 @@ static int sequencer_continue(struct replay_opts *opts)
>         }
>         if (index_differs_from("HEAD", 0))
>                 return error_dirty_index(opts);
> -       {
> +       if (!skip) {
>                 unsigned char to[20];
>                 if (!read_ref("HEAD", to))
>                         add_rewritten(todo_list->item->object.sha1, to);

Couldn't you just say if (skip) todo_list = todo_list -> next?

> +       if (setup_rerere(&merge_rr, 0) >= 0) {
> +               rerere_clear(&merge_rr);
> +               string_list_clear(&merge_rr, 1);
> +       }

Why exactly?  Why doesn't rebase --skip 'rerere clear'?

> +       argv[0] = "reset";
> +       argv[1] = "--hard";
> +       argv[2] = "HEAD";
> +       argv[3] = NULL;
> +       ret = run_command_v_opt(argv, RUN_GIT_CMD);

Unrelated to your patch, but any clue why reset doesn't have an api
yet?  Does it leak memory too?
