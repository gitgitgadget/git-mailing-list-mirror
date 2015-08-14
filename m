From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Correctly close config file handle in case of error
Date: Fri, 14 Aug 2015 16:32:35 -0400
Message-ID: <CAPig+cSSdGeMuV1XLqROXvSeYfmkNc_N7E_pzfJWdDR6wfD80A@mail.gmail.com>
References: <55CE3F23.7040702@cs-ware.de>
	<CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
	<55CE4511.6050704@cs-ware.de>
	<CAPig+cStMdZUwDgSfzT_DgBpF-OMQe-PqTKbSLkzXFHQW8ca=Q@mail.gmail.com>
	<55CE49AD.4010605@cs-ware.de>
	<CAPig+cTo=iiMvvcfRu68feofoBVSFjrd4zG8GYwXN5L6THr=8Q@mail.gmail.com>
	<55CE4DBD.2070308@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLea-00075w-B9
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbbHNUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:32:36 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35344 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbHNUcf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:32:35 -0400
Received: by ykbi184 with SMTP id i184so14683306ykb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=97NG0Ni1Zam1HqTeDUvVSE6RzGvnVfwc0++/LtiKKt4=;
        b=cUEtR079eeCuhLXEWlqOva7YBIz2dYQlq8Oo2OR7XzYR/8RjgApBYNTtNRtAE84c0K
         990asw5E8HgKmqPQh4Ffd+4V/FNlDQptOOeraafZYGvR0GaCzxGg9MaWJ+PMfKuZRJGi
         cJhs2/0rsNqVfGq28yQ2icBwzqoFIKJ05R3yjDgI+EBGGrQiNhxmc0KM+2Clb/KEuejp
         WVn7zgE3hoQNN+gBVukYmHBRNNgVV7lUT7MzTjaZXRZ+FiTrYcaG97GfnMo13bFBgOUT
         7SeLbc5Esb5KGeciGVOGmXGmm1VhNq1EssOd3G/wik9B67gGzIbSFBQFcTwzxkP/rjrB
         OZIw==
X-Received: by 10.13.192.132 with SMTP id b126mr46916320ywd.163.1439584355321;
 Fri, 14 Aug 2015 13:32:35 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 13:32:35 -0700 (PDT)
In-Reply-To: <55CE4DBD.2070308@cs-ware.de>
X-Google-Sender-Auth: n3MrR2Va6m-ZUXlAwmqfdaaeObc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275941>

On Fri, Aug 14, 2015 at 4:21 PM, Sven Strickroth <sven@cs-ware.de> wrote:
> Without this patch there might be open file handle leaks.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>

Better. Thanks.

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
> diff --git a/config.c b/config.c
> index 9fd275f..83caa25 100644
> --- a/config.c
> +++ b/config.c
> @@ -1935,7 +1935,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                                 const char *key, const char *value,
>                                 const char *value_regex, int multi_replace)
>  {
> -       int fd = -1, in_fd;
> +       int fd = -1, in_fd = -1;
>         int ret;
>         struct lock_file *lock = NULL;
>         char *filename_buf = NULL;
> @@ -2065,6 +2065,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                         goto out_free;
>                 }
>                 close(in_fd);
> +               in_fd = -1;
>
>                 if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
>                         error("chmod on %s failed: %s",
> @@ -2148,6 +2149,8 @@ out_free:
>         free(filename_buf);
>         if (contents)
>                 munmap(contents, contents_sz);
> +       if (in_fd >= 0)
> +               close(in_fd);
>         return ret;
>
>  write_err_out:
> --
> Best regards,
>  Sven Strickroth
>  PGP key id F5A9D4C4 @ any key-server
