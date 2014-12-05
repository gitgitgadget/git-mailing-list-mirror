From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Thu, 4 Dec 2014 16:23:31 -0800
Message-ID: <20141205002331.GJ16345@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 01:23:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwggN-0001eT-P1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 01:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbaLEAXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 19:23:35 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:40678 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbaLEAXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 19:23:34 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so19704829igd.8
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 16:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a8XwH32iNI0xyi3LBjRdB5En8DsDtuP4d9gPbhuVP5s=;
        b=k96TEBhhqdvv84PavKjAxuo8+U2ZWZoP6S9i9UBcuAzk/qeZ7nef/Sn1v+HMNCyBnQ
         ryx19qGudNTmCJhA92GSjrT+GzdiNvXrLDKD3960iy3ZCjqtKLwBl201DIQHxdEjxf/O
         I4hYcf5F9/CiYF6lCg6OHdxIRDv+sWWj0W25El0vTYVVYOC7wgI6m+2IAlbcpjd6S//J
         StiRcVtcdyWQdqN2jiZSfWr62f+9stmNDtNlPMRYqp3OfTIc0AVtMakeN4TcBDiuzyK1
         w2pfO1NBFobGRNQ5YTWtyI268rL6am6xngRKNyb282LlGlhpgW5M/nAdVz2gYkxzIPEs
         ouyg==
X-Received: by 10.50.171.194 with SMTP id aw2mr36534igc.25.1417739013869;
        Thu, 04 Dec 2014 16:23:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id e3sm11764202iod.0.2014.12.04.16.23.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 16:23:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260848>

Michael Haggerty wrote:

> We don't actually need the locking functionality, because we already
> hold the lock on the reference itself, which is how the reflog file is
> locked. But the lock_file code still does some of the bookkeeping for
> us and is more careful than the old code here was.

As you say, the ref lock takes care of mutual exclusion, so we do not
have to be too careful about compatibility with other tools that might
not know to lock the reflog.  And this is not tying our hands for a
future when I might want to lock logs/refs/heads/topic/1 while
logs/refs/heads/topic still exists as part of the implementation of
"git mv topic/1 topic".

Stefan and I had forgotten about that guarantee when looking at that
kind of operation --- thanks for the reminder.

Should updates to the HEAD reflog acquire HEAD.lock?  (They don't
currently.)

[...]
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -349,12 +349,14 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>  	return 0;
>  }
>  
> +static struct lock_file reflog_lock;

If this lockfile is only used in that one function, it can be declared
inside the function.

If it is meant to be used throughout the 'git reflog' command, then it
can go near the top of the file.

> +
>  static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
>  {
>  	struct cmd_reflog_expire_cb *cmd = cb_data;
>  	struct expire_reflog_cb cb;
>  	struct ref_lock *lock;
> -	char *log_file, *newlog_path = NULL;
> +	char *log_file;
>  	struct commit *tip_commit;
>  	struct commit_list *tips;
>  	int status = 0;
> @@ -372,10 +374,14 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>  		unlock_ref(lock);
>  		return 0;
>  	}
> +
>  	log_file = git_pathdup("logs/%s", refname);
>  	if (!cmd->dry_run) {
> -		newlog_path = git_pathdup("logs/%s.lock", refname);
> -		cb.newlog = fopen(newlog_path, "w");
> +		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
> +			goto failure;

hold_lock_file_for_update doesn't print a message.  Code to print one
looks like

	if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
		unable_to_lock_message(log_file, errno, &err);
		error("%s", err.buf);
		goto failure;
	}

(A patch in flight changes that to

	if (hold_lock_file_for_update(&reflog_lock, log_file, 0, &err) < 0) {
		error("%s", err.buf);
		goto failure;
	}

)

> +		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> +		if (!cb.newlog)
> +			goto failure;

Hm.  lockfile.c::fdopen_lock_file ought to use xfdopen to make this
case impossible.  And xfdopen should use try_to_free_routine() and
try again on failure.

[...]
> @@ -423,10 +429,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>  	}
>  
>  	if (cb.newlog) {
> -		if (fclose(cb.newlog)) {
> -			status |= error("%s: %s", strerror(errno),
> -					newlog_path);
> -			unlink(newlog_path);
> +		if (close_lock_file(&reflog_lock)) {
> +			status |= error("Couldn't write %s: %s", log_file,
> +					strerror(errno));

Style nit: error messages usually start with a lowercase letter
(though I realize nearby examples are already inconsistent).

commit_lock_file() can take care of the close_lock_file automatically.

[...]
> @@ -434,21 +439,23 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>  			 close_ref(lock) < 0)) {
>  			status |= error("Couldn't write %s",
>  					lock->lk->filename.buf);
> -			unlink(newlog_path);
> -		} else if (rename(newlog_path, log_file)) {
> -			status |= error("cannot rename %s to %s",
> -					newlog_path, log_file);
> -			unlink(newlog_path);
> +			rollback_lock_file(&reflog_lock);
> +		} else if (commit_lock_file(&reflog_lock)) {
> +			status |= error("cannot rename %s.lock to %s",
> +					log_file, log_file);

Most callers say "unable to commit reflog '%s'", log_file to hedge their
bets in case the close failed (which may be what you were avoiding
above.

errno is meaningful when commit_lock_file fails, making a more
detailed diagnosis from strerror(errno) possible.

Thanks,
Jonathan
