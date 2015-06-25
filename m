From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] cherry-pick: Use refs infrastructure for CHERRY_PICK_HEAD
Date: Thu, 25 Jun 2015 09:41:43 -0700
Message-ID: <xmqqvbebzqns.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	<1435173388-8346-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ADp-0007ef-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbbFYQls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:41:48 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36752 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbbFYQlp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:41:45 -0400
Received: by igbiq7 with SMTP id iq7so122866324igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KjUhSf5wr3Vum1NpCcp7ZV3CEfQyIv7FaA1x/74vOY8=;
        b=XHYh/1DzEF5py2nl1YXRnm21l53NekPVI9gQ+/pBPpCFxiw5nZ5mPRTkiV4DQYHrZu
         /6rXpzwjDja4dUY3OMSPT7jabaXO6VF6lzbVH/d5T1qhBruYi35d9qCjb/O34HHOvMMM
         GsrpHPedmYOyDG8u/nwIsSLkFefua9qvn/V9uUMg+M9J0g0zTQ6hgnyLxh4OIE+QEA5Z
         1M2qAheMtHqiyj4knQboU2mUWOph2/Y4owwGPMyNXLWy4o7exQlTPGgToVFe7OtTILAe
         fGCbscis55Ppxm5mFpCyXZJEWWaDXguV25YMWqrx/l7stTe8UyXo0Ihdufng+3E95nPh
         qOPQ==
X-Received: by 10.107.129.210 with SMTP id l79mr59393359ioi.32.1435250504998;
        Thu, 25 Jun 2015 09:41:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id i185sm19918463ioi.24.2015.06.25.09.41.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 09:41:44 -0700 (PDT)
In-Reply-To: <1435173388-8346-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Jun 2015 15:16:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272692>

David Turner <dturner@twopensource.com> writes:

> Subject: Re: [PATCH 2/6] cherry-pick: Use refs infrastructure for CHERRY_PICK_HEAD
> Also use refs infrastructure for REVERT_HEAD.  These refs
> need to go through the refs backend, since some code
> assumes that they can be read as refs.

	cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs

	Instead of directly writing to and reading from files in
        $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
	and REVERT_HEAD.


>  void remove_branch_state(void)
>  {
> -	unlink(git_path("CHERRY_PICK_HEAD"));
> -	unlink(git_path("REVERT_HEAD"));
> +	delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF | REF_NO_REFLOG);
> +	delete_ref("REVERT_HEAD", NULL, REF_NODEREF | REF_NO_REFLOG);

Interesting.  There is a separate question about NO_REFLOG I'll
discuss in more detail later.  But no-deref puzzled me.  They should
not be symbolic, but if somebody by mistake made a symbolic one, we
won't accidentally remove another unrelated one through them, so
that bit is a good thing to have.

