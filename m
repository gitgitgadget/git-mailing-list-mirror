From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Don't push a repository with unpushed submodules
Date: Tue, 09 Aug 2011 14:12:05 -0700
Message-ID: <7vobzys316.fsf@alter.siamese.dyndns.org>
References: <1312913752-21555-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 23:12:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqtax-0001Na-TL
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 23:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1HIVMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 17:12:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab1HIVMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 17:12:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD5AE54CF;
	Tue,  9 Aug 2011 17:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r6yqpK12HFj/0mPMryUS4uhJqOw=; b=XToh+l
	YIedYeyaL2gu/IWL19dM17YK0fapFlaoenczbA2QxDyVrJK8hjtOOkKrbpi8HaEp
	3IGewMv2bGOk3EeMMUb8fHr+nAlMSorjgCrSkXErNXUxAabbSmOyTBAGABXGkItA
	yrrLqqTHtU7LDDVKmqsSmIJnh9JJ0hhw1Urc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qmRgi8tVNnD/OaSvCW4Wz+Svt1/9VaPz
	JAPvHXUF9FdBvhjPwdxDQrluQooLjXRcyTkzFk93PoHT7pIJzTSmjfUP8pwrIlwh
	qpCFxrWIOu364/lp2MNUbgBOAuv1qTi5aFc3HlE6OicQwPwFV2u+TlQ4OnWROsDj
	ekpIOHQ6Dvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D319254CE;
	Tue,  9 Aug 2011 17:12:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7CF154CD; Tue,  9 Aug 2011
 17:12:06 -0400 (EDT)
In-Reply-To: <1312913752-21555-1-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Tue, 9 Aug 2011 20:15:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CB87042-C2CC-11E0-BBD1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179048>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> When working with submodules it is easy to forget to push a
> submodule to the server but pushing a super-project that
> contains a commit for that submodule. The result is that the
> superproject points at a submodule commit that is not available
> on the server.
>
> This adds the option --recurse-submodules=check to push. When
> using this option git will check that all submodule commits that
> are about to be pushed are present on a remote of the submodule.

Looking better.

> This does not guarantee that all submodules a super-project
> needs will be available on the server.

Hmm, why not?

You do not, when this option is in effect, push a new commit of the
superproject to the remote unless you know all the submodule commits
pointed at by the superproject commit you are pushing out are already
pushed out, right? If so how could some submodules become unavailable on
the other end?

Are you thinking about some submodules that you did not touch may have
been updated by somebody else, rewinding the branch that contained the
commit that you did not modify and that you have in your superproject
commit, or something? But ...

> In that case both the
> super-project and the submodules would need an atomic push.

... such a case won't be helped with any atomic push, as you didn't even
update that submodule that somebody else rewound.

So you must be thinking about something else. Can you clarify the failure
mode you are worried about a bit better here?

You may also drop the "atomic push might help something" from the
description; as it is unclear what it could help. Then what remains would
be...

> This
> does however prevent the human error of forgetting to push a
> submodule.

...this one, which is correct. This change is primarily to help prevent a
human error that was described in the first paragraph of the message (I do
not think it prevents any other kind of error). So while it is correct, it
may not have to be said again here.

> The first iteration of this patch series can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

And the second iteration was here:

  http://thread.gmane.org/gmane.comp.version-control.git/177992

>  Documentation/git-push.txt     |    6 ++
>  builtin/push.c                 |   17 +++++
>  submodule.c                    |  129 ++++++++++++++++++++++++++++++++++++++++
>  submodule.h                    |    1 +
>  t/t5531-deep-submodule-push.sh |   99 ++++++++++++++++++++++++++++++
>  transport.c                    |    9 +++
>  transport.h                    |    1 +
>  7 files changed, 262 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 88acfcd..6ae6ba3 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -162,6 +162,12 @@ useful if you write an alias or script around 'git push'.
>  	is specified. This flag forces progress status even if the
>  	standard error stream is not directed to a terminal.
>  
> +--recurse-submodules=check::
> +	Check whether all submodule commits used by the revisions to be
> +	pushed are available on a remote tracking branch. Otherwise the
> +	push will be aborted and the command will exit with non-zero status.
> +
> +
>  include::urls-remotes.txt[]
>  
>  OUTPUT
> diff --git a/builtin/push.c b/builtin/push.c
> index 9cebf9e..23ba365 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -8,6 +8,7 @@
>  #include "remote.h"
>  #include "transport.h"
>  #include "parse-options.h"
> +#include "submodule.h"
>  
>  static const char * const push_usage[] = {
>  	"git push [<options>] [<repository> [<refspec>...]]",
> @@ -219,6 +220,19 @@ static int do_push(const char *repo, int flags)
>  	return !!errs;
>  }
>  
> +static int option_parse_recurse_submodules(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	int *flags = opt->value;
> +	if (arg) {
> +		if (!strcmp(arg, "check"))
> +			*flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
> +		else
> +			die("bad %s argument: %s", opt->long_name, arg);
> +	}
> +	return 0;
> +}

