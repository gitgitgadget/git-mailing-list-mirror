From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] Support signing pushes iff the server supports it
Date: Fri, 14 Aug 2015 16:22:07 -0700
Message-ID: <xmqqio8hfobk.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<1439492451-11233-7-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 01:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQOIh-0003iN-8i
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 01:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbbHNXWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 19:22:10 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33156 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHNXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 19:22:09 -0400
Received: by pabyb7 with SMTP id yb7so68399637pab.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=d+noA8OBuY/Z/yKB7G4OpioN++L2FPnD9I3AaQxbZ1I=;
        b=cJXB441XlXlJovXU1+BYRGI4eZuDzoogdNbsjNetYbBbODIxJDcwy72TU3NgvGBKdJ
         nsoql8vGySvXUHgdG7BoMP1vpCr+LMUVqlRoyo0z8ekBkzqFcBw/wjmbtGPet57u8eya
         P/dIwqUJm8xCrlVVS3jc0FNaBRy+6PkgU8mmXbuDCMW/Cir5FcUZt4L6zeoBypA8hJ3s
         I2vWYX9O6xKqbTn66EmSXVFrVNcloSiW9NKkn7fj1I+wNQbLxoVoTPbaG5Gk43af/ZdE
         cqjrI3RML0VvbzN1EKsat1bn4vNRQLGMadeN0zqP5roVXJYDXSZv0HJ9hHxWf0YxiuUd
         gC5g==
X-Received: by 10.68.248.102 with SMTP id yl6mr93538288pbc.66.1439594528273;
        Fri, 14 Aug 2015 16:22:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id qb10sm7253252pab.39.2015.08.14.16.22.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 16:22:07 -0700 (PDT)
In-Reply-To: <1439492451-11233-7-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Thu, 13 Aug 2015 15:00:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275976>

Dave Borowitz <dborowitz@google.com> writes:

> diff --git a/send-pack.c b/send-pack.c
> index 2a64fec..6ae9f45 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -370,7 +370,7 @@ int send_pack(struct send_pack_args *args,
>  		args->use_thin_pack = 0;
>  	if (server_supports("atomic"))
>  		atomic_supported = 1;
> -	if (args->push_cert) {
> +	if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
>  		int len;
>  
>  		push_cert_nonce = server_feature_value("push-cert", &len);
> @@ -379,6 +379,18 @@ int send_pack(struct send_pack_args *args,
>  		reject_invalid_nonce(push_cert_nonce, len);
>  		push_cert_nonce = xmemdupz(push_cert_nonce, len);
>  	}
> +	if (args->push_cert == SEND_PACK_PUSH_CERT_IF_POSSIBLE) {
> +		int len;
> +
> +		push_cert_nonce = server_feature_value("push-cert", &len);
> +		if (push_cert_nonce) {
> +			reject_invalid_nonce(push_cert_nonce, len);
> +			push_cert_nonce = xmemdupz(push_cert_nonce, len);
> +		} else
> +			warning(_("not sending a push certificate since the"
> +				  " receiving end does not support --signed"
> +				  " push"));
> +	}

I wonder if the bodies of these two if statements can be a bit
better organized to avoid duplication (I suspect you have tried
and you may already know that the above is the most readable
version, but I haven't tried to do so myself, so...).
