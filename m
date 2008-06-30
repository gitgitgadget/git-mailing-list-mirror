From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/13] Build in merge
Date: Sun, 29 Jun 2008 22:44:43 -0700
Message-ID: <7vd4lz4gtw.fsf@gitster.siamese.dyndns.org>
References: <20080630013612.GY2058@genesis.frugalware.org>
 <e8d1385cc49a06ca3fae28231ebc66a333ce4ffb.1214789764.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDCD3-0001m1-DW
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYF3Fo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYF3Foz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:44:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYF3Foy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:44:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 04FF0ABC7;
	Mon, 30 Jun 2008 01:44:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 411A7A996; Mon, 30 Jun 2008 01:44:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A97CB588-4667-11DD-9119-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86878>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/builtin-merge.c b/builtin-merge.c
> new file mode 100644
> index 0000000..187038c
> --- /dev/null
> +++ b/builtin-merge.c
> @@ -0,0 +1,1173 @@
> ...
> +static void save_state(void)
> +{
> +	int fd;
> +	struct child_process stash;
> +	const char *argv[] = {"stash", "create", NULL};
> +
> +	fd = open(git_path("MERGE_STASH"), O_WRONLY | O_CREAT, 0666);
> +	if (fd < 0)
> +		die("Could not write to %s", git_path("MERGE_STASH"));
> +	memset(&stash, 0, sizeof(stash));
> +	stash.argv = argv;
> +	stash.out = fd;
> +	stash.git_cmd = 1;
> +	run_command(&stash);
> +}

I first thought "heh, that's clever" until I noticed that we use "stash
create" with "stash apply" these days instead of cpio for this.  I suspect
that we can do away without leaving the stash in this temporary file, but
that comment applies to the scripted version as well.

By the way, it would be consistent to name counterpart to dropsave in the
scripted version as "drop_save" if you use "save_state" and "restore_state".

> +static void reset_hard(unsigned const char *sha1, int verbose)
> +{
> +	struct tree *tree;
> +	struct unpack_trees_options opts;
> +	struct tree_desc t;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx = -1;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.update = 1;
> +	opts.reset = 1;
> +	if (verbose)
> +		opts.verbose_update = 1;
> +
> +	tree = parse_tree_indirect(sha1);
> +	if (!tree)
> +		die("failed to unpack %s tree object", sha1_to_hex(sha1));
> +	parse_tree(tree);
> +	init_tree_desc(&t, tree->buffer, tree->size);
> +	if (unpack_trees(1, &t, &opts))
> +		exit(128); /* We've already reported the error, finish dying */
> +}

Isn't this trashing all the cached stat info from the index?  If this is
emulating "reset --hard", it also should set opts.merge and do
oneway_merge, after reading the current index in, I think.  Resetting the
index and the working tree is not particularly performance critical part,
but trashing the cached stat info would hurt the performance of everything
that reads the index after this function returns quite badly.  I suspect
that you might be better off forking the real thing (reset --hard) if you
cannot get it right here.

> +/* Get the name for the merge commit's message. */
> +static void merge_name(const char *remote, struct strbuf *msg)
> ...
> +	strbuf_init(&buf, 0);
> +	strbuf_addstr(&buf, "refs/heads/");
> +	strbuf_addstr(&buf, remote);
> +	dwim_ref(buf.buf, buf.len, branch_head, &ref);
> +	if (!hashcmp(remote_head->sha1, branch_head)) {
> +		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
> +			sha1_to_hex(branch_head), remote);
> +		return;
> +	}

Hmm, why not resolve_ref() so that it does not dwim at all?  The point of
the code is so that you can be confident that 'blah' *is* a local branch
when you say "branch 'blah'".

