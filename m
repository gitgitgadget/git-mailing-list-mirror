From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 30/44] refs.c: add transaction.status and track
 OPEN/CLOSED/ERROR
Date: Wed, 21 May 2014 15:00:35 -0700
Message-ID: <20140521220035.GE12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-31-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEZ0-0004gT-Me
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbaEUWAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:00:39 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:62347 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbaEUWAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:00:38 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so1792037pab.7
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8xFO/r/R8tKnSILmFLApNSZGlxBbWjnzZiZ5qy9JxFc=;
        b=y/JSwhswg9OMYQ9napbNhRO4OlsQzeyLbkTUgEUUs3/MddhNyguA2ssYIHC9hTgKDY
         hQmmx7kc3Y8DxntdOp66vetQUR3Yrw5B/emdTcbbA7AVezyp6xRiEo1jL7z7dbjq/sXH
         Z/70WpdfFhJAk/fw5h7loQ7tcoV7UsqtkNKfTWPW6pGeFXSNIxL69IpLogYeeBONzQcD
         n7M7bLq7JaQjrDviO9xqLkAfPVUtjjyPHrKlfzDDs88lVYsniWmIadG2pd439RuWJXXJ
         MIK8M45Ybyr0KHBHTNw+cDAubWjTC6s8Ij0vfEeohorV/YjoM0/8DJcjgqIHkOz2EGXo
         5gpw==
X-Received: by 10.67.23.135 with SMTP id ia7mr62290396pad.5.1400709637952;
        Wed, 21 May 2014 15:00:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ja8sm9716009pbd.3.2014.05.21.15.00.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-31-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249843>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
> @@ -3308,6 +3308,12 @@ struct ref_update {
>  	const char refname[FLEX_ARRAY];
>  };
>  
> +enum ref_transaction_status {
> +	REF_TRANSACTION_OPEN   = 0,
> +	REF_TRANSACTION_CLOSED = 1,
> +	REF_TRANSACTION_ERROR  = 2,

What is the difference between _TRANSACTION_CLOSED and
_TRANSACTION_ERROR?

[...]
> @@ -3340,6 +3347,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  
>  void ref_transaction_rollback(struct ref_transaction *transaction)
>  {
> +	if (!transaction)
> +		return;
> +
> +	transaction->status = REF_TRANSACTION_ERROR;
> +
>  	ref_transaction_free(transaction);

Once the transaction is freed, transaction->status is not reachable any
more so no one can tell that you've set it to _ERROR.  What is the
intended effect?

[...]
> @@ -3366,6 +3378,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	if (have_old && !old_sha1)
>  		die("BUG: have_old is true but old_sha1 is NULL");
>  
> +	if (transaction->status != REF_TRANSACTION_OPEN)
> +		die("BUG: update on transaction that is not open");

Ok.

[...]
> @@ -3538,6 +3564,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	clear_loose_ref_cache(&ref_cache);
>  
>  cleanup:
> +	transaction->status = ret ? REF_TRANSACTION_ERROR
> +	  : REF_TRANSACTION_CLOSED;

Nit: odd use of whitespace.

Overall thoughts: I like the idea of enforcing the API more strictly
("after an error, the only permitted operations are...").  The details
leave me a little confused because I don't think anything is
distinguishing between _CLOSED and _ERROR.  Maybe the enum only needs
two states.

Thanks,
Jonathan
