From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 4/6] receive-pack.c: use a single ref_transaction for
 atomic pushes
Date: Tue, 16 Dec 2014 14:29:05 -0500
Message-ID: <CAPig+cRkPZ8-MQyDs_S-3UXy2JUP6nLzjCE-pmpOa4Z4gyQKEg@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, ronniesahlberg@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xo0-0004Hv-EK
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbaLPT3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:29:08 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:64055 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaLPT3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:29:06 -0500
Received: by mail-yh0-f42.google.com with SMTP id v1so6435279yhn.15
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 11:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WLZ9Sq6jCKjnqnAA0cWv8UARgvnyZ6W3I3bwEG1v2bk=;
        b=iA8j8Ow/zWUXDGKh5GycJilxBmYutuHBH9kyLrATNAhFvHYGdD9X4X4ibZZbpVRfY0
         PlTip1do4EKWF9KdS7lIhSHp62xNJieSs9Upv7lkvfai3fRPSYBXb7noit8sW6MDkMQN
         ZhPWoNaPr3BJTdTqwjvFWO4l+WuaaETMMgN4SDJdzSN0jPwuiI/MNzZLe45X5VEYT4xM
         0Bx9nPUNnxu2zhBVQknylQJqw+wn6T6x0V/I/INUrP/gLl0esAgL0ngM+PMiN94iE5ZY
         Zl21tgs2YxTSpUfIo+QEKqTDUMumIkVDq9B0NX7OuMub1BOtVU/E/CrCruHITnUPwcBb
         67rQ==
X-Received: by 10.236.0.197 with SMTP id 45mr28101293yhb.148.1418758145297;
 Tue, 16 Dec 2014 11:29:05 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 16 Dec 2014 11:29:05 -0800 (PST)
In-Reply-To: <1418755747-22506-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: GmCAmzHs3-OlG3jidNMHsskB5do
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261455>

On Tue, Dec 16, 2014 at 1:49 PM, Stefan Beller <sbeller@google.com> wrote:
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
> index e76e5d5..0803fd2 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -67,6 +67,8 @@ static const char *NONCE_SLOP = "SLOP";
>  static const char *nonce_status;
>  static long nonce_stamp_slop;
>  static unsigned long nonce_stamp_slop_limit;
> +struct strbuf err = STRBUF_INIT;
> +struct ref_transaction *transaction;

Should these be static?

>  static enum deny_action parse_deny_action(const char *var, const char *value)
>  {
> @@ -1059,6 +1059,16 @@ static void execute_commands(struct command *commands,
>                 return;
>         }
>
> +       if (use_atomic) {
> +               transaction = ref_transaction_begin(&err);
> +               if (!transaction) {
> +                       error("%s", err.buf);
> +                       strbuf_release(&err);
> +                       for (cmd = commands; cmd; cmd = cmd->next)
> +                               cmd->error_string = "transaction error";
> +                       return;
> +               }
> +       }

Not seen in this diff, but just below this point, the pre-receive hook
is invoked. If it "declines", then execute_commands() returns without
releasing the transaction which was begun here. Is that correct
behavior?

For robustness, it might also be sane to release the 'err' strbuf at
this early return (though the current code does not strictly leak it).

>         data.cmds = commands;
>         data.si = si;
>         if (check_everything_connected(iterate_receive_command_list, 0, &data))
> @@ -1086,8 +1096,23 @@ static void execute_commands(struct command *commands,
>
>                 if (cmd->skip_update)
>                         continue;
> -
> +               if (!use_atomic) {
> +                       transaction = ref_transaction_begin(&err);
> +                       if (!transaction) {
> +                               rp_error("%s", err.buf);
> +                               strbuf_release(&err);
> +                               cmd->error_string = "failed to start transaction";

Here, you assign cmd->error_string...

> +                       }
> +               }
>                 cmd->error_string = update(cmd, si);

and then immediately overwrite it here. Is it correct to invoke
update() when ref_transaction_begin() has failed? Seems fishy.

> +               if (!use_atomic)
> +                       if (ref_transaction_commit(transaction, &err)) {
> +                               ref_transaction_free(transaction);

Shouldn't you be freeing the transaction outside of this conditional
rather than only in case of failure?

> +                               rp_error("%s", err.buf);
> +                               strbuf_release(&err);
> +                               cmd->error_string = "failed to update ref";
> +                       }
> +
>                 if (shallow_update && !cmd->error_string &&
>                     si->shallow_ref[cmd->index]) {
>                         error("BUG: connectivity check has not been run on ref %s",
> @@ -1096,6 +1121,14 @@ static void execute_commands(struct command *commands,
>                 }
>         }
>
> +       if (use_atomic) {
> +               if (ref_transaction_commit(transaction, &err)) {
> +                       rp_error("%s", err.buf);
> +                       for (cmd = commands; cmd; cmd = cmd->next)
> +                               cmd->error_string = err.buf;
> +               }
> +               ref_transaction_free(transaction);
> +       }
>         if (shallow_update && !checked_connectivity)
>                 error("BUG: run 'git fsck' for safety.\n"
>                       "If there are errors, try to remove "
> @@ -1543,5 +1576,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>         sha1_array_clear(&shallow);
>         sha1_array_clear(&ref);
>         free((void *)push_cert_nonce);
> +       strbuf_release(&err);
>         return 0;
>  }
> --
> 2.2.0.31.gad78000.dirty
