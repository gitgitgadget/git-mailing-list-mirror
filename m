From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Implement git commit as a builtin command.
Date: Wed, 19 Sep 2007 18:27:29 -0700
Message-ID: <7vk5qmm8hq.fsf@gitster.siamese.dyndns.org>
References: <1190074008617-git-send-email-krh@redhat.com>
	<1190074014548-git-send-email-krh@redhat.com>
	<11900740142347-git-send-email-krh@redhat.com>
	<11900740153845-git-send-email-krh@redhat.com>
	<11900740154136-git-send-email-krh@redhat.com>
	<1190074016669-git-send-email-krh@redhat.com>
	<11900740163661-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 03:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYApY-0007CX-DQ
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 03:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXITB1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2007 21:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbXITB1k
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 21:27:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXITB1i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2007 21:27:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 257051385B0;
	Wed, 19 Sep 2007 21:27:53 -0400 (EDT)
In-Reply-To: <11900740163661-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 17 Sep 2007 20:06:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58746>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> diff --git a/builtin-commit.c b/builtin-commit.c
> new file mode 100644
> index 0000000..ee98de9
> --- /dev/null
> +++ b/builtin-commit.c
> @@ -0,0 +1,740 @@
> +/*
> + * Builtin "git commit"
> + *
> + * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
> + * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +

With 85023577a8f4b540aa64aa37f6f44578c0c305a3 (simplify
inclusion of system header files.), we introduced a rule against
these lines.  We probably would want a Coding Guideline (aka
"Hacking Git") document somewhere.

> +#include "cache.h"
> +#include "cache-tree.h"
> +#include "builtin.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "commit.h"
> +#include "revision.h"
> +#include "wt-status.h"
> +#include "run-command.h"
> +#include "refs.h"
> +#include "log-tree.h"
> +#include "strbuf.h"
> +#include "utf8.h"
> +
> +static const char builtin_commit_usage[] =3D
> +	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <l=
ogfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--=
template <file>] [[-i | -o] <path>...]";
> +
> +static unsigned char head_sha1[20], merge_head_sha1[20];
> +static char *use_message_buffer;
> +static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
> +static struct lock_file lock_file;
> +
> +enum option_type {
> +    OPTION_NONE,
> +    OPTION_STRING,
> +    OPTION_INTEGER,
> +    OPTION_LAST,
> +};
> +
> +struct option {
> +    enum option_type type;
> +    const char *long_name;
> +    char short_name;
> +    void *value;
> +};
> +
> +static int scan_options(const char ***argv, struct option *options)
> +{
> +	const char *value, *eq;
> +	int i;
> +
> +	if (**argv =3D=3D NULL)
> +		return 0;
> +	if ((**argv)[0] !=3D '-')
> +		return 0;
> +	if (!strcmp(**argv, "--"))
> +		return 0;
> +
> +	value =3D NULL;
> +	for (i =3D 0; options[i].type !=3D OPTION_LAST; i++) {
> +		if ((**argv)[1] =3D=3D '-') {
> +			if (!prefixcmp(options[i].long_name, **argv + 2)) {
> +				if (options[i].type !=3D OPTION_NONE)
> +					value =3D *++(*argv);
> +				goto match;
> +			}
> +
> +			eq =3D strchr(**argv + 2, '=3D');
> +			if (eq && options[i].type !=3D OPTION_NONE &&
> +			    !strncmp(**argv + 2,=20
> +				     options[i].long_name, eq - **argv - 2)) {
> +				value =3D eq + 1;
> +				goto match;
> +			}
> +		}
> +
> +		if ((**argv)[1] =3D=3D options[i].short_name) {
> +			if ((**argv)[2] =3D=3D '\0') {
> +				if (options[i].type !=3D OPTION_NONE)
> +					value =3D *++(*argv);
> +				goto match;
> +			}
> +
> +			if (options[i].type !=3D OPTION_NONE) {
> +				value =3D **argv + 2;
> +				goto match;
> +			}
> +		}
> +	}

How do you disambiguate between "--author <me>" and "--amend"?
"The order in *options list matters" is an acceptable answer but
it needs to be documented.

> +
> +	usage(builtin_commit_usage);
> +
> + match:
> +	switch (options[i].type) {
> +	case OPTION_NONE:
> +		*(int *)options[i].value =3D 1;
> +		break;
> +	case OPTION_STRING:
> +		if (value =3D=3D NULL)
> +			die("option %s requires a value.", (*argv)[-1]);
> +		*(const char **)options[i].value =3D value;
> +		break;
> +	case OPTION_INTEGER:
> +		if (value =3D=3D NULL)
> +			die("option %s requires a value.", (*argv)[-1]);
> +		*(int *)options[i].value =3D atoi(value);
> +		break;
> +	default:
> +		assert(0);
> +	}
> +
> +	(*argv)++;
> +
> +	return 1;
> +}

I do not particularly like this OPTION_LAST convention, but that
is a minor detail.  I also suspect in the longer term we might
be better off using getopt() or popt(), but that would be a
larger project.

In any case, if you want to use this option parser, you would
need to add a new file, perhaps parse_options.c, and move this
part there, so that other parts of the system can reuse it.

And the same comment goes for the launch_editor still in
builtin-tag.c.  We should move it to editor.c or something.

> +
> +static char *logfile, *force_author, *message, *template_file;
> +static char *edit_message, *use_message;
> +static int all, edit_flag, also, interactive, only, no_verify, amend=
, signoff;
> +static int quiet, verbose, untracked_files;
> +
> +static int no_edit, initial_commit, in_merge;
> +const char *only_include_assumed;
> +
> +static struct option commit_options[] =3D {
> +	{ OPTION_STRING, "file", 'F', (void *) &logfile },
> +	{ OPTION_NONE, "all", 'a', &all },
> +	{ OPTION_STRING, "author", 0, (void *) &force_author },
> +	{ OPTION_NONE, "edit", 'e', &edit_flag },

Why do some get casted to (void*) and others don't?  It doesn't
seem to have any pattern.  I am puzzled...

> +	{ OPTION_NONE, "include", 'i', &also },
> +	{ OPTION_NONE, "interactive", 0, &interactive },
> +	{ OPTION_NONE, "only", 'o', &only },
> +	{ OPTION_STRING, "message", 'm', &message },
> +	{ OPTION_NONE, "no-verify", 'n', &no_verify },
> +	{ OPTION_NONE, "amend", 0, &amend },
> +	{ OPTION_STRING, "reedit-message", 'c', &edit_message },
> +	{ OPTION_STRING, "reuse-message", 'C', &use_message },
> +	{ OPTION_NONE, "signoff", 's', &signoff },
> +	{ OPTION_NONE, "quiet", 'q', &quiet },
> +	{ OPTION_NONE, "verbose", 'v', &verbose },
> +	{ OPTION_NONE, "untracked-files", 0, &untracked_files },
> +	{ OPTION_STRING, "template", 't', &template_file },
> +	{ OPTION_LAST },
> +};
> +
> +/* FIXME: Taken from builtin-add, should be shared. */