Later you may want to add a configuration variable to flip the default,
and _before_ that happens (e.g. like "now"), you would need to be able to
accept --recurse-submodules=no-check or something that defeats the
configured default from the command line during the transition period.

Why not use a simple string-valued variable to keep the last value of this
option you saw instead of using a callback?  The overall control flow in
cmd_push() would look like this:

	const char *submodules = NULL; /* default */
        ...
	OPT_STRING(0, "recurse-submodules", &submodules, ...),
	...
	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
	parse_recurse_submodules_option(submodules, &flags);

and you set or unset the necessary bits in flags in the helper function.
That would also help people who use an alias with --recurse-submodules=
early on the command line to force his own default before configuration is
introduced by naturally implementing the usual "last one on the command
line wins" rule, no?

>  int cmd_push(int argc, const char **argv, const char *prefix)
>  {
>  	int flags = 0;
> @@ -236,6 +250,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
>  		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
>  		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
> +		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, "check",
> +			"controls recursive pushing of submodules",
> +			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>  		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
>  		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
>  		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
> diff --git a/submodule.c b/submodule.c
> index 1ba9646..c44472f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -308,6 +308,135 @@ void set_config_fetch_recurse_submodules(int value)
>  	config_fetch_recurse_submodules = value;
>  }
>  
> +static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
> +{
> +	return 1;
> +}
> +
> +/*
> + * checks whether a certain submodule commit is pushed based on the
> + * submodules remote tracking branches. returns 1 in case no remote
> + * tracking branches are found.
> + */
> +static int is_submodule_commit_pushed(const char *path, const unsigned char sha1[20])
> +{
> +	int is_pushed = 0;
> +	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
> +		if (for_each_remote_ref_submodule(path, has_remote, NULL)) {

This code assumes that this for_each_remote_ref_submodule() call will
return non-zero only when has_remote() is called even once. Is that really
true? Doesn't the function (not has_remote() but the iterator) want to
signal errors in any way, and if so doesn't it return a negative value or
something?

> +			struct child_process cp;
> +			const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
> +			struct strbuf buf = STRBUF_INIT;
> +
> +			argv[1] = sha1_to_hex(sha1);
> +			memset(&cp, 0, sizeof(cp));
> +			cp.argv = argv;
> +			cp.env = local_repo_env;
> +			cp.git_cmd = 1;
> +			cp.no_stdin = 1;
> +			cp.out = -1;
> +			cp.dir = path;
> +			if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
> +				is_pushed = 1;
> +			close(cp.out);
> +			strbuf_release(&buf);

Hmm, this run_command(), while it may not be a bug, feels somewhat fishy.

It calls start and then calls finish. What if the subprocess is really
fast, writes everything it needs to write (which is presumably 41 bytes at
most), closes its end of the pipe? And then you read from the other end of
the pipe. Am I being too paranoid to think that this sequence is ...

	start_command();
        strbuf_read();
        finish_command();
        close();
        strbuf_release();

... a more natural way of writing this logic?

> +		} else
> +			is_pushed = 1;

This case is not "we know it is pushed" but "we do not know (and we do not
care) if it was pushed, because the submodule does not have a tracking",
no?

Probably the function should be named "submodule_needs_pushing()" and
return the value accordingly. Then "we do not have to prevent the user
from pushing the superproject based on the state of this submodule" case
can say "No, this submodule repository does not need pushing", which reads
a lot more naturally. The overall code structure would also become
simpler:

	static int submodule_needs_pushing(...)
        {
		int needs_pushing = 0;
                if (!(we can inspect the objects in this submodule))
			return needs_pushing;

               	if (for_each_remote_ref_in_submodule(...)) {
                	... run rev-list ...
                       	if (found commit not in remotes)
				needs_pushing = 1;
			... clean-up rev-list ...                                
		}
		return needs_pushing;
	}

