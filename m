From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 1/3] refs.c: split writing and commiting a ref into
 two separate functions
Date: Tue, 15 Apr 2014 13:17:00 +0200
Message-ID: <534D152C.7090607@alum.mit.edu>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com> <1397500163-7617-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 13:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa1MX-0006p1-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 13:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaDOLRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 07:17:06 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62166 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbaDOLRE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2014 07:17:04 -0400
X-AuditID: 12074412-f79d46d000002e58-5e-534d152e4c0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E4.49.11864.E251D435; Tue, 15 Apr 2014 07:17:02 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97931.dip0.t-ipconnect.de [79.201.121.49])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3FBH0f7005335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 15 Apr 2014 07:17:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397500163-7617-2-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1NUT9Q026J4mbtF1pZvJ4t+EGgcm
	jwWbSj0+b5ILYIritklKLCkLzkzP07dL4M5YtWgnW8HHooqH89ezNDDej+xi5OSQEDCRuNxw
	lgnCFpO4cG89G4gtJHCZUeLj3/AuRi4g+zyTxITOmewgCV4BbYmtG7cAFXFwsAioSpzeWgsS
	ZhPQlVjU08wEEhYVCJL4c1YRolpQ4uTMJywgtoiAncT6WwuZQWxhgWSJ00tuMUOsqpTYd/0Z
	mM0p4Czx/d5KsDESAuISPY1BIGFmAR2Jd30PmCFseYntb+cwT2AUmIVkwywkZbOQlC1gZF7F
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERKeQjsY15+UO8QowMGoxMNr8cY7
	WIg1say4MvcQoyQHk5Io7w4R32AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwfuYFyvCmJlVWp
	RfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvEtAhgoWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSDYjS+GBilICkeoL1rQdp5iwsSc4GiEK2nGHU5Nmxb08gkxJKXn5cq
	Jc57RBioSACkKKM0D24FLBm9YhQH+liYdzPIKB5gIoOb9ApoCRPQEpZ2b5AlJYkIKakGxsnz
	3pyLzfmmoOGvfuRyTb/Y7IDjD9bGP560ZEH+60pnsYmbpi1dt+TKdLc5H0v/ehWU625f+sbK
	sDRjUc93UdHdMavnH5xvZFb+MKljY9LUnbIq329NO/Lj3+rPx3o+ttdZ3+W6/ueu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246285>

See my comment to your cover letter where I suggest using ref
transactions instead of making callers deal with even more of the
details of updating references.  But I will comment on these patches
anyway, in case you'd rather leave them closer to the current form.

On 04/14/2014 08:29 PM, Ronnie Sahlberg wrote:
> Change the function write_ref_sha1() to just write the ref but not
> commit the ref or the lockfile.
> Add a new function commit_ref_lock() that will commit the change done by
> a previous write_ref_sha1().
> Update all callers of write_ref_sha1() to call commit_ref_lock().
> 
> The new pattern for updating a ref is now :
> 
> lock = lock_ref_sha1_basic() (or varient of)

s/varient/variant/

> write_ref_sha1(lock)
> unlock_ref(lock) | commit_ref_lock(lock)
> 
> Once write_ref_sha1() returns, the new ref has been written and the lock
> file has been closed.
> At that stage we can then either call unlock_ref() which will abort the
> update and delete the lock file withouth applying it, or call

You need a comma after "unlock_ref()".

s/withouth/without/

> commit_ref_lock() which will rename the lock file onto the ref file.


The commit message would be easier to read with better formatting; maybe

---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---
refs.c: split writing and commiting a ref into two separate functions

* Change the function write_ref_sha1() to just write the ref but not
  commit the ref or the lockfile.

* Add a new function commit_ref_lock() that will commit the change done by
  a previous write_ref_sha1().

* Update all callers of write_ref_sha1() to call commit_ref_lock().

The new pattern for updating a ref is now :

    lock = lock_ref_sha1_basic() (or variant of)
    write_ref_sha1(lock)
    unlock_ref(lock) | commit_ref_lock(lock)

