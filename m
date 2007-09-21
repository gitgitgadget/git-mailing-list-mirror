From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 7/7] Implement git commit as a builtin command.
Date: Fri, 21 Sep 2007 13:18:08 -0400
Message-ID: <1190395088.31494.55.camel@hinata.boston.redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
	 <1190074014548-git-send-email-krh@redhat.com>
	 <11900740142347-git-send-email-krh@redhat.com>
	 <11900740153845-git-send-email-krh@redhat.com>
	 <11900740154136-git-send-email-krh@redhat.com>
	 <1190074016669-git-send-email-krh@redhat.com>
	 <11900740163661-git-send-email-krh@redhat.com>
	 <7vk5qmm8hq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:33:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYmNm-0007UW-4o
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 19:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759172AbXIURdc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759082AbXIURdc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 13:33:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758531AbXIURda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 13:33:30 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8LHIHNe002081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Sep 2007 13:18:17 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LHIG9R019229;
	Fri, 21 Sep 2007 13:18:16 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LHID5e031100;
	Fri, 21 Sep 2007 13:18:16 -0400
In-Reply-To: <7vk5qmm8hq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58864>

On Wed, 2007-09-19 at 18:27 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > diff --git a/builtin-commit.c b/builtin-commit.c
> > new file mode 100644
> > index 0000000..ee98de9
> > --- /dev/null
> > +++ b/builtin-commit.c
> > @@ -0,0 +1,740 @@
> > +/*
> > + * Builtin "git commit"
> > + *
> > + * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
> > + * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
> > + */
> > +
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <unistd.h>
> > +
>=20
> With 85023577a8f4b540aa64aa37f6f44578c0c305a3 (simplify
> inclusion of system header files.), we introduced a rule against
> these lines.  We probably would want a Coding Guideline (aka
> "Hacking Git") document somewhere.

Ok.  I see you removed them in the pu commit, thanks.

> > +#include "cache.h"
> > +#include "cache-tree.h"
> > +#include "builtin.h"
> > +#include "diff.h"
> > +#include "diffcore.h"
> > +#include "commit.h"
> > +#include "revision.h"
> > +#include "wt-status.h"
> > +#include "run-command.h"
> > +#include "refs.h"
> > +#include "log-tree.h"
> > +#include "strbuf.h"
> > +#include "utf8.h"
> > +
> > +static const char builtin_commit_usage[] =3D
> > +	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F =
<logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [=
--template <file>] [[-i | -o] <path>...]";
> > +
> > +static unsigned char head_sha1[20], merge_head_sha1[20];
> > +static char *use_message_buffer;
> > +static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
> > +static struct lock_file lock_file;
> > +
> > +enum option_type {
> > +    OPTION_NONE,
> > +    OPTION_STRING,
> > +    OPTION_INTEGER,
> > +    OPTION_LAST,
> > +};
> > +
> > +struct option {
> > +    enum option_type type;
> > +    const char *long_name;
> > +    char short_name;
> > +    void *value;
> > +};
> > +
> > +static int scan_options(const char ***argv, struct option *options=
)
> > +{
> > +	const char *value, *eq;
> > +	int i;
> > +
> > +	if (**argv =3D=3D NULL)
> > +		return 0;
> > +	if ((**argv)[0] !=3D '-')
> > +		return 0;
> > +	if (!strcmp(**argv, "--"))
> > +		return 0;
> > +
> > +	value =3D NULL;
> > +	for (i =3D 0; options[i].type !=3D OPTION_LAST; i++) {
> > +		if ((**argv)[1] =3D=3D '-') {
> > +			if (!prefixcmp(options[i].long_name, **argv + 2)) {
> > +				if (options[i].type !=3D OPTION_NONE)
> > +					value =3D *++(*argv);
> > +				goto match;
> > +			}
> > +
> > +			eq =3D strchr(**argv + 2, '=3D');
> > +			if (eq && options[i].type !=3D OPTION_NONE &&
> > +			    !strncmp(**argv + 2,=20
> > +				     options[i].long_name, eq - **argv - 2)) {
> > +				value =3D eq + 1;
> > +				goto match;
> > +			}
> > +		}
> > +
> > +		if ((**argv)[1] =3D=3D options[i].short_name) {
> > +			if ((**argv)[2] =3D=3D '\0') {
> > +				if (options[i].type !=3D OPTION_NONE)
> > +					value =3D *++(*argv);
> > +				goto match;
> > +			}
> > +
> > +			if (options[i].type !=3D OPTION_NONE) {
> > +				value =3D **argv + 2;
> > +				goto match;
> > +			}
> > +		}
> > +	}
>=20
> How do you disambiguate between "--author <me>" and "--amend"?
> "The order in *options list matters" is an acceptable answer but
> it needs to be documented.

Yes, the order matters.  I made sure the C version has the same
precedence as the shell script.  I'll add a comment in parse-options.h.

> > +
> > +	usage(builtin_commit_usage);
> > +
> > + match:
> > +	switch (options[i].type) {
> > +	case OPTION_NONE:
> > +		*(int *)options[i].value =3D 1;
> > +		break;
> > +	case OPTION_STRING:
> > +		if (value =3D=3D NULL)
> > +			die("option %s requires a value.", (*argv)[-1]);
> > +		*(const char **)options[i].value =3D value;
> > +		break;
> > +	case OPTION_INTEGER:
> > +		if (value =3D=3D NULL)
> > +			die("option %s requires a value.", (*argv)[-1]);
> > +		*(int *)options[i].value =3D atoi(value);
> > +		break;
> > +	default:
> > +		assert(0);
> > +	}
> > +
> > +	(*argv)++;
> > +
> > +	return 1;
> > +}
>=20
> I do not particularly like this OPTION_LAST convention, but that
> is a minor detail.  I also suspect in the longer term we might
> be better off using getopt() or popt(), but that would be a
> larger project.
>=20
> In any case, if you want to use this option parser, you would
> need to add a new file, perhaps parse_options.c, and move this
> part there, so that other parts of the system can reuse it.

