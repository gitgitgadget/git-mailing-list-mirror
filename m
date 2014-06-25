From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] imap-send.c: replace git_config with git_config_get_string
Date: Wed, 25 Jun 2014 03:09:18 -0400
Message-ID: <CAPig+cTStpB09Fh3bAF2NcdWR9W_UMaL5qutvUuQNfEL4=GwNw@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzhKl-00076n-H9
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 09:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbaFYHJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 03:09:23 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:64887 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbaFYHJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 03:09:19 -0400
Received: by mail-yk0-f180.google.com with SMTP id 131so855875ykp.25
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TmPi57u7cxp5UkkB57qLVPpKU/LU3Nu1I9M87tsv/nQ=;
        b=bNuTt/6OJvxsO1PVKVje5ODBi7ahT27UJDT6cKJ5gBt4C9MWhcYUBrYy/3TE5ypFs9
         fg3I+EHwvM1RBziPnNUjlhUziPy2gPJK4XjbRxos/Ag0VZ8OXOkteliM6Ob/Kb/mlOhH
         9/zIb6BE/SqJwawTXDuu7oGlf3rHzvQIacZg7belQIafdllAarwsu2KphY1/WSjd+QjW
         3NdJlPAcdZqXaT8phLjiVlY70HecVniZ4Z4oJV+xBXPENVMnSH0pyr/y1fAESCV/VSgp
         UUX7V7l5Ms70uQALBUolBIaOcECpv02NgxWdNL6l+22tG1RCSX9vdOWluSI4aOOEXWrt
         nc7g==
X-Received: by 10.236.81.1 with SMTP id l1mr8903411yhe.27.1403680158605; Wed,
 25 Jun 2014 00:09:18 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Wed, 25 Jun 2014 00:09:18 -0700 (PDT)
In-Reply-To: <1403520105-23250-3-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: cNhuWG9v8ua7RvLFU9SVdou0NbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252436>

On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use git_config_get_string instead of git_config to take advantage of
> the config hash-table api which provides a cleaner control flow.

You may want to mention as a side-note the slight behavior change
introduced by this patch. The original code complained about any
unknown boolean "imap.*" key, whereas the new code does not.

More below.

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  imap-send.c | 68 ++++++++++++++++++++++++++-----------------------------------
>  1 file changed, 29 insertions(+), 39 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 83a6ed2..87bd418 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1326,47 +1326,37 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
>
>  static char *imap_folder;
>
> -static int git_imap_config(const char *key, const char *val, void *cb)
> +static void git_imap_config(void)
>  {
> -       char imap_key[] = "imap.";
> -
> -       if (strncmp(key, imap_key, sizeof imap_key - 1))
> -               return 0;
> -
> -       key += sizeof imap_key - 1;
> -
> -       /* check booleans first, and barf on others */
> -       if (!strcmp("sslverify", key))
> -               server.ssl_verify = git_config_bool(key, val);
> -       else if (!strcmp("preformattedhtml", key))
> -               server.use_html = git_config_bool(key, val);
> -       else if (!val)
> -               return config_error_nonbool(key);
> -
> -       if (!strcmp("folder", key)) {
> -               imap_folder = xstrdup(val);
> -       } else if (!strcmp("host", key)) {
> -               if (starts_with(val, "imap:"))
> -                       val += 5;
> -               else if (starts_with(val, "imaps:")) {
> -                       val += 6;
> +       const char *value;

Observation: If you name this variable 'val', which is the name of the
argument to the function in the original code, you will get a slightly
smaller and more readable diff. In this case, the improvement in the
diff is so slight that it might not be worth re-using the old variable
name, but in general, it's helpful to keep in mind that the smaller
and simpler the diff, the easier the patch is to review.

> +       if (!git_config_get_string("imap.sslverify", &value))
> +               server.ssl_verify = git_config_bool("sslverify", value);

I realize that you are just replicating the behavior of the original
code, but the error message emitted here for a non-bool value is less
than desirable since it throws away context (namely, the "imap."
prefix). You can improve the message, and help the user resolve the
error more quickly, by presenting the full configuration key (namely,
"imap.sslverify"). Such a change would deserve mention in the commit
message. Alternately, it could be fixed in a follow-up patch.

> +       if (!git_config_get_string("imap.preformattedhtml", &value))
> +               server.use_html = git_config_bool("preformattedhtml", value);

Ditto regarding error message: "imap.preformattedhtml"

> +       if (!git_config_get_string("imap.folder", &value))
> +               imap_folder = xstrdup(value);
> +       if (!git_config_get_string("imap.host", &value)) {
> +               if (starts_with(value, "imap:"))
> +                       value += 5;
> +               else if (starts_with(value, "imaps:")) {
> +                       value += 6;
>                         server.use_ssl = 1;
>                 }
> -               if (starts_with(val, "//"))
> -                       val += 2;
> -               server.host = xstrdup(val);
> -       } else if (!strcmp("user", key))
> -               server.user = xstrdup(val);
> -       else if (!strcmp("pass", key))
> -               server.pass = xstrdup(val);
> -       else if (!strcmp("port", key))
> -               server.port = git_config_int(key, val);
> -       else if (!strcmp("tunnel", key))
> -               server.tunnel = xstrdup(val);
> -       else if (!strcmp("authmethod", key))
> -               server.auth_method = xstrdup(val);
> -
> -       return 0;
> +               if (starts_with(value, "//"))
> +                       value += 2;
> +               server.host = xstrdup(value);
> +       }
> +       if (!git_config_get_string("imap.user", &value))
> +               server.user = xstrdup(value);
> +       if (!git_config_get_string("imap.pass", &value))
> +               server.pass = xstrdup(value);
> +       if (!git_config_get_string("imap.port", &value))
> +               server.port = git_config_int("port", value);

Same regarding diagnostic: "imap.port"

> +       if (!git_config_get_string("imap.tunnel", &value))
> +               server.tunnel = xstrdup(value);
> +       if (!git_config_get_string("imap.authmethod", &value))
> +               server.auth_method = xstrdup(value);
>  }
>
>  int main(int argc, char **argv)
> @@ -1387,7 +1377,7 @@ int main(int argc, char **argv)
>                 usage(imap_send_usage);
>
>         setup_git_directory_gently(&nongit_ok);
> -       git_config(git_imap_config, NULL);
> +       git_imap_config();
>
>         if (!server.port)
>                 server.port = server.use_ssl ? 993 : 143;
> --
> 1.9.0.GIT
