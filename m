From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/5] submodule--helper: move config-sanitizing to submodule.c
Date: Thu, 28 Apr 2016 08:30:45 -0700
Message-ID: <CAGZ79kbJvgseY6aBV6vh0aEFNmHDtSvQuM8xHvp7_pYZSXCq+A@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net>
	<20160428133819.GD25319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:30:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnu1-00075G-Km
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcD1Pat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:30:49 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37528 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcD1Pas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:30:48 -0400
Received: by mail-ig0-f179.google.com with SMTP id s8so24006301ign.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/+NeD305kgPAVtb4WuE8Cdin+lK/va41YIau7PTencE=;
        b=U7BGmE0moOtuv6MfzF8d4GqGrP7HsnkYTTgBeqVpMMTZkG+4TIn3TSAjvQcX89r5cY
         6BF8R5BghwWn40qRQSsQQlaG9PC/37exu59Kg066O9b1Hye3bDxHphXGPqovVM3ndfHy
         Ad72+aHSLOnanqqmwB1jIFulYnyp/+t5kWPvwfE6T/DWDeoW9PS5WQD2mc4rSo+gZ82m
         1VhD/1+fWSUOkurG1GjIpEwgk+0P+Ke61KpGTL3IYkqGlsZLjmkMungoCKqFs6XgoyTB
         zV1SJ/eneFEwMEAJC9EUdbl8+fCYhC8NK9PTuYVuxfldVs7gwVp2CHkFdlTNjf+JMYdR
         uk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/+NeD305kgPAVtb4WuE8Cdin+lK/va41YIau7PTencE=;
        b=GXUvMK2EwkFwpYL+Pv3oqTDBDFZEqlGsOaqlnAHMHOyjnvLYqBq0MvrTiTdFWqOhKA
         nOfaM91wwve9Lxryo4iXIG2zuu0QJY23GGo+s/EeIpQZmYl44i3eJD1NlbvHaIw/WKUf
         TiDwcv7Zhowey3ZD1fqfGFUDkVLwEMdpKgG/cR86eS2geYuqomr18VHt68D3bQgL4GKU
         tiP7uy6aLsX6pJVX/DQHjmP0zRWRwhyDqtGQP0u/RgHUQYy2qCBAbQW/8VebIdXrbHwB
         Bnl8Bpckf8qzY8L7SrmLFqb2eMCVntuwhs0LbKn+YT23DN4FHwLG9kqd6SVin0J465m3
         lKVQ==
X-Gm-Message-State: AOPr4FWI31t65FFzEvkQm8gIEVtACMUR1Z9ZctH52RWSy+3raOU4o8fE8Bl9JZtRVSwQDIQS0en/fvMEOkBvpqoZ
X-Received: by 10.50.111.15 with SMTP id ie15mr19633188igb.94.1461857446347;
 Thu, 28 Apr 2016 08:30:46 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 08:30:45 -0700 (PDT)
In-Reply-To: <20160428133819.GD25319@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292903>

