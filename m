From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 06/17] rebase-am: introduce am backend for
 builtin rebase
Date: Wed, 16 Mar 2016 14:21:16 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603160905230.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:21:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agBOH-0007t9-5I
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 14:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966080AbcCPNV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 09:21:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:63155 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965315AbcCPNV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 09:21:26 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LoEcP-1a91IS16ZF-00gDZa; Wed, 16 Mar 2016 14:21:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457779597-6918-7-git-send-email-pyokagan@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:h7JofYki9YORcpgMZjgcI5McjWCFQpOgAmppWaD4qzAx0rIi1AE
 5IbDcbmCGyTU6n7lQsD5D2ID95wIFwY1MGEuvgjWd7RPOzerkh7MI+FJlbvZ9kOW/PNUeu6
 Vavx1P4gZ/BQWMHKqIX6JMoQzLs/63Jfysl2cq6S3t/meYXaSRWjE4fqFLYYVN/7obBryUf
 ARm15h/VbVIq/B89dEFGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:93sk+bW26uU=:3VyMcSkIY/WNFUnBa/Ii/X
 swFZqg0kpqnzrIbu1x1X7mYurntqdaro5JSn7YgtQhAyP/ab1xPHhu2hp+Rns2LidRHsmTOO3
 49PxQZgmahLt2NIqZ8N0pByRSvdeuXc52QhlGQtcs2ea+yWA/yGYsSKmdc184jhUa50v1RYoa
 fO7u5Yr5O7su3ox/0GVEXbczrtlrc1C0WOGC1O5VxBowPZunbsLlopU1lPAEQk/pSNSKRpun/
 appmB/O+HCWl5V9flz8N+G8fgoJUZ71nZ+vWpeLxKH6EPqVdaS6U/kP9sBCmDXc1UGil2Zf+T
 R1OixtJIHTei6lQQ7VW5B5tnioyYZDuVeYrvXG8gqKCvRSKlJHu5Z5EVVr0211lEeSSlxgj51
 t8O05otyBt7uJrl0cj5Ktv6ZLH2jvdo1UJpAhKaqych3GVe43dDc9pxf7Cd7ZP9Zefualafq0
 sKMb1BgI0jQ1LUxn1DCxbzfpLBeo9L8Tv/iQwBkxmlW5mbC1vZlITmZBkV4aPtRd7ScdOjKZV
 Z1BhXky6lNsUzL1TVDFLP9JO5wcQU834aJZWcp9t+8Lh1O1/rAJyPaU3QWgpi40UFmmCqnczh
 eL35tZNUtrMGUOYn1QZVHrPKV/HDWBF4RX1Zyktrj1938/YYpNtzhDXeGACnIEAiFPGkqw1tp
 DxBG4JPZFbVWipFFcvushawQlDj6Lph6qOYHBjDxEmGbqjmTUNUHev86Ygio8K+Z/mKxj2S+F
 NdK1McfQOwhBRmKngQYz79YLtRAdLuWhU1AYk3efGArMhy//hF00T1btilo299eArvf1Rfuu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288970>

Hi Paul,

On Sat, 12 Mar 2016, Paul Tan wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 40176ca..ec63d3b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -8,6 +8,22 @@
>  #include "remote.h"
>  #include "branch.h"
>  #include "refs.h"
> +#include "rebase-am.h"
> +
> +enum rebase_type {
> +	REBASE_TYPE_NONE = 0,
> +	REBASE_TYPE_AM
> +};
> +
> +static const char *rebase_dir(enum rebase_type type)
> +{
> +	switch (type) {
> +	case REBASE_TYPE_AM:
> +		return git_path_rebase_am_dir();
> +	default:
> +		die("BUG: invalid rebase_type %d", type);
> +	}
> +}

This is awfully close to what the sequencer sports. So close that I would
call it technical debt.

It would most likely result in easier-to-maintain source code if the
sequencer and the rebase code shared as much as possible (in
sequencer.[ch], for historical reasons).


