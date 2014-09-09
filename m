From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 8/8] log --remerge-diff: show what the conflict resolution changed
Date: Tue, 09 Sep 2014 11:58:52 -0700
Message-ID: <xmqqy4tsk4cz.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<29c15efe998630143eaa75ec7155a31ce17bd433.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRQfW-00085m-TC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbaIIS67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 14:58:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62617 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbaIIS64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 14:58:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43D1B377FC;
	Tue,  9 Sep 2014 14:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ifOizvjUh8aokmmF8QnqCpFzbzs=; b=CkdbSv
	JgA5AGAEP4cISM4cJ7Vg37yzkxvyIMbt3tDpoRAg5bJVMgdS1V7Ek2SepYDdzfim
	Lu+oNXN+sdEllib+riykumkmtRh2xPeSu93EAZ74Pv92IqF+Kt56AzPJ0igfgZv3
	3GgJ55FjWxpkwvU1PSBgREm2QDeckW7uQh1rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CAM5RONqUUK/wO2M4brD1lSvc3NC1cWp
	C+JL+KVuWVS9wJKnLGB1z98mJ1uOFJG58EiyzbLTr5irOhQxiFCoDGEOPTTMIgvS
	T8KE+1owQaIXhx/XJG/Wk9QgxUF2Bf38BnyvHSvUuBt1YlEYlcpZfKFf00nN8GkP
	UFzi9zj9JI0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AD93377FB;
	Tue,  9 Sep 2014 14:58:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D86A377F9;
	Tue,  9 Sep 2014 14:58:54 -0400 (EDT)
In-Reply-To: <29c15efe998630143eaa75ec7155a31ce17bd433.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5871DA44-3853-11E4-A503-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256702>

Thomas Rast <tr@thomasrast.ch> writes:

Thomas Rast <tr@thomasrast.ch> writes:

> Git has --cc as a very fast inspection tool that shows a brief summary
> of what a conflicted merge "looks like", and -c/-m as "give me the
> full information" data dumps.
>
> But --cc actually loses information: if the merge lost(!) some changes
> from one side, that hunk would fully agree with the other side, and
> therefore be elided.  So --cc cannot be used to investigate mismerges.
> Indeed it is rather hard to find a merge that has lost changes, unless
> one knows where to look.
>
> The new option --remerge-diff is an attempt at filling this gap,
> admittedly at the cost of a lot of CPU cycles.  For each merge commit,
> it diffs the merge result against a recursive merge of the merge's
> parents.
>
> For files that can be auto-merged cleanly, it will typically show
> nothing.  However, it will make it obvious when the merge introduces
> extra changes.
>
> For files that result in merge conflicts, we diff against the
> representation with conflict hunks (what the user would usually see in
> the worktree).  So the diff will show what was changed in the conflict
> hunks to resolve the conflict.
>
> It still takes a bit of staring to tell an evil from a regular merge.
> But at least the information is there, unlike with --cc; and the
> output is usually much shorter than with -c.
>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
>  Documentation/rev-list-options.txt |   7 +
>  log-tree.c                         | 297 +++++++++++++++++++++++++++++++++++++
>  merge-recursive.c                  |   3 +-
>  merge-recursive.h                  |   1 +
>  revision.c                         |   2 +
>  revision.h                         |   4 +-
>  t/t4213-log-remerge-diff.sh        | 222 +++++++++++++++++++++++++++
>  7 files changed, 534 insertions(+), 2 deletions(-)
>  create mode 100755 t/t4213-log-remerge-diff.sh
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index deb8cca..7128350 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -805,6 +805,13 @@ options may be given. See linkgit:git-diff-files[1] for more options.
>  	in that case, the output represents the changes the merge
>  	brought _into_ the then-current branch.
>  
> +--remerge-diff::
> +	Diff merge commits against a recursive merge of their parents,
> +	with conflict hunks.  Intuitively speaking, this shows what
> +	the author of the merge changed to resolve the merge.  It
> +	assumes that all (or most) merges are recursive merges; other
> +	strategies are not supported.
> +
>  -r::
>  	Show recursive diffs.
>  
> diff --git a/log-tree.c b/log-tree.c
> index 8f57651..4db1385 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -11,6 +11,8 @@
>  #include "gpg-interface.h"
>  #include "sequencer.h"
>  #include "line-log.h"
> +#include "cache-tree.h"
> +#include "merge-recursive.h"
>  
>  struct decoration name_decoration = { "object names" };
>  
> @@ -719,6 +721,299 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
>  }
>  
>  /*
> + * Helpers for make_asymmetric_conflict_entries() below.
> + */
> +static char *load_cache_entry_blob(struct cache_entry *entry,
> +				   unsigned long *size)
> +{
> +	enum object_type type;
> +	void *data;
> +
> +	if (!entry)
> +		return NULL;
> +
> +	data = read_sha1_file(entry->sha1, &type, size);
> +	if (type != OBJ_BLOB)
> +		die("BUG: load_cache_entry_blob for non-blob");
> +
> +	return data;
> +}
> +
> +static void strbuf_append_cache_entry_blob(struct strbuf *sb,
> +					   struct cache_entry *entry)
> +{
> +	unsigned long size;
> +	char *data = load_cache_entry_blob(entry, &size);;
> +
> +	if (!data)
> +		return;
> +
> +	strbuf_add(sb, data, size);
> +	free(data);
> +}
> +
> +static void assemble_conflict_entry(struct strbuf *sb,
> +				    const char *branch1,
> +				    const char *branch2,
> +				    struct cache_entry *entry1,
> +				    struct cache_entry *entry2)
> +{
> +	strbuf_addf(sb, "<<<<<<< %s\n", branch1);
> +	strbuf_append_cache_entry_blob(sb, entry1);
> +	strbuf_addstr(sb, "=======\n");
> +	strbuf_append_cache_entry_blob(sb, entry2);
> +	strbuf_addf(sb, ">>>>>>> %s\n", branch2);
> +}

