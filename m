From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 08/17] read-cache: invalidate untracked cache data when
 reading WAMA
Date: Tue, 29 Mar 2016 09:50:22 +0700
Message-ID: <CACsJy8DQGadWodE3x0K+h5x75Hrf7QtcCwTC2zOgE_YiwtXc3Q@mail.gmail.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com> <1458349490-1704-9-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:51:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akjkc-0000rr-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 04:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcC2Cuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 22:50:55 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35453 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcC2Cuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 22:50:54 -0400
Received: by mail-lb0-f174.google.com with SMTP id bc4so1615572lbc.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vubCExl5KHpR6UXOYCAcioBmL8yTb/ak+fycWSl5tMI=;
        b=s1ug6vCX6YE4LYgAxDV73yrAQt2NkHty1JNcsa/slgZuK4Qlm1ynsVeQ9NA0W/qWcE
         6pgLvmNdGnivlhoy22VEcdzlDKL5nEh9fqInltPrmxw2Di7BmLRjWAFHxYTN8IMIo2EL
         GuxXUVB3zlJZNNiDJw1GyMrcUdJPtHlcHkcoOFKcxB9ZXFSXl61ysCnUIPKHhnI/Unv1
         GseG+j1MYEa9il/kHapU9GFI1HFyCeRQKv/eLjDDLorsF65ljS8O4TTcM6kbJERGessB
         m822y2hu9Vxb6REPC9SUA1wto2TrK568pRDLzRSa2Dqq6KzbLuKnWHoLV6DK/QH8pCM6
         vX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vubCExl5KHpR6UXOYCAcioBmL8yTb/ak+fycWSl5tMI=;
        b=b5QZRq3PwkWnacIxFsR9gb2aKa3wuFVMg7zB9WUZw9GMXNG1+qTJ+hen9ipJbtDOTW
         NWepqjAoEhJEkgEtRJiTC3cGNwcQbDo+DIUtONSD+o11DWJ+e/ZcPS8YbMPFWIurwAhE
         srlh6PSRpWDIKFWYCu4ELmZvpfsRR2N5u2PEEYzb1gnUMDMsWHqqSIpQxDF5uD4ONUWW
         +1j1nQKgFsOphBS6g9LQj5LY2+fLYClTnxpzCX8PwMGadF4h15Ra6D/KBIRbIRe15hG0
         laoFQojTphgPySY11R5DN3DZHsNRTqrQFeNDdxFJWPwoZ6RkODBgMAOUJ8A3c+c5dnjY
         OWOA==
X-Gm-Message-State: AD7BkJJIzp74aERE+fsrFSM3lRZig8yu/h4Npwj3zvg8E/bOX4Qadph3H6o9PsIzRPjO3Uw0LrTDcype9UN5/A==
X-Received: by 10.112.198.166 with SMTP id jd6mr3884444lbc.12.1459219852385;
 Mon, 28 Mar 2016 19:50:52 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 28 Mar 2016 19:50:22 -0700 (PDT)
In-Reply-To: <1458349490-1704-9-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290099>

On Sat, Mar 19, 2016 at 8:04 AM, David Turner <dturner@twopensource.com> wrote:
> @@ -1407,10 +1472,24 @@ static int read_watchman_ext(struct index_state *istate, const void *data,
>         ewah_each_bit(bitmap, mark_no_watchman, istate);
>         ewah_free(bitmap);
>
> -       /*
> -        * TODO: update the untracked cache from the untracked data in this
> -        * extension.
> -        */
> +       if (istate->untracked && istate->untracked->root) {
> +               int i;
> +               const char *untracked;
> +
> +               untracked = data + len + 8 + bitmap_size;
> +               for (i = 0; i < untracked_nr; ++i) {
> +                       int len = strlen(untracked);
> +                       string_list_append(&istate->untracked->invalid_untracked,
> +                                          untracked);
> +                       untracked += len + 1;
> +               }
> +
> +               for_each_string_list(&istate->untracked->invalid_untracked,
> +                        mark_untracked_invalid, istate->untracked);

I think it's a bit early to invalidate untracked cache here. We can do
that in refresh_by_watchman() in 10/17, where ce_mark_uptodate() to
prevent lstat() is also done.

> +
> +               if (untracked_nr)
> +                       istate->cache_changed |= WATCHMAN_CHANGED;
> +       }
>         return 0;
>  }
-- 
Duy
