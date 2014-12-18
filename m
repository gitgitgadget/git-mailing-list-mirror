From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 4/6] receive-pack.c: use a single ref_transaction for
 atomic pushes
Date: Thu, 18 Dec 2014 17:26:55 -0500
Message-ID: <CAPig+cS9hJBga7BU-YC3bNG23Tb30kQsXydwGyRYb1T_0fiVqw@mail.gmail.com>
References: <xmqqppbg7uxk.fsf@gitster.dls.corp.google.com>
	<1418924706-9843-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 23:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1jXB-0002SK-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 23:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaLRW05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 17:26:57 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:64868 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbaLRW04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 17:26:56 -0500
Received: by mail-yk0-f175.google.com with SMTP id 200so946140ykr.20
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 14:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mgKjdy63luQIkFix7mNgnQzaTpCr5g+8BpIfV6K2iHY=;
        b=RNxXzjNNGMP2teQkYi9y9ylstWpY50H+2HiUP/AX9jTa+GW4pCuDR//XzeXatCnjHx
         jNB+Qr+yS9268/aIqg0TnZpX8gLxXByS9y0RmsFvI3f/0tE/3XpJ7+ud++UaGdWD45WN
         Mmku8Tvcsv1XuolBTHK+MQnsBRoQCX3adJtUKMzlhCGVFbBTyp0K8wgF88FLFrYA9TLr
         U0u0+ibGRTn8tr5zX2OYugPBeyDEAFonT8pOziVXdjk87O0yk+cO4XfYJrDmenoCnWkH
         zoV07mbEGGCerf3LB42Q0c7Hjz51K2XUchQ3ZWT6RebQfeOMK59ufziJsI419pwsuYfZ
         lg+g==
X-Received: by 10.170.130.21 with SMTP id w21mr4527910ykb.22.1418941616012;
 Thu, 18 Dec 2014 14:26:56 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Thu, 18 Dec 2014 14:26:55 -0800 (PST)
In-Reply-To: <1418924706-9843-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 3E22zRYUnIcDmer-gwYVkiynkVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261540>

On Thu, Dec 18, 2014 at 12:45 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Update receive-pack to use an atomic transaction iff the client negotiated
> that it wanted atomic-push. This leaves the default behavior to be the old
> non-atomic one ref at a time update. This is to cause as little disruption
> as possible to existing clients. It is unknown if there are client scripts
> that depend on the old non-atomic behavior so we make it opt-in for now.
>
> If it turns out over time that there are no client scripts that depend on the
> old behavior we can change git to default to use atomic pushes and instead
> offer an opt-out argument for people that do not want atomic pushes.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e76e5d5..4952d91 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1059,6 +1063,16 @@ static void execute_commands(struct command *commands,
>                 return;
>         }
>
> +       if (use_atomic) {
> +               transaction = ref_transaction_begin(&err);

Repeating from my earlier review[1]: If the 'pre-receive' hook
"declines", then this transaction is left dangling (and its resources
leaked).

> +               if (!transaction) {
> +                       error("%s", err.buf);
> +                       strbuf_release(&err);
> +                       for (cmd = commands; cmd; cmd = cmd->next)
> +                               cmd->error_string = "transaction error";

The !use_atomic case (below), calls this error "failed to start
transaction", not merely "transaction error".

Furthermore, in the use_atomic case (also below), when a commit fails,
you assign err.buf to cmd->error_string rather than a generic
"transaction error" message. What differs between these cases which
makes the generic message preferable here over the more specific
err.buf message?

> +                       return;
> +               }
> +       }
>         data.cmds = commands;
>         data.si = si;
>         if (check_everything_connected(iterate_receive_command_list, 0, &data))
> @@ -1087,7 +1101,30 @@ static void execute_commands(struct command *commands,
>                 if (cmd->skip_update)
>                         continue;
>
> +               if (!use_atomic) {
> +                       transaction = ref_transaction_begin(&err);
> +                       if (!transaction) {
> +                               rp_error("%s", err.buf);
> +                               strbuf_release(&err);
> +                               cmd->error_string = "failed to start transaction";
> +                               continue;
> +                       }
> +               }
>                 cmd->error_string = update(cmd, si);
> +               if (!cmd->error_string) {
> +                       if (!use_atomic
> +                           && ref_transaction_commit(transaction, &err)) {
> +                               ref_transaction_free(transaction);

Repeating from my earlier review[1]: This is leaking 'transaction' for
each successful commit (and only freeing it upon commit error).

> +                               rp_error("%s", err.buf);
> +                               strbuf_release(&err);
> +                               cmd->error_string = "failed to update ref";
> +                       }
> +               } else if (use_atomic) {
> +                       goto atomic_failure;

See commentary below.

> +               } else {
> +                       ref_transaction_free(transaction);
> +               }
> +
>                 if (shallow_update && !cmd->error_string &&
>                     si->shallow_ref[cmd->index]) {
>                         error("BUG: connectivity check has not been run on ref %s",
> @@ -1096,10 +1133,28 @@ static void execute_commands(struct command *commands,
>                 }
>         }
>
> +       if (use_atomic) {
> +               if (ref_transaction_commit(transaction, &err)) {
> +                       rp_error("%s", err.buf);
> +                       for (cmd = commands; cmd; cmd = cmd->next)
> +                               cmd->error_string = err.buf;

At the end of this function, strbuf_release(&err) is invoked, which
leaves all these cmd->error_strings dangling.

> +               }
> +               ref_transaction_free(transaction);
> +       }
>         if (shallow_update && !checked_connectivity)
>                 error("BUG: run 'git fsck' for safety.\n"
>                       "If there are errors, try to remove "
>                       "the reported refs above");
> +       strbuf_release(&err);
> +
> +       return;
> +
> +atomic_failure:
> +       for (cmd = commands; cmd; cmd = cmd->next)
> +               if (!cmd->error_string)
> +                       cmd->error_string = "atomic push failure";
> +
> +       ref_transaction_free(transaction);

goto's can help simplify error-handling when multiple conditional
branches need to perform common cleanup, however, this label
corresponds to only a single goto statement. Placing the cleanup code
for that one case so far away from the point where the condition is
detected actually obfuscates the code slightly rather than clarifying
it. It would be a bit easier to understand the logic if this cleanup
(plus a 'return') was inlined directly at the location of the 'goto'.

By the way, you employ the idiom of iterating over 'commands' and
assigning error_string often enough, that it might be worthwhile to
wrap it in a function. In that case, inlining the above cleanup code
in place of the 'goto' would make it even easier to read since it
would be a mere two-liner.

>  }

[1]: http://article.gmane.org/gmane.comp.version-control.git/261455
