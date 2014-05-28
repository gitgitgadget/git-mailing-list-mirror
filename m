From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 16/41] refs.c: add transaction.status and track
 OPEN/CLOSED/ERROR
Date: Wed, 28 May 2014 11:51:23 -0700
Message-ID: <20140528185123.GT12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-17-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:51:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpiwk-0006c4-DH
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbaE1Sv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:51:26 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39419 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065AbaE1Sv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:51:26 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so11498156pab.20
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ewEDYa+f0BFoEYCgBSS045cyczxzpoJcWmm8QHvbzj8=;
        b=hfCxwmGVAdTelBpSS1bEjT36QYuE/dwWtT2xY2CNQk167gTdaU9cBbUEpuNTJyV6uv
         On2lEfZekgT1UyaUoCMvoJhAyBaMenm3PTtoBJEy2jHSi6elNWvw7F4h/8nEaTXwspwZ
         q3VJL3w1kfNOVvjrqBC6TQY9m9kpLwr8KEaUUVR2YLnQpUjNy5i08hwK5vC1NmdShB7P
         llM2tJHiB8FJtToVWXGWNu/7eIZ4vEw1gcz4avROmh1M019avDEGtGaU+Rx31ipZn7uO
         hosHe3W8PvKZMgyFyROF1x3qoX6VLq0ed979tRU8dCgQyhUDKpaxo22WqI1lIxnltcuI
         DOFw==
X-Received: by 10.66.158.132 with SMTP id wu4mr2091481pab.66.1401303085593;
        Wed, 28 May 2014 11:51:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pr4sm29591084pbb.53.2014.05.28.11.51.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:51:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-17-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250311>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
[...]
> @@ -3385,6 +3408,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  {
>  	struct ref_update *update;
>  
> +	if (transaction->state != REF_TRANSACTION_OPEN)
> +		return -1;

I still think this is a step in the wrong direction.  It means that
instead of being able to do

	if (ref_transaction_update(..., &err))
		die("%s", err.buf);

and be certain that err.buf has a meaningful message, now I have to
worry that if the state were not REF_TRANSACTION_OPEN (e.g., due to
someone else's code forgetting to handle an error) then the result
would be a plain

	fatal:

The behavior would be much easier to debug if the code were

	if (transaction->state != REF_TRANSACTION_OPEN)
		die("BUG: update on transaction that is not open");

since then the symptom would be

	fatal: BUG: update on transaction that is not open

which is easier to work with.

If a non-OPEN state were a normal, recoverable error, then it could
append a message to the *err argument.  But there's no message that
could be put there that would be meaningful to the end-user.  So I
suspect it's not a normal, recoverable error.

If we want to collect errors to make _commit() later fail with a
message like '38 refs failed to update' or something (or a
string_list, if the API is to change that way in the future), then
_update() should not fail.  It can record information about what is
wrong with this update in the transaction and succeed so the caller
knows to keep going and collect other updates before the _commit()
that will fail.

Of course it's easily possible I'm missing something.  That's just how
I see it now.

Does that make sense?

Jonathan
