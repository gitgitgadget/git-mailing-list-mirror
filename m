From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 19/44] refs.c: change update_ref to use a transaction
Date: Thu, 15 May 2014 16:16:15 -0700
Message-ID: <20140515231615.GR26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-20-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 01:16:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tQ-0006Dm-0g
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254AbaEOXQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:47 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53424 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbaEOXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:16:18 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so1671354pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CFRf6vhgjRLRszNbuWD1BR3oqM/Rh/z7BscUs1+NonI=;
        b=fxFInY9b5O/iJapZeRiI0IwOc+zGplWgcynJ+F3NnJBNkgTy5VC903oVuwfluIUGVP
         YY39WZKX5p+VWVRiPwno5ganaVR1YGTa7JBsA5p7DpN28cKuKk2WvP7Se8EXOFA4LgUX
         JKuy51QGDrSL5xwiG3HtNoMqSLWzonnd0gRasMi7vBZLWid3p1COxWRiMmrb/tjVi9ql
         KoIcuHHUcHTnfQaCOpEZqMggXFztEt0stMG5DVR5KJypaE3gM6oOGfpSYe1nv669jz1u
         iyQD1nK5DLFZZFLtH+WBkkLkGkDaOf3iNx/17lY5xc+bXVpqrm/9hDjlQJqQ8D+V8O1o
         cmvw==
X-Received: by 10.68.171.4 with SMTP id aq4mr16049838pbc.150.1400195777894;
        Thu, 15 May 2014 16:16:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fk4sm26406535pab.23.2014.05.15.16.16.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 16:16:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-20-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249240>

Ronnie Sahlberg wrote:

> Change the update_ref helper function to use a ref transaction internally.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 6e5e940..0476892 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3416,11 +3416,28 @@ int update_ref(const char *action, const char *refname,
>  	       const unsigned char *sha1, const unsigned char *oldval,
>  	       int flags, enum action_on_err onerr)
>  {
> -	struct ref_lock *lock;
> -	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
> -	if (!lock)
> +	struct ref_transaction *t;
> +	struct strbuf err = STRBUF_INIT;
> +
> +	t = ref_transaction_begin();
> +	if ((!t ||
> +	    ref_transaction_update(t, refname, sha1, oldval, flags,
> +				   !!oldval)) ||
> +	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
> +		const char *str = "update_ref failed for ref '%s': %s";
> +
> +		ref_transaction_rollback(t);
> +		switch (onerr) {
> +		case UPDATE_REFS_MSG_ON_ERR:
> +			error(str, refname, err.buf); break;
> +		case UPDATE_REFS_DIE_ON_ERR:
> +			die(str, refname, err.buf); break;
> +		case UPDATE_REFS_QUIET_ON_ERR: break;
> +		}

The error string already contains the refname, so it would make sense to
do

		case UPDATE_REFS_MSG_ON_ERR:
			error("%s", err.buf); break;

etc here.

It occurs to me now that if ref_transaction_begin fails, presumably
the error string would not contain the refname.  I want to say that
the refname wouldn't help much in diagnosing or recovering from the
problem in that case so it would still be okay to just do error("%s",
err.buf).  What do you think?

Thanks,
Jonathan
