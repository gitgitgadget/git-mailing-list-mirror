From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/8] revert: Improve error handling by cascading errors
 upwards
Date: Wed, 11 May 2011 04:59:49 -0500
Message-ID: <20110511095949.GA2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 19:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCvP-0001pR-71
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 19:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab1EKRKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 13:10:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35430 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab1EKRKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 13:10:07 -0400
Received: by iyb14 with SMTP id 14so507471iyb.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=R8URGvkHQ5bMb8RnGdVnC97g8H0g4s4MwuXbNsDd68Y=;
        b=lJaWN7BpO64m9HpK8Qnfi7llRyIHckJ2qv540xCJZoA8mfir/SEBuUPzBvqrc5wR3p
         25N0pPb2JGQlgk4gZwEYLqZlQEN4s8ezX5te7/4x8qFwzfMzfoI4ZNdkZFlUV0gOS1gy
         qK25nOb6Q3ATf4zfmGWvZ5n7vnjKLMy318xwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jXo8vNe7I/1ak6kRpwJQhv7F7zbOiMhOtwbcQwdib8zZSVbgFEKDFjW6t+6Q4/3q9U
         YA/SNteUgQWeNwobNe6nQGUKMpyYq4zHSCTiOyxUPYot4qWzA4Pnt+5UkUIJyAu9zlNZ
         RTmFXyx9IslSnZqZgI3GnEDicwqtEIiLYSYgA=
Received: by 10.43.58.15 with SMTP id wi15mr3020827icb.411.1305107996876;
        Wed, 11 May 2011 02:59:56 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id un1sm3184150icb.21.2011.05.11.02.59.53
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 02:59:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173413>

Hi,

Ramkumar Ramachandra wrote:
[reordered for convenience]

