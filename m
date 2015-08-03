From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] remote: add get-url subcommand
Date: Mon, 3 Aug 2015 19:38:15 -0400
Message-ID: <CAPig+cQO_jXZmJG=EccwQ408TiAk7_BiQF1UKA31phXF7CXy6w@mail.gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<1438635614-11174-1-git-send-email-mathstuf@gmail.com>
	<1438635614-11174-2-git-send-email-mathstuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 01:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMPJF-0006nL-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 01:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658AbbHCXiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 19:38:17 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36480 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbHCXiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 19:38:16 -0400
Received: by ykeo23 with SMTP id o23so27299477yke.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ilbG20mlbXkpUO0pBK1VUjjqpos8/vtglatS8ROZwMc=;
        b=VF6rr59EO1Bz1PzHeYTLmXP9HbitoMNr9RPUfFV7+3IkDgPLFKHBYKGstfNoov+MGE
         B+hWsS6SNX/5ZjGkwH55ezhwb31HyejLCfZX8UySqEAgmwCWi7Pqc0AGCBpxmm7d0gvB
         RLKvAguP8rFRwupnA6p1i0/YnBF9gzXx5vkem61XjEWXRGNjnEUYl+0GJApGEAePJPez
         HA+415cpjS1gyVUeGilAaxKlLlYRWh6Fjv/Juqr33VsSnkyj1apQG9M1EUEtAfsh6nlC
         GtAT/5W9nj4w0i1+xIZ0KMi/6SwQv6Mh98wa+3U3x52XWowc53X3/SRH6X6eCufOb+qE
         OeIQ==
X-Received: by 10.13.192.132 with SMTP id b126mr587855ywd.163.1438645095376;
 Mon, 03 Aug 2015 16:38:15 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 3 Aug 2015 16:38:15 -0700 (PDT)
In-Reply-To: <1438635614-11174-2-git-send-email-mathstuf@gmail.com>
X-Google-Sender-Auth: 6F9u5Xo9_tUjDnl0oF746xQNl4I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275229>

On Mon, Aug 3, 2015 at 5:00 PM, Ben Boeckel <mathstuf@gmail.com> wrote:
> Expanding `insteadOf` is a part of ls-remote --url and there is no way
> to expand `pushInsteadOf` as well. Add a get-url subcommand to be able
> to query both as well as a way to get all configured urls.
>
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
> diff --git a/builtin/remote.c b/builtin/remote.c
> index f4a6ec9..9278a83 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1497,6 +1503,53 @@ static int set_branches(int argc, const char **argv)
> +static int get_url(int argc, const char **argv)
> +{
> +       int i, push_mode = 0, all_mode = 0;
> +       const char *remotename = NULL;
> +       struct remote *remote;
> +       const char **url;
> +       int url_nr;
> +       struct option options[] = {
> +               OPT_BOOL('\0', "push", &push_mode,
> +                        N_("query push URLs")),

A bit more explanatory:

    "query push URLs rather than fetch URLs"

> +               OPT_BOOL('\0', "all", &all_mode,
> +                        N_("return all URLs")),
> +               OPT_END()
> +       };
> +       argc = parse_options(argc, argv, NULL, options, builtin_remote_geturl_usage,
> +                            PARSE_OPT_KEEP_ARGV0);

What is the reason for PARSE_OPT_KEEP_ARGV0 in this case?

> +       if (argc < 1 || argc > 2)
> +               usage_with_options(builtin_remote_geturl_usage, options);

So,  'argc' must be 1 or 2, which in 'argv' terms is argv[0] and argv[1]).

> +       remotename = argv[1];

But here, argv[1] is accessed unconditionally, even though 'argc' may
have been 1, thus out of bounds.

> +       if (!remote_is_configured(remotename))
> +               die(_("No such remote '%s'"), remotename);
> +       remote = remote_get(remotename);
> +
> +       if (push_mode) {
> +               url = remote->pushurl;
> +               url_nr = remote->pushurl_nr;
> +       } else {
> +               url = remote->url;
> +               url_nr = remote->url_nr;
> +       }
> +
> +       if (!url_nr)
> +               die(_("no URLs configured for remote '%s'"), remotename);
> +
> +       if (all_mode) {
> +               for (i = 0; i < url_nr; i++)
> +                       printf_ln("%s", url[i]);
> +       } else {
> +               printf_ln("%s", *url);
> +       }
> +
> +       return 0;
> +}
