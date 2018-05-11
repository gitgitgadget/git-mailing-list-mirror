Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C59F1F406
	for <e@80x24.org>; Fri, 11 May 2018 22:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeEKWjd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 May 2018 18:39:33 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32799 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeEKWjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 18:39:32 -0400
Received: by mail-qk0-f171.google.com with SMTP id c11-v6so5644776qkm.0
        for <git@vger.kernel.org>; Fri, 11 May 2018 15:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6XuUZA3txvZHUXfHMs4ISrxv0+dLtZTtIitW+8WKtg8=;
        b=CLrIoeN88GhOMOeLnesZPvvLnB5JtXQhvmvjDW4lKJmG4MVBFvbcXkKZj3/YpwW+wu
         ejhXXMQimov4Yvon9SFMCXFvgEslsm8h3FXLHOu6bW3DSOHtNqRGKwMjYtGVNUhaVB5D
         EyG40CtgNeka7pmVpNiqPOPT3YyfLeWES0WAXLvlD6FKOc+V2hguzmTomwZIllzZ5lWa
         5aPqcrqfTsQ4nYlkv7gjn8aYfJGJB0xe/neszhDyXXmaiWmMTYjTEJBctctENgDC1cIg
         w0uVP6dTb/krUMWprzEio1Q6YISQRbVWXHXEdlO9HPJzZuQmem+1ggTLHCbstXbkKcvY
         c0MQ==
X-Gm-Message-State: ALKqPwfv+rfF+P1Jldf34loiYO2CskpDJcGhb8U7x2EmvaGnTilLG+m5
        Z0UQVsl/rvkZkVFlY80aq6oE/T5fArVk1ZuI3OGf4A==
X-Google-Smtp-Source: AB8JxZppxx2824WAxDFRroJ/7Rhb7P75pWOmPb8RWmelYl4oakiIWV+q1h7qPFOAh8JS7oTMQTAkuZ0old54SfOTM8Y=
X-Received: by 2002:a37:be86:: with SMTP id o128-v6mr6579485qkf.141.1526078371730;
 Fri, 11 May 2018 15:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180510141927.23590-1-pclouds@gmail.com> <20180510141927.23590-5-pclouds@gmail.com>
In-Reply-To: <20180510141927.23590-5-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 May 2018 18:39:20 -0400
Message-ID: <CAPig+cR63S-cpihwHYOadK_SbNRoCVjOOQH87Ry7fdCwxdbOxg@mail.gmail.com>
Subject: Re: [PATCH 4/9] help: add --config to list all available config
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:20 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
wrote:
> Sometimes it helps to list all available config vars so the user can
> search for something they want. The config man page can also be used
> but it's harder to search if you want to focus on the variable name,
> for example.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/builtin/help.c b/builtin/help.c
> @@ -44,6 +45,7 @@ static struct option builtin_help_options[] = {
>          OPT_BOOL('g', "guides", &show_guides, N_("print list of useful
guides")),
> +       OPT_BOOL('c', "config", &show_config, N_("print list recognized
config variables")),

s/list/& of/

Though, simpler might be better: "print all configuration variable names"

> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> @@ -76,6 +76,24 @@ print_command_list () {
> +print_config_list() {
> +       cat <<EOF
> +static const char *config_name_list[] = {
> +EOF
> +       grep '^[a-zA-Z].*\..*::$' Documentation/config.txt |
> +       grep -v deprecated |
> +       sed 's/::$//; s/,  */\n/g' |

Nit: "grep -v" and "sed" could be combined:

     sed '/deprecated/d; s/::$//; s/,  */\n/g' |

> +       sort |
> +       while read line
> +       do
> +               echo "  \"$line\","
> +       done
> +       cat <<EOF
> +       NULL,
> +};
> +EOF
> diff --git a/help.c b/help.c
> @@ -409,6 +409,54 @@ void list_common_guides_help(void)
> +void list_config_help(void)
> +{
> +       [...]
> +       for (p = config_name_list; *p; p++) {
> +               const char *var = *p;
> +
> +               for (e = slot_expansions; e->prefix; e++) {
> +                       struct strbuf sb = STRBUF_INIT;
> +
> +                       strbuf_addf(&sb, "%s.%s", e->prefix,
e->placeholder);
> +                       if (strcasecmp(var, sb.buf))
> +                               continue;

Isn't this "continue" leaking the strbuf? It seems that it would be easier
to declare the strbuf once outside the loop, strbuf_reset() it at the top
of the loop, and finally strbuf_release() it after the loop exits.

> +                       e->fn(e->prefix);
> +                       strbuf_release(&sb);
> +                       e->found++;
> +                       break;
> +               }
> +               if (!e->prefix)
> +                       puts(var);
> +       }