> --- a/advice.c
> +++ b/advice.c
> @@ -47,3 +47,17 @@ void NORETURN die_resolve_conflict(const char *me)
>  	else
>  		die("'%s' is not possible because you have unmerged files.", me);
>  }
> +
> +int error_resolve_conflict(const char *me)
> +{
> +	if (advice_resolve_conflict)
> +		/*
> +		 * Message used both when 'git commit' fails and when
> +		 * other commands doing a merge do.
> +		 */
> +		return error("'%s' is not possible because you have unmerged files=
=2E\n"
> +			"Please, fix them up in the work tree, and then use 'git add/rm <=
file>' as\n"
> +			"appropriate to mark resolution and make a commit, or use 'git co=
mmit -a'.", me);
> +	else
> +		return error("'%s' is not possible because you have unmerged files=
=2E", me);
> +}

Would it make sense to do

 void NORETURN die_resolve_conflict(const char *me)
 {
	error_resolve_conflict(me);
	exit(128);
 }

or is the s/fatal/error/ in output too much?  I would suspect
saying "error:" instead of "fatal:" should be okay if it means having
less code to deal with, but if not, maybe there is some other way to
achieve the appropriate effect (e.g. --- please don=E2=80=99t use this;=
 it=E2=80=99s
just an example --- when a global in usage.c about_to_die is true,
changing "error:" to "fatal:" or something like that).

> As a general
> guideline for libification, "die" should be only be called in two
> cases: by toplevel callers like command-line argument parsing
> routines, or when an irrecoverable situation is encountered.

The above hints at to a downside to this principle: currently the
message printed by "die" is clearly labelled as git=E2=80=99s cause of =
death.
Still, I think the principle is right and that it=E2=80=99s worth it, a=
nd that
generally speaking a library function should not have to know whether
its errors would be an appropriate time to exit or this is a GUI that
will want to stay alive.

>  Has the commit message justified this change fully?

It didn=E2=80=99t mention "GUI", so I guess no. :)

Could you give a reminder about how this fits in the sequencer series?
Is it that you want to give advice to the user about how to recover
when exiting (and if so, could an atexit handler work instead for
that)?

I'm reviewing the rest because I like the aforementioned "GUI" use
case, but if you get tired of the exercise, please remember that it is
not self-evidently necessary to continue along this track for the sake
of the sequencer alone.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -167,9 +167,11 @@ static char *get_encoding(const char *message)
>  {
>  	const char *p =3D message, *eol;
> =20
> -	if (!p)
> -		die (_("Could not read commit message of %s"),
> -				sha1_to_hex(commit->object.sha1));
> +	if (!p) {
> +		error(_("Could not read commit message of %s"),
> +			sha1_to_hex(commit->object.sha1));
> +		return NULL;

The only caller to get_encoding is get_message, which already returns
early when not passed a usable message.  So maybe this should say

	assert(p);

or

	if (!p)
		die("BUG: get_message caller forgot to give a commit message");

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -198,7 +200,7 @@ static void add_message_to_msg(struct strbuf *msg=
buf, const char *message)
>  	strbuf_addstr(msgbuf, p);
>  }
> =20
> -static void write_cherry_pick_head(void)
> +static int write_cherry_pick_head(void)

write_cherry_pick_head gets called by do_pick_commit to help a person
pick up where "git cherry-pick" left off if it has to exit when
resolving conflicts.  So it=E2=80=99s a good example of how to avoid ha=
ving
to clean up after code when it fails. :)

Anyway, the question here is, what should happen if
write_cherry_pick_head fails (for example due to EPERM or ENOSPC)?  If
this is a GUI or another program that has to stay alive, I suppose one
would want to report the error and back out the cherry-pick of the
current commit as far as it has proceeded (meaning freeing some
memory).  From the signature above I would expect that it does

	return error(...);

on failure (which would bring up an explanation of the failure under
the tab bar in my GUI).

>  {
>  	int fd;
>  	struct strbuf buf =3D STRBUF_INIT;
> @@ -206,12 +208,22 @@ static void write_cherry_pick_head(void)
>  	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
> =20
>  	fd =3D open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666)=
;
> -	if (fd < 0)
> -		die_errno(_("Could not open '%s' for writing"),
> -			  git_path("CHERRY_PICK_HEAD"));
> +	if (fd < 0) {
> +		int err =3D errno;
> +		strbuf_release(&buf);
> +		error(_("Could not open '%s' for writing: %s"),
> +			git_path("CHERRY_PICK_HEAD"), strerror(err));
> +		return -err;
> +	}

Why does the caller care about errno (i.e., why "return -errno"
instead of "return error(...)")?

> -	if (write_in_full(fd, buf.buf, buf.len) !=3D buf.len || close(fd))
> -		die_errno(_("Could not write to '%s'"), git_path("CHERRY_PICK_HEAD=
"));
> +	if (write_in_full(fd, buf.buf, buf.len) !=3D buf.len || close(fd)) =
{
> +		int err =3D errno;
> +		strbuf_release(&buf);
> +		error(_("Could not write to '%s': %s"),
> +			git_path("CHERRY_PICK_HEAD"), strerror(err));
> +		return -err;
> +	}

In the write_in_full case, missing "close(fd)".

In the close(fd) case, not missing "close(fd)", unless we want to
check for errno =3D=3D EINTR and handle that.  (If we do, though, it wo=
uld
probably be in a separate patch, by introducing an xclose function
analagous to xwrite.)  So I suppose this should look something like

	if (write_in_full(...)) {
		ret =3D error(_("Could not write...
		goto done3;
	}
	if (close(fd)) {
		ret =3D error(_(...
		goto done2;
	}
	goto done;

 done3:
	close(fd);
 done2:
	unlink_or_warn(git_path("CHERRY_PICK_HEAD"));
 done:
	strbuf_release(&buf);
	return ret;
 }

> @@ -243,17 +255,22 @@ static void print_advice(void)
>  	advise("and commit the result with 'git commit'");
>  }
> =20
> -static void write_message(struct strbuf *msgbuf, const char *filenam=
e)
> +static int write_message(struct strbuf *msgbuf, const char *filename=
)

write_message writes the MERGE_MSG file.  Like get_cherry_pick_head,
its purpose is to allow recovery if the cherry-pick runs into
conflicts, and presumably the appropriate way to recover would be to
back out the cherry-pick (meaning to free buffers used so far and
remove the CHERRY_PICK_HEAD file).

>  {
>  	static struct lock_file msg_file;
> =20
>  	int msg_fd =3D hold_lock_file_for_update(&msg_file, filename,
>  					       LOCK_DIE_ON_ERROR);
> -	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> -		die_errno(_("Could not write to %s."), filename);
> +	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0) {
> +		int err =3D errno;
> +		strbuf_release(msgbuf);
> +		error(_("Could not write to %s: %s"), filename, strerror(err));
> +		return -err;
> +	}

Same question as before: why does the caller care about the nature of
the error?

hold_lock_file will die on error unless we declare we want to handle
that ourselves through its flags word.  If we are not about to exit,
we will also want to roll back the lockfile on errors, too.

>  	strbuf_release(msgbuf);
>  	if (commit_lock_file(&msg_file) < 0)
> -		die(_("Error wrapping up %s"), filename);
> +		return error(_("Error wrapping up %s"), filename);

If we use the "return -errno" convention, that would mean "return
-EPERM" on traditional Unixen.

[...]
> +static int error_dirty_worktree(const char *me)
> +{
> +	if (advice_commit_before_merge)
> +		return error(_("Your local changes would be overwritten by %s.\n"
> +				"Please, commit your changes or stash them to proceed."), me);
> +	return error(_("Your local changes would be overwritten by %s.\n"),=
 me);
> +}

Side note: git still doesn=E2=80=99t have a good API for dealing with a=
dvice.
I think I=E2=80=99d prefer

	error(_("Your local changes would be overwritten by %s.\n"), me);
	if (advice_commit_before_merge)
		advise(_("Please, commit your...

or perhaps that last part would be

	advise(advice_commit_before_merge,
	       _("Please,...

which would write

 fatal: your local changes would be overwritten by the cherry-pick
 hint: please, commit your changes or stash them to proceed

> -static NORETURN void die_dirty_index(const char *me)
> -{
> -	if (read_cache_unmerged()) {
> -		die_resolve_conflict(me);
> -	} else {
> -		if (advice_commit_before_merge) {
> -			if (action =3D=3D REVERT)
> -				die(_("Your local changes would be overwritten by revert.\n"
> -					  "Please, commit your changes or stash them to proceed."));
[...]
> +static int verify_resolution(const char *me)
> +{
> +	if (!read_cache_unmerged())
> +		return 0;
> +
> +	return error_resolve_conflict(me);
> +}
> +

How is this function meant to be used?  die_dirty_index would
presumably become something like

	if (verify_resolution(me))
		return -1;
	return error_dirty_worktree(me);

but that is not what your caller for this does.  Will say more when I
get to it.

[...]
> @@ -329,10 +341,12 @@ static int do_recursive_merge(struct commit *ba=
se, struct commit *next,
>  			    next_tree, base_tree, &result);
> =20
>  	if (active_cache_changed &&
> -	    (write_cache(index_fd, active_cache, active_nr) ||
> -	     commit_locked_index(&index_lock)))
> +		(write_cache(index_fd, active_cache, active_nr) ||
> +			commit_locked_index(&index_lock))) {

Whitespace changes seem to have snuck in.

> +		rollback_lock_file(&index_lock);

Makes sense.

>  		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -		die(_("%s: Unable to write new index file"), me);
> +		return error(_("%s: Unable to write new index file"), me);
> +	}
>  	rollback_lock_file(&index_lock);

merge_recursive can die, too (e.g., "error building trees").

[...]
> @@ -397,19 +411,21 @@ static int do_pick_commit(void)

do_pick_commit is the main worker of "git cherry-pick foo..bar".  When
it returned an error, traditionally that meant it had encountered a
conflict, and the return value would what exit status to use to
indicate that (typically 1, one hopes, but perhaps 139 if the merge
strategy segfaulted, etc).

To recover, I suppose I can imagine a caller wanting to "try harder".
At any rate the CHERRY_PICK_HEAD, MERGE_HEAD, on-disk dirty index, and
so on are good state that should be kept.

>  		 * that represents the "current" state for merge-recursive
>  		 * to work on.
>  		 */
> -		if (write_cache_as_tree(head, 0, NULL))
> -			die (_("Your index file is unmerged."));
> +		if (write_cache_as_tree(head, 0, NULL)) {
> +			discard_cache();

I suppose this is cleaning up after the read_cache call in
write_cache_as_tree?  But the above does not back out the index lock
at the same time, so I don=E2=80=99t find it so clear.  I would prefer =
to
see write_cache_as_tree taught to clean up after itself on error.

[...]
> @@ -418,19 +434,19 @@ static int do_pick_commit(void)
>  		struct commit_list *p;
> =20
>  		if (!mainline)
> -			die(_("Commit %s is a merge but no -m option was given."),
> -			    sha1_to_hex(commit->object.sha1));
> +			return error(_("Commit %s is a merge but no -m option was given."=
),
> +				sha1_to_hex(commit->object.sha1));

This is not a conflict but an error in usage.  Stepping back for a
second, what is the best way to handle that?  The aforementioned
hypothetical caller considering "try an alternate strategy" would make
a wrong move, so we need to use a return value that would dissuade it.

I=E2=80=99m not sure what the most appropriate thing to do is.  Maybe

	/*
	 * Positive numbers are exit status from conflicts; negative
	 * numbers are other errors.
	 */
	enum pick_commit_error {
		PICK_COMMIT_USAGE_ERROR =3D -1
	};

but it=E2=80=99s hard to think clearly about it since it seems too
hypothetical to me.  If all callers are going to exit, then

	error(...);
	return 129;

will work, but in that case why not exit for them?

> =20
>  		for (cnt =3D 1, p =3D commit->parents;
>  		     cnt !=3D mainline && p;
>  		     cnt++)
>  			p =3D p->next;
>  		if (cnt !=3D mainline || !p)
> -			die(_("Commit %s does not have parent %d"),
> +			return error(_("Commit %s does not have parent %d"),
>  			    sha1_to_hex(commit->object.sha1), mainline);

Likewise.

>  		parent =3D p->item;
> -	} else if (0 < mainline)
> -		die(_("Mainline was specified but commit %s is not a merge."),
> +	} else if (mainline > 0)
> +		return error(_("Mainline was specified but commit %s is not a merg=
e."),
>  		    sha1_to_hex(commit->object.sha1));

Likewise.

>  	else
>  		parent =3D commit->parents->item;
> @@ -441,11 +457,11 @@ static int do_pick_commit(void)
>  	if (parent && parse_commit(parent) < 0)
>  		/* TRANSLATORS: The first %s will be "revert" or
>  		   "cherry-pick", the second %s a SHA1 */
> -		die(_("%s: cannot parse parent commit %s"),
> +		return error(_("%s: cannot parse parent commit %s"),
>  		    me, sha1_to_hex(parent->object.sha1));
> =20
>  	if (get_message(commit->buffer, &msg) !=3D 0)
> -		die(_("Cannot get commit message for %s"),
> +		return error(_("Cannot get commit message for %s"),
>  				sha1_to_hex(commit->object.sha1));
> =20
>  	/*
> @@ -484,7 +500,11 @@ static int do_pick_commit(void)
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
>  		if (!no_commit)
> -			write_cherry_pick_head();
> +			if ((res =3D write_cherry_pick_head())) {
> +				free_message(&msg);
> +				free(defmsg);
> +				return res;
> +			}


These need to eventually exit with status 128.

> @@ -524,44 +544,46 @@ static int do_pick_commit(void)
>  	return res;
>  }
> =20
> -static void prepare_revs(struct rev_info *revs)
> +static int prepare_revs(struct rev_info *revs)

prepare_revs is used by the cherry-pick porcelain after parsing
arguments to initialize the revision walker.  If it fails, we can
save some trouble and cancel the whole operation.

>  {
> -	int argc;
> -
>  	init_revisions(revs, NULL);
>  	revs->no_walk =3D 1;
>  	if (action !=3D REVERT)
>  		revs->reverse =3D 1;
> =20
> -	argc =3D setup_revisions(commit_argc, commit_argv, revs, NULL);
> -	if (argc > 1)
> -		usage(*revert_or_cherry_pick_usage());
> +	if (setup_revisions(commit_argc, commit_argv, revs, NULL) > 1)
> +		return error(_("usage: %s"), *revert_or_cherry_pick_usage());

The exit status for errors in usage ought to be 129, and the message

	error: usage: ...

is not so pretty. :)

I think a library version of this would want to take a struct rev_info
that has been prepopulated.

[...]
> -static void read_and_refresh_cache(const char *me)
> +static int read_and_refresh_cache(const char *me)
>  {
>  	static struct lock_file index_lock;
>  	int index_fd =3D hold_locked_index(&index_lock, 0);
>  	if (read_index_preload(&the_index, NULL) < 0)
> -		die(_("git %s: failed to read the index"), me);
> +		return error(_("%s: failed to read the index"), me);

What is the caller expecting to happen when this fails?  Do we
want to roll back the lockfile and discard the index?

>  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NUL=
L, NULL);
>  	if (the_index.cache_changed) {
>  		if (write_index(&the_index, index_fd) ||
> -		    commit_locked_index(&index_lock))
> +			commit_locked_index(&index_lock)) {

Whitespace change snuck in.

> -			die(_("git %s: failed to refresh the index"), me);
> +			rollback_lock_file(&index_lock);
> +			return error(_("%s: failed to refresh the index"), me);

Likewise.  (Should this discard the index?  If so, why?  If not, why
not?)

> +		}
>  	}
>  	rollback_lock_file(&index_lock);
> +	return 0;
>  }
> =20
>  static int revert_or_cherry_pick(int argc, const char **argv)

The porcelain itself, but the sequencer wants to call it.

>  {
>  	struct rev_info revs;
> +	int res;
> =20
>  	git_config(git_default_config, NULL);
>  	me =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
> @@ -579,17 +601,15 @@ static int revert_or_cherry_pick(int argc, cons=
t char **argv)
>  			die(_("cherry-pick --ff cannot be used with --edit"));
>  	}
> =20
> -	read_and_refresh_cache(me);
> -	prepare_revs(&revs);
> -
> +	if ((res =3D read_and_refresh_cache(me)) ||
> +		(res =3D prepare_revs(&revs)))
> +		return res;

Clearer to write:

	if (read_and_refresh_cache(me) ||
	    prepare_revs(&revs))
		return -1;

and it has the nice side-effect of making it clear to callers that
they don=E2=80=99t have to worry about return value conventions from th=
ose
functions.

> -	while ((commit =3D get_revision(&revs))) {
> -		int res =3D do_pick_commit();
> -		if (res)
> -			return res;
> -	}
> -
> -	return 0;
> +	while ((commit =3D get_revision(&revs)) &&
> +		!(res =3D do_pick_commit()))
> +		;
> +
> +	return res;

I think the original is clearer here.

>  }
>
[...]
>  How do I trap and handle the exit status from write_message in
>  do_pick_commit correctly?  There's already a call to
>  do_recursive_merge whose exit status is being trapped -- what happen=
s
>  when do_recursive_merge succeeds and write_message fails, or
>  viceversa?

Good question.  See my confused "enum" ramble above.

>  Junio has suggested dropping error_errno, and simply using error and
>  returning -errno by hand in one email.  Considering the number of
>  times I've used that tecnique, and I think we should get something
>  like an error_errno atleast for the sake of terseness.

I do think an error_errno that unconditionally returns -1 (analagous
to die_errno) would be a nice thing to have, even though it wouldn=E2=80=
=99t
make anything much shorter. :)

*whew*

Thanks and hope that helps,
Jonathan
