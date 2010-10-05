From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/4] Introduce wholesame directory move detection in
 diffcore.
Date: Mon, 4 Oct 2010 20:06:20 -0500
Message-ID: <20101005010620.GC9994@burratino>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Brian Ewins <brian.ewins@gmail.com>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 03:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2w2P-000689-4C
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0JEBJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 21:09:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41282 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab0JEBJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 21:09:41 -0400
Received: by ewy23 with SMTP id 23so2318371ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=L2n3VWPBbBe1Ialo9ui7vhxCYqfr+HA9Sqg98QqB2I4=;
        b=CKcIgfsashUPGFz8luGGnY2roihV9r0HD4O7Crr7WMJB7D21s8n0QU7OXqo8x2h1I5
         UW9bGxdwDYDVddbQrWh5VeLGzj1PMmoQ5NB9YfmUfobRp6VNXm9VtCJlJEZRT4p/V+vR
         vTJ9/UI4o3F4KzVsOLnQ6Yadix8n4ba6Hd/+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rqsZoGyXjEDP9kLLP0QAxJoJZ/wGZ4qJK2ikoP/pvAvzOQ+zScqY1G4w3z0qofhuj2
         norju1pRPZZKcY4wAksBdcw4iyu6JPGfJYkny3k2oG3ISwO6Xi+v42qFiOujpwM8uAlG
         e2V+Xk+I4TjirND8MMMdpx6+qTuPjy+17/MFI=
Received: by 10.14.37.10 with SMTP id x10mr6587165eea.33.1286240979995;
        Mon, 04 Oct 2010 18:09:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v8sm8293329eeh.2.2010.10.04.18.09.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 18:09:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286138529-6780-2-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158153>

Yann Dirson wrote:

> This feature tries to group together files moving from and to
> identical directories - the most common case being directory renames.

Intro for the uninitiated (e.g., me):

1. Entry point for the existing rename detection.

The entry point to diffcore's rename translator is diffcore_rename(),
which is used, naturally enough, by diffcore_std() if and only if
the detect_rename option is enabled.

2. Semantics of the existing rename detection.

When diffcore_std() is called, the caller has already queued up
a nice list of files to diff (see Documentation/technical/api-diff.txt).
The rename detection pass replaces the queue with a new list of
filepairs that reflects the detected renames, guided by the
detect_rename, rename_score, and rename_limit options.

3. Implementation of the existing rename detection.

 I.   find rename candidates (all files, if detecting copies; added and
       deleted files, if not)
 II.  find exact renames and copies
 III. for each target file not accounted for yet, find the best 4
       candidate source files
 IV.  record rename winners, in order from most to least similar pair
 V.   record copy winners, in order from most to least similar pair
 VI.  queue up results

4. Data maintained by the existing rename detection.

 rename_dst, a list of rename candidates from step I, sorted by name
 For each rename dest candidate: a filespec and a filepair.

  filepair::one		source filespec
  filepair::two		destination filespec
  filepair::score	similarity score

 rename_src, a list of rename candidates from step I, sorted by name
 For each rename source candidate: a filespec and a score

  filespec::rename_used	number of filespecs it's paired against
			(to distinguish renames from copies)

> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -208,7 +208,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  						    ce_option, &dirty_submodule);
>  		if (!changed && !dirty_submodule) {
>  			ce_mark_uptodate(ce);
> -			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> +			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> +			    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
>  				continue;
>  		}
>  		oldmode = ce->ce_mode;

Sane.  diff-files and friends need to pass unchanged files to the
diffcore lib when directory renames are being considered, just like
they would with -C -C.

Otherwise, we cannot distinguish between

	a/1 stays
	a/2 stays
	a/3 stays
	a/4 stays
	...
	a/1000 stays
	a/1001 -> b/1001
	a/1002 -> b/1002

which is clearly not a directory rename, and

	a/1001 -> b/1001
	a/1002 -> b/1002

which sure looks like one.

Reference: v0.99~515 (Diff overhaul, adding the other half of copy
detection, 2005-05-21).