> +	/* See if remote matches <name>~<number>, or <name>^ */
> +	ptr = strrchr(remote, '^');
> +	if (ptr && ptr[1] == '\0') {
> +		len = strlen(remote);
> +		while ((ptr = (char *)memrchr(remote, '^', len)))
> +			if (ptr && ptr[1] == '\0')
> +				len = ptr - remote - 1;
> +			else
> +				break;

That's a funny way to say:

	for (len = 0, ptr = remote + strlen(remote);
             remote < ptr && ptr[-1] == '^';
             ptr--)
		len++;

> +	if (len) {
> +		struct strbuf truname = STRBUF_INIT;
> +		strbuf_addstr(&truname, remote);
> +		strbuf_setlen(&truname, len);
> +		if (dwim_ref(truname.buf, truname.len, buf_sha, &ref)) {
> +			strbuf_addf(msg,
> +				"%s\t\tbranch '%s' (early part) of .\n",
> +				sha1_to_hex(remote_head->sha1), truname.buf);
> +			return;

Isn't this wrong?  Giving "v1.5.6~20" to this code will strip ~20 and make
remote = "v1.5.6", to which dwim_ref() will happily say Ok, and you end up
saying "branch 'v1.5.6' (early part)", don't you?

> +static int read_tree_trivial(unsigned char *common, unsigned char *head,
> +	unsigned char *one)
> +{
> +	int i, nr_trees = 0;
> +	struct tree *trees[MAX_UNPACK_TREES];
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct unpack_trees_options opts;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx = -1;

Is this the correct head_idx value for this three-way merge?  I think it
should be 2 but please double check.

> +static int commit_tree_trivial(const char *msg, unsigned const char *tree,
> +		struct commit_list *parents, unsigned char *ret)
> +{
>  ...
> +}

We may want to have another patch before this one to abstract most of
cmd_commit_tree() out, perhaps?

> +int cmd_merge(int argc, const char **argv, const char *prefix)
> ...
> +	/*
> +	 * This could be traditional "merge <msg> HEAD <commit>..."  and
> +	 * the way we can tell it is to see if the second token is HEAD,
> +	 * but some people might have misused the interface and used a
> +	 * committish that is the same as HEAD there instead.
> +	 * Traditional format never would have "-m" so it is an
> +	 * additional safety measure to check for it.
> +	 */
> +	strbuf_init(&buf, 0);
> +	if (argc > 1) {
> +		unsigned char second_sha1[20];
> +
> +		if (get_sha1(argv[1], second_sha1))
> +			die("Not a valid ref: %s", argv[1]);
> +		second_token = lookup_commit_reference_gently(second_sha1, 0);
> +		if (!second_token)
> +			die("'%s' is not a commit", argv[1]);

Interesting.

This _superficially_ is quite wrong, because the purpose of this part of
the code is to tell if we got old-style invocation, and we should not
barfing merely because what we got is _not_ old-style.  If it is not
old-style, then it would be new-style, and the logic to tell if it is
old-style should ideally not have much knowledge about the new-style
invocation to say "hey, that's an incocrrect new-style invocation".  By
the way, this part should probably be in a separate function:

	static int is_old_style_invocation(int ac, const char **gv);

Old-style invocation of "git merge" (primarily by "git pull") was
to call it as:

	git merge "message here" HEAD $commit1 $commit2...

and it checks the second token ("HEAD" in the above, but people can misuse
the interface to name the current branch name).  If the second token is
not a ref that resolves to a commit, all you know is that this is _not_ an
old-style invocation, and calling the program with new-style is not a
crime.

The only reason this is wrong only superficially is because new style
invocation would always be:

	git merge [options] $commit1 $commit2...

after stripping the options, and these seemingly wrong die() will complain
when you try to create an Octopus with the new-style syntax and the
parameter given as the second remote parent is not a commit.  So the logic
is wrong, the fact that the user gets the same error message for incorrect
old-style invocation (perhaps "git merge <msg> HAED $commit") and
incorrect new-style invocation "git merge $commit1 $nonsense" is just an
accident, and the end result does not hurt, but asks for a "Huh? why does
it check and complain only the second parent here but not the first one?".

It is interesting, but feels quite dirty.

> +	}
> +
> +	if (!have_message && second_token &&
> +		!hashcmp(second_token->object.sha1, head)) {

You need to know that resolve_ref() cleared head[] when head_invalid is
true when reading this code to notice that, unlike the previous round of
this patch, it is Ok not to check head_invalid is fine here.  I somehow
feel it is an unnecessary optimization/obfuscation.

But once you have "is_old_style_invocation" suggested earlier, this part
would look much cleaner and the above comment would become unnecessary.

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
> +		o = peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
> +			0, NULL, OBJ_COMMIT);
> +		if (!o)
> +			return 0;
> +
> +		if (checkout_fast_forward(head, remoteheads->item->object.sha1))
> +			return 0;

When o does not peel well, or checkout_fast_forward() returns failure,
that would be a failure case, wouldn't it?  Why return 0?

Maybe you misread "exit" in shell scripts?  It does not mean exit(0); it
means "exit with the same exit status as the last command".  So

	new_head=$(git rev-parse ...) &&
        git read-tree -m -u ... &&
        finish || exit

will exit non-zero if any of the commands chained by && fails.

> +		if (allow_trivial) {
> +			/* See if it is really trivial. */
> +			git_committer_info(IDENT_ERROR_ON_NO_NAME);
> +			printf("Trying really trivial in-index merge...\n");
> +			if (!read_tree_trivial(common->item->object.sha1,
> +					head, remoteheads->item->object.sha1))
> +				return merge_trivial();
> +			printf("Nope.\n");

Nicer, much nicer.

> +	/*
> +	 * At this point, we need a real merge.  No matter what strategy
> +	 * we use, it would operate on the index, possibly affecting the
> +	 * working tree, and when resolved cleanly, have the desired
> +	 * tree in the index -- this means that the index must be in
> +	 * sync with the head commit.  The strategies are responsible
> +	 * to ensure this.
> +	 */
> +	if (use_strategies.nr != 1) {
> +		/*
> +		 * Stash away the local changes so that we can try more
> +		 * than one.
> +		 */
> +		save_state();
> +		single_strategy = 0;
> +	} else {
> +		unlink(git_path("MERGE_STASH"));
> +		single_strategy = 1;

I think s/single_strategy/(use_strategies.nr == 1)/ in the remainder of the
code would be taking advantage of working in C ;-)

> +		if (ret) {
> +			/*
> +			 * The backend exits with 1 when conflicts are
> +			 * left to be resolved, with 2 when it does not
> +			 * handle the given merge at all.
> +			 */
> +			if (ret == 1) {

Probably from here til ...

> +				int cnt = 0;
> ...
> +				cnt += count_unmerged_entries();

... here should be a separate "evaluate_result()" function.

> +				if (best_cnt <= 0 || cnt <= best_cnt) {
> +					best_strategy =
> +						&use_strategies.items[i];
> +					best_cnt = cnt;
> +				}
> +			}
> +			if (merge_was_ok)
> +				break;
> +			else
> +				continue;
> +		}
> +
> +		/* Automerge succeeded. */
> +		write_tree_trivial(result_tree);
> +		automerge_was_ok = 1;
> +		break;
> +	}

The part of the file I did not comment in this message (except for the
"cast" thing) looked straightforward enough.  I did not very carefully
hunt for bugs, but I did not see anything obviously wrong.

Thanks.