Once write_ref_sha1() returns, the new ref has been written and the lock
file has been closed. At that stage we can then either call unlock_ref(),
which will abort the update and delete the lock file without applying it,
or call commit_ref_lock() which will rename the lock file onto the ref
file.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---


> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  branch.c               | 10 ++++++++--
>  builtin/commit.c       |  5 +++++
>  builtin/fetch.c        |  7 ++++++-
>  builtin/receive-pack.c |  4 ++++
>  builtin/replace.c      |  6 +++++-
>  builtin/tag.c          |  6 +++++-
>  fast-import.c          | 18 ++++++++++++++++--
>  refs.c                 | 41 +++++++++++++++++++++++++++++++----------
>  refs.h                 |  4 ++++
>  sequencer.c            |  4 ++++
>  walker.c               |  4 ++++
>  11 files changed, 92 insertions(+), 17 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 660097b..903ea75 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -304,9 +304,15 @@ void create_branch(const char *head,
>  	if (real_ref && track)
>  		setup_tracking(ref.buf + 11, real_ref, track, quiet);
>  
> -	if (!dont_change_ref)
> -		if (write_ref_sha1(lock, sha1, msg) < 0)
> +	if (!dont_change_ref) {
> +		if (write_ref_sha1(lock, sha1, msg) < 0) {
> +			unlock_ref(lock);
>  			die_errno(_("Failed to write ref"));
> +		}
> +		if (commit_ref_lock(lock) < 0) {
> +			die_errno(_("Failed to commit ref"));
> +		}
> +	}
>  
>  	strbuf_release(&ref);
>  	free(real_ref);

There are a lot of changes like this with similar duplicated error
handling.  Why not define a helper function like
write_ref_sha1_and_commit() that does what the old write_ref_sha1() used
to do (for the callers who don't care about updating multiple references
at once)?

In fact, I would recommend renaming the function in a preparatory
commit, to reduce the amount of code churn in the second commit where
you extract the two new separate functions.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index d9550c5..3d8a3a8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1686,9 +1686,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		die(_("cannot lock HEAD ref"));
>  	}
>  	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
> +		unlock_ref(ref_lock);
>  		rollback_index_files();
>  		die(_("cannot update HEAD ref"));
>  	}
> +	if (commit_ref_lock(ref_lock) < 0) {
> +		rollback_index_files();
> +		die(_("cannot commit HEAD ref"));
> +	}
>  
>  	unlink(git_path("CHERRY_PICK_HEAD"));
>  	unlink(git_path("REVERT_HEAD"));
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 55f457c..ebfb854 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -388,7 +388,12 @@ static int s_update_ref(const char *action,
>  	if (!lock)
>  		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>  					  STORE_REF_ERROR_OTHER;
> -	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
> +	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0) {
> +		unlock_ref(lock);
> +		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
> +					  STORE_REF_ERROR_OTHER;
> +	}
> +	if (commit_ref_lock(lock) < 0)
>  		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>  					  STORE_REF_ERROR_OTHER;
>  	return 0;
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c323081..4760274 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -587,8 +587,12 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  			return "failed to lock";
>  		}
>  		if (write_ref_sha1(lock, new_sha1, "push")) {
> +			unlock_ref(lock);
>  			return "failed to write"; /* error() already called */
>  		}
> +		if (commit_ref_lock(lock))
> +			return "failed to commit"; /* error() already called */
> +
>  		return NULL; /* good */
>  	}
>  }
> diff --git a/builtin/replace.c b/builtin/replace.c
> index b62420a..c09ff49 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -160,8 +160,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>  	if (!lock)
>  		die("%s: cannot lock the ref", ref);
> -	if (write_ref_sha1(lock, repl, NULL) < 0)
> +	if (write_ref_sha1(lock, repl, NULL) < 0) {
> +		unlock_ref(lock);
>  		die("%s: cannot update the ref", ref);
> +	}
> +	if (commit_ref_lock(lock) < 0)
> +		die("%s: cannot commit the ref", ref);
>  
>  	return 0;
>  }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 40356e3..8653a64 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -644,8 +644,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
>  	if (!lock)
>  		die(_("%s: cannot lock the ref"), ref.buf);
> -	if (write_ref_sha1(lock, object, NULL) < 0)
> +	if (write_ref_sha1(lock, object, NULL) < 0) {
> +		unlock_ref(lock);
>  		die(_("%s: cannot update the ref"), ref.buf);
> +	}
> +	if (commit_ref_lock(lock) < 0)
> +		die(_("%s: cannot commit the ref"), ref.buf);
>  	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>  		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>  
> diff --git a/fast-import.c b/fast-import.c
> index fb4738d..f732bfb 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1706,8 +1706,13 @@ static int update_branch(struct branch *b)
>  			return -1;
>  		}
>  	}
> -	if (write_ref_sha1(lock, b->sha1, msg) < 0)
> +	if (write_ref_sha1(lock, b->sha1, msg) < 0) {
> +		unlock_ref(lock);
>  		return error("Unable to update %s", b->name);
> +	}
> +	if (commit_ref_lock(lock) < 0) {
> +		return error("Unable to commit %s", b->name);
> +	}
>  	return 0;
>  }
>  
> @@ -1732,8 +1737,17 @@ static void dump_tags(void)
>  	for (t = first_tag; t; t = t->next_tag) {
>  		sprintf(ref_name, "tags/%s", t->name);
>  		lock = lock_ref_sha1(ref_name, NULL);
> -		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
> +		if (!lock) {
> +			failure |= error("Unable to lock %s", ref_name);
> +			continue;
> +		}
> +		if (write_ref_sha1(lock, t->sha1, msg) < 0) {
>  			failure |= error("Unable to update %s", ref_name);
> +			unlock_ref(lock);
> +			continue;
> +		}
> +		if (commit_ref_lock(lock) < 0)
> +			failure |= error("Unable to commit %s", ref_name);
>  	}
>  }
>  
> diff --git a/refs.c b/refs.c
> index 728a761..646afd7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2633,9 +2633,14 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	lock->force_write = 1;
>  	hashcpy(lock->old_sha1, orig_sha1);
>  	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
> +		unlock_ref(lock);
>  		error("unable to write current sha1 into %s", newrefname);
>  		goto rollback;
>  	}
> +	if (commit_ref_lock(lock)) {
> +		error("unable to commit current sha1 into %s", newrefname);
> +		goto rollback;
> +	}
>  
>  	return 0;
>  
> @@ -2649,8 +2654,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	lock->force_write = 1;
>  	flag = log_all_ref_updates;
>  	log_all_ref_updates = 0;
> -	if (write_ref_sha1(lock, orig_sha1, NULL))
> +	if (write_ref_sha1(lock, orig_sha1, NULL)) {
> +		unlock_ref(lock);
>  		error("unable to write current sha1 into %s", oldrefname);
> +	}
> +	if (commit_ref_lock(lock))
> +		error("unable to commit current sha1 into %s", oldrefname);
>  	log_all_ref_updates = flag;
>  
>   rollbacklog:
> @@ -2807,34 +2816,30 @@ int write_ref_sha1(struct ref_lock *lock,
>  	if (!lock)
>  		return -1;
>  	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
> -		unlock_ref(lock);
> +		lock->skipped_write = 1;
>  		return 0;
>  	}
>  	o = parse_object(sha1);
>  	if (!o) {
>  		error("Trying to write ref %s with nonexistent object %s",
>  			lock->ref_name, sha1_to_hex(sha1));
> -		unlock_ref(lock);
>  		return -1;
>  	}
>  	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
>  		error("Trying to write non-commit object %s to branch %s",
>  			sha1_to_hex(sha1), lock->ref_name);
> -		unlock_ref(lock);
>  		return -1;
>  	}
>  	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
>  	    write_in_full(lock->lock_fd, &term, 1) != 1
>  		|| close_ref(lock) < 0) {
>  		error("Couldn't write %s", lock->lk->filename);
> -		unlock_ref(lock);
>  		return -1;
>  	}
>  	clear_loose_ref_cache(&ref_cache);
>  	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
>  	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
>  	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
> -		unlock_ref(lock);
>  		return -1;
>  	}
>  	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
> @@ -2858,7 +2863,12 @@ int write_ref_sha1(struct ref_lock *lock,
>  		    !strcmp(head_ref, lock->ref_name))
>  			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
>  	}
> -	if (commit_ref(lock)) {
> +	return 0;
> +}
> +
> +int commit_ref_lock(struct ref_lock *lock)
> +{
> +	if (!lock->skipped_write && commit_ref(lock)) {
>  		error("Couldn't set %s", lock->ref_name);
>  		unlock_ref(lock);
>  		return -1;
> @@ -3375,10 +3385,17 @@ int update_ref(const char *action, const char *refname,
>  	       int flags, enum action_on_err onerr)
>  {
>  	struct ref_lock *lock;
> +	int ret;
> +
>  	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
>  	if (!lock)
>  		return 1;
> -	return update_ref_write(action, refname, sha1, lock, onerr);
> +	ret = update_ref_write(action, refname, sha1, lock, onerr);
> +	if (ret)
> +		unlock_ref(lock);
> +	else
> +		ret = commit_ref_lock(lock);
> +	return ret;
>  }
>  
>  static int ref_update_compare(const void *r1, const void *r2)
> @@ -3453,7 +3470,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  					       update->refname,
>  					       update->new_sha1,
>  					       update->lock, onerr);
> -			update->lock = NULL; /* freed by update_ref_write */
> +			if (ret)
> +				unlock_ref(update->lock);
> +			else
> +				commit_ref_lock(update->lock);
> +			update->lock = NULL;
>  			if (ret)
>  				goto cleanup;
>  		}
> @@ -3464,7 +3485,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		struct ref_update *update = updates[i];
>  
>  		if (update->lock) {
> -			delnames[delnum++] = update->lock->ref_name;
> +			delnames[delnum++] = update->refname;

Isn't this hunk orthogonal to the main point of this commit?  If so,
please split it into a separate commit.

>  			ret |= delete_ref_loose(update->lock, update->type);
>  		}
>  	}
> diff --git a/refs.h b/refs.h
> index 0f08def..f14a417 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -8,6 +8,7 @@ struct ref_lock {
>  	unsigned char old_sha1[20];
>  	int lock_fd;
>  	int force_write;
> +	int skipped_write;
>  };
>  
>  struct ref_transaction;
> @@ -153,6 +154,9 @@ extern void unlock_ref(struct ref_lock *lock);
>  /** Writes sha1 into the ref specified by the lock. **/
>  extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
>  
> +/** Commit any changes done to the ref specified by the lock. **/
> +extern int commit_ref_lock(struct ref_lock *lock);
> +
>  /** Setup reflog before using. **/
>  int log_ref_setup(const char *refname, char *logfile, int bufsize);
>  
> diff --git a/sequencer.c b/sequencer.c
> index bde5f04..ffadf82 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -283,6 +283,10 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  					   0, NULL);
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>  	ret = write_ref_sha1(ref_lock, to, sb.buf);
> +	if (ret)
> +		unlock_ref(ref_lock);
> +	else
> +		ret |= commit_ref_lock(ref_lock);

"|=" could be changed to "=" here and in the next hunk.

>  	strbuf_release(&sb);
>  	return ret;
>  }
> diff --git a/walker.c b/walker.c
> index 1dd86b8..5ce5a1d 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -295,6 +295,10 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  		if (!write_ref || !write_ref[i])
>  			continue;
>  		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
> +		if (ret)
> +			unlock_ref(lock[i]);
> +		else
> +			ret |= commit_ref_lock(lock[i]);
>  		lock[i] = NULL;
>  		if (ret)
>  			goto unlock_and_fail;
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
