From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] submodule: implement `module_name` as a builtin helper
Date: Mon, 31 Aug 2015 18:01:40 -0400
Message-ID: <CAPig+cT5Z0CJVok8Za=fBarQLu4WQD3TbA7Wr1aASP4neLLXRA@mail.gmail.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 00:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWX9N-0006gh-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 00:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbbHaWBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 18:01:42 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36801 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbHaWBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 18:01:41 -0400
Received: by qkbp67 with SMTP id p67so19442560qkb.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jLxxBgYCH/Qz4KftVjHY9JDV/5rzB+WJitKV7p784xA=;
        b=aSN134IGJ3wfE96Hf279F22Lg07pL/euZlMko2mMjCQ/CS7pZktqioyXrilYzohlax
         nI09yaNguWtbK2jthnioLZ0wkQhzcw7US/TDL3IF8CQVkqxwWD4Nijil3lZWbRMc3cso
         zkUntncrIqz7eAGwZB1jL4L568wr2OGbjbiFL96t+clchbcJmNoxFpapyiXAYgL0vD1f
         d7U+9qXstdwFE9duxUHnWXzFfRasordCrdwTE6seaetX/Ul8lH9qq/sRueVHc02j0LUj
         dxGRefPbdWhgSMZa6tBdjev4TUq43tXLDSIxRwHD5XJLCfPaE3SsGxJcCQdp7eWagRVi
         T9/Q==
X-Received: by 10.129.83.136 with SMTP id h130mr25115094ywb.95.1441058500619;
 Mon, 31 Aug 2015 15:01:40 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 15:01:40 -0700 (PDT)
In-Reply-To: <1441048767-29729-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 9dqNwNraU4viYgzVwSBUIDXhomM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276948>

On Mon, Aug 31, 2015 at 3:19 PM, Stefan Beller <sbeller@google.com> wrote:
> This implements the helper `module_name` in C instead of shell,
> yielding a nice performance boost.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index beaab7d..c8f7e0c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -101,6 +104,26 @@ static int module_list(int argc, const char **argv, const char *prefix)
> +static int module_name(int argc, const char **argv, const char *prefix)
> +{
> +       const char *name;
> +       const struct submodule *sub;
> +
> +       if (argc != 1)
> +               usage("git submodule--helper module_name <path>\n");
> +
> +       gitmodules_config();
> +       sub = submodule_from_path(null_sha1, argv[0]);
> +
> +       if (!sub)
> +               die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);

In the original shell code, this error message went through
eval_gettext(), so don't you want:

    die(_("No ..."), ...);

?

> +       name = sub->name;
> +       printf("%s\n", name);

Why the useless assignment to 'name'? Instead:

    printf("%s\n", sub->name);

> +       return 0;
> +}
> +
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  {
>         if (argc < 2)
> @@ -109,6 +132,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>         if (!strcmp(argv[1], "module_list"))
>                 return module_list(argc - 1, argv + 1, prefix);
>
> +       if (!strcmp(argv[1], "module_name"))
> +               return module_name(argc - 2, argv + 2, prefix);
> +
>  usage:
> -       usage("git submodule--helper module_list\n");
> +       usage("git submodule--helper [module_list | module_name]\n");
>  }
