From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: exit silently on "forget" when rerere is disabled
Date: Thu, 14 May 2015 12:33:02 -0700
Message-ID: <xmqqmw17j6oh.fsf@gitster.dls.corp.google.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	<xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
	<20150514191637.GA9329@peff.net>
	<xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
	<20150514192052.GB9329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Coppens <alex@nativetouch.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 21:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsysX-0004us-RC
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbbENTdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:33:05 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36202 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbbENTdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:33:04 -0400
Received: by igbpi8 with SMTP id pi8so176196749igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nHx1h3SaC9S5dbjY/mrCw1biVkdEuhIDkSjm9ExDlEM=;
        b=hNcGNOLH9sdvJEk1ZD4b4UNCuIvrkOotS9+zDBvclbFEsXXdXDnkdJsnGjI9wh8oXK
         o869PCJEOZnaeEwyZMqAc8RE07WDt4wLziM9QjRRIShg6RP/68dsaL+Vx2081SEud5Kg
         mY7lfWhmyeD3c23mHYxCJ2hASe1zO6LiEbBqlcFCab23C4sQ4/Jo10OYYaqOOLdRXqop
         sQQiiNSTZpL5iwGYpsLS+7lrksH2owK9tban0ZtNKk3NXlhPDwW123yXDSK2KG4em276
         T5LhSrwG1YK9mn2GTRgdSGRD0Voh7UNb9eTHWt8w2JdenQ3h7xnLMzIldUNFS71LrREn
         zrfg==
X-Received: by 10.42.240.82 with SMTP id kz18mr3105961icb.92.1431631983758;
        Thu, 14 May 2015 12:33:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id f126sm17136289ioe.21.2015.05.14.12.33.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 12:33:03 -0700 (PDT)
In-Reply-To: <20150514192052.GB9329@peff.net> (Jeff King's message of "Thu, 14
	May 2015 15:20:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269075>

Jeff King <peff@peff.net> writes:

> On Thu, May 14, 2015 at 12:19:25PM -0700, Junio C Hamano wrote:
>
>> > It looks like we need to pay more attention to the return value of
>> > setup_rerere, which is what is supposed to take the lock.
>> 
>> Good spotting.  The normal rerere does check, but rerere-forget
>> codepath seems to forget it.
>
> Here's a patch.

Thanks.  This is obviously correct to fix your "init -q" one.

I am still puzzled by the original, though.  I assumed that rerere
was enabled and working correctly (in the sense that it correctly
replayed a mistaken resolution recorded earlier, which Alex wanted
to correct by forgetting).

>
> -- >8 --
> Subject: rerere: exit silently on "forget" when rerere is disabled
>
> If you run "git rerere forget foo" in a repository that does
> not have rerere enabled, git hits an internal error:
>
>   $ git init -q
>   $ git rerere forget foo
>   fatal: BUG: attempt to commit unlocked object
>
> The problem is that setup_rerere() will not actually take
> the lock if the rerere system is disabled. We should notice
> this and return early. We can return with a success code
> here, because we know there is nothing to forget.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  rerere.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rerere.c b/rerere.c
> index 31644de..94aea9a 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -659,6 +659,8 @@ int rerere_forget(struct pathspec *pathspec)
>  		return error("Could not read index");
>  
>  	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
> +	if (fd < 0)
> +		return 0;
>  
>  	unmerge_cache(pathspec);
>  	find_conflict(&conflict);