You're darn right.  I thought you have some other patch that
touches builtin-add already...

> +
> +static void update_callback(struct diff_queue_struct *q,
> +			    struct diff_options *opt, void *cbdata)
> +{
> +	int i, verbose;
> +
> +	verbose =3D *((int *)cbdata);
> +	for (i =3D 0; i < q->nr; i++) {
> +		struct diff_filepair *p =3D q->queue[i];
> +		const char *path =3D p->one->path;
> +		switch (p->status) {
> +		default:
> +			die("unexpacted diff status %c", p->status);
> +		case DIFF_STATUS_UNMERGED:
> +		case DIFF_STATUS_MODIFIED:
> +		case DIFF_STATUS_TYPE_CHANGED:
> +			add_file_to_cache(path, verbose);
> +			break;
> +		case DIFF_STATUS_DELETED:
> +			remove_file_from_cache(path);
> +			cache_tree_invalidate_path(active_cache_tree, path);

I've updated remove_file_from_cache() to invalidate the path in
cache-tree so this does not hurt but is no longer necessary.  I
removed this line in the version I queued in 'pu'.

> +			if (verbose)
> +				printf("remove '%s'\n", path);
> +			break;
> +		}
> +	}
> +}
> +
> +static void
> +add_files_to_cache(int fd, const char **files, const char *prefix)
> +{
> +	struct rev_info rev;
> +
> +	init_revisions(&rev, "");
> +	setup_revisions(0, NULL, &rev, NULL);
> +	rev.prune_data =3D get_pathspec(prefix, files);
> +	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback =3D update_callback;
> +	rev.diffopt.format_callback_data =3D &verbose;
> +
> +	run_diff_files(&rev, 0);
> +	refresh_cache(REFRESH_QUIET);

Your update_callback() does add_file_to_cache() which picks up
the stat information from the filesystem already, so I do not
see much point calling refresh_cache() afterwards.  On the other
hand, refreshing before running diff_files() might make sense,
as you can avoid a lot of unnecessary work when you are told to
do "git commit ."

Have you tested this with an unmerged index?

> +
> +	if (write_cache(fd, active_cache, active_nr) || close(fd))
> +		die("unable to write new index file");
> +}
> +
> +static char *
> +prepare_index(const char **files, const char *prefix)
> +{
> +	int fd;
> +	struct tree *tree;
> +	struct lock_file *next_index_lock;
> +
> +	fd =3D hold_locked_index(&lock_file, 1);
> +	if (read_cache() < 0)
> +		die("index file corrupt");
> +
> +	if (all) {
> +		add_files_to_cache(fd, files, NULL);
> +		return lock_file.filename;

Should you be passing files, which is used as pathspec to decide
if your update_callback() should be called, under --all option?

> +	} else if (also) {
> +		add_files_to_cache(fd, files, prefix);
> +		return lock_file.filename;
> +	}
> +
> +	if (interactive)
> +		interactive_add();

Don't you need to

 (1) abort if the user aborts out of interactive add with ^C?
 (2) re-read the index after interactive_add() returns?

> +	if (*files =3D=3D NULL) {
> +		/* Commit index as-is. */
> +		rollback_lock_file(&lock_file);
> +		return get_index_file();
> +	}
> +
> +	/*
> +	 * FIXME: Warn on unknown files.  Shell script does
> +	 *
> +	 *   commit_only=3D`git-ls-files --error-unmatch -- "$@"`
> +	 */

This should be much easier to do than from the shell script, as
you have active_cache[] (aka "the_index.cache[]") in-core.

> +	/*
> +	 * FIXME: shell script does
> +	 *
> +	 *   git-read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
> +	 *
> +	 * which warns about unmerged files in the index.
> +	 */

I think "unmerged warning" is an unintended side effect.  The
point of the command is to have a copy of index, as there is no
way for shell script to work with more than one index at a time
without using a temporary file.

> +
> +	/* update the user index file */
> +	add_files_to_cache(fd, files, prefix);
> +
> +	if (!initial_commit) {
> +		tree =3D parse_tree_indirect(head_sha1);
> +		if (!tree)
> +			die("failed to unpack HEAD tree object");
> +		if (read_tree(tree, 0, NULL))
> +			die("failed to read HEAD tree object");
> +	}

Huh?  Doesn't this read_tree() defeat the add_files_to_cache()
you did earlier?

> +
> +	/* Uh oh, abusing lock_file to create a garbage collected file */
> +	next_index_lock =3D xmalloc(sizeof(*next_index_lock));
> +	fd =3D hold_lock_file_for_update(next_index_lock,
> +				       git_path("next-index-%d", getpid()), 1);

That's not an abuse, but I wonder what happened to the fd you
got at the beginning of the function.

> +	add_files_to_cache(fd, files, prefix);

and then this is puzzling to me.

I am starting to suspect that you might be better off if you do
not follow the use of temporary index file that was in the shell
script version to the letter.  You can use more than one index
in the core at the same time, now you are built-in.

> +
> +	return next_index_lock->filename;
> +}

