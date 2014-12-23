From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/7] receive-pack.c: receive-pack.c: use a single
 ref_transaction for atomic pushes
Date: Mon, 22 Dec 2014 20:31:28 -0500
Message-ID: <CAPig+cTjwiDPdQv-i3VBeQEJDTiPGaB4G-WA141qNA9fCyDKLw@mail.gmail.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 02:31:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3EJz-00071P-53
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 02:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbaLWBba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 20:31:30 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:54947 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaLWBb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 20:31:29 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so3008596yhl.37
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 17:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DrHl84r9mA4c9mIflUjEH3+P6VzjLCSN7KxNEohuQJk=;
        b=wcY3SVm80teA8l8FKGTlBytL2BfF1Wel+jNY7bs6+UJSQOUh70XL72fhG16MKfVS2C
         8LjMIH3V9tfnkhPnBVgWmpDaKoXvipN2y6Tr+9jQmds+gkyTzIAR/gF34bktaZN57cvT
         iOSeAsVFijZb49PifkAFjU2sKGOoKZpyxAYA43WTlap+0WYc5V8BtdEMskLy2WEKAUxZ
         +u/BBKa+6WZZNM7C5XFZAAGjVsNZuT5b6vOl1z/U9yygg9tL2j6ny9L5hBdkKEnH/iaG
         cKMgezcYnyjgy5YdCBlLkLb5Uxm1TGTbXmVbOoYGYloQB7QONIW5yfkQdVI+uscSQTu7
         RLiQ==
X-Received: by 10.236.0.197 with SMTP id 45mr20029732yhb.148.1419298288851;
 Mon, 22 Dec 2014 17:31:28 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 22 Dec 2014 17:31:28 -0800 (PST)
In-Reply-To: <1419017941-7090-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: sCvjki6o8x0hcy0MfOOZMtbLrS0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261706>

On Fri, Dec 19, 2014 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
> Update receive-pack to use an atomic transaction iff the client negotiated
> that it wanted atomic-push. This leaves the default behavior to be the old
> non-atomic one ref at a time update. This is to cause as little disruption
> as possible to existing clients. It is unknown if there are client scripts
> that depend on the old non-atomic behavior so we make it opt-in for now.
>
> If it turns out over time that there are no client scripts that depend on the
> old behavior we can change git to default to use atomic pushes and instead
> offer an opt-out argument for people that do not want atomic pushes.

Notes and observations below. None of them are particularly
actionable. If Junio is happy with the current round, and if you don't
have some other reason to re-roll, then consider them food for thought
for future patches.

