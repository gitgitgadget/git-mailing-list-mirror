From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/13] Build in merge
Date: Sun, 29 Jun 2008 00:46:09 -0700
Message-ID: <7vprq0fzum.fsf@gitster.siamese.dyndns.org>
References: <20080628023355.GH2058@genesis.frugalware.org>
 <ed4b7f44474d6b9398fb0752740ede264bea25b2.1214620551.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 09:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrdY-0005Bu-8O
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 09:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454AbYF2Hqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 03:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYF2Hqr
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 03:46:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbYF2HqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:46:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63D67219E;
	Sun, 29 Jun 2008 03:46:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 68824219D; Sun, 29 Jun 2008 03:46:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76199EEE-45AF-11DD-8664-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86761>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sat, Jun 28, 2008 at 04:33:55AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> OK, I'll send the main patch without the strbuf_initf() calls
>
> Here it is.

Sorry, this file is huge and very time consuming to review.  Here are some
pieces.  The parts I did not comment I haven't looked at.

> +/* Get the name for the merge commit's message. */
> +static void merge_name(const char *remote, struct strbuf *msg)
> +{
> +	struct object *remote_head;
> +	unsigned char branch_head[20], buf_sha[20];
> +	struct strbuf buf;
> +	char *ptr;
> +	int len = 0;
> +
> +	memset(branch_head, 0, sizeof(branch_head));
> +	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
> +	if (!remote_head)
> +		return;

Hmm.  This is a faithful translation of scripted version, but I wonder
what should happen when we got a non-commit here...

> +
> +	strbuf_init(&buf, 0);
> +	strbuf_addstr(&buf, "refs/heads/");
> +	strbuf_addstr(&buf, remote);
> +	get_sha1(buf.buf, branch_head);

This does not correspond to the computation of $bh in the scripted version
that makes sure "remote" is actually a bare name of branch, e.g. "master",
without any adornment like "master~5^3~8.  Your code would succeed and
leave the same object name in branch_head[] as remote_head->sha1, wouldn't
it?

> +	if (!hashcmp(remote_head->sha1, branch_head)) {
> +		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
> +			sha1_to_hex(branch_head), remote);
> +		return;
> +	}
> +	/* See if remote matches <name>~<number>, or <name>^ */

The scripted version did not handle <name>^, so this is an extension.
Don't you want also handle <name>^^^ if we are extending it?

> +	ptr = strrchr(remote, '^');
> +	if (ptr && ptr[1] == '\0')
> +		len = ptr-remote;
> +	else {
> +		ptr = strrchr(remote, '~');
> +		if (ptr && ptr[1] != '0' && isdigit(ptr[1])) {
> +			len = ptr-remote;
> +			ptr++;
> +			for (ptr++; *ptr; ptr++)
> +				if (!isdigit(*ptr)) {
> +					len = 0;
> +					break;
> +				}
> +		}
> +	}
> +	if (len) {
> +		struct strbuf truname = STRBUF_INIT;
> +		strbuf_addstr(&truname, remote);
> +		strbuf_setlen(&truname, len);
> +		if (!get_sha1(truname.buf, buf_sha)) {

Again, isn't this wrong?  You are not making sure truname is the name of
existing local branch.  HEAD@{7}~23 will pass get_sha1() but you are not
merging an early part of HEAD@{7} branch.

> +			strbuf_addf(msg,
> +				"%s\t\tbranch '%s' (early part) of .\n",
> +				sha1_to_hex(remote_head->sha1), truname.buf);
> +			return;
> +		}
> +	}

