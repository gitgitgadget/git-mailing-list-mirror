From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Thu, 21 May 2015 15:07:53 -0700
Message-ID: <xmqqpp5th9dy.fsf@gitster.dls.corp.google.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-2-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 00:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvYdE-0006gx-OP
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 00:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbbEUWH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 18:07:56 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35477 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbbEUWHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 18:07:55 -0400
Received: by igbyr2 with SMTP id yr2so21787364igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=vejHnAYz6tCIfDAgyZ5Vq5y49jPJvwv9cXicw70B1mg=;
        b=WIzAAOt6wzrBDHKyGXzJrHTN4KGsbV6F7Vo8843vLIjSZbDAEDmaSAeWVImYvZOOCj
         DJuDHNyX9sokS3+CiYELvKx6Z8EQFY+ED9Cg414YOzej4fRUkUDw1MHV32S8XUGfiLCU
         UOyRcOCA15slj/hIOPgwBGXJsPy3pb5KgWd5WB/XafMuP/oaPN/lqQo6B8nqsGglUdj5
         7Aak++t1bZYUfkatFiXvb4WwCnyfpuNt9uY5x2IOW+R9EZL3ALk4DilVOe1+Fd35RK+n
         OqN3SkZxcA9/9G257rvQmcpgpqkyp+09Oj0BWvkmEVclzEDdOvG/E0ygv5tzuMQK53jb
         LuOQ==
X-Received: by 10.107.155.81 with SMTP id d78mr6395251ioe.29.1432246075042;
        Thu, 21 May 2015 15:07:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id o9sm137307ioe.35.2015.05.21.15.07.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 15:07:54 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269668>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> To allow future extensions, e.g. allowing non-tip sha1, replace the
> boolean allow_tip_sha1_in_want variable with the flag-style
> allow_request_with_bare_object_name variable.
>
> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
> ---
>  fetch-pack.c  |  9 ++++++---
>  upload-pack.c | 20 +++++++++++++-------
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 48526aa..699f586 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -43,7 +43,10 @@ static int marked;
>  #define MAX_IN_VAIN 256
>  
>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
> +static int non_common_revs, multi_ack, use_sideband;
> +/* Allow specifying sha1 if it is a ref tip. */
> +#define ALLOW_TIP_SHA1	01
> +static int allow_unadvertised_object_request;

It is better to use "unsigned int" for these bit masks, as we are
not interested in the top-most bit getting special-cased by using a
signed type.  I'll amend this (and the one in upload-pack.c) while
applying, so no need to resend only to correct these two, unless you
have other reasons to reroll.

Thanks.

> diff --git a/upload-pack.c b/upload-pack.c
> index 745fda8..726486b 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -35,7 +35,9 @@ static int multi_ack;
>  static int no_done;
>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>  static int no_progress, daemon_mode;
> -static int allow_tip_sha1_in_want;
> +/* Allow specifying sha1 if it is a ref tip. */
> +#define ALLOW_TIP_SHA1	01
> +static int allow_unadvertised_object_request;
