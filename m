From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Sun, 19 May 2013 23:02:06 +0100
Message-ID: <20130519220206.GK27005@serenity.lan>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130519193612.GH3362@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 00:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeBgO-0000Wd-9l
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 00:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab3ESWCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 18:02:19 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38171 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab3ESWCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 18:02:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D464FCDA5CD;
	Sun, 19 May 2013 23:02:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y9nqYhNuSPGq; Sun, 19 May 2013 23:02:16 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 33C2ACDA52A;
	Sun, 19 May 2013 23:02:15 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D84D1161E26E;
	Sun, 19 May 2013 23:02:15 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4P5Zu2r3PkVY; Sun, 19 May 2013 23:02:14 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 06936161E1A5;
	Sun, 19 May 2013 23:02:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130519193612.GH3362@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224926>

On Sun, May 19, 2013 at 12:36:12PM -0700, Jonathan Nieder wrote:
> John Keeping wrote:
> 
> > In this case, it is likely that only a small number of paths are touched
> > by the commits on the smaller side of the range and by storing these we
> > can ignore many commits on the other side before unpacking blobs and
> > diffing them.
> 
> I like this idea a lot.
> 
> > --- a/patch-ids.c
> > +++ b/patch-ids.c
> > @@ -1,5 +1,6 @@
> >  #include "cache.h"
> >  #include "diff.h"
> > +#include "diffcore.h"
> >  #include "commit.h"
> >  #include "sha1-lookup.h"
> >  #include "patch-ids.h"
> > @@ -16,6 +17,137 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
> >  	return diff_flush_patch_id(options, sha1);
> >  }
> >  
> > +struct collect_paths_info {
> > +	struct string_list *paths;
> > +	int searching;
> > +};
> > +
> > +static int collect_paths_recursive(int n, struct tree_desc *t,
> > +	const char *base, struct pathspec *pathspec,
> > +	struct collect_paths_info *data);
> 
> Can you say a little about how this function works (e.g., in a
> comment)?  What are the preconditions and postconditions?  How does
> the state evolve (e.g, when is "searching" set)?

As you figure out below, the patch ID API has two modes, "compute and
store" and "have we seen before".  The "searching" flag passes this
information down as we recursively compare the before and after trees
for a commit.  So when we hit a file that is changed by the commit we
either add it to the list of touched paths or tests if it is in the list
and stops comparing the trees if it isn't.

