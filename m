From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] refs.c: add a transaction function to append a
 reflog entry
Date: Wed, 3 Dec 2014 14:52:01 -0800
Message-ID: <20141203225201.GH6527@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
 <1417506402-24257-4-git-send-email-sbeller@google.com>
 <20141203031519.GF6527@google.com>
 <20141203222852.GB26810@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:52:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwImK-00088d-9g
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbaLCWwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:52:07 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55887 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaLCWwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:52:04 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so17750239igb.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 14:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yn8DKqyrvHiZdHzx95/omhIbjJPsiqQjCN+ZtMDPiYU=;
        b=s3ee0VzcsUTqV1VqhTZrMB1eQXjkXv8rzwWtsu7onlvkQ6ULNXIHzN05Ffi4v0uE/T
         szTiALSF0O6xt0YuL04RD3ttxhnyYT9X4W/rib4rFPNhjGj8Q/akT2Nq8GAdSE0x5Rc2
         UO17SkCvQK72h6FPaZBKnDksWq/kk5GbRn9ikL8+EgJw8KSHDN/MM8u6X9JRv1j2HjHY
         oFCSLw24EchnjiCET0YDfs++1cXuahd2ZdvnaouPLxWyk3qO+YpSJl5DVc1h/dW4fngW
         fxDjsC38vf+x5zLZdyHS6Okw38T8Rci4jqgoFF6nBCAmuKjKi0k92ZS+SOgCRsEc5un9
         9KOg==
X-Received: by 10.107.132.78 with SMTP id g75mr7031264iod.21.1417647124079;
        Wed, 03 Dec 2014 14:52:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id b2sm9111397ioe.2.2014.12.03.14.52.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 14:52:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203222852.GB26810@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260706>

Stefan Beller wrote:
> On Tue, Dec 02, 2014 at 07:15:19PM -0800, Jonathan Nieder wrote:
>> Stefan Beller wrote:

>>> +int transaction_update_reflog(struct transaction *transaction,
>>> +			      const char *refname,
>>> +			      const unsigned char *new_sha1,
>>> +			      const unsigned char *old_sha1,
>>> +			      const char *email,
>>> +			      unsigned long timestamp, int tz,
>>> +			      const char *msg, int flags,
>>> +			      struct strbuf *err)
>>
>> This is an intimidating list of arguments.  Would it make sense to
>> pack them into a struct, or to make the list less intimidating
>> some other way (e.g. combining email + timestamp + tz into an
>> ident string)?
>
> It's true, that is's a huge list.
[...]
> If we want to change the function signature of transaction_update_reflog,
> I'd do it in a follow up?

The important change here is that it is moving from a static to a public
function.  In static functions, having a signature that is hard to work
with is okay because the possibility of confusion is restricted to
callers coordinating between each other in the same file.  Now that the
function is becoming public, it is time to think about the API.

[...]
>> Maybe I am misunderstanding the API.  If I use
>> transaction_update_reflog() and have not updated the reflog
>> previously, isn't this supposed to just append a new entry to the
>> reflog?
>
> He, that's indeed a good catch. I was investigating the API again myself and
> the REFLOG_TRUNCATE flag is only set on the very first call to transaction_update_reflog
> and the subsequent calls are rebuilding the reflog by adding the unpruned lines
> again line by line.

Taking a step back, there are two ways this API can be used:

 * commands like "git reflog expire" that filter the reflog want to
   create an entirely new reflog and copy entries one by one into it

 * commands like "git update-ref" that append to the reflog want to
   have the reflog as-is, plus some new entries added one-by-one

For that second use, the only operation needed is

	transaction_update_reflog

which would add a line to the reflog.  The first use can have that plus

	transaction_truncate_reflog

which would clear the reflog.

If I understood the API proposed by Ronnie, it combined those two
operations into a single function, transaction_truncate_reflog(flag).
The flag could be REFLOG_TRUNCATE to mean "truncate the reflog first",
analagous to the O_TRUNC flag in open(2).

Either API (the two-function version with no flag or one-function
version with flag) is basically equivalent --- they can be implemented
in terms of each other.  I slightly prefer the two-function API since
it makes the sequence of operations more obvious ("first truncate,
then append this, then append that, then...").

[...]
>>> +failure:
>>> +	strbuf_release(&buf);
>>> +	/*
>>> +	 * As we are using the lock file API, any stale files left behind will
>>> +	 * be taken care of, no need to do anything here.
>>> +	 */
>>
>> That's only true if the caller is going to exit instead of proceeding
>> to other work.
>>
>> With current callers, I assume that's true.  So should this comment
>> say something like "No need to roll back stale lock files because
>> the caller will exit soon"?  Or should this roll back the lockfile
>> anyway, in case the caller wants to try again?
>
> I am not sure if we ever want transactions be tried again without the user
> explicitely rerunning the command?
>
> As we're operating on a lockfile, which was just created by us, and now in
> the failure command, we're likely to die? Maybe I remove the comment altogether,
> as the wondering reader will look into the API for lock files, when looking
> for problems here.

It is tempting to roll back the lock file and keeping the transaction in OPEN
state would be best.  That way, the caller can keep going if they want
to --- it is as if the failing call never happened.

... except that rolling back the lockfile would mean rolling back previous
updates to the same reflog that had succeeded, too.

So I think closing the transaction like you do is the right thing to
do.  Rolling back the lockfile wouldn't be useful since there are
still other lockfiles to take care of from previous updates to other
reflogs that haven't been rolled back.  The comment should say that
the caller is going to exit.

Thanks,
Jonathan