=2E.. and if we were to go that route, wt_status structure would
have a pointer to the "struct index_state" instead of the
filename of the index... oops, wt_status_print() will discard
and re-read the cache from file, so that approach would not work
right now without fixing wt-status first.  Hmm.

> +static int run_status(FILE *fp, const char *index_file)
> +{
> +	struct wt_status s;
> +
> +	wt_status_prepare(&s);
> +
> +	if (amend) {
> +		s.amend =3D 1;
> +		s.reference =3D "HEAD^1";
> +	}
> +	s.verbose =3D verbose;
> +	s.untracked =3D untracked_files;
> +	s.index_file =3D index_file;
> +	s.fp =3D fp;
> +
> +	wt_status_print(&s);
> +
> +	return s.commitable;
> +}

I did not look at the rest of the patch; it should be either
obviously correct or outright incorrect --- anybody would notice
the breakage immediately.

The prepare_index() part is the most (and only) "interesting"
part of the puzzle.  I need to look at this again and think
about it a bit more.  It needs to:

 * save the current index and restore in case the whole
   "git-commit" is aborted in any way (e.g. ^C, empty log
   message from the editor); This is easy to do from C with
   hold_locked_index().

 * when doing a partial commit,
   - read HEAD in a temporary index, if not initial commit;
   - update the temporary index with the given paths;
   - write out the temporary index as a tree to build a commit;

   - update the real index the same way with the given paths;
   - if all goes well, commit the updated real index; again,
     this is easy in C with commit_locked_index();

 * when not doing a partial commit,
   - update the real index with given paths (if "--also") or all
     what diff-files reports (if "--all");
   - write out the real index as a tree to build a commit;
   - if all goes well, commit the updated real index; again,
     this is easy in C with commit_locked_index();

