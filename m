From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 01:11:38 -0500
Message-ID: <CAPig+cT9JVkDvUUsbx9HW8HpakCb9SkoQf3LJZc4h3TQTt2ZXQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 07:12:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5q2K-0005rd-EW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 07:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbaL3GLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 01:11:40 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:54032 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbaL3GLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 01:11:39 -0500
Received: by mail-yk0-f172.google.com with SMTP id 131so6952989ykp.3
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 22:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Vom/YB0/nkJeFhpZUwpIwQRiaTbc8//RLuoI0TjhGn8=;
        b=QNQ/KoXjSPZOosBIKnnTznvu+WvXIhhAlP0X++SwhZUADcCWTW7L1qY3n05nC6YFvZ
         pi0S36Jg2vtNL3WGcTdda6Gh5asFFPbMfFF7D1MM3o44gp1zdAsHuP745A/0N+MgbwBa
         F9TAtCc/mklUynmv1s2+F/WoA+eXn1G/g2ViCmNdp8d27wM/Slm6sNxyfaDGzoS86kPj
         w3/Ll0Rpb2RNcL8bKjH1S6LoZ/X6JkW2BwrlaOwpPx4hMj9MfsYxOZ1H1AQSgLBWF9An
         CIZWlwrOmksuQRtYBsKlBpRppZTxHiePO8cbE0dwbth3X7lPwMp3vIxdQwYXHQP6zWdt
         74RQ==
X-Received: by 10.236.14.36 with SMTP id c24mr39205012yhc.166.1419919898500;
 Mon, 29 Dec 2014 22:11:38 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 29 Dec 2014 22:11:38 -0800 (PST)
In-Reply-To: <1419907007-19387-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: -I5kzod_M2wMEo16EbZRCpBJtDc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261912>

On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
> No functional changes intended.

This is useful to know but is of secondary importance, thus should be
placed after the explanation and justification of the change.

> Subject: receive-pack.c: simplify execute_commands
> This commit shortens execute_commands by moving some parts of the code
> to extra functions.

The _real_ reason for moving these bits of code into their own
functions is that you intend to introduce additional callers in
subsequent patches. That is what the commit message (including
subject) should be conveying to the reader.

The claimed simplification is questionable and not of particular
importance; and it's misleading to paint it as a goal of the patch.
Consequently, you could drop mention of it altogether.

More below.

> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 4e8eaf7..06eb287 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1043,11 +1043,40 @@ static void reject_updates_to_hidden(struct command *commands)
>         }
>  }
>
> +static int should_process_cmd(struct command *cmd)
> +{
> +       if (cmd->error_string)
> +               return 0;
> +       if (cmd->skip_update)
> +               return 0;
> +       return 1;

Alternately, depending upon the polarity of your brain, you could
collapse the entire function body to:

    return !cmd->error_string && !cmd->skip_update;

or:

    return !(cmd->error_string || cmd->skip_update);

> +}
> +
> +static void check_shallow_bugs(struct command *commands,
> +                              struct shallow_info *si)
> +{
> +       struct command *cmd;
> +       int checked_connectivity = 1;
> +       for (cmd = commands; cmd; cmd = cmd->next) {
> +               if (!should_process_cmd(cmd))
> +                       continue;
> +
> +               if (shallow_update && si->shallow_ref[cmd->index]) {

Here, inside the loop, you check 'shallow_update'...

> +                       error("BUG: connectivity check has not been run on ref %s",
> +                             cmd->ref_name);
> +                       checked_connectivity = 0;
> +               }
> +       }
> +       if (shallow_update && !checked_connectivity)

And here, after the loop, you check 'shallow_update'.

But, if you examine the overall logic, you will find that this
function does _nothing_ at all when 'shallow_update' is false (other
than uselessly looping through 'commands'). Therefore, either check
'shallow_update' just once at the beginning of the function and exit
early if false, or have the caller check 'shallow_update' and only
invoke check_shallow_bugs() if true.

Also, since nothing happens between them, the two conditionals inside
the loop can be coalesced:

    if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {

> +               error("BUG: run 'git fsck' for safety.\n"
> +                     "If there are errors, try to remove "
> +                     "the reported refs above");

In v6, you considered this a fatal error in the atomic case, which
caused the entire transaction to be rolled back. However, in this
version, this error has no effect whatsoever on the atomic
transaction, which is a rather significant behavioral departure. Which
is correct? (This is a genuine question; not at all rhetorical.) If
failing the entire transaction is the correct thing to do, then this
is going to need some more work.

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
> @@ -1078,27 +1107,13 @@ static void execute_commands(struct command *commands,
>         free(head_name_to_free);
>         head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
>
> -       checked_connectivity = 1;
>         for (cmd = commands; cmd; cmd = cmd->next) {
> -               if (cmd->error_string)
> -                       continue;
> -
> -               if (cmd->skip_update)
> +               if (!should_process_cmd(cmd))
>                         continue;
>
>                 cmd->error_string = update(cmd, si);
> -               if (shallow_update && !cmd->error_string &&
> -                   si->shallow_ref[cmd->index]) {
> -                       error("BUG: connectivity check has not been run on ref %s",
> -                             cmd->ref_name);
> -                       checked_connectivity = 0;
> -               }
>         }
> -
> -       if (shallow_update && !checked_connectivity)
> -               error("BUG: run 'git fsck' for safety.\n"
> -                     "If there are errors, try to remove "
> -                     "the reported refs above");
> +       check_shallow_bugs(commands, si);
>  }
>
>  static struct command **queue_command(struct command **tail,
> --
> 2.2.1.62.g3f15098