I'll split it out in parse-options.[ch].  I still don't understand why
using getopt is better; parse-options.c is a 75 line file and it's
simple code.  It does more work that getopt, since for most options it
automatically writes back the option argument into a global.  All I hav=
e
to do then is validate that no illegal combination of options was
passed.

> And the same comment goes for the launch_editor still in
> builtin-tag.c.  We should move it to editor.c or something.

Yeah.

> > +
> > +static char *logfile, *force_author, *message, *template_file;
> > +static char *edit_message, *use_message;
> > +static int all, edit_flag, also, interactive, only, no_verify, ame=
nd, signoff;
> > +static int quiet, verbose, untracked_files;
> > +
> > +static int no_edit, initial_commit, in_merge;
> > +const char *only_include_assumed;
> > +
> > +static struct option commit_options[] =3D {
> > +	{ OPTION_STRING, "file", 'F', (void *) &logfile },
> > +	{ OPTION_NONE, "all", 'a', &all },
> > +	{ OPTION_STRING, "author", 0, (void *) &force_author },
> > +	{ OPTION_NONE, "edit", 'e', &edit_flag },
>=20
> Why do some get casted to (void*) and others don't?  It doesn't
> seem to have any pattern.  I am puzzled...

Yes, oops, not sure what that was about.

> > +	{ OPTION_NONE, "include", 'i', &also },
> > +	{ OPTION_NONE, "interactive", 0, &interactive },
> > +	{ OPTION_NONE, "only", 'o', &only },
> > +	{ OPTION_STRING, "message", 'm', &message },
> > +	{ OPTION_NONE, "no-verify", 'n', &no_verify },
> > +	{ OPTION_NONE, "amend", 0, &amend },
> > +	{ OPTION_STRING, "reedit-message", 'c', &edit_message },
> > +	{ OPTION_STRING, "reuse-message", 'C', &use_message },
> > +	{ OPTION_NONE, "signoff", 's', &signoff },
> > +	{ OPTION_NONE, "quiet", 'q', &quiet },
> > +	{ OPTION_NONE, "verbose", 'v', &verbose },
> > +	{ OPTION_NONE, "untracked-files", 0, &untracked_files },
> > +	{ OPTION_STRING, "template", 't', &template_file },
> > +	{ OPTION_LAST },
> > +};
> > +
> > +/* FIXME: Taken from builtin-add, should be shared. */
>=20
> You're darn right.  I thought you have some other patch that
> touches builtin-add already...

Yeah, I'll fix that.

