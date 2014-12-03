From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] refs.c: add a transaction function to append a
 reflog entry
Date: Wed, 3 Dec 2014 14:28:52 -0800
Message-ID: <20141203222852.GB26810@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
 <1417506402-24257-4-git-send-email-sbeller@google.com>
 <20141203031519.GF6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:29:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwIPr-0003mQ-1F
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbaLCW2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:28:55 -0500
Received: from mail-ig0-f201.google.com ([209.85.213.201]:36686 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaLCW2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:28:54 -0500
Received: by mail-ig0-f201.google.com with SMTP id h15so1842051igd.4
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PyUb4ifyJcL15fzmsC/kODy8oAR7WbG2TLt4C33a3Fk=;
        b=NdzZW0QknWK1zPz42ZUr011gTRVADZ22WW7cy933v2Wyc4z+G7HwomVJmbynz1k6TN
         Plj5k9M5G3/vBtbGNk6PXObhNDPQokR7hpBEnLor2VLqMiiKVcnsOpspja/OtUsztmhC
         Gzc13lgimxZk/bJOYBcSGxBKqySiA/k3Fjzgqh1i48u5gnvsLvUlVWmXYfvRZVK3Bmwd
         p9ZEhuPOSBNvToqln/fcFO1veGSo0ov8rlKdfSRv+8EZ4r/wSXJfifVWEsfQo+374QFm
         fpzZMotRl+j5MJjWqgqiXGyYTz8YTau6BrqrNbcKf5mSfmYxNczGgD1qGbbdstINFKNr
         qOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PyUb4ifyJcL15fzmsC/kODy8oAR7WbG2TLt4C33a3Fk=;
        b=kfMw9JO4AJxAJmLULfQSMiKMk083mhZLv+zkGJXDVTFlITsymE6LLsIcnEuuSotfyo
         fOH7rQbT6xgeoTZt1MxOtV27aTrW82oQn8U1nNLRf16lf4ImN4XrPDgcsNbPjzWpPY+s
         KF2PG0M4tqU+7qqURpdU6ufkMg0gmsI2TipQnnJNpkzZfCUNEOay5SJv/riTTSttZ1vd
         bGrkKnzG+PGYR3AAxOyVnGHSu/riBkYjtwAWqLOxpwjvSmYeTXhvfjDN9rOs+tiBfiEU
         NvCu9Og7YnTvxbU0MiV9AG5lm8RMfN/UfyYWMUhD6VqnqJaId+PaFTC6cfq69dunXd7S
         4Kew==
X-Gm-Message-State: ALoCoQnyRAOZrLenfFf4FcYiXtJJ46SG441Dodgil8gfytvjSEJRvmSPAv+X2u3GutvN48PepkeK
X-Received: by 10.182.165.37 with SMTP id yv5mr6872097obb.25.1417645733609;
        Wed, 03 Dec 2014 14:28:53 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si1040899yhb.4.2014.12.03.14.28.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2014 14:28:53 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id ks0QUiCc.1; Wed, 03 Dec 2014 14:28:53 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 8C99C141027; Wed,  3 Dec 2014 14:28:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203031519.GF6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260704>

On Tue, Dec 02, 2014 at 07:15:19PM -0800, Jonathan Nieder wrote:

I'll think about rewriting the commit message, so it is easier to digest.
I'll follow your suggestions except for the following annotations

> 
> > +int transaction_update_reflog(struct transaction *transaction,
> > +			      const char *refname,
> > +			      const unsigned char *new_sha1,
> > +			      const unsigned char *old_sha1,
> > +			      const char *email,
> > +			      unsigned long timestamp, int tz,
> > +			      const char *msg, int flags,
> > +			      struct strbuf *err)
> 
> This is an intimidating list of arguments.  Would it make sense to
> pack them into a struct, or to make the list less intimidating
> some other way (e.g. combining email + timestamp + tz into an
> ident string)?

It's true, that is's a huge list. One of the reasons Ronnie gave, 
was having symmetry in reflog.c:expire_reflog_ent, which has a very
similar signature, the  email + timestamp + tz are passed in as separate
arguments.

expire_reflog_ent is being called from within reflog.c:expire_reflog

	if (for_each_reflog_ent(ref, expire_reflog_ent, &cb)) {
		status |= error("%s", err.buf);
		goto cleanup;
	}

now if, we dive into the for_each_reflog_ent function, it's essentially 
just calling show_one_reflog_ent on each reflog entry.
In there we are trying to separate a reflogs entry into the fields
(new sha1, old sha1, committer, email, time, timezone, message) by the
lovely expression

	/* old SP new SP name <email> SP time TAB msg LF */
	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
	    get_sha1_hex(sb->buf, osha1) || sb->buf[40] != ' ' ||
	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
	    !(email_end = strchr(sb->buf + 82, '>')) ||
	    email_end[1] != ' ' ||
	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
	    !message || message[0] != ' ' ||
	    (message[1] != '+' && message[1] != '-') ||
	    !isdigit(message[2]) || !isdigit(message[3]) ||
	    !isdigit(message[4]) || !isdigit(message[5]))
		return 0; /* corrupt? */

