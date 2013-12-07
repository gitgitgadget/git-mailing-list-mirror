From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] push: Allow @ shortcut with git-push
Date: Sat, 07 Dec 2013 03:45:41 -0600
Message-ID: <52a2ee45b8644_29836d5e9877@nysa.notmuch>
References: <1386310392-26882-1-git-send-email-tkrajina@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Tomo Krajina <tkrajina@gmail.com>
To: Tomo Krajina <tkrajina@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 10:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpEca-00025S-FO
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 10:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab3LGJ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 04:56:18 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:60376 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab3LGJ4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 04:56:15 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so1851874obc.20
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 01:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=cV4y8tMNsl1bMn4xPfkwLN/s5SDhLW5i0CF5QU78cxU=;
        b=rIM1VkC4Y58QOJLgWe/r9+64V+7zx3E3SJIhF17y2VhjwuIFreVIZ7pJGD6KlofQ2O
         5V2knq+jnvV396wmsQP83SnBvdDZTqtUAhBqQs1906y31dKKy9ThFuut2q0yV2dNbXa5
         wOIR/VIeSq5E2gbyP7Spv8ezJf0XVo/qwUCXb4GTMFB/VvWI8ptD3G3RgNEDnh2zkXMA
         ptdB7OmhJBGer8cB36QJU9c0ADa9Xs6u9VEoa8dd8aaVroowOoOpvjYnZPwJZS1s0C8c
         YOl/e3hmfu8GJwBdFOmDZmeHkfTl01+ATruDmLj+x3UbZvWYRyQwCfqucSjWUF3nNr6F
         gLuA==
X-Received: by 10.182.16.33 with SMTP id c1mr5951236obd.4.1386410175398;
        Sat, 07 Dec 2013 01:56:15 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm3242997obc.2.2013.12.07.01.56.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 01:56:14 -0800 (PST)
In-Reply-To: <1386310392-26882-1-git-send-email-tkrajina@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238973>

Tomo Krajina wrote:
> Until now, HEAD could be used with git-push to push the current
> branch. Now @ is a shortcut to HEAD, but it didn't work when
> pushing branches. It fails with:
> 
>   fatal: remote part of refspec is not a valid name in @
> 
> Reinterpret all branch names from argv in order for @ to be used
> when pushing branches.
> 
> Signed-off-by: Tomo Krajina <tkrajina@gmail.com>
> ---
>  builtin/push.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/push.c b/builtin/push.c
> index 7b1b66c..51c0200 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -494,7 +494,20 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  
>  	if (argc > 0) {
>  		repo = argv[0];
> -		set_refspecs(argv + 1, argc - 1);
> +
> +		char *refs[argc - 1];
> +		int i;
> +		for(i = 1; i < argc; i++) {
> +			refs[i - 1] = argv[i];
> +
> +			struct strbuf buf = STRBUF_INIT;
> +			interpret_branch_name(argv[i], strlen(argv[i]), &buf);
> +
> +			if(buf.buf && strlen(buf.buf) > 0)
> +				refs[i - 1] = buf.buf;
> +		}
> +
> +		set_refspecs(refs, argc - 1);
>  	}
>  
>  	rc = do_push(repo, flags);
> -- 

I don't think this is the right way to go. There are many places where HEAD
cannot be replaced with @, or @{u}, or any of such syntaxes.

We might want to do this kind of replacement in many other places, but we would
need to make sure it makes sense.

Moreover, in order for this patch to be considered you need to add tests.

Cheers.

-- 
Felipe Contreras
