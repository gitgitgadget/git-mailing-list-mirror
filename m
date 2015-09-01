From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 2/3] submodule: implement `module-name` as a builtin helper
Date: Mon, 31 Aug 2015 22:31:15 -0400
Message-ID: <CAPig+cTTiW_tZBNoz-kj6CkViR+MFegv1Tz5xmVvbGxZ0pbqwQ@mail.gmail.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
	<1441068029-19158-1-git-send-email-sbeller@google.com>
	<1441068029-19158-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWbME-0003oa-KO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbbIACbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:31:17 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33872 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbbIACbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:31:16 -0400
Received: by qkct7 with SMTP id t7so27337752qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m4c0BPkSB4WEi/ow7mN6zAV5FlTMxEG5JGiTZk9v6F4=;
        b=suEWXGrWkqTeAjZvHkvuizoUqNfOrxJT2Kjudnr3+Fd3Tyh4InhL6nPciBuVYGNW3v
         NHWLd2mQarnIjG/nkfFiyBwMW9jdl2s7AkaOutIaMjV5+rI6yA+P3z81YsIxLCN8T6QL
         Gmv0mtYsEIPM0G0+zAnvJmEqBc1rRWXhBZD9swO2teap3Rx9RUbOjPUfk51/QVwXV1HM
         9NY+3nN/4mOQf7MVDl1EjwHS4gCQFGzWMFlQRtNIYIWyGFt6It1eYWS/EfsDTcV0mVFT
         g90IhMKNsOqXXfbYg6BBLN2UkhJ83HoqtgRST6qEqEg/C2H0vuDJ1Qvv4cAJgAX2by5q
         s96w==
X-Received: by 10.129.155.147 with SMTP id s141mr8501057ywg.17.1441074676046;
 Mon, 31 Aug 2015 19:31:16 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 19:31:15 -0700 (PDT)
In-Reply-To: <1441068029-19158-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: T46dMn_vcRbH-JUk7SJd5_OWV_Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276965>

On Mon, Aug 31, 2015 at 8:40 PM, Stefan Beller <sbeller@google.com> wrote:
> This implements the helper `module_name` in C instead of shell,
> yielding a nice performance boost.
>
> Before this patch, I measured a time (best out of three):
>
>   $ time ./t7400-submodule-basic.sh  >/dev/null
>     real        0m11.066s
>     user        0m3.348s
>     sys 0m8.534s
>
> With this patch applied I measured (also best out of three)
>
>   $ time ./t7400-submodule-basic.sh  >/dev/null
>     real        0m10.063s
>     user        0m3.044s
>     sys 0m7.487s
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 44310f5..91bd420 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -102,16 +105,38 @@ static int module_list(int argc, const char **argv, const char *prefix)
> +static int module_name(int argc, const char **argv, const char *prefix)
> +{
> +       const struct submodule *sub;
> +
> +       if (argc != 1)
> +               usage("git submodule--helper module_name <path>\n");

usage(_("..."));

s/module_name/module-name/

I think you also need to drop the newline from the usage() argument.

> +       gitmodules_config();
> +       sub = submodule_from_path(null_sha1, argv[0]);
> +
> +       if (!sub)
> +               die(N_("No submodule mapping found in .gitmodules for path '%s'"),
> +                   argv[0]);
> +
> +       printf("%s\n", sub->name);
> +
> +       return 0;
> +}
> +
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  {
>         if (argc < 2)
>                 die(N_("fatal: submodule--helper subcommand must be called with "
> -                      "a subcommand, which is module-list\n"));
> +                      "a subcommand, which are module-list, module-name\n"));

Manually maintaining this list is likely to become a maintenance issue
pretty quickly. Isn't there an OPT_CMDMODE for this sort of thing?

Also, it would like be more readable if the possible commands were
printed one per line rather than all squashed together.

>         if (!strcmp(argv[1], "module-list"))
>                 return module_list(argc - 1, argv + 1, prefix);
>
> +       if (!strcmp(argv[1], "module-name"))
> +               return module_name(argc - 2, argv + 2, prefix);
> +
>         die(N_("fatal: '%s' is not a valid submodule--helper subcommand, "
> -              "which is module-list\n"),
> +              "which are module-list, module-name\n"),

And, it's duplicated here, making it even more of a maintenance problem.

>             argv[1]);
>  }
