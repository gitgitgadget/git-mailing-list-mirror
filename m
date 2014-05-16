From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 23/44] fetch.c: change s_update_ref to use a ref
 transaction
Date: Fri, 16 May 2014 15:54:21 -0700
Message-ID: <20140516225421.GJ12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-24-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat May 17 00:54:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlR1L-0002Qh-RF
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992452AbaEPWy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:54:27 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40391 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbaEPWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:54:25 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so3175549pbc.16
        for <git@vger.kernel.org>; Fri, 16 May 2014 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K/pg25ETTujJx/HQcTZYGLDIDuklVZvoodjVKGbhYV0=;
        b=LXUt3lXhxHSxLmQ0TP91Tu+Eyr2Y4FFk4j+g/Nu0lMvVJZR5xyPdxRSIVMVegCdqdL
         WS2A2tfzwiJtVgH6wYP6CE6wPOt2iAuByTPXTtt7iFhZm8swrA3IyA90YK3rOK223zA3
         pVSTP27bmqH4VZMku/fOno1T6WhWO16OooJQLsKySIkgQtGIgKs4lPDTtiXJcKektC/2
         /13r3669Y9NWunlsigV2BdNtcjWwSwDfnhaQLhCDdCaeET+0BgP5YU24sX2XkNUWIt5P
         MTS0nOMqIENpIQ5dUWZ23AZKSQ8clBVeMv/D9EovES91M+bOm82xu8l2iFQ6TGAV0qYg
         H6Pg==
X-Received: by 10.66.66.66 with SMTP id d2mr24879921pat.36.1400280864507;
        Fri, 16 May 2014 15:54:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cz3sm16491016pbc.9.2014.05.16.15.54.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 15:54:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-24-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249428>

Ronnie Sahlberg wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
[...]
> @@ -384,15 +384,16 @@ static int s_update_ref(const char *action,
>  	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>  
>  	errno = 0;
> -	lock = lock_any_ref_for_update(ref->name,
> -				       check_old ? ref->old_sha1 : NULL,
> -				       0, NULL);
> -	if (!lock)
> -		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
> -					  STORE_REF_ERROR_OTHER;
> -	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
> +				   ref->old_sha1, 0, check_old) ||
> +	    ref_transaction_commit(transaction, msg, NULL)) {

Since 'err' is NULL, does that mean there's no message shown to the
user on error?
