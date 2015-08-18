From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v7 1/2] submodule refactor: use git_path_submodule() in add_submodule_odb()
Date: Mon, 17 Aug 2015 17:07:53 -0700
Message-ID: <CAGZ79kYQtcu_YJ57vT=OKh4WTbcfyjTRhn6eDbEO7BrfEru2TA@mail.gmail.com>
References: <1438725067-3295-1-git-send-email-max@max630.net>
	<1438725925-3689-1-git-send-email-max@max630.net>
	<1438725925-3689-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:07:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRURa-0008Un-RU
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbHRAHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:07:55 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36051 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbHRAHy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:07:54 -0400
Received: by ykfw73 with SMTP id w73so89330582ykf.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5VVTLI/wYl04WhJ0oZ9Wz7e5aqdPEteNrn4FHhDxEqw=;
        b=bz0AzA6en26nHSO4dUFqUQ0RjlAc7hvNJFUg1x/JMbXVskBgY4LADrkSEK5oD6jPC7
         iqB93jqwMJnbKuJkFe/HDU9b6NUnAGSpQEvX/osbVn4yq77eSy8DYS1jj4zRJO6UJFFz
         Zy9uOPKQ04vWcjQ2EnnAwwDLQOGxMtlAgksUSsav3yo/o5P8BT2UG3L485ZWHaoZ1pbm
         jbd3cpMN8uUtm2IntrkRS47diwEM4IgdcN+B1e0C/FVk8eAjZq7dxJiMlW30mRdXilEH
         7brjW7adegStsEGUmkHFao443RbBCwoijp7dgLWkzS2wS/wHeW1MC4ViPKtX64OzZxUb
         YK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5VVTLI/wYl04WhJ0oZ9Wz7e5aqdPEteNrn4FHhDxEqw=;
        b=lvomJkXajYVj1gsudVm18wNWu/xsJB0iseo9OMOhYUWLn+AiCzPkc8nmTlwvZlsMyt
         WWejBeHI8dmGj83NE4VNs6O7lEDsZyiYN2f7Dc/TpDp54ACdGIE8Rjm0fZc2oearcBYY
         dmyC6kEbH/InbY6Rg5YdyI359ATfJoLV071AvlhcHGW8TapeQD3qjLBH697BZvCVoubW
         a9erVWcmYwS7WcQasujDYyfBm640t8SfMtBIgS40HdiGrRuy6wQTVM9m/QH6pXl54eY3
         31FE8Ib2G/QwTxMJukLiSTsG0VjZBYDrRdmNajxIGCjBIOj+Eo8M4F/4z09TEpRWBGUX
         J65w==
X-Gm-Message-State: ALoCoQkJCLUBqS//vKt+cQnNuAAiORG20rBslS1tj5p70sNhW7JaWmCfTj2mCiSGSSJF7t8vwPEI
X-Received: by 10.170.112.194 with SMTP id e185mr4340694ykb.119.1439856473561;
 Mon, 17 Aug 2015 17:07:53 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 17 Aug 2015 17:07:53 -0700 (PDT)
In-Reply-To: <1438725925-3689-2-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276108>

On Tue, Aug 4, 2015 at 3:05 PM, Max Kirillov <max@max630.net> wrote:
> Functions which directly operate submodule's object database do not handle the
> case when the submodule is linked worktree (which are introduced in
> c7b3a3d2fe). Instead of fixing the path calculation use already existing
> git_path_submodule() function without changing overall behavior. Then it will
> be possible to modify only that function whenever we need to change real
> location of submodule's repository content.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  submodule.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 15e90d1..70d18ec 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -122,43 +122,35 @@ void stage_updated_gitmodules(void)
>
>  static int add_submodule_odb(const char *path)
>  {
> -       struct strbuf objects_directory = STRBUF_INIT;
>         struct alternate_object_database *alt_odb;
> +       const char *objects_directory;
>         int ret = 0;
> -       const char *git_dir;
>
> -       strbuf_addf(&objects_directory, "%s/.git", path);
> -       git_dir = read_gitfile(objects_directory.buf);
> -       if (git_dir) {
> -               strbuf_reset(&objects_directory);
> -               strbuf_addstr(&objects_directory, git_dir);
> -       }
> -       strbuf_addstr(&objects_directory, "/objects/");
> -       if (!is_directory(objects_directory.buf)) {
> +       objects_directory = git_path_submodule(path, "objects/");

git_path_submodule is going away with  jk/git-path (2015-08-10)
So you may want to use git_pathdup_submodule and free the
result of that function before returning.

> +       if (!is_directory(objects_directory)) {
>                 ret = -1;
>                 goto done;
>         }
> +
>         /* avoid adding it twice */
>         for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
> -               if (alt_odb->name - alt_odb->base == objects_directory.len &&
> -                               !strncmp(alt_odb->base, objects_directory.buf,
> -                                       objects_directory.len))
> +               if (alt_odb->name - alt_odb->base == strlen(objects_directory) &&
> +                               !strcmp(alt_odb->base, objects_directory))
>                         goto done;
>
> -       alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
> +       alt_odb = xmalloc(strlen(objects_directory) + 42 + sizeof(*alt_odb));
>         alt_odb->next = alt_odb_list;
> -       strcpy(alt_odb->base, objects_directory.buf);
> -       alt_odb->name = alt_odb->base + objects_directory.len;
> +       strcpy(alt_odb->base, objects_directory);
> +       alt_odb->name = alt_odb->base + strlen(objects_directory);
>         alt_odb->name[2] = '/';
>         alt_odb->name[40] = '\0';
>         alt_odb->name[41] = '\0';
>         alt_odb_list = alt_odb;
>
>         /* add possible alternates from the submodule */
> -       read_info_alternates(objects_directory.buf, 0);
> +       read_info_alternates(objects_directory, 0);
>         prepare_alt_odb();
>  done:
> -       strbuf_release(&objects_directory);
>         return ret;
>  }
>

This looks good, though I am diving into the submodule code base
myself just now,
so it's not a strong review. :)

> --
> 2.3.4.2801.g3d0809b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