> +int cmd_merge(int argc, const char **argv, const char *prefix)
> +{

This is an ultra-huge function.  I wonder if it can further split up to
make it easier to maintain.

> +	unsigned char sha1[20], result_tree[20];
> +	struct object *second_token = NULL;
> +	struct strbuf buf, head_arg;
> +	int flag, head_invalid, i, single_strategy;
> +	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
> +	struct commit_list *common = NULL;
> +	struct path_list_item *best_strategy = NULL, *wt_strategy = NULL;
> +	struct commit_list **remotes = &remoteheads;
> +
> +	setup_work_tree();
> +	if (unmerged_cache())
> +		die("You are in the middle of a conflicted merge.");
> +
> +	/*
> +	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
> +	 * current branch.
> +	 */
> +	branch = resolve_ref("HEAD", sha1, 0, &flag);

You are resolving for non-reading, so before an initial commit, you won't
get any error from this call, which is good.  And sha1[] will be cleared.
Otherwise you learn where the HEAD is in sha1[] at this point.

> +	if (branch && flag & REF_ISSYMREF) {
> +		const char *ptr = skip_prefix(branch, "refs/heads/");
> +		if (ptr)
> +			branch = ptr;
> +	}
> +
> +	git_config(git_merge_config, NULL);
> +
> +	/* for color.diff and diff.color */
> +	git_config(git_diff_ui_config, NULL);
> +
> +	/* for color.ui */
> +	if (diff_use_color_default == -1)
> +		diff_use_color_default = git_use_color_default;
> +
> +	argc = parse_options(argc, argv, builtin_merge_options,
> +			builtin_merge_usage, 0);
> +
> +	if (squash) {
> +		if (!allow_fast_forward)
> +			die("You cannot combine --squash with --no-ff.");
> +		option_commit = 0;
> +	}
> +
> +	if (!argc)
> +		usage_with_options(builtin_merge_usage,
> +			builtin_merge_options);
> +
> +	/*
> +	 * This could be traditional "merge <msg> HEAD <commit>..."  and
> +	 * the way we can tell it is to see if the second token is HEAD,
> +	 * but some people might have misused the interface and used a
> +	 * committish that is the same as HEAD there instead.
> +	 * Traditional format never would have "-m" so it is an
> +	 * additional safety measure to check for it.
> +	 */
> +	strbuf_init(&buf, 0);
> +	strbuf_init(&head_arg, 0);
> +	if (argc > 1)
> +		second_token = peel_to_type(argv[1], 0, NULL, OBJ_COMMIT);

If the second token was a string that could resolve to an object name that
does not peel to commit (say "merge -m 'HEAD^{tree}' other"), you will get
a complaint fro mpeel-to-type "I expected a commit but you gave something
else".  You (or more likely Dscho) might have said "that won't matter in
practice", but I think you should really do get_sha1() followed by
lookup_commit_reference_gently() here to avoid the errors.

> +	head_invalid = get_sha1("HEAD", head);

You've already done this earlier with resolve_ref() haven't you?

> +	if (!have_message && second_token &&
> +		!hashcmp(second_token->sha1, head)) {

Isn't this wrong if head_invalid is true?

> +		strbuf_addstr(&merge_msg, argv[0]);
> +		strbuf_addstr(&head_arg, argv[1]);
> +		argv += 2;
> +		argc -= 2;

I do not think there is any point using strbuf for head_arg.  Shouldn't it
simply be a "const char *"?

> +	} else if (head_invalid) {
> +		struct object *remote_head;
> +		/*
> +		 * If the merged head is a valid one there is no reason
> +		 * to forbid "git merge" into a branch yet to be born.
> +		 * We do the same for "git pull".
> +		 */
> +		if (argc != 1)
> +			die("Can merge only exactly one commit into "
> +				"empty head");
> +		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);

Here we _do_ expect it to be a commit, so peel_to_type() is fine.

> +		if (!remote_head)
> +			die("%s - not something we can merge", argv[0]);
> +		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
> +				DIE_ON_ERR);
> +		reset_hard(remote_head->sha1, 0);
> +		return 0;

Makes one wonder reset_hard() (aka "read-tree --reset -u HEAD") ever fail
and return here (iow, without calling die()).  The answer is luckily no
in this case, but it is somewhat unnerving to reviewers.

