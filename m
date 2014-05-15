From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 10/44] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Thu, 15 May 2014 12:34:46 -0700
Message-ID: <20140515193446.GH26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-11-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:34:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1Qb-0006o3-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaEOTeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:34:50 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34787 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbaEOTet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:34:49 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so1503314pbc.15
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3sPJ2fBZmpmVhV2roHBffPYjuX7l9L1ybarvLJVUe7M=;
        b=RpMaowQ46sFmwznJaOol4i0qKwL+SG3C7tdgJzstXPs7ib20Odg1SFeful7PlnMmpG
         K7FwdH1tH/wGyoX0UKyRZmGpMyi0SekslsVCBKXjtvius/wDKKBt4AoP1CEnHRzTrd37
         97KDqF9/C5XUfGwrNrOF5wRRJijr4TijluY2xh1kqjEmQVYVy93BaBhPdadyAtb9wcOt
         cB5tegT2BqNx2pgpqU4VHD8yAcqROVrTF850YC1bpKmXY2RKsAUyMlod19UjqR12WoYP
         PY2FXl9ZPrBKSc2QoC9kAReXZeRrCbAjgufQMNLWzORxeQQ0xVCjT/OBqg4sTMtqQrUU
         8iSQ==
X-Received: by 10.68.237.133 with SMTP id vc5mr15028069pbc.92.1400182488975;
        Thu, 15 May 2014 12:34:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oz7sm10496890pbc.41.2014.05.15.12.34.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 12:34:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-11-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249191>

Ronnie Sahlberg wrote:

> Update ref_transaction_update() do some basic error checking and return
> non-zero on error. Update all callers to check ref_transaction_update() for
> error. There are currently no conditions in _update that will return error but
> there will be in the future.

Probably worth passing a 'struct strbuf *err' argument.  Then callers
can do

		die("%s", err.buf);

and the error message can say which ref and whether we were trying to
create a ref, or delete one, or whatever.

> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +				   update_flags, have_old))
> +		die("update %s: failed", refname);

This could say

		die("update %s: %s", refname, err.buf);

to give context about which command it was trying to execute.

[...]
> @@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("verify %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +				   update_flags, have_old))
> +		die("failed transaction update for %s", refname);

And this could say

		die("verify %s: %s", refname, err.buf);

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -242,12 +242,15 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>   * be deleted.  If have_old is true, then old_sha1 holds the value
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
> + * Function returns 0 on success and non-zero on failure. A failure to update
> + * means that the transaction as a whole has failed and will need to be
> + * rolled back.
> + */

Thanks for this documentation.
