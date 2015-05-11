From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] lockfile: allow file locking to be retried with a timeout
Date: Mon, 11 May 2015 11:04:54 -0700
Message-ID: <xmqq38337zy1.fsf@gitster.dls.corp.google.com>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
	<1430491977-25817-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 20:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrs57-00005s-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 20:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbbEKSFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 14:05:22 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35335 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbEKSFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 14:05:18 -0400
Received: by igbyr2 with SMTP id yr2so77912504igb.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BTmtA9cpZxxNth0KZHZ118A36tUHLIjRafpz+q07R6g=;
        b=dAqodP3Wn+5Fo1UY55NdY4vCbivxCnJ8IPcJXirKbBbHqvaAYZOQKaxE3cYrOUZNr8
         biMeUj68WdwTIjxvP+9r5ELTBT1/QdXuT5Jk9bvC3pVXKaPv42D+Df6vzJbdCnw/Tr7i
         gdJLYgKnMzl04k7sabyJLarKYEg9JRvdPgLGuvI+0VwXj7CG6OEdRa5+nW+nozjpoi3x
         wuWaswhw8z1j3S3IjYBzY47v/BlArnYfsu5eXtq3aBGhaVjHRBkJEXxNmd4tOks8Bs6K
         FJ+zfkx8Xeqr0WmDIAgoZ0/KvthFzuB93JUJtFHcIsKQ3X/7w6FLmCrgxFLlrFIqy7Pz
         Scaw==
X-Received: by 10.42.99.205 with SMTP id x13mr12584434icn.53.1431367518164;
        Mon, 11 May 2015 11:05:18 -0700 (PDT)
Received: from gitster.dls.corp.google.com ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id 69sm10189557ioz.10.2015.05.11.11.05.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 11:05:17 -0700 (PDT)
In-Reply-To: <1430491977-25817-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 1 May 2015 16:52:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268810>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> Notes (discussion):
>     It would be easy to also add a hold_lock_file_for_append_timeout(),
>     but I can't yet think of an application for it.
>
>  lockfile.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  lockfile.h | 16 +++++++++++--
>  2 files changed, 91 insertions(+), 4 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 9889277..30e65e9 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -157,6 +157,80 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	return lk->fd;
>  }
>  
> +static int sleep_microseconds(long us)
> +{
> +	struct timeval tv;
> +	tv.tv_sec = 0;
> +	tv.tv_usec = us;
> +	return select(0, NULL, NULL, NULL, &tv);
> +}

This is familiar for an old timer like me.  It seems help.c uses
"poll(NULL, 0, timeout)" for "do nothing but wait" (and we have
compat/poll to help those who lack poll() by using select()).

As we do not need microseconds resolution here, either would be fine
;-)
