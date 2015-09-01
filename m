From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 1/3] submodule: implement `list` as a builtin helper
Date: Tue, 1 Sep 2015 19:17:28 -0400
Message-ID: <CAPig+cTBK0Zw6ECJY4cDeP-eYOoGrCGAPXAvj1Xk-HABeBv-_A@mail.gmail.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuo1-0000iv-Oo
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 01:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbbIAXRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 19:17:30 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34852 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbIAXR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 19:17:29 -0400
Received: by ykax124 with SMTP id x124so6453816yka.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9hKC4PR8sP4uHz+7WLjIlJ6+8tTrth3Ua8AYKXQryWo=;
        b=KfLcDs1Q5Ekis00W9F+76bvNBhBD+kAhvQwWD0IEXQdzODRQfWOk5cE7tsZPFt6/2T
         /ioOqSzEfyOXa6Hr7mD6t6442N/d4RHTT0mHpwKIXnsb4fbJKidzHrfdvrG2BF/HOsPf
         C5kxvlwTFzlyv6m3GtP1Gip9xdNnXNvNuTNl8lRIMbjVVi7ANidYw3MRPqzGt4hcG85V
         ONJYAH0OJomzkP6HdhsaV6fuqYa3/4MLJNvt6/mXLw0XYfGjYRWqC0JD3xYFnkY/ktQG
         FqEhLB16+7PjKAXqn7SSU2yZGXUs9TAzoiUFL6vHVMz6tbq8GKFF8yrcy7EWoF/86Szd
         PsVg==
X-Received: by 10.13.202.80 with SMTP id m77mr32168499ywd.166.1441149448848;
 Tue, 01 Sep 2015 16:17:28 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 1 Sep 2015 16:17:28 -0700 (PDT)
In-Reply-To: <1441131869-29474-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: jGpzJSSUPEWQhDR0apI3pyvGni4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277072>

On Tue, Sep 1, 2015 at 2:24 PM, Stefan Beller <sbeller@google.com> wrote:
> Most of the submodule operations work on a set of submodules.
> Calculating and using this set is usually done via:
>
>        module_list "$@" | {
>            while read mode sha1 stage sm_path
>            do
>                 # the actual operation
>            done
>        }
>
> Currently the function `module_list` is implemented in the
> git-submodule.sh as a shell script wrapping a perl script.
> The rewrite is in C, such that it is faster and can later be
> easily adapted when other functions are rewritten in C.
>
> [...]
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> +struct cmd_struct {
> +       const char *cmd;
> +       int (*fct)(int, const char **, const char *);

It would be better to stick with a more idiomatic name such as 'f' or
'func' than invent an entirely new one ('fct').

> +};
> +
> +static struct cmd_struct commands[] = {
> +       {"list", module_list},
> +};
> +
> +int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> +{
> +       int i;
> +       if (argc < 2)
> +               goto out;
> +
> +       for (i = 0; i < ARRAY_SIZE(commands); i++)
> +               if (!strcmp(argv[1], commands[i].cmd))
> +                       return commands[i].fct(argc - 1, argv + 1, prefix);
> +
> +out:
> +       if (argc > 1)
> +               fprintf(stderr, _("fatal: '%s' is not a valid submodule--helper "
> +                                 "subcommand, which are:\n"), argv[1]);
> +       else
> +               fprintf(stderr, _("fatal: submodule--helper subcommand must be "
> +                                 "called with a subcommand, which are:\n"));
> +
> +       for (i = 0; i < ARRAY_SIZE(commands); i++)
> +               fprintf(stderr, "\t%s\n", commands[i].cmd);

A couple observations:

1. git-submodule--helper isn't the only Git command featuring
subcommands which could benefit from this dispatching and error
reporting code, so making it re-usable would be sensible rather than
hiding it away inside this one (very low-level, not user-facing)
command. If you go that route, it would deserve its own patch series,
and well thought out design and interface. However...

2. I realize that the suggestion of listing available subcommands was
put forth tentatively by Junio[1], but it seems overkill for a command
like this which is not user-facing, and is inconsistent with other
subcommand-bearing commands. At this stage, it should be sufficient
merely to emit a plain error message (without any usage information):

    unrecognized subcommand: %s

    missing subcommand

at which point the user can consult the man page or "git
subcommand--helper -h" to find out what went wrong.

[1]: http://article.gmane.org/gmane.comp.version-control.git/276935

> +
> +       exit(129);
> +}