> > +
> > +static int same_entry(struct name_entry *a, struct name_entry *b)
> > +{
> > +	if (!a->sha1 || !b->sha1)
> > +		return a->sha1 == b->sha1;
> > +	return	!hashcmp(a->sha1, b->sha1) &&
> > +		a->mode == b->mode;
> 
> Style: unusual whitespace (the tab after "return").  I'd just do
> 
> 	if (!a->sha1 || ...)
> 		return ...
> 	return !hashcmp(a->sha1, b->sha1) && a->mode == b->mode;
> 
> since it is not too long.

Makes sense, I copied from the function of the same name in
builtin/merge-tree.c, although I then changed the semantics for
non-existent entries.

> [...]
> > +static char *traverse_path(const struct traverse_info *info,
> > +		const struct name_entry *n)
> > +{
> > +	char *path = xmalloc(traverse_path_len(info, n) + 1);
> > +	return make_traverse_path(path, info, n);
> > +}
> 
> This function seems to be the same as one of the same name in
> builtin/merge-tree.c.  Should it be put somewhere more public, for
> example as part of the tree-walk API?  Who is responsible for freeing
> "path"?  Would it make sense to use a strbuf here?
> 
> 	strbuf_setlen(&buf, traverse_path_len(info, n));
> 	make_traverse_path(&buf.buf, info, n);

Perhaps alloc_traverse_path?  I'm not sure the strbuf buys us much for
this case, since we only use the result for a few lines before freeing
it.

> > +
> > +static int add_touched_path(struct collect_paths_info *info, const char *path)
> > +{
> > +	if (info->searching) {
> > +		if (!string_list_has_string(info->paths, path))
> > +			return -1;
> > +	}
> > +	string_list_insert(info->paths, path);
> > +	return 0;
> > +}
> 
> Same question about internal API: when I see
> 
> 	add_touched_path(info, path)
> 
> what should I expect it to do?

Yeah, this patch suffers a lot from writing separate "collect" and
"check" codepaths and refactoring out common functionality later.

Perhaps all of the collect_* functions should be changed_paths_* and
then this is "process_changed_path".

> In the info->searching case, "string_list_insert(info->paths, path)"
> will always be a no-op, right?  What does it mean that this is adding
> a touched path in that case?
> 
> [...]
> > +static int collect_touched_paths_cb(int n, unsigned long mask,
> > +		unsigned long dirmask, struct name_entry *entry,
> > +		struct traverse_info *info)
> > +{
> 
> Same question about contracts.  Ideally a reader in a rush should be
> able to read an opening comment about what the function does and
> then return to the caller without delving into the details of how
> it does its work.
> 
> > +	struct collect_paths_info *collect_info = info->data;
> > +	if (n == 1) {
> > +		/* We're handling a root commit - add all the paths. */
> [...]
> > +	if ((entry[0].sha1 && S_ISDIR(entry[0].mode)) ||
> > +	    (entry[1].sha1 && S_ISDIR(entry[1].mode))) {
> 
> At this point I'm not sure what two trees are being traversed in
> parallel, so it's not obvious to me what the code's about.  Are
> they the "before" and "after" trees for commits being rebased?
> 
> [...]
> > +static int collect_touched_paths(struct commit *commit, struct patch_ids *ids,
> > +		int searching)
> > +{
> > +	struct tree_desc trees[2];
> > +	struct collect_paths_info info = { &ids->touched_paths, searching };
> > +	void *commitbuf;
> > +	int result;
> > +
> > +	commitbuf = fill_tree_descriptor(trees + 1, commit->object.sha1);
> > +	if (commit->parents) {
> > +		void *parentbuf = fill_tree_descriptor(trees + 0,
> > +					commit->parents->item->object.sha1);
> 
> Looks like yes.
> 
> What should happen for commits with more than 1 parent?  If they're
> supposed to not enter this codepath because of a previous check, a
> die("BUG: ...") could be a good way to make reading easier.

Currently the patch ID code compares the commit with its first parent,
so I think this should do the same.  I posted about this in relation to
revision.c earlier [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/224884

> [...]
> > @@ -40,6 +172,7 @@ int init_patch_ids(struct patch_ids *ids)
> >  	diff_setup(&ids->diffopts);
> >  	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
> >  	diff_setup_done(&ids->diffopts);
> > +	ids->touched_paths.strdup_strings = 1;
> 
> Good.
> 
> [...]
> > @@ -64,6 +199,13 @@ static struct patch_id *add_commit(struct commit *commit,
> >  	unsigned char sha1[20];
> >  	int pos;
> >  
> > +	if (no_add) {
> > +		if (collect_touched_paths(commit, ids, 1) < 0)
> > +			return NULL;
> 
> Ah, so this is what the "searching" does.
> 
> The existing "no_add" argument is very confusing (what does it mean to
> add a commit without adding?), but at least the confusion is
> self-contained in a small, simple set of functions:
> 
> 	static struct patch_id *add_commit(struct commit *commit,
> 					   struct patch_ids *ids,
> 					   int no_add)
> 	{
> 		...
> 	}
> 
> 	struct patch_id *has_commit_patch_id(struct commit *commit,
> 					     struct patch_ids *ids)
> 	{
> 		return add_commit(commit, ids, 1);
> 	}
> 
> 	struct patch_id *add_commit_patch_id(struct commit *commit,
> 					     struct patch_ids *ids)
> 	{
> 		return add_commit(commit, ids, 0);
> 	}
> 
> In fact the "no_add" makes *some* sense because add_commit() needs
> to search for a patch-id before adding it, so calling with no_add
> means to do all the work except for actually adding.
> 
> This new call propagates the mysterious boolean argument beyond
> there and uses it in different ways.  Would it make sense to do
> the following?
> 
>  (1) rename the "no_add" parameter to "search_instead" or something
>  (2) avoid passing on "no_add" as a boolean.  Instead, use the
>      same trick elsewhere so this can use appropriately named
>      functions like:
> 
> 	if (!searching)
> 		collect_touched_paths(commit, ids);
> 	else if (!only_touches_touched_paths(commit, ids))
> 		return NULL;

Seems reasonable.

Thanks for the review.
