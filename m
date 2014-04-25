From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/11] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Fri, 25 Apr 2014 14:32:10 -0700
Message-ID: <20140425213210.GN15516@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
 <1397763987-4453-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 23:32:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdnjJ-0006Ig-6r
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 23:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaDYVcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 17:32:15 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37008 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaDYVcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 17:32:13 -0400
Received: by mail-pd0-f169.google.com with SMTP id y13so2636837pdi.14
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SdDV3WJsWOf32cT3ddq7AK+QeqeUO/VuK3tNLNH420c=;
        b=NyYwS4XrHrLmxa3o1VU4PlyoRdvNp7/akfQbx9k7BAQo+xNR0n47wUP8WPIxl7T2XS
         z6ZPWsgScXmvPt/VNq4b1D31SXJ4TABC39ZIEkiFpeVmXWcpLIa7B2u5UGCDcwR4D3lf
         tNMpH8gbtR9r/uawC620+apI2ABP/9aa6aI48FBh0SaBVaJsKdABZuh2XvBMxAOtbL0c
         VsJT7eAnBxC0uwA6HsPTRXRQtW4wVGMxjMqolE5B888EnUpgS+qwOZYHnJguPNcFQ6j3
         J7kYPR2EsxNLK4SuFSPljw3eVMu+USenseZB0Od/P83W/f3A4cY5OOergyfCKYDgnLx5
         6W2g==
X-Received: by 10.69.19.140 with SMTP id gu12mr5124342pbd.147.1398461533125;
        Fri, 25 Apr 2014 14:32:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ov4sm18078156pbc.46.2014.04.25.14.32.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 14:32:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397763987-4453-3-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247115>

Hi,

Ronnie Sahlberg wrote:

> Update ref_transaction_update() do some basic error checking and return
> true on error. Update all callers to check ref_transaction_update() for error.

Micronit: nonzero, not true.  (true tends to mean '1' while here we
have the usual error return of -1.  It's kind of annoying that C
doesn't have a nice way to distinguish between the usual int return of
0 for success and the usual bool return of true for success.)

Looks like a good change.  Some tiny nitpicks below.

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
>   */
> -void ref_transaction_update(struct ref_transaction *transaction,
> +int ref_transaction_update(struct ref_transaction *transaction,

The comment above the prototype doesn't tell me:

When should the caller expect ref_transaction_update to return an
error?  What does an error mean: is it always a sign of a bug in the
caller, or can it be due to some other problem?  What guarantees does
the caller have about the state after an error --- is it just "Things
will be in a sane state so you can free resources and exit", or will
the ref_transaction_update() have been essentially a no-op allowing
the caller to continue?

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -3327,19 +3327,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>  	return update;
>  }
>  
> -void ref_transaction_update(struct ref_transaction *transaction,
> +int ref_transaction_update(struct ref_transaction *transaction,
>  			    const char *refname,
>  			    const unsigned char *new_sha1,
>  			    const unsigned char *old_sha1,
>  			    int flags, int have_old)
>  {
> -	struct ref_update *update = add_update(transaction, refname);
> +	struct ref_update *update;
> +
> +	if (have_old && !old_sha1)
> +		return error("have_old is true but old_sha1 is NULL");

I agree with Michael that the error message should start with "BUG:"
so humans encountering this know to contact the list instead of
blaming themselves.

Returning error instead of die-ing seems like a nice thing that make
it easier to make git valgrind-clean some day.  Others might disagree
with me about whether that's worthwhile, but I think it's a good
change. :)

[...]
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -197,8 +197,10 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +				   update_flags, have_old))
> +		die("failed transaction update for %s", refname);

ref_transaction_update already printed an error, but of course that's
no guarantee that bugs in ref_transaction_update will not cause it
to fail without printing a message in the future.  And the extra
context for the error might be nice (but why not print refname in
the message from ref_transaction_update instead?).

Is the plan for ref_transaction_update to be able to fail for
other reasons some day?  What is the contract --- do we need a
human-readable, translatable message here, or is a "this can't
happen" BUG message fine?

I'd be fine with

		die("BUG: failed transa...

or

		/* ref_transaction_update already printed a message */
		exit(128)

with a slight preference for the former, for what it's worth.

[...]
> @@ -286,8 +288,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("verify %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +			       update_flags, have_old))
> +		die("failed transaction update for %s", refname);

Likewise.

Thanks,
Jonathan
