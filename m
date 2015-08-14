From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Correctly close config file handle in case of error
Date: Fri, 14 Aug 2015 16:14:11 -0400
Message-ID: <CAPig+cTo=iiMvvcfRu68feofoBVSFjrd4zG8GYwXN5L6THr=8Q@mail.gmail.com>
References: <55CE3F23.7040702@cs-ware.de>
	<CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
	<55CE4511.6050704@cs-ware.de>
	<CAPig+cStMdZUwDgSfzT_DgBpF-OMQe-PqTKbSLkzXFHQW8ca=Q@mail.gmail.com>
	<55CE49AD.4010605@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLMt-0007LY-43
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbHNUON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:14:13 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34481 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbHNUOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:14:12 -0400
Received: by ykdt205 with SMTP id t205so78594005ykd.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rvut27qkdjWIRUbFvEOFyRK7knMJBuLnUU05MGdhOho=;
        b=fJKauR+x4LAoU5mSZDiqAJhlrhZ9SFziI+srgcdd2t7e//EHYWu7kIYVvLEdVcIBnr
         0AdX8DzbRt4ciKdxEVv/EWSdpD2hajvk8rsSr1O9SSLJXhbIVH4UftxyDNkohmn8QdSz
         8zBcW6AQGBLjdEar6FyVeWgmrwh4ZusixjkB/OuzNvsC51xtZzyvaGKL9gsKXqHoxJEg
         PA51+gQ8ydvSQ1arbLtyjoOxQ4CZT5PUBfOhV7M9GTksbcLts0AJMcg/WTsiAVLLoxdS
         AONqpXf2eRgHFlKx8hdIJYyr5AYMZn95nCsnDC+3/Ofoqkh/QNQl86us0UPXV6noWsRh
         dftg==
X-Received: by 10.129.1.213 with SMTP id 204mr22351474ywb.48.1439583251357;
 Fri, 14 Aug 2015 13:14:11 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 13:14:11 -0700 (PDT)
In-Reply-To: <55CE49AD.4010605@cs-ware.de>
X-Google-Sender-Auth: P0ClgUIrfbDsJR4770epFnZCb00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275936>

On Fri, Aug 14, 2015 at 4:03 PM, Sven Strickroth <sven@cs-ware.de> wrote:
> Without this patch there might be open file handle leaks.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
> ---
> diff --git a/config.c b/config.c
> index 9fd275f..8138d5d 100644
> --- a/config.c
> +++ b/config.c
> @@ -2065,6 +2065,7 @@ int git_config_set_multivar_in_file(const char
> *config_filename,
>                         goto out_free;
>                 }
>                 close(in_fd);
> +               in_fd = -1;

You also need to initialize 'in_fd' to -1 at its point of declaration
since there are goto's to 'out_free' which occur before the `in_fd =
open(...)'.

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
