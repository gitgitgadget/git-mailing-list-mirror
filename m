From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] clean: add a flag to back up cleaned files
Date: Tue, 27 May 2014 12:37:01 -0400
Message-ID: <20140527163700.GB29693@sigill.intra.peff.net>
References: <1401200254-4592-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 18:37:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpKN9-0006Du-Sc
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 18:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaE0QhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 12:37:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:60305 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751778AbaE0QhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 12:37:03 -0400
Received: (qmail 17531 invoked by uid 102); 27 May 2014 16:37:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 May 2014 11:37:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2014 12:37:01 -0400
Content-Disposition: inline
In-Reply-To: <1401200254-4592-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250173>

On Tue, May 27, 2014 at 04:17:34PM +0200, Erik Faye-Lund wrote:

> The combination of "git clean" and fat fingers can some times cause
> data-loss, which can be frustrating.
> 
> So let's add a flag that imports the files to be deleted into the
> object-database, in a way similar to what git-stash does. Maintain
> a reflog of the previously backed up clean-runs.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> I've had a similar patch laying around for quite a while, but since
> f538a91 ("git-clean: Display more accurate delete messages"), this
> patch is a lot less nasty than before. So here you go, perhaps
> someone else has fat fingers and hate to lose work?

I've definitely considered doing something like this before (and for
"git reset --hard"). My biggest concern would be poor performance in
some cases. But since it's optional, and one can presumably override it
with --no-backup for a specific large cleanup, it would not hurt anybody
who does not want to play with it.

> +	/* load HEAD into the index */
> +
> +	tree = parse_tree_indirect(sha1);
> +	if (!tree)
> +		die(_("Failed to unpack tree object %s"), sha1);
> +
> +	parse_tree(tree);
> +	init_tree_desc(&t, tree->buffer, tree->size);
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx = -1;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.index_only = 1;
> +
> +	if (unpack_trees(1, &t, &opts)) {
> +		/* We've already reported the error, finish dying */
> +		exit(128);
> +	}

This bit of the code surprised me. I guess you are trying to re-create
the index state of the HEAD so that the commit you build on top of it
contains _only_ the untracked files as changes, and not whatever
intermediate index state you had.  That makes some sense to me, as clean
is never touching the index state.

Though taking a step back for a moment, I'd like to think about doing
something similar for "reset --hard", which is the other "destructive"
operation in git[1]. In that case, I think saving the index state is also
useful, because it is being reset, too (and while those blobs are
recoverable, the exact state is sometimes useful).

If we were to do that, should it be a separate ref? Or should there be a
single backup ref for such "oops, undo that" operations? If the latter,
what should that ref look like? I think it would look something like
refs/stash, with the index and the working tree state stored as separate
commits (even though in the "clean" case, the index state is not likely
to be that interesting, it is cheap to store and makes the recovery
tools uniform to use).

And if we are going to store it like that, should we just be using "git
stash save --keep-index --include-untracked"? I think we would just need
to teach it a "--no-reset" option to leave the tracked files as-is.

I realize that I went a few steps down the "if..." chain there to get to
"should we just be using stash?". But it would also make the code here
dirt-simple.

[1] Actually, "reset --hard" may be more of an education issue, as
    simply running "git stash" has the same effect, but keeps a backup.
    It's just that "reset --hard" is advertised as the solution to many
    problems.

> +	if (!active_cache_tree)
> +		active_cache_tree = cache_tree();
> +
> +	if (!cache_tree_fully_valid(active_cache_tree)) {
> +		if (cache_tree_update(active_cache_tree,
> +		    (const struct cache_entry * const *)active_cache,
> +		    active_nr, 0) < 0)
> +			die("failed to update cache");
> +	}

I'd have thought you could use write_cache_as_tree, which backs "git
write-tree", but there is currently no way to convince it not to write
out the new cache. This is little enough code that it may not be worth
refactoring write_cache_as_tree to handle it.

> +	/* create a reflog, if there isn't one */
> +	git_snpath(logfile, sizeof(logfile), "logs/%s", ref);
> +	if (stat(logfile, &st)) {
> +		FILE *fp = fopen(logfile, "w");
> +		if (!fp)
> +			warning(_("Can not do reflog for '%s'\n"), ref);
> +		else
> +			fclose(fp);
> +	}

Kind of gross that we have to do this ourselves (and somewhat contrary
to efforts elsewhere to make the ref code more abstract), but I see that
"git stash" does the same thing.

Should you fopen with "a" here, to avoid a race condition where another
process creates it between the stat() and the fopen(), in which case we
would truncate what they wrote? You could even just get rid of the
stat(), then, like:

  if ((fp = fopen(logfile, "a")))
	fclose(fp);
  else
	warning(_("Can not do reflog for '%s'"), ref);

Also note that your warning has an extra "\n" in it.

-Peff
