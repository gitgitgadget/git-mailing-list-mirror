From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/11] http-backend.c: replace `git_config()` with
 `git_config_get_bool()` family
Date: Mon, 4 Aug 2014 14:59:10 -0400
Message-ID: <CAPig+cRpf9fc4HhNWpJ9Su+hSVEDc2+m4QmhY38zLD3RO8pGnA@mail.gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
	<1407177229-30081-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:59:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENTX-0007BB-J6
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbaHDS7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:59:12 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:40546 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbaHDS7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:59:11 -0400
Received: by mail-yk0-f178.google.com with SMTP id 142so4384541ykq.37
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7ECMsWZi1oTgf5pOcgWyvMV5u7DmfNFiEonTpKK2kwY=;
        b=gRbJZOo9tDvsek2AHRvB/o5l+vsQgK9jEP9vxwL99Mv4zDa2R9UkjRaijAcHMM+7NZ
         4nJgz+LQuu4IIYREQE8nW0ZiGix+Ez7F1o5xWPyOuQnMLVd4HUfSUlQntnC+QXeWbxHw
         N/WlQlWl35AMPxmWPFiYAc0Ug0nmJBSZse5Ut9b3n7XY5GaWYS3IwetShIR/H4sxWg53
         p+3pK1JvrirjprACPRmSNemqrth4ly+3dGsfoDNSU4TDfk3EelXDMdEOyE9h0HOgvf8y
         +LA8tVdmIw559zaDM5FBIst5FFOoqk8AI5MGBAT1eoEatGfnmUC+5yOYOStk+yfjwtNK
         FTFA==
X-Received: by 10.236.221.162 with SMTP id r32mr41639967yhp.94.1407178750739;
 Mon, 04 Aug 2014 11:59:10 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Mon, 4 Aug 2014 11:59:10 -0700 (PDT)
In-Reply-To: <1407177229-30081-3-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: x_btR_oXC_qPCp3nmGDjLgzKmUM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254767>

On Mon, Aug 4, 2014 at 2:33 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use `git_config_get_bool()` family instead of `git_config()` to take advantage of
> the config-set API which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  http-backend.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index 80790bb..106ca6b 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -219,29 +219,22 @@ static void get_idx_file(char *name)
>         send_local_file("application/x-git-packed-objects-toc", name);
>  }
>
> -static int http_config(const char *var, const char *value, void *cb)
> +static void http_config(void)
>  {
> -       const char *p;
> +       int i, value = 0;
> +       struct strbuf var = STRBUF_INIT;
>
> -       if (!strcmp(var, "http.getanyfile")) {
> -               getanyfile = git_config_bool(var, value);
> -               return 0;
> -       }
> +       git_config_get_bool("http.getanyfile", &getanyfile);
>
> -       if (skip_prefix(var, "http.", &p)) {
> -               int i;
> -
> -               for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
> -                       struct rpc_service *svc = &rpc_service[i];
> -                       if (!strcmp(p, svc->config_name)) {
> -                               svc->enabled = git_config_bool(var, value);
> -                               return 0;
> -                       }
> -               }
> +       for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
> +               struct rpc_service *svc = &rpc_service[i];
> +               strbuf_addf(&var, "http.%s", svc->config_name);
> +               if (!git_config_get_bool(var.buf, &value))
> +                       svc->enabled = value;
> +               strbuf_reset(&var);
>         }

There is a behavior change here. The original code set svc->enabled to
the first matching rpc_service[] entry, whereas the new code sets it
to the last matching entry. Is this change intentional?

> -       /* we are not interested in parsing any other configuration here */
> -       return 0;
> +       strbuf_release(&var);
>  }
>
>  static struct rpc_service *select_service(const char *name)
> @@ -627,7 +620,7 @@ int main(int argc, char **argv)
>             access("git-daemon-export-ok", F_OK) )
>                 not_found("Repository not exported: '%s'", dir);
>
> -       git_config(http_config, NULL);
> +       http_config();
>         cmd->imp(cmd_arg);
>         return 0;
>  }
> --
> 1.9.0.GIT