> > +
> > +static void update_callback(struct diff_queue_struct *q,
> > +			    struct diff_options *opt, void *cbdata)
> > +{
> > +	int i, verbose;
> > +
> > +	verbose =3D *((int *)cbdata);
> > +	for (i =3D 0; i < q->nr; i++) {
> > +		struct diff_filepair *p =3D q->queue[i];
> > +		const char *path =3D p->one->path;
> > +		switch (p->status) {
> > +		default:
> > +			die("unexpacted diff status %c", p->status);
> > +		case DIFF_STATUS_UNMERGED:
> > +		case DIFF_STATUS_MODIFIED:
> > +		case DIFF_STATUS_TYPE_CHANGED:
> > +			add_file_to_cache(path, verbose);
> > +			break;
> > +		case DIFF_STATUS_DELETED:
> > +			remove_file_from_cache(path);
> > +			cache_tree_invalidate_path(active_cache_tree, path);
>=20
> I've updated remove_file_from_cache() to invalidate the path in
> cache-tree so this does not hurt but is no longer necessary.  I
> removed this line in the version I queued in 'pu'.
>=20
> > +			if (verbose)
> > +				printf("remove '%s'\n", path);
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static void
> > +add_files_to_cache(int fd, const char **files, const char *prefix)
> > +{
> > +	struct rev_info rev;
> > +
> > +	init_revisions(&rev, "");
> > +	setup_revisions(0, NULL, &rev, NULL);
> > +	rev.prune_data =3D get_pathspec(prefix, files);
> > +	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
> > +	rev.diffopt.format_callback =3D update_callback;
> > +	rev.diffopt.format_callback_data =3D &verbose;
> > +
> > +	run_diff_files(&rev, 0);
> > +	refresh_cache(REFRESH_QUIET);
>=20
> Your update_callback() does add_file_to_cache() which picks up
> the stat information from the filesystem already, so I do not
> see much point calling refresh_cache() afterwards.  On the other
> hand, refreshing before running diff_files() might make sense,
> as you can avoid a lot of unnecessary work when you are told to
> do "git commit ."

I didn't have refresh_cache() in there originally, there was some test
case that didn't pass until I added it.  The git-commit.sh shell script
calls git update-index --refresh after the prepare_index() part, which
is where I got it from.  Will investigate.

> Have you tested this with an unmerged index?

Not yet.

> > +
> > +	if (write_cache(fd, active_cache, active_nr) || close(fd))
> > +		die("unable to write new index file");
> > +}
> > +
> > +static char *
> > +prepare_index(const char **files, const char *prefix)
> > +{
> > +	int fd;
> > +	struct tree *tree;
> > +	struct lock_file *next_index_lock;
> > +
> > +	fd =3D hold_locked_index(&lock_file, 1);
> > +	if (read_cache() < 0)
> > +		die("index file corrupt");
> > +
> > +	if (all) {
> > +		add_files_to_cache(fd, files, NULL);
> > +		return lock_file.filename;
>=20
> Should you be passing files, which is used as pathspec to decide
> if your update_callback() should be called, under --all option?

Oh... hmm, if 'all' is set there are no paths, but yes, that is
confusing.

> > +	} else if (also) {
> > +		add_files_to_cache(fd, files, prefix);
> > +		return lock_file.filename;
> > +	}
> > +
> > +	if (interactive)
> > +		interactive_add();
>=20
> Don't you need to
>=20
>  (1) abort if the user aborts out of interactive add with ^C?
>  (2) re-read the index after interactive_add() returns?

Uhm, yes, good points.

> > +	if (*files =3D=3D NULL) {
> > +		/* Commit index as-is. */
> > +		rollback_lock_file(&lock_file);
> > +		return get_index_file();
> > +	}
> > +
> > +	/*
> > +	 * FIXME: Warn on unknown files.  Shell script does
> > +	 *
> > +	 *   commit_only=3D`git-ls-files --error-unmatch -- "$@"`
> > +	 */
>=20
> This should be much easier to do than from the shell script, as
> you have active_cache[] (aka "the_index.cache[]") in-core.
>=20
> > +	/*
> > +	 * FIXME: shell script does
> > +	 *
> > +	 *   git-read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
> > +	 *
> > +	 * which warns about unmerged files in the index.
> > +	 */
>=20
> I think "unmerged warning" is an unintended side effect.  The
> point of the command is to have a copy of index, as there is no
> way for shell script to work with more than one index at a time
> without using a temporary file.

Yes, we talked about this in IRC a few weeks back, and agreed that just
read_tree() should be fine.  I'll just remove that FIXME.

> > +
> > +	/* update the user index file */
> > +	add_files_to_cache(fd, files, prefix);
> > +
> > +	if (!initial_commit) {
> > +		tree =3D parse_tree_indirect(head_sha1);
> > +		if (!tree)
> > +			die("failed to unpack HEAD tree object");
> > +		if (read_tree(tree, 0, NULL))
> > +			die("failed to read HEAD tree object");
> > +	}
>=20
> Huh?  Doesn't this read_tree() defeat the add_files_to_cache()
> you did earlier?

This is the case where we add the files on the command line
to .git/index, but commit from a clean index file corresponding to HEAD
with the files from the command line added (partial commit?).  The firs=
t
add_files_to_cache() updates .git/index, then we do read_tree() to buil=
d
a tmp index from HEAD and then we add the files again.  The tmp index i=
s
written to a tmp index file.

> > +
> > +	/* Uh oh, abusing lock_file to create a garbage collected file */
> > +	next_index_lock =3D xmalloc(sizeof(*next_index_lock));
> > +	fd =3D hold_lock_file_for_update(next_index_lock,
> > +				       git_path("next-index-%d", getpid()), 1);
>=20
> That's not an abuse, but I wonder what happened to the fd you
> got at the beginning of the function.

Ugh, yeah, that's a bit ugly... it gets closed in add_files_to_cache()
once we've written the index.  The patch I have here uses the
add_files_to_cache() from builtin-add.c which doesn't close the fd or
write the index.  That now happens in prepare_index(), so it's a little
clearer what's going on.

> > +	add_files_to_cache(fd, files, prefix);
>=20
> and then this is puzzling to me.
>=20
> I am starting to suspect that you might be better off if you do
> not follow the use of temporary index file that was in the shell
> script version to the letter.  You can use more than one index
> in the core at the same time, now you are built-in.

As described above, we need to add the files to the user index and the
temporary index we're committing from.  As for just using an in-memory
index, I wanted to do it that way originally, but you have to write it
to disk after all for the pre-commit hook.  Maybe doing it in-memory is
better after all, and then only write it to disk if we actually have a
pre-commit hook.

> > +
> > +	return next_index_lock->filename;
> > +}
>=20
> ... and if we were to go that route, wt_status structure would
> have a pointer to the "struct index_state" instead of the
> filename of the index... oops, wt_status_print() will discard
> and re-read the cache from file, so that approach would not work
> right now without fixing wt-status first.  Hmm.

Yep, that was the other reason.  I suppose a short term fix for this
would be to make run_status() take a struct index_state and write it to
a temp file and run against that.  We can then clean that up to not use
a temp file in a second patch.

> > +static int run_status(FILE *fp, const char *index_file)
> > +{
> > +	struct wt_status s;
> > +
> > +	wt_status_prepare(&s);
> > +
> > +	if (amend) {
> > +		s.amend =3D 1;
> > +		s.reference =3D "HEAD^1";
> > +	}
> > +	s.verbose =3D verbose;
> > +	s.untracked =3D untracked_files;
> > +	s.index_file =3D index_file;
> > +	s.fp =3D fp;
> > +
> > +	wt_status_print(&s);
> > +
> > +	return s.commitable;
> > +}
>=20
> I did not look at the rest of the patch; it should be either
> obviously correct or outright incorrect --- anybody would notice
> the breakage immediately.
>=20
> The prepare_index() part is the most (and only) "interesting"
> part of the puzzle.  I need to look at this again and think
> about it a bit more.  It needs to:
>=20
>  * save the current index and restore in case the whole
>    "git-commit" is aborted in any way (e.g. ^C, empty log
>    message from the editor); This is easy to do from C with
>    hold_locked_index().

This is working in the current version.  I use hold_locked_index() in
the beginning of prepare_index() and calls commit_locked_index() to
write the new index at the end of cmd_commit() once the commit is done.

>  * when doing a partial commit,
>    - read HEAD in a temporary index, if not initial commit;
>    - update the temporary index with the given paths;
>    - write out the temporary index as a tree to build a commit;
>=20
>    - update the real index the same way with the given paths;
>    - if all goes well, commit the updated real index; again,
>      this is easy in C with commit_locked_index();

prepare_index() does this, that's the case you pointed out above, where
I'm calling add_files_to_cache() twice.

>  * when not doing a partial commit,
>    - update the real index with given paths (if "--also") or all
>      what diff-files reports (if "--all");
>    - write out the real index as a tree to build a commit;
>    - if all goes well, commit the updated real index; again,
>      this is easy in C with commit_locked_index();

This is also in prepare_index() - the 'if (all)' and 'if (also)' cases
in the beginning of the function does that, except commiting the the
updated real index, that's done at the end of cmd_commit(), share among
all cases.

> A thing to keep in mind is that you can write out the temporary
> index as a tree from the core without writing it out first to a
> temporary index file at all.  Perhaps the code should be
> structured like this.
>=20
>     - parse options and all the other necessary setup;
>=20
>     - hold_locked_index() to lock the "real" index;
>=20
>     - prepare_index() is responsibile for doing two things
>=20
>       1. build, write out and return the tree object to be
>          committed;
>=20
>       2. leave the_index[] in the state to become the "real"
>          index if this commit command is not aborted;
>=20
>     - take the tree object, put commit log message around it and
>       make a commit object;
>=20
>     - commit_locked_index() to write out the "real" index.
>=20
> Now, the task #1 for prepare_index() is simpler for "also" and
> "all" case.  You do the equivalent of "git-add -u" or "git add
> <path>" and run cache_tree_update() to write out the tree, and
> when you are done, both the_index.cache and the_index.cache_tree
> are up-to-date, ready to be written out by the caller at the
> very end.

Yes, but isn't that what the code is doing now?  I write out the tree i=
n
cmd_commit(), not in prepare_index(), but prepare_index() is also used
in cmd_status().  It seems better to only write the tree if we're going
to do a commit.  Other than that, the flow of the code follows your
description pretty much step by step.

> For a partial commit, the task is a bit more convoluted, as
> writing out the tree needs to be done from outside the_index.  I
> would say something like this:
>=20
> 	int prepare_index(unsigned char *sha1) {
> 		if (partial commit) {
>                        struct index_state tmp_index;
>=20
>                        /* "temporary index" only in-core */
>                        memset(&tmp_index, 0, sizeof(tmp_index));
>                        read_index(&tmp_index);
>                        add_files_to_index(files, prefix, &tmp_index);
>                        write_index_as_tree(&tmp_index, sha1);
>                        discard_index(&tmp_index);
>=20
>                        /* update the index the same way */
>                        add_files_to_index(files, prefix, &the_index);
>                        return ok;
> 		}
>                 /* otherwise */
>                 if (files && *files)
>                 	add_files_to_index(files, prefix, &the_index);
> 		else if (all)
>                 	add_files_to_index(NULL, prefix, &the_index);
> 		write_index_as_tree(&the_index, sha1);
>                 return ok;
> 	}
>=20
> where
>=20
>  * add_files_to_index() is similar to your add_files_to_cache()
>    but takes struct index_state; the callback can still diff
>    with the_index.cache (aka active_cache) as that diff is what
>    we are interested in updating anyway;
>=20
>  * write_index_as_tree() would be a new function that takes
>    struct index_state and writes that as a tree.  It would
>    essentially be the builtin-write-tree.c::write_tree()
>    function except the opening and reading the index (or
>    updating the cache-tree) part, something like:
>=20
> write_index_as_tree(struct index_state *istate, unsigned char *sha1)
> {
>        	if (!cache_tree_fully_valid(istate->cache_tree))
>         	cache_tree_update(istate->cache_tree,
>                 		  istate->cache,
>                                   istate->cache_nr, 0, 0);
> 	hashcpy(sha1, istate->cache_tree->sha1);
> }

That looks nicer, the add_files_to_index() function is a pretty clean
solution.  But again, we can't write the tree in prepare_index(); we
need the temporary index for the pre-commit hook, and prepare_index() i=
s
used in cmd_status().  But we can just return an struct index_state
pointer from prepare_index().

Thanks for reviewing,
Kristian