> diff --git a/rebase-am.c b/rebase-am.c
> new file mode 100644
> index 0000000..53e8798
> --- /dev/null
> +++ b/rebase-am.c
> @@ -0,0 +1,110 @@
> +#include "cache.h"
> +#include "rebase-am.h"
> +#include "run-command.h"
> +
> +GIT_PATH_FUNC(git_path_rebase_am_dir, "rebase-apply");
> +
> +void rebase_am_init(struct rebase_am *state, const char *dir)
> +{
> +	if (!dir)
> +		dir = git_path_rebase_am_dir();
> +	rebase_options_init(&state->opts);
> +	state->dir = xstrdup(dir);
> +}

Does it really make sense to have completely separate structs for the
different rebase types? I think not. It would not hurt IMO to have a
couple of fields that are only used for certain rebase types but not
others. The benefit of being able to reuse, code would far outweigh that
minimal cost.

It all comes back to my favorite paradigm: DRY. Don't Repeat Yourself.

Another important paradigm is: avoid feautures that you do not use. In
this instance, I have to ask why the init function accepts the "dir"
parameter? Do we ever need it? And if yes, would it make more sense to
introduce the parameter with the patch that actually uses it?

> +
> +void rebase_am_release(struct rebase_am *state)
> +{
> +	rebase_options_release(&state->opts);
> +	free(state->dir);

Urgh. The only reason for this free() and the corresponding xstrdup() is
so that the caller *may* release the directory before finishing the rebase
*if* it overrides the directory. That's not very elegant.

Why not simply state (by declaring the field as const char *) that it is
*not* the rebase machinery's duty to take care of the memory management of
this string?

This would simplify the common code flow, especially if it was done to
*all* strings in the state struct.

> +int rebase_am_in_progress(const struct rebase_am *state)
> +{
> +	const char *dir = state ? state->dir : git_path_rebase_am_dir();
> +	struct stat st;
> +
> +	return !lstat(dir, &st) && S_ISDIR(st.st_mode);
> +}

This function is sobbing inconsolably for being stuck into the rebase-am
part of the code, with a name that ensures that it will never grow up and
become more useful. Between its miserable life, it dreams of being named
dir_exists() and living the high life next to its buddy, file_exists().

> +int rebase_am_load(struct rebase_am *state)
> +{
> +	if (rebase_options_load(&state->opts, state->dir) < 0)
> +		return -1;
> +
> +	return 0;
> +}

:-(

This looks like adding code for adding code's sake. Not only does it craft
its own return value instead of reusing rebase_options_load()'s, it is
just wrapping a single, simple statement, therefore its only use is to add
one layer of indirection.

> +static int run_format_patch(const char *patches, const struct object_id *left,
> +		const struct object_id *right)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int ret;
> +
> +	cp.git_cmd = 1;
> +	cp.out = xopen(patches, O_WRONLY | O_CREAT, 0777);
> +	argv_array_push(&cp.args, "format-patch");
> +	argv_array_push(&cp.args, "-k");
> +	argv_array_push(&cp.args, "--stdout");
> +	argv_array_push(&cp.args, "--full-index");
> +	argv_array_push(&cp.args, "--cherry-pick");
> +	argv_array_push(&cp.args, "--right-only");
> +	argv_array_push(&cp.args, "--src-prefix=a/");
> +	argv_array_push(&cp.args, "--dst-prefix=b/");
> +	argv_array_push(&cp.args, "--no-renames");
> +	argv_array_push(&cp.args, "--no-cover-letter");
> +	argv_array_pushf(&cp.args, "%s...%s", oid_to_hex(left), oid_to_hex(right));
> +
> +	ret = run_command(&cp);
> +	close(cp.out);
> +	return ret;
> +}
> +
> +static int run_am(const struct rebase_am *state, const char *patches)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int ret;
> +
> +	cp.git_cmd = 1;
> +	cp.in = xopen(patches, O_RDONLY);
> +	argv_array_push(&cp.args, "am");
> +	argv_array_push(&cp.args, "--rebasing");
> +	if (state->opts.resolvemsg)
> +		argv_array_pushf(&cp.args, "--resolvemsg=%s", state->opts.resolvemsg);
> +
> +	ret = run_command(&cp);
> +	close(cp.in);
> +	return ret;
> +}