so I wonder if it actually makes sense to first separate it out into fields,
and then joining to an ident string again. Is there some kind of struct already,
which groups together identifying information, such as name, email, timestamp + zone,
which could be reused here for passing on the data?

Anyway, this is a first step on transactioning the reflog code, so it is minimally
invasive, not changing a lot of business logic. If you look into the next patch,
(reflog.c: use a reflog transaction when writing during expire)
you'll see that it's essentially just a replacement of printfs to calling
the function.

-	if (cb->newlog) {
-		fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1),
-			email, timestamp, sign, zone,
-			message);
+	if (cb->t) {
+		if (transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
+					      email, timestamp, tz, message, 0,
+					      cb->err))

and the errorhandling was removed.
If we want to change the function signature of transaction_update_reflog, 
I'd do it in a follow up?



> 

> 
> [...]
> > +	if (flags & REFLOG_TRUNCATE) {
> > +		if (lseek(fd, 0, SEEK_SET) < 0 ||
> > +			ftruncate(fd, 0)) {
> > +			strbuf_addf(err, "Could not truncate reflog: %s. %s",
> > +				    refname, strerror(errno));
> 
> Odd error message format (using '.' to separate the refname from
> strerror(errno) is unusual).  Errors normally are supposed to start
> with a lowercase letter, like
> 
> 	cannot truncate reflog '%s': %s
> 
> > +			goto failure;
> > +		}
> > +	}
> 
> How does this cause the reflog to be populated in the !(flags &
> REFLOG_TRUNCATE) case?
> 
> Maybe I am misunderstanding the API.  If I use
> transaction_update_reflog() and have not updated the reflog
> previously, isn't this supposed to just append a new entry to the
> reflog?
> 

He, that's indeed a good catch. I was investigating the API again myself and
the REFLOG_TRUNCATE flag is only set on the very first call to transaction_update_reflog
and the subsequent calls are rebuilding the reflog by adding the unpruned lines 
again line by line.

I am wondering if we should actually put that into the same function now.
As the new reflog is build on the calls by transaction_update_reflog, it's actually
depending on the order strictly as opposed to the refs.
Maybe we want to have two separate functions
	transaction_update_begin_reflog(...)
	transaction_update_reflog_add_line(...)

instead? Then a reflog update could look like this:
	t=transaction_begin(...)
	
	transaction_update_begin_reflog(t, refname)
	for_each_reflog_entry_for_refname(entry, refname):
		if (want_to_keep(entry):
			transaction_update_reflog_add_line(entry, refname)

	transaction_commit(...)

The logic of want_to_keep is currently in reflog.c:expire_reflog_ent(...),
not sure if there are other places.


> [...]
> > +failure:
> > +	strbuf_release(&buf);
> > +	/*
> > +	 * As we are using the lock file API, any stale files left behind will
> > +	 * be taken care of, no need to do anything here.
> > +	 */
> 
> That's only true if the caller is going to exit instead of proceeding
> to other work.
> 
> With current callers, I assume that's true.  So should this comment
> say something like "No need to roll back stale lock files because
> the caller will exit soon"?  Or should this roll back the lockfile
> anyway, in case the caller wants to try again?

I am not sure if we ever want transactions be tried again without the user 
explicitely rerunning the command?

As we're operating on a lockfile, which was just created by us, and now in 
the failure command, we're likely to die? Maybe I remove the comment altogether, 
as the wondering reader will look into the API for lock files, when looking 
for problems here.

> > +	/* Commit all reflog updates*/
> > +	for_each_string_list_item(item, &transaction->reflog_updates) {
> > +		struct lock_file *lock = item->util;
> > +		commit_lock_file_to(lock, git_path("logs/%s", item->string));
> 
> Neat.
> 
> This seems like a good starting point.  Other code paths still write
> to reflogs directly --- is there a plan to get them to use this code,
> too, in a followup patch (e.g., by making write_ref_sha1() or
> log_ref_write() use its own small transaction for the reflog update)?
> 

That's the plan, but not part of this patch series yet.

> Thanks and hope that helps,
> Jonathan

Thanks for the comments,
Stefan
