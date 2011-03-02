From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 12:16:54 -0500
Message-ID: <20110302171653.GA18957@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 18:17:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pupfc-0007Y1-24
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 18:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab1CBRQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 12:16:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38557 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063Ab1CBRQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 12:16:57 -0500
Received: (qmail 18879 invoked by uid 111); 2 Mar 2011 17:16:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 17:16:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 12:16:54 -0500
Content-Disposition: inline
In-Reply-To: <20110302164031.GA18233@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168325>

On Wed, Mar 02, 2011 at 11:40:32AM -0500, Jeff King wrote:

>  blame-tree.c          |  156 +++++++++++++++++++++++++++++++++++++++++++++++++
>  blame-tree.h          |   25 ++++++++
>  builtin.h             |    1 +
>  builtin/blame-tree.c  |   34 +++++++++++

I tried to lib-ify the implementation as much as possible. It increases
the lines of code, of course, but I figured there was a reasonable
chance that there might be a user-friendly "git ls" command eventually,
and this would probably make a good "-v" option to it.

I considered making it a special mode of "git blame" when blame is fed a
directory instead of a file. But the implementations aren't shared at
all (nor do I think they need to be; blame-tree is _way_ simpler). And I
didn't want to steal that concept in case somebody can think of a more
content-level way of blaming a whole tree that makes sense (obviously
just showing the concatenation of the blames of each file is one way,
but I don't know how useful that would be). If we want to go that way,
we can always catch the special case in blame and just exec blame-tree.

> +void blame_tree_init(struct blame_tree *bt)
> +{
> +	memset(bt, 0, sizeof(*bt));
> +	bt->paths.strdup_strings = 1;
> +	init_revisions(&bt->rev, NULL);
> +	bt->rev.no_merges = 1;
> +	bt->rev.def = "HEAD";
> +}

I turn off merges by default, since they are unlikely to be interesting
matches (you will see the merge of a side-branch that touched a file
instead of the actual commit on the side-branch). You could of course do
"git blame-tree . --no-merges" to get the same effect. I think no-merges
makes a saner default, but sadly it doesn't seem like there is a way to
turn no-merges back off ("--merges" means something else, and there is
no --no-no-merges").

> +static int add_from_revs(struct blame_tree *bt)
> +{
> +	struct object_array_entry *obj;
> +	unsigned char sha1[20];
> +	unsigned mode;
> +	struct tree *tree;
> +
> +	if (!bt->rev.pending.nr)
> +		return error("no revisions specified");
> +
> +	obj = bt->rev.pending.objects;
> +	if (get_tree_entry(obj->item->sha1, bt->prefix, sha1, &mode) < 0)
> +		return error("no such path: %s:%s", obj->name, bt->prefix);
> +
> +	tree = parse_tree_indirect(sha1);
> +	if (!tree)
> +		return error("not a tree: %s:%s", obj->name, bt->prefix);
> +
> +	if (read_tree_recursive(tree, "", 0, 0, NULL, add_path, &bt->paths) < 0)
> +		return error("unable to read tree object");
> +
> +	sort_string_list(&bt->paths);
> +	return 0;
> +}

The initial set of interesting files we come up with is gotten by
looking at the tree of the first pending object after parsing the rev
options (defaulting to HEAD). Which sounds a little flaky to me, but
does what you want in practice. I'd be curious if somebody can come up
with a counterexample where the ability to manually specify the source
tree would be more useful.

Right now the code just handles trees. But in the long run, it would
probably make sense to get the list of files from the index, and mark
files modified in the working tree or index, too. So something like:

  foo.c  1234abcd this is a commit subject
  bar.c  modified in working tree
  baz.c  modified in index

Sort of like how gitk shows "pseudo-commits" on top of history to
indicate changes.

> +static void process_diff(struct diff_queue_struct *q,
> +			 struct diff_options *opt, void *cbdata)
> +{
> +	struct blame_tree_callback_data *data = cbdata;
> +	int i;
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		const char *path = p->one->path;
> +		struct string_list_item *item;
> +
> +		item = string_list_lookup(data->paths, path);
> +		/* Not an interesting path to us */
> +		if (!item)
> +			continue;
> +		/* We already found its latest commit */
> +		if (item->util)
> +			continue;
> +
> +		item->util = data->commit;
> +		data->num_interesting--;
> +		if (data->callback)
> +			data->callback(path, data->commit, data->callback_data);
> +	}
> +}

So this is the per-commit processing. Basically we just do a diff for
each commit, and see if each path has been claimed.  Note that it
depends on the string-list item->util being initialized to zero. Hence
my recent patch to string-list, and this needs to go on top of 62b8102
(which is in master and maint).

Note that the further back you go in history, the less interesting most
of the diffs will be, so you waste a lot of time generating boring diffs
and then looking up those diffs in the string list (which is at least a
binary search). I considered an implementation where we literally just
do a 3-way merge-traversal of the old tree, the new tree, and the list
of paths still to be claimed. That would make it O(# of paths) for each
commit. But I decided against it because:

  1. It would be a lot more complex, having to hook into unpack_trees
     instead of the diff machinery.

  2. I'm not sure it would actually be that much faster. If prior
     measurements are any indication, we are probably spending most of
     our time unpacking the tree objects.

  3. It closes the door for more advanced diff machinery, like rename
     detection.

> +	while (data.num_interesting > 0 &&

An optimization; we can quit the traversal as soon as everything is
claimed. In practice this helps disappointingly little. Blaming git.git,
the last thing that gets claimed is tar.h, which saves only 3838 commits
(out of ~24500) being traversed. Similarly, COPYING in linux-2.6 is the
last, saving only 8378 commits out of ~232000. Still, every little bit
helps.

> +		if (commit->parents) {
> +			struct commit_list *p;
> +			for (p = commit->parents; p; p = p->next) {
> +				unsigned char from_sha1[20];
> +				if (get_tree_entry(p->item->object.sha1,
> +						   bt->prefix,
> +						   from_sha1, &mode) < 0)
> +					diff_root_tree_sha1(to_sha1, "",
> +							    &bt->rev.diffopt);
> +				else
> +					diff_tree_sha1(from_sha1, to_sha1,
> +						       "", &bt->rev.diffopt);
> +			}
> +		}

My merge handling is just "which files are different from the parents".
Which is reasonable, but I don't actually exercise it since we use
--no-merges by default. :)

We could try to do something clever here about evil merges. If the sha1
for a file is different in the merge from both parents, then we know
there was at least a conflict. So we could perhaps not blame the merge
for non-conflict cases pretty easily, and that would be more useful than
the current behavior.  But finding out if a conflicted file was simply
resolved or if content was introduced is much more expensive.

> +		else
> +			diff_root_tree_sha1(to_sha1, "", &bt->rev.diffopt);
> +		diff_flush(&bt->rev.diffopt);

Hmm. I mentioned rename detection previously. Probably I should
diffcore_std here so that it actually works.

> --- /dev/null
> +++ b/builtin/blame-tree.c
> [...]
> +static void show_entry(const char *path, const struct commit *commit, void *d)
> +{
> +	printf("%s\t", sha1_to_hex(commit->object.sha1));
> +	write_name_quoted(path, stdout, '\n');
> +	fflush(stdout);
> +}

This callback just shows entries and their commit sha1s as we find them
during the traversal.  So the output is not ordered by pathname, but
rather by traversal order (which is chronological-ish, though you can
also use --date-order to get a more certain ordering). It does keep the
output streaming, which is nice if you are incrementally filling in a
display.

Probably for a porcelain command we would want to collect and sort the
results by pathname. And show actual commit onelines instead of the
sha1.

> +int cmd_blame_tree(int argc, const char **argv, const char *prefix)
> +{
> +	struct blame_tree bt;
> +	const char *path = NULL;
> +
> +	git_config(git_default_config, NULL);
> +
> +	if (argv[1]) {
> +		path = argv[1];
> +		argc--;
> +		argv++;
> +	}

Obviously no options. Probably there should at least be "--porcelain" to
output the current form, and the default output should be more
user-friendly. And probably "-z" to avoid quoting issues.

> --- /dev/null
> +++ b/t/t8010-blame-tree.sh
> [...]
> +test_description='basic blame-tree tests'

These are extremely basic. If people can think of more interesting
corner cases, I'd love to exercise this more. I definitely need to
consider merge behavior a bit more and codify it in some tests. Probably
also diffcore stuff like renames and copies should be tested.

-Peff
