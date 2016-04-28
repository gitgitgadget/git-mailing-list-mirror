From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule init: fail gracefully with a missing
 .gitmodules file
Date: Thu, 28 Apr 2016 12:12:56 -0700
Message-ID: <CAGZ79kairv4jXsaRfqj_TA9ejqOyinOVwrj+-ATMTraaiQsvBA@mail.gmail.com>
References: <1461868119-9146-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:13:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avrN1-000179-NB
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbcD1TM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:12:59 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37793 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbcD1TM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:12:58 -0400
Received: by mail-ig0-f182.google.com with SMTP id s8so1039839ign.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=U9PQQpCZWbAeNuWRrGaMmwyJrMDrybyQtN0rXfEGVoQ=;
        b=I4uRRwx1QU5FhoNZBEdygdJQMjCo8D2lMqE4NoccfZUZTqH6/xQCapEzap9ewB34SL
         QEnfgtv3/4jy3GgePv05m2HVihWBrJZ4H+M0qH6fwRHwZi41M9cbfXRg67c2D4YBMuFm
         fBxVvnbmQLdKZlA+T9tkCQ10IRoiPcthz3P8vN6C1nSQdqMkmVDyLL9Akl9FVTurrw2u
         9KbGiO9DsvPEu0j3Y8nRXkD97vcbJ7WVpX2O1e3p5tvmtKIS8wcLLrEsGDylr7r7b9fX
         LU8BYrGWJ98v3clmjhd2GcHdUmyLXyEmlNNi1tSGS/Vwh9AhSZfctFEYllkoY9rh50h3
         tMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=U9PQQpCZWbAeNuWRrGaMmwyJrMDrybyQtN0rXfEGVoQ=;
        b=AIVHro/tw5OnsB5EDUvTP5nq5wROF5eS+C0bMKSeUMnp260QeZyXT6OBjTj8/5I5Pe
         SJdteZSR+vjPU6aXAiitP9D6k+ZCXHVZb+W6idNnU3HztrqkQ82euK+P+Gx7H97nrxrs
         +1xOHtiSRtRNyvaf3FfFztgCNl+czgXXaRB3+LfBY7x67rRMZjiILbiRFOv+ZzupS/lS
         QL/izsZiwi3+HkMK9wowSGaUtzSLdxI6sHJQ3Myt+kLja059e7PLemrPg+pXxqjM5Vzu
         2zgr8GdPei8zns8ywSqLdlc5lgBp9onkTtY1iBbjhhNl26lT0VfvKs94EJ1r0fdDEAQF
         RgjA==
X-Gm-Message-State: AOPr4FVpemH9Z563Atv6gVZQg/YRHWbPuVY9ItlBZQYlAaIJhSMYIGMxylQnlvRSy0TPAWbUjlQinYKPTDfVdiLG
X-Received: by 10.50.72.107 with SMTP id c11mr20416709igv.85.1461870777017;
 Thu, 28 Apr 2016 12:12:57 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 12:12:56 -0700 (PDT)
In-Reply-To: <1461868119-9146-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292937>

On Thu, Apr 28, 2016 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
> When there is no .gitmodules file availabe to initialize a submodule
> from, `submodule_from_path` just returns NULL. We need to check for
> that and abort gracefully. When `submodule init` was implemented in shell,
> a missing .gitmodules file would result in an error message
>
>     No url found for submodule path '%s' in .gitmodules
>
> While that is technically true, I think we can broaden the error message
> and just say there is no section for the submodule in the .gitmodules file.

Actually I am not so sure any more about this part. In a resend I will use
the old error message again.

This fix is also required for `submodule--helper update-clone`.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  This goes on top of sb/submodule-init (I added the base-commit
>  below, just in case anyone uses that feature already. Though I did
>  that manually :)
>
>  Thanks,
>  Stefan
>
>  builtin/submodule--helper.c | 10 +++++++---
>  t/t7400-submodule-basic.sh  |  8 ++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b6d4f27..af5406e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -314,13 +314,17 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>         /* Only loads from .gitmodules, no overlay with .git/config */
>         gitmodules_config();
>
> -       sub = submodule_from_path(null_sha1, path);
> -
>         if (prefix) {
>                 strbuf_addf(&sb, "%s%s", prefix, path);
>                 displaypath = strbuf_detach(&sb, NULL);
>         } else
> -               displaypath = xstrdup(sub->path);
> +               displaypath = xstrdup(path);
> +
> +       sub = submodule_from_path(null_sha1, path);
> +
> +       if (!sub)
> +               die(_("No section found for submodule path '%s' in .gitmodules"),
> +                       displaypath);
>
>         /*
>          * Copy url setting when it is not set yet.
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index f99f674..f2b3519 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -18,6 +18,14 @@ test_expect_success 'setup - initial commit' '
>         git branch initial
>  '
>
> +test_expect_success 'sane abort on missing .gitmodules file' '
> +       test_when_finished "git update-index --remove sub" &&
> +       git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
> +       # missing the .gitmodules file here
> +       test_must_fail git submodule init 2>actual &&
> +       test_i18ngrep "No section found for submodule path" actual
> +'
> +
>  test_expect_success 'configuration parsing' '
>         test_when_finished "rm -f .gitmodules" &&
>         cat >.gitmodules <<-\EOF &&
> --
> 2.8.0.26.g3604242.dirty
>
> base-commit: 3604242f080a813d6f20a7394def422d1e55b30e
