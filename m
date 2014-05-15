From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 11/42] tag.c: use ref transactions when doing updates
Date: Wed, 14 May 2014 17:27:38 -0700
Message-ID: <20140515002738.GH9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-12-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 02:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkjWb-0005Kl-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 02:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbaEOA1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 20:27:42 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52830 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaEOA1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 20:27:41 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so296315pab.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3Eg2RUOJWpN4h/fjo0ptVjiXulbaSbjDIesgMxoRO7A=;
        b=YdzRduTbbMS08+IhO9epreXe1ZFvyvX1g1xDh1rVwm2h+Xu4wSLLCo87KCEmnlqPFs
         HvofUWLqQYfXP1aTwMuHf0L9w5lLHVWHOtJIzxVEK8Dju8EeUdxnbawC45KehWAXXcxQ
         s0DEO5sjF+JWBXiIpslkNy96l9r6kYV5aIgWFr1W6yimdxqET1g7MoDL9cDUodJMlFpD
         ZdhfU/s12xhc4qi6nIvV+Bx6n2oZA6JxKxF8ETCCYi5mYCgpElLYeP/mFgg7HAjhsD/c
         kZzypcfXTKL/zvVD8pUf2iLeZUmrWcOOVPlU8S4mYokaXNZG4veg8jhVy/cJcIz/7san
         uYRA==
X-Received: by 10.68.190.136 with SMTP id gq8mr8129824pbc.21.1400113661005;
        Wed, 14 May 2014 17:27:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qw8sm5659510pbb.27.2014.05.14.17.27.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 17:27:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-12-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249054>

Ronnie Sahlberg wrote:

> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -701,11 +702,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (annotate)
>  		create_tag(object, tag, &buf, &opt, prev, object);
>  
> -	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
> -	if (!lock)
> -		die(_("%s: cannot lock the ref"), ref.buf);
> -	if (write_ref_sha1(lock, object, NULL) < 0)
> -		die(_("%s: cannot update the ref"), ref.buf);
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref.buf, object, prev,
> +				   0, !is_null_sha1(prev)) ||
> +	    ref_transaction_commit(transaction, NULL, &err))
> +		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);

Makes sense for the _update and _commit case.  (BTW, why is have_old
a separate boolean instead of a bit in flags?)

For the _begin() case, can ref_transaction_begin() ever fail?  xcalloc
die()s on allocation failure.  So I think it's fine to assume
transaction is non-null (i.e., drop the !transaction condition), or if
you want to be defensive, then label it as a bug --- e.g.:

	if (!transaction)
		die("BUG: ref_transaction_begin() returned NULL?");

Otherwise if ref_transaction_begin regresses in the future and this
case is tripped then the message would be

	fatal: refs/tags/v1.0: cannot update the ref:

which is not as obvious an indicator that the user should contact
the mailing list.

Thanks,
Jonathan