Hmm, what is this one doing?  I would have expected that you would
give file-level three-way merge using ll_merge machinery here.  For
a conflicted path with two entries, using an empty buffer as the
common ancestor would give you a reasonable-looking two-way
no-parent merge.

> +/*
> + * For --remerge-diff, we need conflicted (<<<<<<< ... >>>>>>>)
> + * representations of as many conflicts as possible.  Default conflict
> + * generation only applies to files that have all three stages.
> + *
> + * This function generates conflict hunk representations for files
> + * that have only one of stage 2 or 3.  The corresponding side in the
> + * conflict hunk format will be empty.  A stage 1, if any, will be
> + * dropped in the process.
> + */
> +static void make_asymmetric_conflict_entries(const char *branch1,
> +					     const char *branch2)
> +{
> +	int o = 0, i = 0;
> +
> +	/*
> +	 * NEEDSWORK: we trample all over the cache below, so we need
> +	 * to set up the name hash early, before modifying it.  And
> +	 * after that we cannot free any cache entries, because they
> +	 * remain hashed even if deleted.  Sigh.
> +	 */
> +	init_name_hash(&the_index, 1);
> +
> +	/*
> +	 * The loop always starts with 'i' pointing at the first entry
> +	 * for a pathname.
> +	 */
> +	while (i < active_nr) {
> +		struct cache_entry *ce;
> +		struct cache_entry *stage1 = NULL;
> +		struct cache_entry *stage2 = NULL;
> +		struct cache_entry *stage3 = NULL;
> +		struct cache_entry *new_ce = NULL;
> +		struct strbuf content = STRBUF_INIT;
> +		unsigned char sha1[20];
> +
> +		assert(o <= i);
> +
> +		ce = active_cache[i];
> +
> +		/*
> +		 * Pass through stage 0 and submodules unchanged, we
> +		 * don't know how to handle them.
> +		 */
> +		if (ce_stage(ce) == 0
> +		    || S_ISGITLINK(ce->ce_mode)) {

unnecessary line folding?

> +			active_cache[o++] = ce;
> +			i++;
> +			continue;
> +		}
> +
> +		/*
> +		 * Collect the stages we have.  Point 'i' past the
> +		 * entry.
> +		 */
> +		if (/* i < active_nr && */

Why is this commented out?

Is it because ce === active_cache[i] and i that was i < active_nr at
the top has not been incremented yet?  If so, shouldn't the strcmp()
on the next line also be unnecessary?

> +		    !strcmp(ce->name, active_cache[i]->name) &&
> +		    ce_stage(active_cache[i]) == 1)
> +			stage1 = active_cache[i++];
> +
> +		if (i < active_nr &&
> +		    !strcmp(ce->name, active_cache[i]->name) &&
> +		    ce_stage(active_cache[i]) == 2)
> +			stage2 = active_cache[i++];
> +
> +		if (i < active_nr &&
> +		    !strcmp(ce->name, active_cache[i]->name) &&
> +		    ce_stage(active_cache[i]) == 3)
> +			stage3 = active_cache[i++];
> +
> +		if (!stage2 && !stage3)
> +			die("BUG: merging resulted in conflict with neither "
> +			    "stage 2 nor 3");

... which would mean that the caller did not resolve "both deleted"
into "delete from the result".  Sensible.

> +		if (cache_dir_exists(ce->name, ce->ce_namelen)) {
> +			/*
> +			 * If a conflicting directory for this entry exists,
> +			 * we can drop it:
> +			 *
> +			 * In the face of a file/directory conflict,
> +			 * merge-recursive
> +			 * - puts the file at stage >0 as usual
> +			 * - also attempts to check out the file as
> +			 *   'file~side' where side is the sha1 of the commit
> +			 *   the file came from, to avoid colliding with the
> +			 *   directory
> +			 *
> +			 * But we have requested that files go to the index
> +			 * instead of the worktree, so by the time we get
> +			 * here, we have both stage>0 'file' from ordinary
> +			 * merging and a stage=0 'file~side' from the "write
> +			 * all files to index".
> +			 *
> +			 * We need to remove one of them.  Currently we ditch
> +			 * the 'file' entry because it's easier to detect.
> +			 * This amounts to always renaming the file to make
> +			 * room for the directory.

Good explanation.

> +			 * NEEDSWORK: Two options:
> +			 *
> +			 * - If the merge result kept the file, it would be
> +			 *   better to rename the _directory_ to make room for
> +			 *   the file, so that filenames match between the
> +			 *   result and the re-merge.
> +			 *
> +			 * - Or we could avoid going through a tree, since the
> +			 *   index can represent (though it's not "legal") a
> +			 *   file/directory collision just fine.

If you are going to compare the resulting garbage with an existing
tree, it is not "just fine even though illegal", I suspect.  It is
just a garbage.

> +			 */
> +		} else {
> +			/*
> +			 * Otherwise, there is room for a file entry
> +			 * at stage 0.  It has fake-conflict content,
> +			 * but its mode is the same.
> +			 */
> +
> +			assemble_conflict_entry(&content,
> +						branch1, branch2,
> +						stage2, stage3);

Need to ask the conflict-marker-size for the ce->name path and tell
the callee to use it, perhaps?

> +			if (write_sha1_file(content.buf, content.len,
> +					    typename(OBJ_BLOB), sha1))
> +				die("write_sha1_file failed");
> +			strbuf_release(&content);
> +
> +			new_ce = xcalloc(1, cache_entry_size(ce->ce_namelen));
> +			new_ce->ce_mode = ce->ce_mode;
> +			new_ce->ce_flags = ce->ce_flags & ~CE_STAGEMASK;
> +			new_ce->ce_namelen = ce->ce_namelen;
> +			hashcpy(new_ce->sha1, sha1);
> +			memcpy(new_ce->name, ce->name, ce->ce_namelen+1);
> +			active_cache[o++] = new_ce;
> +			add_name_hash(&the_index, new_ce);

Invalidate the cache-tree entry here?

An easier alternative may be to drop the cache-tree at the very
beginning and not worry about it, as you are not going to write this
out as a tree (or save it as an on-disk index for somebody else to
later write a tree out of), but there is a rumor that since a0919ce
"diff-index --cached" sees a large performance gain with cache-tree,
so dropping the cache-tree entirely may be too huge a hammer.  It
needs to be measured.

I haven't read the series enough to know who calls this with an
index in what state, so all of the above might be a moot point.  For
example, three-way merge would drop the cache-tree at the very
beginning anyway, so if the caller is doing such a merge and giving
us such an index, then just dropping the cache-tree at the beginning
to protect yourself from future changes in the caller may turn out
to be the simplest.  The same comment applies to drop-non-stage0.

> +/*
> + * --remerge-diff doesn't currently handle entries that cannot be
> + * turned into a stage0 conflicted-file format blob.  So this routine
> + * clears the corresponding entries from the index.  This is
> + * suboptimal; we should eventually handle them _somehow_.
> +*/
> +static void drop_non_stage0()

"static void drop_unmerged_entries(void)", perhaps?

> +static int do_diff_remerge(struct rev_info *opt, struct commit *commit)
> +{
> +	struct commit_list *merge_bases;
> +	struct commit *result, *parent1, *parent2;
> +	struct merge_options o;
> +	char *branch1, *branch2;
> +	struct cache_tree *orig_cache_tree;
> +
> +	/*
> +	 * We show the log message early to avoid headaches later.  In
> +	 * general we need to run this before printing anything in
> +	 * this routine.
> +	 */

Huh?  What if the merge turns out to be a no-op, in which case you
should not print anything here?

> +	if (opt->loginfo && !opt->no_commit_id) {
> +		show_log(opt);
> +
> +		if (opt->verbose_header && opt->diffopt.output_format)
> +			printf("%s%c", diff_line_prefix(&opt->diffopt),
> +			       opt->diffopt.line_termination);
> +	}
> +
> +	if (commit->parents->next->next) {
> +		printf("--remerge-diff not supported for octopus merges.\n");
> +		return !opt->loginfo;
> +	}
> +
> +	parent1 = commit->parents->item;
> +	parent2 = commit->parents->next->item;
> +	parse_commit(parent1);
> +	parse_commit(parent2);
> +	branch1 = xstrdup(sha1_to_hex(parent1->object.sha1));
> +	branch2 = xstrdup(sha1_to_hex(parent2->object.sha1));
> +
> +	merge_bases = get_octopus_merge_bases(commit->parents);

Hmm, why not get_merge_bases()?

> +	init_merge_options(&o);
> +	o.verbosity = -1;
> +	o.no_worktree = 1;
> +	o.conflicts_in_index = 1;
> +	o.use_ondisk_index = 0;
> +	o.branch1 = branch1;
> +	o.branch2 = branch2;

Hmm.  Usual merge_recursive() does in-core virtual merges and then
builds the final one on top of the current index which represents
what would have come from parent1.  Here you are (correctly)
refusing the on-disk index, which does not have anything to do with
parent1, to be used.  Now at this point, what does the_index have?
Ideally, you wouldn't have made any read_cache() call, as you are
not interested in the current working tree state at all in "git
log", and the call to merge_recursive() will discard_cache() anyway,
so you will start from an empty in-core index.

> +	merge_recursive(&o, parent1, parent2, merge_bases, &result);

> +	make_asymmetric_conflict_entries(branch1, branch2);
> +	drop_non_stage0();
> +
> +	free(branch1);
> +	free(branch2);
> +
> +	orig_cache_tree = the_index.cache_tree;

... which makes me wonder what you are saving here, and ...

> +	the_index.cache_tree = cache_tree();
> +	if (cache_tree_update(&the_index, WRITE_TREE_SILENT) < 0) {
> +		printf("BUG: merge conflicts not fully folded, cannot diff.\n");
> +		return !opt->loginfo;
> +	}

... why you run cache-tree-update here.

Ahh, this is a "write_tree()", because you want to run
diff-tree-sha1?

I wondered why you are not doing diff_cache() from diff-lib.c
instead, but I think that is because it punts on unmerged entries
with "* Unmerged path $pathname".  Teaching "diff-index --cached -p"
an option to give a remerge diff may give us a useful tool that can
be used _during_ a merge resolution.

    $ git merge other
    ... results in conflicts
    $ git diff
    ... shows the working tree content and the initial conflict
    $ edit
    $ git diff
    ... shows your partial resolution in the working tree and the
    ... initial conflict
    $ git diff HEAD
    ... shows your partial resolution in the working tree and the HEAD
    $ git diff --cached HEAD
    ... shows the initial conflict and the HEAD, may be useful when
    ... you are lost

On second thought, that may not be so useful after all.  I dunno
until I see one ;-).

> +	diff_tree_sha1(the_index.cache_tree->sha1, commit->tree->object.sha1,
> +		       "", &opt->diffopt);
> +	log_tree_diff_flush(opt);
> +
> +	cache_tree_free(&the_index.cache_tree);
> +	the_index.cache_tree = orig_cache_tree;

In any case, I do not understand what we are trying to save and
restore here.
