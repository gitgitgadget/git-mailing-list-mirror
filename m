From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 5/9] receive-pack.c: move transaction handling in a
 central place
Date: Tue, 30 Dec 2014 03:36:55 -0500
Message-ID: <CAPig+cSYD+gBdEZ9TzWdeTEufzH6eJTbt=ZVS5imMJGjWnUFPA@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:37:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5sIX-0003DR-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 09:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbaL3Ig5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 03:36:57 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:59038 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaL3Ig4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 03:36:56 -0500
Received: by mail-yk0-f182.google.com with SMTP id 131so6960400ykp.41
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 00:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uXuuguvlQryjh1SOTf/tBi1VvO7wyBxdLyp98K5Q7C4=;
        b=aYGBiESSI7Li4KCymbNvFkF+YpjGbdgH7IRsmn2EOVyK91VzE9qGyQ3t7ZWUju1NA5
         EnJGTYGiWxtRdyn/Ge1mM29ZkRAtLsKbyqeBnNGlYK3/DQkTMziJDlFvySaBaaaQPKOC
         ipM+V6E55zOu3E4Q5XXksfAuzk3mdCB+ms7PxILXVv1aEUCTqFUY5lyD5hznkm5Jxc53
         wE+lzD+M2+GcqYVNqJxO28cb+J+a7WwnhUfRsGp/sOf093nMv5qU5pABBWY9Jn9Q9CDQ
         qEPqJlFvV4Lt9KKRjdvI9NuY2HPStunlKkec1M7x2kQhXHT3qtTEPpfT7TVNf3olW2h6
         KInA==
X-Received: by 10.236.63.6 with SMTP id z6mr5396417yhc.65.1419928615398; Tue,
 30 Dec 2014 00:36:55 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 00:36:55 -0800 (PST)
In-Reply-To: <1419907007-19387-6-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: lHCLM3qQz22ZW7jNrrkRDWBAsgE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261916>

On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
> Subject: receive-pack.c: move transaction handling in a central place

This is very generic, and doesn't really explain what this patch is
about. (See below.)

> No functional changes intended.

Secondary information can be demoted to the end of the commit message.

> This moves all code related to transactions into the execute_commands_loop
> function which was factored out of execute_commands. This includes
> beginning and committing the transaction as well as dealing with the
> errors which may occur during the begin and commit phase of a transaction.

This explains what you're doing, but not why. The purpose of this
change is that a subsequent patch will be adding another mode of
operation ("atomic") to execute_commands() which differs from the
existing mode ("non-atomic") implemented by its main loop. In its
high-level role, execute_commands() does not need to know or care
about the low-level details of each mode of operation. Therefore, as
preparation for introducing a new mode, you're factoring out the
existing mode into its own stand-alone function.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     This covers the suggestion of patch 2 and 3 by Eric
>     > patch 2: Factor out the main 'for' loop of execute_commands() into a
>     > new function. This new function will eventually become
>     > execute_commands_non_atomic(). At this point, execute_commands() is
>     > pretty much in its final form with the exception of the upcoming 'if
>     > (use_atomic)' conditional.
>     > patch 3: Morph the function extracted in patch 2 into
>     > execute_commands_non_atomic() by adding transaction handling inside
>     > the 'for' loop (and applying the changes from the early part of the
>     > patch which go along with that).

This patch is still rather heavyweight. My suggestion[1] for making
these particular changes across two patches was quite deliberate. The
problem with combining them into a single patch is that you're
performing both code movement and functional changes at the same time.

On its own, pure code movement is easy to review.

On its own, code changes are as easy or difficult to review as the
changes themselves.

When combined, however, the review effort is greater than the sum of
the efforts of reviewing them separately. Partly this is because the
combined changes have a noisier diff. If you move the code in one
patch, and then change it in a second one, the changes pop out --
they're quite obvious. On the other hand, when they are combined, the
reviewer has to deliberately and painstakingly search out the changes,
which is difficult and error-prone. Combining movement and code
changes into a single patch also places greater cognitive load on the
reviewer due to the necessity of keeping a more complex mental
scoreboard relating to the different types of changes.

More below.

[1]: http://article.gmane.org/gmane.comp.version-control.git/261706

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 06eb287..5f44466 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1073,6 +1076,38 @@ static void check_shallow_bugs(struct command *commands,
>                       "the reported refs above");
>  }
>
> +static void execute_commands_loop(struct command *commands,
> +                                 struct shallow_info *si)

Style: Indent the wrapped line to align with the text following the
'(' in the first line.

It's safe to say that the code which you extracted from
execute_commands() handled the non-atomic case, and it's safe to say
that this new function implements the non-atomic case. Therefore, it
would be truthful to call this function execute_commands_nonatomic().
No need to invent the name execute_commands_loop().

> +{
> +       struct command *cmd;
> +       struct strbuf err = STRBUF_INIT;
> +
> +       for (cmd = commands; cmd; cmd = cmd->next) {
> +               if (!should_process_cmd(cmd))
> +                       continue;
> +
> +               transaction = ref_transaction_begin(&err);
> +               if (!transaction) {
> +                       rp_error("%s", err.buf);
> +                       strbuf_reset(&err);
> +                       cmd->error_string = "transaction failed to start";
> +                       continue;
> +               }
> +
> +               cmd->error_string = update(cmd, si);
> +
> +               if (!cmd->error_string
> +                   && ref_transaction_commit(transaction, &err)) {
> +                       rp_error("%s", err.buf);
> +                       strbuf_reset(&err);
> +                       cmd->error_string = "failed to update ref";
> +               }
> +               ref_transaction_free(transaction);
> +       }
> +
> +       strbuf_release(&err);
> +}
> +
>  static void execute_commands(struct command *commands,
>                              const char *unpacker_error,
>                              struct shallow_info *si)
> @@ -1107,12 +1142,8 @@ static void execute_commands(struct command *commands,
>         free(head_name_to_free);
>         head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
>
> -       for (cmd = commands; cmd; cmd = cmd->next) {
> -               if (!should_process_cmd(cmd))
> -                       continue;
> +       execute_commands_loop(commands, si);
>
> -               cmd->error_string = update(cmd, si);
> -       }
>         check_shallow_bugs(commands, si);
>  }
>
> --
> 2.2.1.62.g3f15098
