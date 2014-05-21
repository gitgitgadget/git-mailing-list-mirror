From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 27/44] walker.c: use ref transaction for ref updates
Date: Tue, 20 May 2014 17:46:32 -0700
Message-ID: <20140521004632.GX12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-28-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 21 02:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmug3-0006uS-I2
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbaEUAqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:46:36 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:61692 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaEUAqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:46:35 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so837765pbb.13
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KpY/VVsbTt3+myBdmpy3ZKbBQOl+8lGZbXXnDoUjmZM=;
        b=Y9vYTq7yRxAC51xp/BnoAGe+0Iph1DsZ3Sv76ncTq5tX0693csi8Ag12RVQbVtog07
         MrOh8MdoN/eVDyg7QDbfGuUwCUWt+2c4KJMn6RS120L5DpAYCojSkdI/oG8W3G1gWU99
         6CC7JbvJdZiP6O+dUWjIsGWUlk0XWF8zgYitn6eRxcee95SbSU2b2VW32Qn7nOgR5FqN
         AhFodwtNR5VdSlli60qmoDLQuxXcNCsmeNvDudWQiq6pbChAMXW3hEBepgnVEJXQv5zF
         BtOG7fI4N9msdvWpd+EEG1paX4N+2+cfee/WnbR6SI4AJt9LdjshyWmmq8Y6Rr3ZyjEB
         ntaA==
X-Received: by 10.68.221.42 with SMTP id qb10mr54729555pbc.65.1400633194749;
        Tue, 20 May 2014 17:46:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gg3sm5124818pbc.34.2014.05.20.17.46.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 17:46:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-28-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249767>

Ronnie Sahlberg wrote:

> This changes the locking slightly for walker_fetch. Previously the code would
> lock all refs before writing them but now we do not lock the refs until the
> commit stage. There is thus a very short window where changes could be done
> locally during the fetch which would be overwritten when the fetch completes
> and commits its transaction. But this window should be reasonably short.
> Even if this race does trigger, since both the old code and the new code
> just overwrites the refs to the new values without checking or comparing
> them with the previous value, this is not too dissimilar to a similar scenario
> where you first do a ref change locally and then later do a fetch that
> overwrites the local change. With this in mind I do not see the change in
> locking semantics to be critical.

Sounds scary.  The usual approach is

	old_sha1 = ...
	... various checks ...

	transaction = transaction_begin(&err)
	transaction_update(transaction, refname, new_sha1, old_sha1, ...);
	transaction_commit(transaction, &err);

which is not racy because _update checks against old_sha1.

If I understand correctly, you are saying 'have_old' is false here so
we don't have the usual protection.  If the "... various checks ..."
section shown above is empty, that should be fine and there is no
actual change in semantics.  If the "... various checks ..." section
shown above is nonempty then it could be a problem.

[...]
> --- a/walker.c
> +++ b/walker.c
> @@ -251,24 +251,18 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
>  int walker_fetch(struct walker *walker, int targets, char **target,
>  		 const char **write_ref, const char *write_ref_log_details)
>  {
> -	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
> +	char ref_name[PATH_MAX];

We tend to prefer strbuf instead of fixed-size buffers in new code.

[...]
> -	char *msg;
> +	char *msg = NULL;

Needed?  The existing code seems to set msg = NULL in the
!write_ref_log_details case already.

[...]
> @@ -294,19 +288,26 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  	for (i = 0; i < targets; i++) {
>  		if (!write_ref || !write_ref[i])
>  			continue;
> -		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");

Okay, so before this patch we do:

	for each target in write_ref:
		lock it (with no particular expectation about where it
		points)

Then

	unless http-fetch was passed --recover:
		mark the objects pointed to by current refs as COMPLETE

Then we do HTTP GETs to grab the objects we need from a "dumb" HTTP
server.  The COMPLETE objects tell us about objects we don't have to
bother trying to get.

When we're done, we come up with a reflog entry and write out refs
pointing to the requested commits.

This code has two callers:

	git-remote-http (aka remote-curl.c::fetch_dumb)
	git-http-fetch (aka http-fetch.c)

The codepath in git-remote-http gets wide use, though it's diminishing
as more people switch to "smart" http.  It doesn't 't use the "write
out some refs" feature.  It just wants the objects and then takes care
of writing refs on its own.

Perhaps it's worth avoiding beginning a transaction in the first place
in the !write_ref case.

The git-http-fetch command is a piece of plumbing that used to be used
by 'git clone' and 'git fetch' in the olden days when they were shell
scripts.  I doubt anyone uses it.  As you noticed, it doesn't have any
way to specify anything about the expected old values of the refs it
writes to.  So this change doesn't introduce any race there.

> +		sprintf(ref_name, "refs/%s", write_ref[i]);
> +		if (ref_transaction_update(transaction, ref_name,
> +					   &sha1[20 * i], NULL,
> +					   0, 0))
> +			goto rollback_and_fail;
> +	}

Looks good.

> +
> +	if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
> +				   &err)) {
> +		error("%s", err.buf);
> +		goto rollback_and_fail;
>  	}

Also looks good.

Thanks,
Jonathan