> @@ -338,7 +339,8 @@ static int show_modified(struct rev_info *revs,
>  
>  	oldmode = old->ce_mode;
>  	if (mode == oldmode && !hashcmp(sha1, old->sha1) && !dirty_submodule &&
> -	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> +	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> +	    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
>  		return 0;

The diff-index part.

Would we also need something like v1.6.4-rc0~45^2 (Avoid "diff-index
--cached" optimization under --find-copies-harder, 2009-05-22) in
order to grok unchanged subtrees, or is that taken care of some other
way?

[...]
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -11,6 +11,7 @@
>  static struct diff_rename_dst {
>  	struct diff_filespec *two;
>  	struct diff_filepair *pair;
> +	int i_am_not_single:1; // does not look for a match, only here to be looked at
>  } *rename_dst;

If we're looking for directory renames but not finding-copies-harder,
then unmodified files, while interesting and deserving of dst entries,
should not be considered candidates for tracing individual files.

Yes?  If so, maybe the less colorful

	unsigned rename_target_candidate:1;

would make that clearer (and more importantly, the new kind of dst
entry should be mentioned in the commit log message).

> @@ -49,9 +50,36 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
>  	rename_dst[first].two = alloc_filespec(two->path);
>  	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
>  	rename_dst[first].pair = NULL;
> +	rename_dst[first].i_am_not_single = 0;
>  	return &(rename_dst[first]);
>  }

All new files are rename target candidates.

>  
> +static struct diff_rename_dst *locate_rename_dst_dir(struct diff_filespec *dir)
> +{
> +	/* code mostly duplicated from locate_rename_dst - not sure we
> +	 * could merge them efficiently,though
> +	 */
> +	int first, last;
> +	int prefixlength = strlen(dir->path);
> +
> +	first = 0;
> +	last = rename_dst_nr;
> +	while (last > first) {
> +		int next = (last + first) >> 1;
> +		struct diff_rename_dst *dst = &(rename_dst[next]);
> +		int cmp = strncmp(dir->path, dst->two->path, prefixlength);

prefixcmp?

> +		if (!cmp)
> +			return dst;
> +		if (cmp < 0) {
> +			last = next;
> +			continue;
> +		}
> +		first = next+1;
> +	}
> +	/* not found */
> +	return NULL;
> +}

Hmm, so this is like locate_rename_dst(..., 0), except it matches
prefixes.  Result is a rename_dst entry within that directory (why
not spend the time to find the first?).

> +
>  /* Table of rename/copy src files */
>  static struct diff_rename_src {
>  	struct diff_filespec *one;
> @@ -386,8 +414,11 @@ static int find_exact_renames(void)
>  	for (i = 0; i < rename_src_nr; i++)
>  		insert_file_table(&file_table, -1, i, rename_src[i].one);
>  
> -	for (i = 0; i < rename_dst_nr; i++)
> +	for (i = 0; i < rename_dst_nr; i++) {
> +		if (rename_dst[i].i_am_not_single)
> +			continue;
>  		insert_file_table(&file_table, 1, i, rename_dst[i].two);
> +	}

Prevents the new feature from turning on --find-copies-harder in
step II.  Good.

>  
>  	/* Find the renames */
>  	i = for_each_hash(&file_table, find_same_files);
> @@ -414,6 +445,180 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
>  		m[worst] = *o;
>  }
>  
> +struct diff_dir_rename {
> +	struct diff_filespec *one;
> +	struct diff_filespec *two;
> +	int discarded;
> +	struct diff_dir_rename* next;
> +};

A linked list of renamed directories.  What functions maintain it?

[...]
> +static const char* copy_dirname(char* dst, const char* src)

Discussed already.

[...]
> +static struct diff_dir_rename* factorization_candidates = NULL;
> +static void diffcore_factorize_renames(void)
> +{
> +	char one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
> +	int i;
> +
> +	for (i = 0; i < rename_dst_nr; i++) {

For each rename target candidate: ...

Would it make sense to give the body of this loop its own function?

> +		struct diff_dir_rename* seen;
> +
> +		// FIXME: what are those ?
> +		if (!rename_dst[i].pair)
> +			continue;

Genuine new files are not interesting to us (since they do not
provide evidence about directory renames, postive or negative).

> +		// dummy renames used by copy detection
> +		if (!strcmp(rename_dst[i].pair->one->path, rename_dst[i].pair->two->path))
> +			continue;

Whether a file was copied is probably interesting to us, but the
corresponding filepair isn't.

> +
> +		copy_dirname(one_parent_path, rename_dst[i].pair->one->path);
> +		copy_dirname(two_parent_path, rename_dst[i].pair->two->path);
> +
> +		// simple rename with no directory change
> +		if (!strcmp(one_parent_path, two_parent_path))
> +			continue;

File renames within a flat directory are not interesting to us.

> +
> +		struct diff_filespec* one_parent = alloc_filespec(one_parent_path);
> +		fill_filespec(one_parent, null_sha1 /*FIXME*/, S_IFDIR);

Initialize a filespec, for use in filepairs in case the containing
directories are a source/target pair. (?)

> +
> +		// After this commit, are there any files still under one_parent_path ?
> +		struct diff_rename_dst* one_leftover = locate_rename_dst_dir(one_parent);
> +		if (one_leftover) { // FIXME: should only be run if !seen
[...]
> +		}

A candidate for a separate function, no?  The idea, if I understand
it: too many unchanged files can disqualify a rename source.

> +
> +		// already considered ?
> +		for (seen=factorization_candidates; seen; seen = seen->next)
> +			if (!strcmp(seen->one->path, one_parent_path)) break;

Lookup.  A candidate for a separate function, I think.

> +		if (!seen) {
> +			// record potential dir rename
> +			seen = xmalloc(sizeof(*seen));
> +			seen->one = one_parent;
> +			seen->two = alloc_filespec(two_parent_path);
> +			fill_filespec(seen->two, null_sha1 /*FIXME*/, S_IFDIR);
> +			seen->discarded = 0;
> +			seen->next = factorization_candidates;
> +			factorization_candidates = seen;
> +			fprintf(stderr, "[DBG] %s -> %s suggests possible rename from %s to %s\n",
> +				rename_dst[i].pair->one->path,
> +				rename_dst[i].pair->two->path,
> +				one_parent_path, two_parent_path);

Insertion.  Likewise.

> +			continue;
> +		}
> +		if (seen->discarded)
> +			continue;

One disqualification disqualifies a directory completely.

> +		// check that seen entry matches this rename
> +		if (strcmp(two_parent_path, seen->two->path)) {
> +			fprintf(stderr, "[DBG] discarding dir %s from renames (split into %s and %s)\n",
> +				one_parent_path, two_parent_path, seen->two->path);
> +			seen->discarded = 1;
> +		}

If a directory split in two, it gets disqualified.  Ok.

> +
> +		/* all checks ok, we keep that entry */
> +	}
> +
> +	return;
> +}
> +
>  void diffcore_rename(struct diff_options *options)
>  {
>  	int detect_rename = options->detect_rename;
> @@ -451,13 +656,22 @@ void diffcore_rename(struct diff_options *options)
[...]
>  			if (detect_rename == DIFF_DETECT_COPY) {
>  				/*
>  				 * Increment the "rename_used" score by
>  				 * one, to indicate ourselves as a user.
>  				 */
>  				p->one->rename_used++;
>  				register_rename_src(p->one, p->score);
>  			}
> +			if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES)) {
> +				/* similarly, rename factorization needs to
> +				 * see all files from second tree, but we don't
> +				 * want them to be matched against single sources.
> +				 */
> +				locate_rename_dst(p->two, 1)->i_am_not_single = 1;

... except when --find-copies-harder is being used, right?

So I suspect there needs to be a

	DIFF_OPT_TST(options, FIND_COPIES_HARDER)

somewhere around here.

> @@ -509,6 +723,8 @@ void diffcore_rename(struct diff_options *options)
>  
>  		if (rename_dst[i].pair)
>  			continue; /* dealt with exact match already. */
> +		if (rename_dst[i].i_am_not_single)
> +			continue; /* not looking for a match. */
>  
>  		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
>  		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)

Prevents the new feature from turning on --find-copies-harder in
step III.  Good.

> @@ -569,7 +785,28 @@ void diffcore_rename(struct diff_options *options)
>  	/* At this point, we have found some renames and copies and they
>  	 * are recorded in rename_dst.  The original list is still in *q.
>  	 */
> +
> +	/* Now possibly factorize those renames and copies. */
> +	if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
> +		diffcore_factorize_renames();
> +
>  	DIFF_QUEUE_CLEAR(&outq);
> +
> +	// Now turn non-discarded factorization_candidates into real renames
> +	struct diff_dir_rename* candidate;
> +	for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
> +		struct diff_filepair* pair;
> +		if (candidate->discarded) continue;
> +		// visualize toplevel dir if needed - FIXME: wrong place for this ?
> +		if (!*candidate->one->path)
> +			candidate->one->path = "./";
> +		if (!*candidate->two->path)
> +			candidate->two->path = "./";
> +		pair = diff_queue(&outq, candidate->one, candidate->two);
> +		pair->score = MAX_SCORE;
> +		pair->renamed_pair = 1;

Outputting the discovered directory renames.

> +	}
> +
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		struct diff_filepair *pair_to_free = NULL;
> diff --git a/tree-diff.c b/tree-diff.c
> index cd659c6..ca0b84f 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -49,7 +49,9 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
>  		show_entry(opt, "+", t2, base, baselen);
>  		return 1;
>  	}
> -	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
> +	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) &&
> +	    !DIFF_OPT_TST(opt, DETECT_DIR_RENAMES) &&
> +	    !hashcmp(sha1, sha2) && mode1 == mode2)
>  		return 0;

Right, makes sense.

Conclusions:

 - the basic idea looks sane
 - the main function would benefit a lot from being split up a bit
 - would be nice to have an overview of the design (especially, a
   quick description of the heuristics used) for the commit message

Looks promising, and a lot simpler than I feared. :)

Thanks.
