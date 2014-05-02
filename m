From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 20/42] fetch.c: clear errno before calling functions
 that might set it
Date: Fri, 2 May 2014 00:11:55 -0400
Message-ID: <CAPig+cRa55472sncNsBnweR9Dj2HwTttu4t3GLP8buoTK59DyA@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-21-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 02 06:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg4qX-0003DO-DN
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 06:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbaEBEL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 00:11:56 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:39244 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbaEBEL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 00:11:56 -0400
Received: by mail-yh0-f46.google.com with SMTP id 29so1335848yhl.33
        for <git@vger.kernel.org>; Thu, 01 May 2014 21:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Pii5D9XH+hya7d3xc12mH0VXDFSSqw4O1d8U4Nuj0qI=;
        b=rjMrYxj4bS3lyWO/F261Jf3jKAO0lVyIWNTH5EFGhQpUUHMi8rxUGYlg80+Lp5p1Dv
         zzN9QwI8WHIzeM7l+zsbImho3Aw6wmGytlRnVd8JIPyAazriYoVu27CXmIp/RrLl4Hi7
         ldapJL0BSzuACcCdQcb1Db8ymPu2RRlI6W8o9qePBcwODh3sLLDGc98ETdpx+KwbK3+Y
         HQRZCfWSU9sjsRTv5eUXFERX8K4lNyxu44KYjuKyMh4DE3kIVD1hJjwE+uw7IaeYfWM0
         nUmKmYAkPkmRFat+Z802zGjz+A4mT5mKG5FsZeG0CJN2sEOdPMKOIjeMxDPcSKQp+unk
         UK7Q==
X-Received: by 10.236.194.169 with SMTP id m29mr19562409yhn.121.1399003915398;
 Thu, 01 May 2014 21:11:55 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Thu, 1 May 2014 21:11:55 -0700 (PDT)
In-Reply-To: <1398976662-6962-21-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: 2NZcoK0jse8q9-Laxc3-7O0MYiE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247922>

On Thu, May 1, 2014 at 4:37 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> In s_update_ref there are two calls that when they fail we return an error
> based on the errno value. In particular we want to return a specific error
> if ENOTDIR happened. Both these functions do have failure modes where they
> may return an error without updating errno, in which case a previous and
> unrelated ENOTDIT may cause us to return the wrong error. Clear errno before

s/ENOTDIT/ENOTDIR/

> calling any functions if we check errno afterwards.
>
> Also skip initializing a static variable to 0. Statics live in .bss and
> are all automatically initialized to 0.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/fetch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 55f457c..a93c893 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -44,7 +44,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static const char *recurse_submodules_default;
> -static int shown_url = 0;
> +static int shown_url;
>
>  static int option_parse_recurse_submodules(const struct option *opt,
>                                    const char *arg, int unset)
> @@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
>         if (!rla)
>                 rla = default_rla.buf;
>         snprintf(msg, sizeof(msg), "%s: %s", rla, action);
> +
> +       errno = 0;
>         lock = lock_any_ref_for_update(ref->name,
>                                        check_old ? ref->old_sha1 : NULL,
>                                        0, NULL);
> --
> 2.0.0.rc1.351.g4d2c8e4
