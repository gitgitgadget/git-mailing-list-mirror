From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 02:46:03 -0500
Message-ID: <CAPig+cQEO+LKZJDzE-sUmo+td=djsOdjx-ouQEMRTTkOBMwzjA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Dec 30 08:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5rVP-00026a-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 08:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaL3HqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 02:46:06 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:49209 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaL3HqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 02:46:05 -0500
Received: by mail-yk0-f179.google.com with SMTP id 19so6999185ykq.10
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 23:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NWiHDD4sX8sUsD6iTzCywxLOwzfJ3OCdbiEaTGi8WYA=;
        b=uMa3x4J/FoTt5ozEki30zLOSCDanozR9uwdZkj/2C8wv3gKIniTUQBZ7fiNsCp3zJV
         4m+QlsGm2P+l93azAP73mCIs8SnwBoiVWBXUuaHDH+BEpqJaqu8o/SgvELebeuHuBY3Z
         rNP66dk0zi0wTmTxBj1umFionwa+zOial6d/ARg5o/Ldv6gbsG+6z2yQi6bYkVyGxwIP
         5G0tcuEVmm+EEQWEOiLhoCZ9ISRf9BxKCZnZ73XFog6AHIVnSa1WxjxpaNFC8m38VtmG
         haOYkw0GSWiqo43hI8Dwr0uI0YK1LiU+yhO3pRnn/yWpT/qkil1e/kLdFlXUt2rg+xPE
         nJAQ==
X-Received: by 10.236.63.6 with SMTP id z6mr5320386yhc.65.1419925563758; Mon,
 29 Dec 2014 23:46:03 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 29 Dec 2014 23:46:03 -0800 (PST)
In-Reply-To: <1419907007-19387-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: fW2mmREJdzsGyWqLrGrlLhgtnKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261914>

On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
> No functional changes intended.
>
> This commit shortens execute_commands by moving some parts of the code
> to extra functions.
>
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

Another issue: In the original code, 'si->shallow_ref[cmd->index]' is
only checked if cmd->error_string is NULL, but here you check it
unconditionally, despite the commit message claiming no functional
changes. Did you verify that such a behavioral change is benign? (This
is a genuine question.)

> +                       error("BUG: connectivity check has not been run on ref %s",
> +                             cmd->ref_name);
> +                       checked_connectivity = 0;
> +               }
> +       }
> +       if (shallow_update && !checked_connectivity)
> +               error("BUG: run 'git fsck' for safety.\n"
> +                     "If there are errors, try to remove "
> +                     "the reported refs above");
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