What happens in a submodule repository that you do not have a checkout?
the first if() statement in the function would be false, and you would end
up returning "is-pushed? no" and collect_unpushed_submodules_from_revs()
(which also is a misnomer; you do not care if commits in certain
submodules haven't been pushed---it should collect submodules that "needs
pushing", which is subtly different from "have not been pushed") that
called this function will say "Ah I found one, I found one, that is an
error!".

And I think that is wrong.

Imagine a merge in a superproject between two branches, among which only
one of them updated the submodule while the other one did not touch. As
far as that submodule path is concerned, the merge should resolve cleanly
without a checkout (or clone) of the submodule repository to take the
update from the branch that updated the submodule commit.

So the "submodule-needs-pushing()" function should return "no need to push
(there is nothing to push to begin with)" for a submodule that is not even
"submodule init"ed.

> +static int collect_unpushed_submodules_in_tree(const unsigned char *sha1,
> +					const char *base, int baselen,
> +					const char *pathname, unsigned mode,
> +					int stage, void *context)
> +{
> +	int *found_unpushed_submodules = context;
> +	struct strbuf path = STRBUF_INIT;
> +
> +	strbuf_add(&path, base, strlen(base));
> +	strbuf_add(&path, pathname, strlen(pathname));
> +
> +	if (S_ISGITLINK(mode) && !is_submodule_commit_pushed(path.buf, sha1)) {
> +		*found_unpushed_submodules = 1;
> +		return 0;
> +	}
> +	return READ_TREE_RECURSIVE;
> +}

I find it somewhat distasteful to have this separate codepath (and
tree_commits_pushed() function) only for the root commit. Why not use the
same diff-tree machinery?

> +static void parent_commits_pushed(struct commit *commit, struct commit_list *parent, int *found_unpushed_submodule)
> +{
> +	while (parent) {

Also I wonder if you really want to do pair-wise diff here, which would
mean that for a typical two-parent merge you will potentially have to
check the same submodule twice (no I am not talking about the cost of
running diff the same number of times as you have parents, but I am
talking about the cost of running submodule_needs_pushing()).

Would it make sense to run the equivalent of "show -c --name-only" here
internally ("diff-tree --root -c --name-only" to be more exact)? Then any
submodule path that match one of the parents you would not have to check
at all. Just thinking aloud...

> +		struct diff_options diff_opts;
> +		diff_setup(&diff_opts);
> +		DIFF_OPT_SET(&diff_opts, RECURSIVE);
> +		diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
> +		diff_opts.format_callback = collect_unpushed_submodules_from_revs;
> +		diff_opts.format_callback_data = found_unpushed_submodule;
> +		if (diff_setup_done(&diff_opts) < 0)
> +			die("diff_setup_done failed");
> +		diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
> +		diffcore_std(&diff_opts);
> +		diff_flush(&diff_opts);
> +		parent = parent->next;
> +	}
> +}
> +
> +static void tree_commits_pushed(struct commit *commit, int *found_unpushed_submodule)
> +{
> +	struct tree * tree;

(style) struct tree *tree;

But I already suggested to get rid of this separate codepath, so it is not
such a big deal.

> +	struct pathspec pathspec;
> +	tree = parse_tree_indirect(commit->object.sha1);
> +	init_pathspec(&pathspec,NULL);
> +	read_tree_recursive(tree, "", 0, 0, &pathspec, collect_unpushed_submodules_in_tree,
> +			    found_unpushed_submodule);
> +}
> +
> +int check_for_unpushed_submodule_commits(unsigned char new_sha1[20])
> +{

The same "we are not looking for 'unpushed' ones, but for 'needs pushing'
ones" comment on naming applies here.

> +	struct rev_info rev;
> +	struct commit *commit;
> +	const char *argv[] = {NULL, NULL, "--not", "--remotes", NULL};
> +	int argc = ARRAY_SIZE(argv) - 1;
> +	char *sha1_copy;
> +	int found_unpushed_submodule = 0;
> +
> +	init_revisions(&rev, NULL);
> +	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
> +	argv[1] = sha1_copy;
> +	setup_revisions(argc, argv, &rev, NULL);
> +	if (prepare_revision_walk(&rev))
> +		die("revision walk setup failed");
> +
> +	while ((commit = get_revision(&rev)) && !found_unpushed_submodule) {

Why are we checking all commits that are not in "any of the remotes" (I am
referring to "--not --remotes" in the argv[]) here, instead of all commits
that are not in "the remote we are pushing this superproject commit to"?
At this point in the codepath don't you (or you may not---I didn't check)
already know where you are pushing?

> +test_expect_success 'push succeeds if submodule has no remote and is on the first superproject commit' '
> +	mkdir a &&
> +	(
> +		cd a &&
> +		git init --bare
> +	) &&

Perhaps

	git init --bare a

would do?