A thing to keep in mind is that you can write out the temporary
index as a tree from the core without writing it out first to a
temporary index file at all.  Perhaps the code should be
structured like this.

    - parse options and all the other necessary setup;

    - hold_locked_index() to lock the "real" index;

    - prepare_index() is responsibile for doing two things

      1. build, write out and return the tree object to be
         committed;

      2. leave the_index[] in the state to become the "real"
         index if this commit command is not aborted;

    - take the tree object, put commit log message around it and
      make a commit object;

    - commit_locked_index() to write out the "real" index.

Now, the task #1 for prepare_index() is simpler for "also" and
"all" case.  You do the equivalent of "git-add -u" or "git add
<path>" and run cache_tree_update() to write out the tree, and
when you are done, both the_index.cache and the_index.cache_tree
are up-to-date, ready to be written out by the caller at the
very end.

=46or a partial commit, the task is a bit more convoluted, as
writing out the tree needs to be done from outside the_index.  I
would say something like this:

	int prepare_index(unsigned char *sha1) {
		if (partial commit) {
                       struct index_state tmp_index;

                       /* "temporary index" only in-core */
                       memset(&tmp_index, 0, sizeof(tmp_index));
                       read_index(&tmp_index);
                       add_files_to_index(files, prefix, &tmp_index);
                       write_index_as_tree(&tmp_index, sha1);
                       discard_index(&tmp_index);

                       /* update the index the same way */
                       add_files_to_index(files, prefix, &the_index);
                       return ok;
		}
                /* otherwise */
                if (files && *files)
                	add_files_to_index(files, prefix, &the_index);
		else if (all)
                	add_files_to_index(NULL, prefix, &the_index);
		write_index_as_tree(&the_index, sha1);
                return ok;
	}

where

 * add_files_to_index() is similar to your add_files_to_cache()
   but takes struct index_state; the callback can still diff
   with the_index.cache (aka active_cache) as that diff is what
   we are interested in updating anyway;

 * write_index_as_tree() would be a new function that takes
   struct index_state and writes that as a tree.  It would
   essentially be the builtin-write-tree.c::write_tree()
   function except the opening and reading the index (or
   updating the cache-tree) part, something like:

write_index_as_tree(struct index_state *istate, unsigned char *sha1)
{
       	if (!cache_tree_fully_valid(istate->cache_tree))
        	cache_tree_update(istate->cache_tree,
                		  istate->cache,
                                  istate->cache_nr, 0, 0);
	hashcpy(sha1, istate->cache_tree->sha1);
}
