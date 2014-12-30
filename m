From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 6/9] receive-pack.c: add execute_commands_atomic function
Date: Tue, 30 Dec 2014 03:57:52 -0500
Message-ID: <CAPig+cTY3UQsOEut7mqUze1or1i3Hx9=2inrToOFrRKEo08=XQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5sdW-0000Kv-4N
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 09:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbaL3I5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 03:57:54 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:58849 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaL3I5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 03:57:53 -0500
Received: by mail-yk0-f179.google.com with SMTP id 19so6998987ykq.38
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/2jHFm1bDNsD5Yv6mFJ6OgIdbI+nZf10KK9lBiXdEEk=;
        b=amtjBR5eSQxjtqYwwWV9z0zpdkJLSWTIr2CuIYGravuefm3qKTYfaelwxQmaK2Q0zd
         ZnYPZPwqjzov6FQHpNwxZAJ5EDV1/lEyOtJbwPLPWVK0WMEZ23Jw1asvT0QD+gCP2t65
         4hSXit26BaWAWz1/7kz5WPz7fOHllRk/HdHdvrP5cXOJt+o7Ey1IO4rRT9NERs1xBw7n
         WBuq/krMlAzr1+EkrmYUmcRzQi5m6mnwkqXi4krUhwRJId6Ax+v/oVUlFSpanzJ7E3gg
         MXDj9CDYhFFP8+X3n86zzokMsVyhk3BUumFOau205lHo2fe+zeyhuBQdjmxbNg2QCfMT
         D/XA==
X-Received: by 10.170.127.5 with SMTP id t5mr27527679ykb.2.1419929872857; Tue,
 30 Dec 2014 00:57:52 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 00:57:52 -0800 (PST)
In-Reply-To: <1419907007-19387-7-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: ixYodP-1-UGZdBg0jOgXGac6rog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261919>

On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
> Update receive-pack to use an atomic transaction iff the client negotiated
> that it wanted atomic push.

This first line seems germane to this patch...

> This leaves the default behavior to be the old
> non-atomic one ref at a time update. This is to cause as little disruption
> as possible to existing clients. It is unknown if there are client scripts
> that depend on the old non-atomic behavior so we make it opt-in for now.
>
> If it turns out over time that there are no client scripts that depend on the
> old behavior we can change git to default to use atomic pushes and instead
> offer an opt-out argument for people that do not want atomic pushes.

However, the remainder feels like it belongs with some other patch,
such as a patch which introduces an --atomic option.

> Inspired-by: Ronnie Sahlberg <sahlberg@google.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 5f44466..35a2264 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1076,8 +1076,8 @@ static void check_shallow_bugs(struct command *commands,
>                       "the reported refs above");
>  }
>
> -static void execute_commands_loop(struct command *commands,
> -                                 struct shallow_info *si)
> +static void execute_commands_non_atomic(struct command *commands,
> +                                       struct shallow_info *si)

Style: Indent the wrapped line to align with the text following the
'(' in the first line.

>  {
>         struct command *cmd;
>         struct strbuf err = STRBUF_INIT;
> @@ -1104,7 +1104,50 @@ static void execute_commands_loop(struct command *commands,
>                 }
>                 ref_transaction_free(transaction);
>         }
> +       strbuf_release(&err);
> +}
> +
> +static void execute_commands_atomic(struct command *commands,
> +                                       struct shallow_info *si)

Style: Indentation.

> +{
> +       struct command *cmd;
> +       struct strbuf err = STRBUF_INIT;
> +       const char *reported_error = "atomic push failure";
> +
> +       transaction = ref_transaction_begin(&err);
> +       if (!transaction) {
> +               rp_error("%s", err.buf);
> +               strbuf_reset(&err);
> +               reported_error = "transaction failed to start";
> +               goto failure;
> +       }
> +
> +       for (cmd = commands; cmd; cmd = cmd->next) {
> +               if (!should_process_cmd(cmd))
> +                       continue;
>
> +               cmd->error_string = update(cmd, si);
> +
> +               if (cmd->error_string)
> +                       goto failure;
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

Minor comment: This cleanup code is repeated in both the success and
fail branches. It _might_ (or not) be a bit cleaner and more
maintainable to replace the above three lines with:

    goto done;

> +
> +failure:
> +       for (cmd = commands; cmd; cmd = cmd->next)
> +               if (!cmd->error_string)
> +                       cmd->error_string = reported_error;

And add a 'done' label here:

    done:

> +       ref_transaction_free(transaction);
>         strbuf_release(&err);
>  }
>
> @@ -1142,7 +1185,10 @@ static void execute_commands(struct command *commands,
>         free(head_name_to_free);
>         head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
>
> -       execute_commands_loop(commands, si);
> +       if (use_atomic)
> +               execute_commands_atomic(commands, si);
> +       else
> +               execute_commands_non_atomic(commands, si);
>
>         check_shallow_bugs(commands, si);
>  }
> --
> 2.2.1.62.g3f15098