>  static void determine_whence(struct wt_status *s)
>  {
> +	unsigned char unused[20];
>  	if (file_exists(git_path("MERGE_HEAD")))
>  		whence = FROM_MERGE;
> -	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
> +	else if (!read_ref("CHERRY_PICK_HEAD", unused)) {

I would have expected that you would use ref_exists() here.

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 366f0bc..5e27a34 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -415,9 +415,9 @@ __git_ps1 ()
>  			fi
>  		elif [ -f "$g/MERGE_HEAD" ]; then
>  			r="|MERGING"
> -		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
> +		elif git rev-parse --quiet --verify "CHERRY_PICK_HEAD" >/dev/null; then
>  			r="|CHERRY-PICKING"
> -		elif [ -f "$g/REVERT_HEAD" ]; then
> +		elif git rev-parse --quiet --verify "REVERT_HEAD" >/dev/null; then
>  			r="|REVERTING"

Functionality-wise this may be OK but at some point we might want to
have a native way to produce $r with a single execution of a binary.

> @@ -429,8 +429,9 @@ __git_ps1 ()
>  			# symlink symbolic ref
>  			b="$(git symbolic-ref HEAD 2>/dev/null)"
>  		else
> -			local head=""
> -			if ! __git_eread "$g/HEAD" head; then
> +			local head
> +			head="ref: $(git symbolic-ref HEAD 2>/dev/null)" || head=$(git rev-parse HEAD)
> +			if [ -z "$head" ]; then

This is questionable; before the pre-context of this hunk is a check
for "HEAD" inside $GIT_DIR on the filesystem.  Besides, the "theme"
of this patch is about CHERRY_PICK_HEAD and REVERT_HEAD; it does not
justify to touch things that deal with HEAD in the same patch.

> diff --git a/refs.c b/refs.c
> index b34a54a..c1a563f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2979,7 +2979,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>  				 const unsigned char *sha1, struct strbuf* err);
>  static int commit_ref_update(struct ref_lock *lock,
>  			     const unsigned char *sha1, const char *logmsg,
> -			     struct strbuf *err);
> +			     struct strbuf *err, int flags);
>  
>  int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
>  {
> @@ -3041,7 +3041,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	hashcpy(lock->old_oid.hash, orig_sha1);
>  
>  	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
> -	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
> +	    commit_ref_update(lock, orig_sha1, logmsg, &err, 0)) {
>  		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
>  		strbuf_release(&err);
>  		goto rollback;
> @@ -3060,7 +3060,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	flag = log_all_ref_updates;
>  	log_all_ref_updates = 0;
>  	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
> -	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
> +	    commit_ref_update(lock, orig_sha1, NULL, &err, 0)) {
>  		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
>  		strbuf_release(&err);
>  	}
> @@ -3291,12 +3291,13 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>   */
>  static int commit_ref_update(struct ref_lock *lock,
>  			     const unsigned char *sha1, const char *logmsg,
> -			     struct strbuf *err)
> +			     struct strbuf *err, int flags)
>  {
>  	clear_loose_ref_cache(&ref_cache);
> -	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
> -	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
> -	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0)) {
> +	if (!(flags & REF_NO_REFLOG) &&
> +	    (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
> +	     (strcmp(lock->ref_name, lock->orig_ref_name) &&
> +	      log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0))) {

What is this change about?  I suspect this should be a separate
preparatory commit to allow callers to skip reflog update.

But more importantly, I do not think that it is a good idea in the
first place to allow callers to selectively say "for this update, do
not write a reflog entry".  If you do three ref-updates on the same
ref in a sequence (e.g. imagine you created a single strand of
pearls consisting of three commits) but passed ref-no-reflog only
for the second update, wouldn't that make your reflog entries
inconsistent?

REF_NO_REFLOG functionality that seletively allows updates to be
skipped should *NOT* exist, I think.

In other words, I think "do updates logged" should be a property of
each ref.  If changes to a ref is to be logged, all changes to it
must be logged.  If changes to a ref is not to be logged, no changes
to it must be logged.

The core.logAllRefUpdates configuration may appear to throw a monkey
wrench to that if its name is taken literally, as your creation of
CHECK_HEAD may get logged, which is not what you want.  But we are
under no obligation to obey core.logAllRefUpdates when updating
CHECK_HEAD or REVERT_HEAD.

core.logAllRefUpdates::
	Enable the reflog. Updates to a ref <ref> is logged to the file
	"$GIT_DIR/logs/<ref>", by appending the new and old
	SHA-1, the date/time and the reason of the update, but
	only when the file exists.  If this configuration
	variable is set to true, missing "$GIT_DIR/logs/<ref>"
	file is automatically created for branch heads (i.e. under
	refs/heads/), remote refs (i.e. under refs/remotes/),
	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.

It is fairly clear that we promise not to auto-vivify reflogs for
CHERRY_PICK_HEAD and REVERT_HEAD from this description.

And if some users create $GIT_DIR/logs/CHERRY_PICK_HEAD to enable
reflog for CHERRY_PICK_HEAD, then it is not our business to refuse
logging the change just to speed things up a bit.