> +	} else {
> +		/* We are invoked directly as the first-class UI. */
> +		strbuf_addstr(&head_arg, "HEAD");
> +		/*
> +		 * All the rest are the commits being merged;
> +		 * prepare the standard merge summary message to
> +		 * be appended to the given message.  If remote
> +		 * is invalid we will die later in the common
> +		 * codepath so we discard the error in this
> +		 * loop.
> +		 */
> +		struct strbuf msg;

Decl-after-statement.

> +		strbuf_init(&msg, 0);
> +		for (i = 0; i < argc; i++)
> +			merge_name(argv[i], &msg);
> +		fmt_merge_msg(option_log, &msg, &merge_msg);
> +		if (merge_msg.len)
> +			strbuf_setlen(&merge_msg, merge_msg.len-1);
> +	}
> +
> +	if (head_invalid || !argc)
> +		usage_with_options(builtin_merge_usage,
> +			builtin_merge_options);
> +	strbuf_addstr(&buf, "merge");
> +	for (i = 0; i < argc; i++)
> +		strbuf_addf(&buf, " %s", argv[i]);
> +	setenv("GIT_REFLOG_ACTION", buf.buf, 0);
> +	strbuf_reset(&buf);
> +
> +	for (i = 0; i < argc; i++) {
> +		struct object *o;
> +
> +		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
> +		if (!o)
> +			die("%s - not something we can merge", argv[i]);
> +		remotes = &commit_list_insert(lookup_commit(o->sha1),
> +			remotes)->next;
> +
> +		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
> +		setenv(buf.buf, argv[i], 1);
> +		strbuf_reset(&buf);
> +	}
> +
> +	if (!use_strategies.nr) {
> +		if (!remoteheads->next)
> +			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
> +		else
> +			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
> +	}
> +
> +	for (i = 0; i < use_strategies.nr; i++) {
> +		if ((unsigned int)use_strategies.items[i].util &
> +			NO_FAST_FORWARD)
> +			allow_fast_forward = 0;
> +		if ((unsigned int)use_strategies.items[i].util & NO_TRIVIAL)
> +			allow_trivial = 0;

Can we abstract out these ugly casts?  Any code that use path_list to
store anything but list of paths (i.e. some value keyed with string) tends
to have this readability issue.

> +	}
> +
> +	if (!remoteheads->next)
> +		common = get_merge_bases(lookup_commit(head),
> +				remoteheads->item, 1);
> +	else {
> +		struct commit_list *list = remoteheads;
> +		commit_list_insert(lookup_commit(head), &list);
> +		common = get_octopus_merge_bases(list);
> +		free(list);
> +	}
> +
> +	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
> +		DIE_ON_ERR);
> +
> +	if (!common)
> +		; /* No common ancestors found. We need a real merge. */
> +	else if (!remoteheads->next &&
> +		!hashcmp(common->item->object.sha1,
> +		remoteheads->item->object.sha1)) {

Wouldn't the latter be "common->item == remoteheads->item" simply?

You do not have the check to make sure there is only one common ancestor
(scripted version compares $common and $1 textually to achieve this), and
checking only the first one of them.  Is this correct?

> +		/*
> +		 * If head can reach all the remote heads then we are up
> +		 * to date.
> +		 */

The comment is wrong --- you are doing "... but first the most common case
of merging one remote" here.

> +		finish_up_to_date("Already up-to-date.");
> +		return 0;
> +	} else if (allow_fast_forward && !remoteheads->next &&
> +		!hashcmp(common->item->object.sha1, head)) {
> +		/* Again the most common case of merging one remote. */

Here again you are not checking there is only one common, and checking
only the first one of them.

> +		struct strbuf msg;
> +		struct object *o;
> +		char hex[41];
> +
> +		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
> +
> +		printf("Updating %s..%s\n",
> +			hex,
> +			find_unique_abbrev(remoteheads->item->object.sha1,
> +			DEFAULT_ABBREV));
> +		refresh_cache(REFRESH_QUIET);
> +		strbuf_init(&msg, 0);
> +		strbuf_addstr(&msg, "Fast forward");
> +		if (have_message)
> +			strbuf_addstr(&msg,
> +				" (no commit created; -m option ignored)");
> +		o = peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
> +			0, NULL, OBJ_COMMIT);
> +		if (!o)
> +			return 0;
> +
> +		if (merge_one_remote(head, remoteheads->item->object.sha1))
> +			return 0;

Isn't "merge_one_remote()" just a "git checkout" after fast-forward?  The
function feels misnamed.

> +		finish(o->sha1, msg.buf);
> +		dropsave();
> +		return 0;
> +	} else if (!remoteheads->next && common->next)
> +		;

Here you are checking common->next but earlier if/elseif chain didn't so
it is too late.

> +		/*
> +		 * We are not doing octopus and not fast forward.  Need
> +		 * a real merge.
> +		 */
> +	else if (!remoteheads->next && option_commit) {
> +		/*
> +		 * We are not doing octopus, not fast forward, and have
> +		 * only one common.

Here again you did not check "have only one common" did you?

> +		 */
> +		refresh_cache(REFRESH_QUIET);
> +		if (allow_trivial) {
> +			/* See if it is really trivial. */
> +			git_committer_info(IDENT_ERROR_ON_NO_NAME);
> +			printf("Trying really trivial in-index merge...\n");
> +			if (!read_tree_trivial(common->item->object.sha1,
> +					head, remoteheads->item->object.sha1)) {
> +				unsigned char result_tree[20],
> +					result_commit[20];
> +				struct commit_list parent;
> +
> +				write_tree_trivial(result_tree);
> +				printf("Wonderful.\n");
> +				parent.item = remoteheads->item;
> +				parent.next = NULL;
> +				commit_tree_trivial(merge_msg.buf,
> +					result_tree, &parent,
> +					result_commit);
> +				finish(result_commit, "In-index merge");
> +				dropsave();
> +				return 0;
> +			}
> +			printf("Nope.\n");
> +		}

There weren't any good way to squelch error messages selectively from the
trivial one in the scripted version and that is the only reason we
surround read-tree with "Trying..." and "Wonderful/Nope.".  Literal
translation to make sure you get identical output in the first round of
this series is good, but after the code stabilizes, we may want to squelch
these messages.  Something to keep in mind but not now.
