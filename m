From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] submodule: implement `module_name` as a builtin helper
Date: Tue, 4 Aug 2015 20:58:41 -0400
Message-ID: <CAPig+cQtoWF_9Km4H7MXDf7ySQNUP9gncxkrV3NFTrULA8fbbA@mail.gmail.com>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
	<1438733070-15805-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 02:58:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMn2e-0002po-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 02:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbbHEA6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 20:58:45 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34614 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbbHEA6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 20:58:42 -0400
Received: by ykax123 with SMTP id x123so23328273yka.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3Yp+dOsP6eSIEcKUBBPHvbAssnNIUQwAfVt+EFAuSTM=;
        b=E2MZuRrbpP0e7vNu03q31JORh5/PxA4Gc2FiRWYLCNTkycKr0+AyBfa+pfRN0LuySF
         R0eBxpdnpFV8AgHoSLTZuriYeNvof/zYd/vbl18nbiEp/nWl54ZI7sRHIPWL1C5pYi0/
         hect+69RK3EF3G6u+pp0ixrnUaPLW/fCU8ZIHkNVU7YpzVgxaiRpt+i2n87nU8xYIM60
         WZxCuYHVdBvU9Ijego2Z2Ndyl52tN3F1RdonT/aUUmt9o3EytuqJzBMZhwjG5AqNbmBh
         dJmB7Y/s7EKS3lkeXQUldC1ByrL+8UAezp/MF9maD9jiHu8M/5VHzxJcBXYH2FStCK6z
         ZN9A==
X-Received: by 10.13.192.132 with SMTP id b126mr6764283ywd.163.1438736321830;
 Tue, 04 Aug 2015 17:58:41 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 4 Aug 2015 17:58:41 -0700 (PDT)
In-Reply-To: <1438733070-15805-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: dh81ggNiSSx4NBC3xbp8hC2FOWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275349>

On Tue, Aug 4, 2015 at 8:04 PM, Stefan Beller <sbeller@google.com> wrote:
> The goal of this series being rewriting `git submodule update`,
> we don't want to call out to the shell script for config lookups.
>
> So reimplement the lookup of the submodule name in C.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index cb18ddf..dd5635f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -98,6 +100,48 @@ static int module_list(int argc, const char **argv, const char *prefix)
> +static int collect_module_names(const char *key, const char *value, void *cb)
> +{
> +       size_t len;
> +       struct string_list *sl = cb;
> +
> +       if (starts_with(key, "submodule.")
> +           && strip_suffix(key, ".path", &len)) {
> +               struct strbuf sb = STRBUF_INIT;
> +               strbuf_add(&sb, key + strlen("submodule."),
> +                               len - strlen("submodule."));
> +               string_list_insert(sl, value)->util = strbuf_detach(&sb, NULL);
> +               strbuf_release(&sb);

Why the complexity and overhead of a strbuf when the same could be
accomplished more easily and straightforwardly with xstrndup()?

> +       }
> +
> +       return 0;
> +}
> +
> +static int module_name(int argc, const char **argv, const char *prefix)
> +{
> +       struct string_list_item *item;
> +       struct git_config_source config_source;
> +       struct string_list values = STRING_LIST_INIT_DUP;
> +
> +       if (!argc)

Do you mean?

    if (argc != 1)

> +               usage("git submodule--helper module_name <path>\n");
> +
> +       memset(&config_source, 0, sizeof(config_source));
> +       config_source.file = ".gitmodules";
> +
> +       if (git_config_with_options(collect_module_names, &values,
> +                                   &config_source, 1) < 0)
> +               die(_("unknown error occured while reading the git modules file"));
> +
> +       item = string_list_lookup(&values, argv[0]);
> +       if (item)
> +               printf("%s\n", (char*)item->util);
> +       else
> +               die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
> +       return 0;
> +}
> +
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  {
>         if (argc < 2)
> @@ -106,6 +150,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>         if (!strcmp(argv[1], "module_list"))
>                 return module_list(argc - 1, argv + 1, prefix);
>
> +       if (!strcmp(argv[1], "module_name"))
> +               return module_name(argc - 2, argv + 2, prefix);
> +
>  usage:
>         usage("git submodule--helper module_list\n");
>  }
