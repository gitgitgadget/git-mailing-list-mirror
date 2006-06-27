From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 09:52:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270936520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060626233838.GA3121@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 09:52:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv8Mn-0004se-Vs
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 09:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWF0HwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 03:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030725AbWF0HwI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 03:52:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:12713 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030302AbWF0HwG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 03:52:06 -0400
Received: (qmail invoked by alias); 27 Jun 2006 07:52:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 Jun 2006 09:52:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060626233838.GA3121@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22709>

Hi,

On Tue, 27 Jun 2006, Alex Riesen wrote:

> I finally got pis^Witched enough by my platform at work and decided
> to start the effort of converting Fredriks git-merge-recursive to C.

Darn. I was working on the same thing since a few days.

A few remarks:

- have you considered using run-command() instead of system()?
- in setup_index(), you set GIT_INDEX_FILE, but I do not think that the 
  rest of git picks up on it. environment.cc:get_index_file() checks if 
  the variable was set already, but not if it changed.
- You work with linked lists all the time. This is slow, especially for 
  the checks, if a file/directory is already there. Sorted lists would be
  way faster there. Since you encapsulated that, it is no problem to 
  change that later (before inclusion).
- is not "struct commit_list" more appropriate than "struct graph"?
- I always wondered why merge-recursive did not call merge-base, but did 
  its own thing. Hmm?

> It still uses some calls to git programs (git-update-index,
> git-hash-object, git-diff-tree and git-write-tree), and merge(1) has
> the labels (-L) missing - I was unsure how to tackle this on windows -
> it has only argv[1].

See above.

> And it needs to be cleaned up a bit (a lot) - Python is not exactly
> what you'd call "C-conversion-friendly-language", and I am not an
> expert (as in "git-merge-recursive.py is my first Python experience").

No problem. Since I already worked on it, that should be easy.

> To my deep disappointment, it didn't work out as good as I hoped: one
> program I see most often and for longest time in the process list
> (git-diff-tree) is a too complex thing to be put directly into
> merge-recursive.c, so any help in this direction will be greatly
> appreciated.

Maybe something like this (ripped from my fragment of merge-recursive.c):

static struct container *get_renames(struct tree *tree,
		struct tree *o, struct tree *a, struct tree *b,
		struct container *cache_entries)
{
	/*
	 * Get information of all renames which occured between 'oTree' and
	 * 'tree'. We need the three trees in the merge ('oTree', 'aTree' and
	 * 'bTree') to be able to associate the correct cache entries with the
	 * rename information. 'tree' is always equal to either aTree or bTree.
	 */
	int i;
	struct diff_options diff_opts;
	struct container *result
		= xcalloc(1, sizeof(struct container));

	diff_setup(&diff_opts);
	diff_opts.recursive = 1;
	diff_opts.detect_rename = DIFF_DETECT_RENAME;

	if (diff_setup_done(&diff_opts) < 0)
		die("diff_setup_done failed");

	diff_tree_sha1(o->object.sha1, tree->object.sha1,
			"", &diff_opts);
	diffcore_std(&diff_opts);

	for (i = 0; i < diff_queued_diff.nr; i++) {
		struct diff_filepair *p = diff_queued_diff.queue[i];

		if (p->status == 'R') {
			struct entry *entry = get_rename(result, p->one->path);
			struct rename *rename = entry->priv;

			rename->src.mode = p->one->mode;
			rename->src.sha1 = p->one->sha1;
			rename->src.data
				= get_cache_entry(cache_entries, p->one->path)->priv;
			fake_stage_data(rename->src.data, o, a, b);

			rename->dest.path = p->two->path;
			rename->dest.mode = p->two->mode;
			rename->dest.sha1 = p->two->sha1;
			rename->dest.data
				= get_cache_entry(cache_entries, p->two->path)->priv;
			fake_stage_data(rename->dest.data, o, a, b);

			rename->score = p->score;
		}
	}

	return result;
}

It is not tested, evidently, since I did not get the merge-base code 
integrated yet. But it should give you an idea.

Ciao,
Dscho
