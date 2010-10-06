From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v4 1/4] Introduce wholesame directory move detection in
 diffcore.
Date: Thu, 7 Oct 2010 01:13:08 +0200
Message-ID: <20101006231308.GY4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <20101005010620.GC9994@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3d0z-00075l-7x
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0JFXDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 19:03:06 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:49150 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183Ab0JFXDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:03:05 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id EA848D4809D;
	Thu,  7 Oct 2010 01:02:57 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P3dAa-0005KA-WF; Thu, 07 Oct 2010 01:13:09 +0200
Content-Disposition: inline
In-Reply-To: <20101005010620.GC9994@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158345>

On Mon, Oct 04, 2010 at 08:06:20PM -0500, Jonathan Nieder wrote:
> > @@ -338,7 +339,8 @@ static int show_modified(struct rev_info *revs,
> >  
> >  	oldmode = old->ce_mode;
> >  	if (mode == oldmode && !hashcmp(sha1, old->sha1) && !dirty_submodule &&
> > -	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> > +	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> > +	    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
> >  		return 0;
> 
> The diff-index part.
> 
> Would we also need something like v1.6.4-rc0~45^2 (Avoid "diff-index
> --cached" optimization under --find-copies-harder, 2009-05-22) in
> order to grok unchanged subtrees, or is that taken care of some other
> way?

Note to self: look at that

> [...]
> > --- a/diffcore-rename.c
> > +++ b/diffcore-rename.c
> > @@ -11,6 +11,7 @@
> >  static struct diff_rename_dst {
> >  	struct diff_filespec *two;
> >  	struct diff_filepair *pair;
> > +	int i_am_not_single:1; // does not look for a match, only here to be looked at
> >  } *rename_dst;
> 
> If we're looking for directory renames but not finding-copies-harder,
> then unmodified files, while interesting and deserving of dst entries,
> should not be considered candidates for tracing individual files.
> 
> Yes?  If so, maybe the less colorful
> 
> 	unsigned rename_target_candidate:1;
> 
> would make that clearer

Right - but maybe we can use a separate list for those non-candidates
as I suggested elsewhere, to make things even more clear.

> (and more importantly, the new kind of dst entry should be mentioned
> in the commit log message).

Hm, the commit message is a bit long already, isn't that too much detail ?


> > +static struct diff_rename_dst *locate_rename_dst_dir(struct diff_filespec *dir)
> > +{
> > +	/* code mostly duplicated from locate_rename_dst - not sure we
> > +	 * could merge them efficiently,though
> > +	 */
> > +	int first, last;
> > +	int prefixlength = strlen(dir->path);
> > +
> > +	first = 0;
> > +	last = rename_dst_nr;
> > +	while (last > first) {
> > +		int next = (last + first) >> 1;
> > +		struct diff_rename_dst *dst = &(rename_dst[next]);
> > +		int cmp = strncmp(dir->path, dst->two->path, prefixlength);
> 
> prefixcmp?

Since prefixlength is constant accross the loop, strncmp spares
comparing every char with \0 - we only do that once.  I guess it's
worth keeping.

> > +		if (!cmp)
> > +			return dst;
> > +		if (cmp < 0) {
> > +			last = next;
> > +			continue;
> > +		}
> > +		first = next+1;
> > +	}
> > +	/* not found */
> > +	return NULL;
> > +}
> 
> Hmm, so this is like locate_rename_dst(..., 0), except it matches
> prefixes.  Result is a rename_dst entry within that directory (why
> not spend the time to find the first?).

We just don't need the first.  In most cases, finding one entry just
invalidates the possiblity of a bulk move.  Then when we want all of
them, we have to scan the list in both directions - and yes, a clean
way to avoid code duplication would be nice for those.

> >  
> >  	/* Find the renames */
> >  	i = for_each_hash(&file_table, find_same_files);
> > @@ -414,6 +445,180 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
> >  		m[worst] = *o;
> >  }
> >  
> > +struct diff_dir_rename {
> > +	struct diff_filespec *one;
> > +	struct diff_filespec *two;
> > +	int discarded;
> > +	struct diff_dir_rename* next;
> > +};
> 
> A linked list of renamed directories.  What functions maintain it?

That is just the type decl.  For this patch it is only used from
diffcore_factorize_renames() and diffcore_rename(), but the
--hide-dir-rename-details part needs it for maybe_mark_uninteresting,
which explains its position in the source file.

> [...]
> > +static struct diff_dir_rename* factorization_candidates = NULL;
> > +static void diffcore_factorize_renames(void)
> > +{
> > +	char one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
> > +	int i;
> > +
> > +	for (i = 0; i < rename_dst_nr; i++) {
> 
> For each rename target candidate: ...
> 
> Would it make sense to give the body of this loop its own function?

Yes, that makes things more readable.

> > +		struct diff_dir_rename* seen;
> > +
> > +		// FIXME: what are those ?
> > +		if (!rename_dst[i].pair)
> > +			continue;
> 
> Genuine new files are not interesting to us (since they do not
> provide evidence about directory renames, postive or negative).

Well, maybe except for Junio's idea of using bulk-rename detection to
bump rename scores (we may want to look at that afterwards, but I fear
it will require heavy surgery).


> > +		// dummy renames used by copy detection
> > +		if (!strcmp(rename_dst[i].pair->one->path, rename_dst[i].pair->two->path))
> > +			continue;
> 
> Whether a file was copied is probably interesting to us, but the
> corresponding filepair isn't.

Good point: bulk-rename can already be made to direct move+copy
detection to select the correct dst for the move.

> > +
> > +		struct diff_filespec* one_parent = alloc_filespec(one_parent_path);
> > +		fill_filespec(one_parent, null_sha1 /*FIXME*/, S_IFDIR);
> 
> Initialize a filespec, for use in filepairs in case the containing
> directories are a source/target pair. (?)

We need a filespec for locate_rename_dst_dir, but it is silly, we can
just pass it a path string, and initialize the filespec when really
needed.  Good catch.
 
> > +
> > +		// After this commit, are there any files still under one_parent_path ?
> > +		struct diff_rename_dst* one_leftover = locate_rename_dst_dir(one_parent);
> > +		if (one_leftover) { // FIXME: should only be run if !seen
> [...]
> > +		}
> 
> A candidate for a separate function, no?

Right.

> The idea, if I understand it: too many unchanged files can
> disqualify a rename source.

Not exactly: any file left in a dir disqualifies this dir for bulk-rename.

> > +
> > +		// already considered ?
> > +		for (seen=factorization_candidates; seen; seen = seen->next)
> > +			if (!strcmp(seen->one->path, one_parent_path)) break;
> 
> Lookup.  A candidate for a separate function, I think.
> 
> > +		if (!seen) {
> > +			// record potential dir rename
> > +			seen = xmalloc(sizeof(*seen));
> > +			seen->one = one_parent;
> > +			seen->two = alloc_filespec(two_parent_path);
> > +			fill_filespec(seen->two, null_sha1 /*FIXME*/, S_IFDIR);
> > +			seen->discarded = 0;
> > +			seen->next = factorization_candidates;
> > +			factorization_candidates = seen;
> > +			fprintf(stderr, "[DBG] %s -> %s suggests possible rename from %s to %s\n",
> > +				rename_dst[i].pair->one->path,
> > +				rename_dst[i].pair->two->path,
> > +				one_parent_path, two_parent_path);
> 
> Insertion.  Likewise.

Hm, it's only used once, and once the other splits are done the func
fits on a screen (at least on my display ;)

OTOH, if we decide for a sorted list, to allow for binary search to be
more efficient, then yes.

> > +
> > +		/* all checks ok, we keep that entry */
> > +	}
> > +
> > +	return;
> > +}
> > +
> >  void diffcore_rename(struct diff_options *options)
> >  {
> >  	int detect_rename = options->detect_rename;
> > @@ -451,13 +656,22 @@ void diffcore_rename(struct diff_options *options)
> [...]
> >  			if (detect_rename == DIFF_DETECT_COPY) {
> >  				/*
> >  				 * Increment the "rename_used" score by
> >  				 * one, to indicate ourselves as a user.
> >  				 */
> >  				p->one->rename_used++;
> >  				register_rename_src(p->one, p->score);
> >  			}
> > +			if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES)) {
> > +				/* similarly, rename factorization needs to
> > +				 * see all files from second tree, but we don't
> > +				 * want them to be matched against single sources.
> > +				 */
> > +				locate_rename_dst(p->two, 1)->i_am_not_single = 1;
> 
> ... except when --find-copies-harder is being used, right?

I have not investigated interactions with copy detection yet.


> > @@ -569,7 +785,28 @@ void diffcore_rename(struct diff_options *options)
> >  	/* At this point, we have found some renames and copies and they
> >  	 * are recorded in rename_dst.  The original list is still in *q.
> >  	 */
> > +
> > +	/* Now possibly factorize those renames and copies. */
> > +	if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
> > +		diffcore_factorize_renames();
> > +
> >  	DIFF_QUEUE_CLEAR(&outq);
> > +
> > +	// Now turn non-discarded factorization_candidates into real renames
> > +	struct diff_dir_rename* candidate;
> > +	for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
> > +		struct diff_filepair* pair;
> > +		if (candidate->discarded) continue;
> > +		// visualize toplevel dir if needed - FIXME: wrong place for this ?
> > +		if (!*candidate->one->path)
> > +			candidate->one->path = "./";
> > +		if (!*candidate->two->path)
> > +			candidate->two->path = "./";
> > +		pair = diff_queue(&outq, candidate->one, candidate->two);
> > +		pair->score = MAX_SCORE;
> > +		pair->renamed_pair = 1;
> 
> Outputting the discovered directory renames.

Not really outputting, just queueing for ouput here.


> Conclusions:
> 
>  - the basic idea looks sane
>  - the main function would benefit a lot from being split up a bit
>  - would be nice to have an overview of the design (especially, a
>    quick description of the heuristics used) for the commit message

Thanks for this detailed review.  Pushing to
http://repo.or.cz/w/git/ydirson.git a set of patches addressing those
remarks and others from this thread.
