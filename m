From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Fri, 5 Dec 2014 11:18:29 -0800
Message-ID: <20141205191829.GB16682@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
 <20141205002331.GJ16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwyOh-00029x-JD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaLETSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:18:32 -0500
Received: from mail-ig0-f202.google.com ([209.85.213.202]:57197 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaLETSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:18:31 -0500
Received: by mail-ig0-f202.google.com with SMTP id hn18so154152igb.1
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iXnFvG4E2BwaUgVCySCJo/jX0wo6czIhgxzc4NLzkSc=;
        b=DqDOBQkl60KE09GSFjsZH0EEd9jt83M2Uhi31oF3t7pYv33hLqUJwZX1DWTH5/uanE
         sEkrOsu4Trj647mv03PwYOLpOgUeLpCNzlgLITmN8Oy9OJNwT6IF41MSdTNsRt8Yw7GJ
         EN0+bMXS5Anuh1DmCLJBjLcX8q1Tf2nuprkiulMRGMNeb9ZMPcCZbawz0HZ6xW9I7u/G
         wt48b+68lQEQNSG+qEboUBEevNW7U/yWXRXLCDoyzPnQB2o7UhEH/Aw7YNQQMr7e7mdm
         NK/GKdsGesEeWo1vTvAhD7SQ5/St38SSsp0mUTsodCGh/S4JkqrXN2oRPCTxxeK4XeNw
         qlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iXnFvG4E2BwaUgVCySCJo/jX0wo6czIhgxzc4NLzkSc=;
        b=b+mCk+ZjaYFLQHtiHtnEee5vtuFbeAUrkHrL424C5uyZYSDuyHL1n690qNvSfZE/w+
         j+wSk8YvLuZZN0MXO9yEChOKTlVlHIuOXY1WXYlL8NJdd2jcBy3YcrhoctglFRyA/r8K
         NlsvSVbyQkqgujfBFlgmEAnmUKAy/SpRkknwZI51x3R3nh2hnf9LZuwOoiry+aGGnKcC
         WpclF2D/IP5fM+aKvVeqXSzsEArVI35nUEjqX8Ey/QR2PTH7BYZoMFulPn5JbKnOWFGb
         j11N+7Y1DnFs8/VBtTXEI7LQf55n9SkY7xucIySDYRAPupECNDVsp4XlPJBIkRhDaiAk
         65ng==
X-Gm-Message-State: ALoCoQkoWEHpTyV96ufe9/nC2EycjgbErDP1nZir5lXZNlzpF3N3r8iKHFJe2JFMhlyA6rnZG3VY
X-Received: by 10.182.85.170 with SMTP id i10mr16994407obz.36.1417807110499;
        Fri, 05 Dec 2014 11:18:30 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si1307382yhb.4.2014.12.05.11.18.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2014 11:18:30 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id sktfcfzT.1; Fri, 05 Dec 2014 11:18:30 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 7B57D140B70; Fri,  5 Dec 2014 11:18:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141205002331.GJ16345@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260884>

On Thu, Dec 04, 2014 at 04:23:31PM -0800, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
> > We don't actually need the locking functionality, because we already
> > hold the lock on the reference itself, which is how the reflog file is
> > locked. But the lock_file code still does some of the bookkeeping for
> > us and is more careful than the old code here was.
> 
> As you say, the ref lock takes care of mutual exclusion, so we do not
> have to be too careful about compatibility with other tools that might
> not know to lock the reflog.  And this is not tying our hands for a
> future when I might want to lock logs/refs/heads/topic/1 while
> logs/refs/heads/topic still exists as part of the implementation of
> "git mv topic/1 topic".
> 
> Stefan and I had forgotten about that guarantee when looking at that
> kind of operation --- thanks for the reminder.
> 
> Should updates to the HEAD reflog acquire HEAD.lock?  (They don't
> currently.)
> 
> [...]
> > --- a/builtin/reflog.c
> > +++ b/builtin/reflog.c
> > @@ -349,12 +349,14 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
> >  	return 0;
> >  }
> >  
> > +static struct lock_file reflog_lock;
> 
> If this lockfile is only used in that one function, it can be declared
> inside the function.
> 
> If it is meant to be used throughout the 'git reflog' command, then it
> can go near the top of the file.
> 

After the series completes, this lock is only used in reflog_expire.
So I'd rather move it inside the function? Then we could run the reflog_expire
function in parallel for different locks in theory?

> > +
> >  static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
> >  {
> >  	struct cmd_reflog_expire_cb *cmd = cb_data;
> >  	struct expire_reflog_cb cb;
> >  	struct ref_lock *lock;
> > -	char *log_file, *newlog_path = NULL;
> > +	char *log_file;
> >  	struct commit *tip_commit;
> >  	struct commit_list *tips;
> >  	int status = 0;
> > @@ -372,10 +374,14 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
> >  		unlock_ref(lock);
> >  		return 0;
> >  	}
> > +
> >  	log_file = git_pathdup("logs/%s", refname);
> >  	if (!cmd->dry_run) {
> > -		newlog_path = git_pathdup("logs/%s.lock", refname);
> > -		cb.newlog = fopen(newlog_path, "w");
> > +		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
> > +			goto failure;
> 
> hold_lock_file_for_update doesn't print a message.  Code to print one
> looks like
> 
> 	if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
> 		unable_to_lock_message(log_file, errno, &err);
> 		error("%s", err.buf);
> 		goto failure;
> 	}
> 
> (A patch in flight changes that to
> 
> 	if (hold_lock_file_for_update(&reflog_lock, log_file, 0, &err) < 0) {
> 		error("%s", err.buf);
> 		goto failure;
> 	}
> 
> )
> 
> > +		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> > +		if (!cb.newlog)
> > +			goto failure;
> 
> Hm.  lockfile.c::fdopen_lock_file ought to use xfdopen to make this
> case impossible.  And xfdopen should use try_to_free_routine() and
> try again on failure.
> 
> [...]
> > @@ -423,10 +429,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
> >  	}
> >  
> >  	if (cb.newlog) {
> > -		if (fclose(cb.newlog)) {
> > -			status |= error("%s: %s", strerror(errno),
> > -					newlog_path);
> > -			unlink(newlog_path);
> > +		if (close_lock_file(&reflog_lock)) {
> > +			status |= error("Couldn't write %s: %s", log_file,
> > +					strerror(errno));
> 
> Style nit: error messages usually start with a lowercase letter
> (though I realize nearby examples are already inconsistent).
> 
> commit_lock_file() can take care of the close_lock_file automatically.
> 
> [...]
> > @@ -434,21 +439,23 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
> >  			 close_ref(lock) < 0)) {
> >  			status |= error("Couldn't write %s",
> >  					lock->lk->filename.buf);
> > -			unlink(newlog_path);
> > -		} else if (rename(newlog_path, log_file)) {
> > -			status |= error("cannot rename %s to %s",
> > -					newlog_path, log_file);
> > -			unlink(newlog_path);
> > +			rollback_lock_file(&reflog_lock);
> > +		} else if (commit_lock_file(&reflog_lock)) {
> > +			status |= error("cannot rename %s.lock to %s",
> > +					log_file, log_file);
> 
> Most callers say "unable to commit reflog '%s'", log_file to hedge their
> bets in case the close failed (which may be what you were avoiding
> above.
> 
> errno is meaningful when commit_lock_file fails, making a more
> detailed diagnosis from strerror(errno) possible.
> 
> Thanks,
> Jonathan
