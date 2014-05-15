From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 13/44] tag.c: use ref transactions when doing updates
Date: Thu, 15 May 2014 14:11:56 -0700
Message-ID: <20140515211156.GK26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-14-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 23:12:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl2wi-0002iq-Ma
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 23:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbaEOVMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 17:12:01 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:56593 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbaEOVMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 17:12:00 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so1588043pbc.16
        for <git@vger.kernel.org>; Thu, 15 May 2014 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1eQbT0xjrBQSxLmcHEEQx3VZbZApzOEYKoh3o78UQRU=;
        b=MEhb8PH/rLvDhKV+ktlgkuxcqtIVqrrBX/laI/kY7WjnLW8CjZr9c02REHw7C7BHAS
         sxplN/kZ0RBx7YpETvYBZI0t9oeaIxYh9aXaEEdyIdS8tTnG3fL3OApuNZFspHvE9Z5R
         9pCdI+i6qbz2jFTgoYylHKcKgLrZIzj2dki1OIz6O2HqLT93Y5zVfJ24qwjQHEJtqC2w
         WN5en17PKTlrPx3OkpBv6qqhBtlzjISz6oaoD4AjjQnR9L3I2HpEa9bMFuDoKmo32RGY
         covRgQxFqTDBvnKsWZD4UPaJz/qYcRBajWJyuYo1kCCNgLLtTEWAUfmONfipV2c/NCNT
         N4Nw==
X-Received: by 10.68.133.229 with SMTP id pf5mr15496339pbb.115.1400188319555;
        Thu, 15 May 2014 14:11:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gz11sm10759702pbd.1.2014.05.15.14.11.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 14:11:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-14-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249201>

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

The error string says what ref it was trying to update, so

		die("%s", err.buf);

should be enough.  (E.g.,

	fatal: refs/tags/v1.0: cannot lock the ref

would become

	fatal: Cannot lock the ref 'refs/tags/v1.0'.

instead of

	fatal: refs/tags/v1.0: cannot update the ref: Cannot lock the ref 'refs/tags/v1.0'.

.)

Thanks,
Jonathan
