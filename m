From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of
 xmalloc + sprintf
Date: Wed, 25 Jun 2014 19:37:55 +0700
Message-ID: <CACsJy8BT8eNfKy64Bt3rJ642d449MdkKLbTCi0MYNcDRQ0X=ag@mail.gmail.com>
References: <20140619211659.GA32412@sigill.intra.peff.net> <20140619212800.GF28474@sigill.intra.peff.net>
 <CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com> <20140624205815.GA28724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 14:38:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzmT8-0000IO-9e
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 14:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915AbaFYMi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 08:38:26 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:63725 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbaFYMiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 08:38:25 -0400
Received: by mail-qa0-f52.google.com with SMTP id w8so1484450qac.11
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nk6HgUCYKXxtH33T9T1a/m8L1kDbVBcat7473veyDj4=;
        b=yvfltDo9nf6kRdKsKvniTZS2Wh7zcmNRV9FqN80IMGd04xaKHju2xSHCt3AM/W/pEt
         Zfo/XEC5UYw6kHK7moxRgfA5i3tTplaEAoxUOpl3TXXOFgUg0wS62u9MA4du2adq1CNN
         Yy6v8AL8RXnwJDXQ91G/UdayFQnnTG0yQjMRfNuzlyLDO5WI+697ZMGVKsrEpUj96xkS
         Xt2Lz187TDyr5ILbcWmz6kihTKcWyy/aPSSJSQe+pUqtz32NgtcpPDOK7M/A5apv81zk
         Lfvd69Qaa8ZQMEsAqHV05kJAYr8BXAeavmB2UBERB04d0KJLOPTozwjTXio1+qeh/B2d
         FdDw==
X-Received: by 10.224.22.12 with SMTP id l12mr11469308qab.88.1403699905139;
 Wed, 25 Jun 2014 05:38:25 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 25 Jun 2014 05:37:55 -0700 (PDT)
In-Reply-To: <20140624205815.GA28724@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252443>

On Wed, Jun 25, 2014 at 3:58 AM, Jeff King <peff@peff.net> wrote:
> Here's a replacement patch that handles this (and just drops the ugly
> mallocs as a side effect).

Shortly after I wrote my email, I thought about getenvdup() and look
for similar getenv/xstrdup patterns. But I saw only one in config.c.
So let's forget about it. Your patch looks good.

>
> -- >8 --
> Subject: [PATCH] setup_git_env: copy getenv return value
>
> The return value of getenv is not guaranteed to survive
> across further invocations of setenv or even getenv. When we
> are assigning it to globals that last the lifetime of the
> program, we should make our own copy.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  environment.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 4dac5e9..efb2fa0 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -124,6 +124,12 @@ static char *expand_namespace(const char *raw_namespace)
>         return strbuf_detach(&buf, NULL);
>  }
>
> +static char *git_path_from_env(const char *envvar, const char *path)
> +{
> +       const char *value = getenv(envvar);
> +       return value ? xstrdup(value) : git_pathdup(path);
> +}
> +
>  static void setup_git_env(void)
>  {
>         const char *gitfile;
> @@ -134,19 +140,9 @@ static void setup_git_env(void)
>                 git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
>         gitfile = read_gitfile(git_dir);
>         git_dir = xstrdup(gitfile ? gitfile : git_dir);
> -       git_object_dir = getenv(DB_ENVIRONMENT);
> -       if (!git_object_dir) {
> -               git_object_dir = xmalloc(strlen(git_dir) + 9);
> -               sprintf(git_object_dir, "%s/objects", git_dir);
> -       }
> -       git_index_file = getenv(INDEX_ENVIRONMENT);
> -       if (!git_index_file) {
> -               git_index_file = xmalloc(strlen(git_dir) + 7);
> -               sprintf(git_index_file, "%s/index", git_dir);
> -       }
> -       git_graft_file = getenv(GRAFT_ENVIRONMENT);
> -       if (!git_graft_file)
> -               git_graft_file = git_pathdup("info/grafts");
> +       git_object_dir = git_path_from_env(DB_ENVIRONMENT, "objects");
> +       git_index_file = git_path_from_env(INDEX_ENVIRONMENT, "index");
> +       git_graft_file = git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts");
>         if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
>                 check_replace_refs = 0;
>         namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
> --
> 2.0.0.566.gfe3e6b2
>



-- 
Duy