On Thu, Apr 28, 2016 at 6:38 AM, Jeff King <peff@peff.net> wrote:
> These functions should be used by any code which spawns a
> submodule process, which may happen in submodule.c (e.g.,
> for spawning fetch). Let's move them there and make them
> public so that submodule--helper can continue to use them.
>
> Sine they're now public, let's also provide a basic overview
> of their intended use.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/submodule--helper.c | 48 --------------------------------------------
>  submodule.c                 | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  submodule.h                 | 16 +++++++++++++++
>  3 files changed, 65 insertions(+), 48 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3bd6883..de3ad5b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -119,54 +119,6 @@ static int module_name(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> -/*
> - * Rules to sanitize configuration variables that are Ok to be passed into
> - * submodule operations from the parent project using "-c". Should only
> - * include keys which are both (a) safe and (b) necessary for proper
> - * operation.
> - */
> -static int submodule_config_ok(const char *var)
> -{
> -       if (starts_with(var, "credential."))
> -               return 1;
> -       return 0;
> -}
> -
> -static int sanitize_submodule_config(const char *var, const char *value, void *data)
> -{
> -       struct strbuf *out = data;
> -
> -       if (submodule_config_ok(var)) {
> -               if (out->len)
> -                       strbuf_addch(out, ' ');
> -
> -               if (value)
> -                       sq_quotef(out, "%s=%s", var, value);
> -               else
> -                       sq_quote_buf(out, var);
> -       }
> -
> -       return 0;
> -}
> -
> -static void prepare_submodule_repo_env(struct argv_array *out)
> -{
> -       const char * const *var;
> -
> -       for (var = local_repo_env; *var; var++) {
> -               if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> -                       struct strbuf sanitized_config = STRBUF_INIT;
> -                       git_config_from_parameters(sanitize_submodule_config,
> -                                                  &sanitized_config);
> -                       argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> -                       strbuf_release(&sanitized_config);
> -               } else {
> -                       argv_array_push(out, *var);
> -               }
> -       }
> -
> -}
> -
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>                            const char *depth, const char *reference, int quiet)
>  {
> diff --git a/submodule.c b/submodule.c
> index 90825e1..02eaf0e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -13,6 +13,7 @@
>  #include "argv-array.h"
>  #include "blob.h"
>  #include "thread-utils.h"
> +#include "quote.h"
>
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>  static int parallel_jobs = 1;
> @@ -1129,3 +1130,51 @@ int parallel_submodules(void)
>  {
>         return parallel_jobs;
>  }
> +
> +/*
> + * Rules to sanitize configuration variables that are Ok to be passed into
> + * submodule operations from the parent project using "-c". Should only
> + * include keys which are both (a) safe and (b) necessary for proper
> + * operation.
> + */
> +static int submodule_config_ok(const char *var)
> +{
> +       if (starts_with(var, "credential."))
> +               return 1;
> +       return 0;
> +}
> +
> +int sanitize_submodule_config(const char *var, const char *value, void *data)
> +{
> +       struct strbuf *out = data;
> +
> +       if (submodule_config_ok(var)) {
> +               if (out->len)
> +                       strbuf_addch(out, ' ');
> +
> +               if (value)
> +                       sq_quotef(out, "%s=%s", var, value);
> +               else
> +                       sq_quote_buf(out, var);
> +       }
> +
> +       return 0;
> +}
> +
> +void prepare_submodule_repo_env(struct argv_array *out)
> +{
> +       const char * const *var;
> +
> +       for (var = local_repo_env; *var; var++) {
> +               if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> +                       struct strbuf sanitized_config = STRBUF_INIT;
> +                       git_config_from_parameters(sanitize_submodule_config,
> +                                                  &sanitized_config);
> +                       argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> +                       strbuf_release(&sanitized_config);
> +               } else {
> +                       argv_array_push(out, *var);
> +               }
> +       }
> +
> +}
> diff --git a/submodule.h b/submodule.h
> index 7ef3775..7577b3b 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -61,4 +61,20 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>  int parallel_submodules(void);
>
> +/*
> + * This function is intended as a callback for use with
> + * git_config_from_parameters(). It ignores any config options which
> + * are not suitable for passing along to a submodule, and accumulates the rest
> + * in "data", which must be a pointer to a strbuf.

So why is it a void* then? You could make it a strbuf* here, so you
would not have to document it?
Oh right, because of git_config_from_parameters(sanitize_submodule_config, ...



> The end result can
> + * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.

s/sub-process/process operating on submodules/, maybe ?

While it is technically a sub-process, I started to have an aversion
against "sub"-things
unless strictly required. :)

> + */
> +int sanitize_submodule_config(const char *var, const char *value, void *data);
> +
> +/*
> + * Prepare the "env_array" parameter of a "struct child_process" for executing
> + * a submodule by clearing any repo-specific envirionment variables, but
> + * retaining any config approved by sanitize_submodule_config().
> + */
> +void prepare_submodule_repo_env(struct argv_array *out);
> +
>  #endif
> --
> 2.8.1.617.gbdccc2d
>