Yeah, these functions really want to use libification for the full, raw
speed improvement that we are going for.

And rather than following the shell script slavishly, we should *really*
consider doing better: the shell script cannot access Git's data
structures directly, therefore it has to use this roundabout way: format
patches as a mailbox only to parse it back into the individual patches
that libgit.a already had available when it formatted the mailbox.

This consideration is pretty important: I do not think that the current
function signatures are correct with that end goal in mind.

> +void rebase_am_run(struct rebase_am *state)
> +{
> +	char *patches;
> +	int ret;
> +
> +	rebase_common_setup(&state->opts, state->dir);
> +
> +	patches = git_pathdup("rebased-patches");
> +	ret = run_format_patch(patches, &state->opts.upstream, &state->opts.orig_head);

Let's wrap the lines at 80 columns/row.

> +	if (ret) {
> +		unlink_or_warn(patches);
> +		fprintf_ln(stderr, _("\ngit encountered an error while preparing the patches to replay\n"
> +			"these revisions:\n"

Also here, the common way to do this is:

		fprintf_ln(stderr, _("\ngit encountered an error while "
				"preparing the patches to replay\n"
			"these revisions:\n"
			[...]

> diff --git a/rebase-common.c b/rebase-common.c
> index 1835f08..8169fb6 100644
> --- a/rebase-common.c
> +++ b/rebase-common.c
> @@ -1,5 +1,8 @@
>  #include "cache.h"
>  #include "rebase-common.h"
> +#include "dir.h"
> +#include "run-command.h"
> +#include "refs.h"
>  
>  void rebase_options_init(struct rebase_options *opts)
>  {
> @@ -95,3 +98,81 @@ void rebase_options_save(const struct rebase_options *opts, const char *dir)
>  	write_state_text(dir, "onto", oid_to_hex(&opts->onto));
>  	write_state_text(dir, "orig-head", oid_to_hex(&opts->orig_head));
>  }
> +
> +static int detach_head(const struct object_id *commit, const char *onto_name)
> +{

Again, this is a very sad function. It would like to work for so many
commands, but it is stuck into the rebase-common.c file where nobody ever
cares about it.

A better place might be branch.[ch], maybe even under a better name
(although this is a matter of contention, as many Git old-timers have an
intuitive understanding of what "detached HEAD" means that is not at all
shared by new Git users).

> +	const char *reflog_action = getenv("GIT_REFLOG_ACTION");
> +	if (!reflog_action || !*reflog_action)
> +		reflog_action = "rebase";
> +	cp.git_cmd = 1;
> +	argv_array_pushf(&cp.env_array, "GIT_REFLOG_ACTION=%s: checkout %s",
> +			reflog_action, onto_name ? onto_name : oid_to_hex(commit));

The REFLOG_ACTION code seems to be a prime candidate for simplification
through a simple, small function owning a static strbuf.

> +void rebase_common_setup(struct rebase_options *opts, const char *dir)
> +{
> +	/* Detach HEAD and reset the tree */
> +	printf_ln(_("First, rewinding head to replay your work on top of it..."));
> +	if (detach_head(&opts->onto, opts->onto_name))
> +		die(_("could not detach HEAD"));
> +	update_ref("rebase", "ORIG_HEAD", opts->orig_head.hash, NULL, 0,
> +			UPDATE_REFS_DIE_ON_ERR);
> +}

If we were to truly reuse the setup between rebase types (and really
preferably extend sequencer's already existing code), we could imitate the
existing "rebase (am)" reflog message.

> +void rebase_common_destroy(struct rebase_options *opts, const char *dir)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_addstr(&sb, dir);
> +	remove_dir_recursively(&sb, 0);
> +	strbuf_release(&sb);
> +}

It is *really* fragile to separate the directory from the rebase options.
That makes it *way* too easy to (attempt to) remove the wrong directory
(that might not even exist, but we'll never get notified about that
error).

> +static void move_to_original_branch(struct rebase_options *opts)
> +{

This function does not really *move* to the original branch. Instead, it
*updates* the original branch to the current HEAD and then "un-detaches"
the HEAD.

In addition, if the function states that it wants to work with an original
branch, it should accept the name of the original branch, not some
rebase_options.

> +	struct strbuf sb = STRBUF_INIT;
> +	struct object_id curr_head;
> +
> +	if (!opts->orig_refname || !starts_with(opts->orig_refname, "refs/"))
> +		return;

The caller should take care of this. Alternatively, this function should
return with an error.

> +	if (get_sha1("HEAD", curr_head.hash) < 0)
> +		die("get_sha1() failed");

Nope. No die() in library functions, please.

> +	strbuf_addf(&sb, "rebase finished: %s onto %s", opts->orig_refname, oid_to_hex(&opts->onto));
> +	if (update_ref(sb.buf, opts->orig_refname, curr_head.hash, opts->orig_head.hash, 0, UPDATE_REFS_MSG_ON_ERR))
> +		goto fail;

Overly long lines.

And here you see how beautiful a simple

	static const char *reflog_message(const char *action,
		const char *fmt, ...)
	{
		static strbuf buf = STRBUF_INIT;

		va_list ap;
		va_start(ap, fmt);

		strbuf_reset(&buf);
		strbuf_addf(_("rebase %s"), action);
		strbuf_vaddf(sb, fmt, ap);

		va_end(ap);
		return &buf.buf;
	}

would make this code and pretty much all of the other places where a
reflog message is needed.

FWIW I think this could be of even more general use, outside of rebase.

> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "rebase finished: returning to %s", opts->orig_refname);
> +	if (create_symref("HEAD", opts->orig_refname, sb.buf))
> +		goto fail;
> +
> +	strbuf_release(&sb);
> +
> +	return;
> +fail:
> +	die(_("Could not move back to %s"), opts->orig_refname);

Again, no die(), please. Besides, we should tell the user what went wrong:
there are two possibilities here, after all (updating the branch or
updating HEAD).

> +void rebase_common_finish(struct rebase_options *opts, const char *dir)
> +{
> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
> +
> +	move_to_original_branch(opts);
> +	close_all_packs();
> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> +	rebase_common_destroy(opts, dir);
> +}

So now we have *two* functions to clean up afterwards. Better to have a
single one.

Besides, this would be a perfect opportunity to refactor out gc_auto()
(that closes all packs and then runs the command) and to update all code
locations that can make use of this function, opening the door for a
single point of libification of auto-gc'ing.

> diff --git a/rebase-common.h b/rebase-common.h
> index 051c056..067ad0b 100644
> --- a/rebase-common.h
> +++ b/rebase-common.h
> @@ -24,4 +24,10 @@ int rebase_options_load(struct rebase_options *, const char *dir);
>  
>  void rebase_options_save(const struct rebase_options *, const char *dir);
>  
> +void rebase_common_setup(struct rebase_options *, const char *dir);
> +
> +void rebase_common_destroy(struct rebase_options *, const char *dir);
> +
> +void rebase_common_finish(struct rebase_options *, const char *dir);

Again, this is not very DRY. Does it really have to repeat that it is the
*common* rebase functionality? Why not simply say init_rebase()? And why
pass that dir all the time? This looks really more like copy-edited code
than like a carefully designed API...

For one, the rebase_options should actually be the replay_options (the
entire original idea of the sequencer was to be the plumbing behind the
rebase, after all, not that that idea was implemented very well).

I would also much prefer to extend the sequencer functionality through
callbacks (e.g. for updating, and switching back to, the original branch
at the end, skipping the updating step in case the user wants to abort)
than repeat essentially the same calls in all rebase varieties. Just think
about it: *all* of them have to call rebase_common_setup() in *their own*
setup() functions, same for destroy() and for finish().

If there was a set of callbacks, depending on the replay type, all of this
could be neatly tucked away behind a common interface.

Ciao,
Dscho
