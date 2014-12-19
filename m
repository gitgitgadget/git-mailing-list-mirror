From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv5 4/6] receive-pack.c: use a single ref_transaction for
 atomic pushes
Date: Fri, 19 Dec 2014 05:14:20 -0500
Message-ID: <CAPig+cSqHW9MGsPW9DCFZ8_Xz+WUc1TBpih2xvPq1NSkJQMM5Q@mail.gmail.com>
References: <CAPig+cS9hJBga7BU-YC3bNG23Tb30kQsXydwGyRYb1T_0fiVqw@mail.gmail.com>
	<1418948521-30787-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 11:14:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1uZn-0003bD-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 11:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaLSKOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 05:14:22 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:48048 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaLSKOV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 05:14:21 -0500
Received: by mail-yh0-f43.google.com with SMTP id z6so233244yhz.30
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+NGUZ0xc3x7uh3dfVifYhiM11BYz5mRFqXOoFI838hI=;
        b=UXygzX8NZ9lAS0xBaSH5+P8EN13TIUm6WglVy4LxZmOMtS39TZAOaNYCimj7p3UPlF
         OLb69xpT+SR8vNQ2B1cEfsGoxZPLK3eTh6AWWPxb7wXMsrn015WKOZnDXQNg4Q0lpSW8
         P6BTJrYE5IooUTqRcp8Tx5tN0qzPRhJBCw9sGMZ0Wyl840pAZm+V5XidFiNb2k+D0ZT9
         hjAhHynfQyJnTP6mQUQPsqNps0SN0VpfJzR+tizKpUYZco1sKaDFOrc1vIjB5Os8f5OQ
         8SRflF9V2qvUirmzaMBa1GU8JHb6ld/zJq4/aU8e3tG1ympv5Pi3NgQovcNTn4J20XZa
         7rrw==
X-Received: by 10.236.0.197 with SMTP id 45mr5609435yhb.148.1418984060687;
 Fri, 19 Dec 2014 02:14:20 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Fri, 19 Dec 2014 02:14:20 -0800 (PST)
In-Reply-To: <1418948521-30787-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: Vb0ayNobJIlcl1wtX9TQppIebow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261554>

On Thu, Dec 18, 2014 at 7:22 PM, Stefan Beller <sbeller@google.com> wrote:
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
> index e76e5d5..ebce2fa 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1087,7 +1102,36 @@ static void execute_commands(struct command *commands,
>                 if (cmd->skip_update)
>                         continue;
>
> +               if (!use_atomic) {
> +                       transaction = ref_transaction_begin(&err);
> +                       if (!transaction) {
> +                               rp_error("%s", err.buf);
> +                               strbuf_release(&err);
> +                               cmd->error_string = "transaction failed to start";
> +                               continue;

For this failure, you 'continue' the loop.

> +                       }
> +               }
>                 cmd->error_string = update(cmd, si);
> +               if (!cmd->error_string) {
> +                       if (!use_atomic) {
> +                               if (ref_transaction_commit(transaction, &err)) {
> +                                       rp_error("%s", err.buf);
> +                                       strbuf_release(&err);
> +                                       cmd->error_string = "failed to update ref";

However, for this failure, you fall through...

> +                               }
> +                               ref_transaction_free(transaction);
> +                       }
> +               } else {
> +                       ref_transaction_free(transaction);
> +                       if (use_atomic) {
> +                               for (cmd = commands; cmd; cmd = cmd->next)
> +                                       if (!cmd->error_string)
> +                                               cmd->error_string = "atomic push failure";
> +                               strbuf_release(&err);
> +                               return;
> +                       }
> +               }
> +
>                 if (shallow_update && !cmd->error_string &&

And here must check if an error occurred in some code above.

This is ugly and inconsistent, and feels as if the new code was
plopped into the middle of this function without concern for overall
flow, thus negatively impacting maintainability and readability. It
could be made a bit cleaner by either (1) consistently using
'continue' for the non-atomic error cases, or (2) moving the "shallow"
handling up into the conditional where you _know_ that no error has
occurred (error_string is NULL).

However, this issue is symptomatic of a larger problem. Prior to this
patch, execute_commands() was relatively straight-forward and easy to
read and understand. With the patch, and its interleaved atomic and
non-atomic cases, the logic flow is a mess: it places a high cognitive
load on the reader and is difficult to maintain and to do correctly in
the first place (as already evidenced).

Have you considered refactoring the code to implement the atomic and
non-atomic cases as distinct single-purpose helper functions of
execute_commands()? It should be possible to do so with very little
duplicated code between the two functions, and the result would likely
be much more readable and maintainable.

>                     si->shallow_ref[cmd->index]) {
>                         error("BUG: connectivity check has not been run on ref %s",
> @@ -1096,10 +1140,19 @@ static void execute_commands(struct command *commands,
>                 }
>         }
>
> +       if (use_atomic) {
> +               if (ref_transaction_commit(transaction, &err)) {
> +                       rp_error("%s", err.buf);
> +                       for (cmd = commands; cmd; cmd = cmd->next)
> +                               cmd->error_string = "atomic transaction failed";
> +               }
> +               ref_transaction_free(transaction);
> +       }
>         if (shallow_update && !checked_connectivity)
>                 error("BUG: run 'git fsck' for safety.\n"
>                       "If there are errors, try to remove "
>                       "the reported refs above");
> +       strbuf_release(&err);
>  }
>
>  static struct command **queue_command(struct command **tail,
> --
> 2.2.1.62.g3f15098
