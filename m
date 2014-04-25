From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 03/19] refs.c: make ref_transaction_commit return an
 error string
Date: Fri, 25 Apr 2014 15:10:01 -0700
Message-ID: <20140425221001.GB9218@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
 <1398442494-23438-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdoKg-0000xE-0b
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbaDYWKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:10:47 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:33387 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbaDYWKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 18:10:05 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so3674345pbc.20
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yHtMXFyywJzZevIDp9HP8M5JK6dvYq25vXEoHYbLckU=;
        b=ampxUBCTjN3NJNQCOkuB7CI75fIaU2we1+2y9rqg4nX1r7jR084vQHmoTXJDXF/1lR
         +p83cSA3b+OtOt9vmS/LTcyvfdwa2cWUsnQ36C6xpmxS9gBzc9Hm95syIEINYPJn/tQ7
         R/LqLdjXwOr4ULwFetetxjPdg/nrHqd3rJ9DxSTI2PciVYXB845eJzTmpZ76kp2b6o5e
         VoQU4vBLH22xHKgfkM4+xQ2TnVkCEA3WkWskgscsBLPDejeEXGnW9FioNqg7A0Nqk/H5
         FSnuMntF+ANlzvBHmZCVF+Tehw1QvJtPmmBzyJW2ZHeoAYVQiaNAZhqK50i4qTEeLLrW
         iC+g==
X-Received: by 10.68.201.10 with SMTP id jw10mr14157333pbc.25.1398463804156;
        Fri, 25 Apr 2014 15:10:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bz4sm18238833pbb.12.2014.04.25.15.10.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 15:10:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398442494-23438-4-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247118>

Ronnie Sahlberg wrote:

> Let ref_transaction_commit return an optional error string that describes
> the transaction failure.  Start by returning the same error as update_ref_lock
> returns, modulo the initial error:/fatal: preamble.

s/returns/prints/?

> This will make it easier for callers to craft better error messages when
> a transaction call fails.

Interesting.  Can you give an example?  What kind of behavior are we
expecting in callers other than die()-ing or cleaning up and then
die()-ing?

I like this more than having the caller pass in a flag/callback/etc to
decide how noisy to be and whether to gracefully accept errors or exit.
So it seems like an improvement, but may always returning error()
would be better --- more context would help in clarifying this.

> --- a/refs.h
> +++ b/refs.h
> @@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
>   * Commit all of the changes that have been queued in transaction, as
>   * atomically as possible.  Return a nonzero value if there is a
>   * problem.  The ref_transaction is freed by this function.
> + * If error is non-NULL it will return an error string that describes
> + * why a commit failed. This string must be free()ed by the caller.
>   */
>  int ref_transaction_commit(struct ref_transaction *transaction,
> -			   const char *msg, enum action_on_err onerr);
> +			   const char *msg, char **err,
> +			   enum action_on_err onerr);

Is the idea that if I pass in a pointer &err then
ref_transaction_commit will take the action described by onerr *and*
write its error message to err?

Probably squashing with patch 07 would make this easier to read (and
wouldn't require changing any messages at that point).

[...]
> --- a/refs.c
> +++ b/refs.c
[...]
> @@ -3443,6 +3447,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  					       update->flags,
>  					       &update->type, onerr);
>  		if (!update->lock) {
> +			if (err) {
> +				const char *str = "Cannot lock the ref '%s'.";
> +				*err = xmalloc(PATH_MAX + 24);
> +				snprintf(*err, PATH_MAX + 24, str,
> +					 update->refname);
> +			}

Might be clearer to use a helper similar to path.c::mkpathdup

	char *aprintf(const char *fmt, ...)
	{
		char *result;
		struct strbuf sb = STRBUF_INIT;
		va_list args;

		va_start(args, fmt);
		strbuf_vaddf(&sb, fmt, args);
		va_end(args);

		return strbuf_detach(&sb);
	}

or to have the caller pass in a pointer to strbuf instead of char *.

The rest looks good to me.

Thanks,
Jonathan
