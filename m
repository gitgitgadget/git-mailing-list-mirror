From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 09/42] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Wed, 14 May 2014 17:04:09 -0700
Message-ID: <20140515000409.GF9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-10-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 02:04:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkj9o-0004pr-9o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 02:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbaEOAEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 20:04:15 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:57690 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaEOAEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 20:04:12 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so273758pbb.13
        for <git@vger.kernel.org>; Wed, 14 May 2014 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Kv+kb6/0rXhaiG9tFsQpZ8u5q4L6H8y9aBBxMaEHaf0=;
        b=CuAI7pMAuL3DDvwlUcMJVb2G4dxbGL52acC8kwvFhNjPTAlbVbngERyWA8Pdzz1aAW
         O4FRTW+bQsShNgYKwo0CeR+6tikAznxWsFIaPAcbX1sj2w1IxGyIV4fJExN8ogQHa8hj
         nWy72VqnmFwzOSu7aC71KjoOFV6Bv5cF6fQIXEgvIDXaQVnBGUNLr4lwuaKTPHK2YVYD
         1FOP4VOanmz8T9x5k23loG0NxV/QldLLO+TgJAWCMlINJGB391bElhAq/Y8xNzVLXjL/
         vqOYiZZwRFZ8SjMF9eIKS5Pis+VcpSrjG2DRxXpgbLtkuPrriM6/SIM+zEjz9bkIEq7K
         C+Jw==
X-Received: by 10.68.159.228 with SMTP id xf4mr8187516pbb.74.1400112252447;
        Wed, 14 May 2014 17:04:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ib5sm5590014pbb.55.2014.05.14.17.04.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 17:04:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-10-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249052>

Ronnie Sahlberg wrote:

> Do basic error checking in ref_transaction_create() and make it return
> status. Update all callers to check the result of ref_transaction_create()
> There are currently no conditions in _create that will return error but there
> will be in the future.

Same concerns as with _update:

[...]
> +++ b/builtin/update-ref.c
> @@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("create %s: extra input: %s", refname, next);
>  
> -	ref_transaction_create(transaction, refname, new_sha1, update_flags);
> +	if (ref_transaction_create(transaction, refname, new_sha1,
> +				   update_flags))
> +		die("failed transaction create for %s", refname);

If it were ever triggered, the message

	error: some bad thing
	fatal: failed transaction create for refs/heads/master

looks overly verbose and unclear.  Something like

	fatal: cannot create ref refs/heads/master: some bad thing

might work better.  It's hard to tell without an example in mind.

[...]
> @@ -3353,18 +3353,23 @@ void ref_transaction_create(struct ref_transaction *transaction,
[...]
> -	assert(!is_null_sha1(new_sha1));
> +	if (!new_sha1 || is_null_sha1(new_sha1))
> +		die("create ref with null new_sha1");

One less 'assert' is nice. :)

As with _update, the message should start with "BUG:" to make it clear
to users and translators that this should never happen, even with
malformed user input.  That gets corrected in patch 28 but it's
clearer to include it from the start.