> Inspired-by: Ronnie Sahlberg <sahlberg@google.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e76e5d5..710cd7f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1044,11 +1047,72 @@ static void reject_updates_to_hidden(struct command *commands)
>         }
>  }
>
> +static void execute_commands_non_atomic(struct command *commands,
> +                                   struct shallow_info *si);
> +
> +
> +static void execute_commands_atomic(struct command *commands,
> +                                   struct shallow_info *si)
> +{
> +       struct command *cmd;
> +       struct strbuf err = STRBUF_INIT;
> +       const char *reported_error = "atomic push failure";
> +       int checked_connectivity = 1;
> +       transaction = ref_transaction_begin(&err);
> +       if (!transaction) {
> +               rp_error("%s", err.buf);
> +               reported_error = "transaction failed to start";
> +               goto failure;
> +       }
> +
> +       for (cmd = commands; cmd; cmd = cmd->next) {
> +               if (cmd->error_string)
> +                       goto failure;
> +
> +               if (cmd->skip_update)
> +                       goto failure;

These checks are common to the atomic and non-atomic cases. To reduce
code duplication between the two cases, you could factor them out to a
cmd_okay() helper function (or some such name) which checks both
conditions.

> +               cmd->error_string = update(cmd, si);
> +
> +               if (cmd->error_string)
> +                       goto failure;
> +
> +               if (shallow_update && si->shallow_ref[cmd->index]) {
> +                       error("BUG: connectivity check has not been run on ref %s",
> +                             cmd->ref_name);
> +                       checked_connectivity = 0;
> +                       reported_error = "transaction failed due to internal bug";
> +                       goto failure;

This code is also common to atomic and non-atomic cases and could be
factored out to a helper function, thus further reducing duplication.
The less code duplication between cases, the lower the cognitive load,
making the code easier to understand.

> +               }
> +       }
> +
> +       if (ref_transaction_commit(transaction, &err)) {
> +               rp_error("%s", err.buf);
> +               reported_error = "atomic transaction failed";
> +               goto failure;
> +       }
> +
> +       ref_transaction_free(transaction);
> +       strbuf_release(&err);
> +       return;
> +
> +failure:
> +       for (cmd = commands; cmd; cmd = cmd->next)
> +               if (!cmd->error_string)
> +                       cmd->error_string = reported_error;
> +       ref_transaction_free(transaction);
> +       strbuf_release(&err);
> +
> +       if (shallow_update && !checked_connectivity)
> +               error("BUG: run 'git fsck' for safety.\n"
> +                     "If there are errors, try to remove "
> +                     "the reported refs above");

This final conditional is common to both cases but does not even need
to be factored out to a helper function. It could/should have remained
in execute_commands() at its original position, following the call to
execute_commands_atomic() or execute_commands_non_atomic().

> +}
> +
>  static void execute_commands(struct command *commands,
>                              const char *unpacker_error,
>                              struct shallow_info *si)
>  {
> -       int checked_connectivity;
>         struct command *cmd;
>         unsigned char sha1[20];
>         struct iterate_data data;
> @@ -1079,7 +1143,20 @@ static void execute_commands(struct command *commands,
>         free(head_name_to_free);
>         head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
>
> -       checked_connectivity = 1;
> +       if (use_atomic) {
> +               execute_commands_atomic(commands, si);
> +       } else {
> +               execute_commands_non_atomic(commands, si);
> +       }

Style: Unnecessary braces.

More below.

> +}
> +
> +static void execute_commands_non_atomic(struct command *commands,
> +                                       struct shallow_info *si)
> +{
> +       struct command *cmd;
> +       struct strbuf err = STRBUF_INIT;
> +       int checked_connectivity = 1;
> +
>         for (cmd = commands; cmd; cmd = cmd->next) {
>                 if (cmd->error_string)
>                         continue;
> @@ -1087,19 +1164,35 @@ static void execute_commands(struct command *commands,
>                 if (cmd->skip_update)
>                         continue;
>
> +               transaction = ref_transaction_begin(&err);
> +               if (!transaction) {
> +                       rp_error("%s", err.buf);
> +                       strbuf_reset(&err);
> +                       cmd->error_string = "transaction failed to start";
> +                       continue;
> +               }
> +
>                 cmd->error_string = update(cmd, si);
> -               if (shallow_update && !cmd->error_string &&
> -                   si->shallow_ref[cmd->index]) {
> -                       error("BUG: connectivity check has not been run on ref %s",
> -                             cmd->ref_name);
> -                       checked_connectivity = 0;
> +
> +               if (!cmd->error_string) {
> +                       if (ref_transaction_commit(transaction, &err)) {
> +                               rp_error("%s", err.buf);
> +                               strbuf_reset(&err);
> +                               cmd->error_string = "failed to update ref";
> +                       }
> +                       if (shallow_update && si->shallow_ref[cmd->index]) {
> +                               error("BUG: connectivity check has not been run on ref %s",
> +                                     cmd->ref_name);
> +                               checked_connectivity = 0;
> +                       }

There is a behavior change here. In the original, the
'si->shallow_ref[cmd->index]' check was performed only if no other
error occurred, however, in the updated code, the check is performed
even when ref_transaction_commit() fails. Is this correct behavior?

>                 }
> +               ref_transaction_free(transaction);
>         }
> -
>         if (shallow_update && !checked_connectivity)
>                 error("BUG: run 'git fsck' for safety.\n"
>                       "If there are errors, try to remove "
>                       "the reported refs above");
> +       strbuf_release(&err);
>  }
>
>  static struct command **queue_command(struct command **tail,
> --

A few comments about the refactoring...

It would have been easier to follow and understand the changes had
they been done in a stepwise fashion over a series of patches,
resulting in a less confusing diff (and avoiding the need for the
follow-up patch where you merely relocate the modified code).

One possible approach would have been something like this:

patch 1: Factor out code into helper functions which will be needed by
the upcoming atomic and non-atomic worker functions. Example helpers:
'cmd->error_string' and cmd->skip_update' check; and the
'si->shallow_ref[cmd->index]' check and handling.

patch 2: Factor out the main 'for' loop of execute_commands() into a
new function. This new function will eventually become
execute_commands_non_atomic(). At this point, execute_commands() is
pretty much in its final form with the exception of the upcoming 'if
(use_atomic)' conditional.

patch 3: Morph the function extracted in patch 2 into
execute_commands_non_atomic() by adding transaction handling inside
the 'for' loop (and applying the changes from the early part of the
patch which go along with that).

patch 4: Add execute_commands_atomic(), and the corresponding 'if
(use_atomic)' conditional to execute_commands().

Other approaches are possible, but the motivation behind the above
organization is that reviewer time is precious, and that it's
beneficial to present changes in an easy-to-digest form.
