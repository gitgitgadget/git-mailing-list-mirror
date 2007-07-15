From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Sun, 15 Jul 2007 16:44:35 +0200
Message-ID: <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 15 16:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA5L1-0006rg-6F
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 16:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbXGOOoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 10:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757745AbXGOOoj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 10:44:39 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:48024 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512AbXGOOoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 10:44:37 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JL8007TJ6ABQR@psmtp04.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 16:44:36 +0200 (MEST)
Received: (qmail 19861 invoked by uid 500); Sun, 15 Jul 2007 14:44:35 +0000
In-reply-to: <Pine.LNX.4.64.0707141140510.14781@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52560>

On Sat, Jul 14, 2007 at 01:49:59PM +0100, Johannes Schindelin wrote:
> On Thu, 12 Jul 2007, skimo@liacs.nl wrote:
> > +#include "grep.h"
> 
> I did not compile test, but do you really need that?

Not anymore.

> > +struct decoration rewrite_decoration = { "rewritten as" };
> > [...]
> > +
> > +struct rewrite_decoration {
> > +	struct rewrite_decoration *next;
> > +	unsigned char sha1[20];
> > +};
> 
> I wonder why you give the instance of a "struct decoration" the same name 
> as that of a _different_ struct. IOW it is confusing that there is a 
> "struct rewrite_decoration", but the variable "rewrite_decoration" is no 
> instance of that struct.

I was just following Linus's example.

> > +static char *add_parents(char *dest, struct commit_list *parents)
> 
> Since one commit can be rewritten to multiple commits now, you do not know 
> how much space you need to add the parents.

I count them beforehand.

> > +		    !get_short_sha1(buf, ll, sha1, 1) &&
> > +		    !get_rewritten_sha1(sha1))
> > +			memcpy(dest, sha1_to_hex(sha1), ll);
> > +		else
> > +			memcpy(dest, buf, ll);
> 
> What do you do if the rewritten sha1, truncated to ll characters, is 
> ambiguous?  Wouldn't you need more than

More than what?
Are you saying I should add some more of it then?
(As you can see, I simply don't consider that case here, so right now
I just leave it possibly ambiguous.)

> > +	if (!prefixcmp(ref+5, original_prefix))
> 
> Should original_prefix not be "refs/original", then?

The idea was that we could add a command line option later
to override it.

> > +static int is_pruned(struct commit *commit, int path_pruning)
> > +{
> > +	if (commit->object.flags & PRUNED)
> > +		return 1;
> 
> Hmm.  I thought about changing get_revision_1() to mark that commit as 
> uninteresting, since the parents were already added.  But I guess this has 
> too much side effect potential.
> 
> In any case, I think that "NO_MATCH" would be a more descriptive name.

Right now, it's only set for matching stuff, but it could be set
for other kinds of pruning too.

> > +	if (path_pruning &&
> > +	    !(commit->object.flags & (TREECHANGE | UNINTERESTING)))
> > +		return 1;
> 
> Why only with "path_pruning"?  Ah yes.  Because otherwise, you would 
> assume "A" in "A..B" to be pruned.

TREECHANGE is only set when path pruning is in effect.
If I didn't check for path_pruning, then all commits would be
considered to have been pruned.  (Or am I missing something?
Honestyl, I found all that TREECHANGE stuff difficult to follow.)

revision.c itself is also riddled with "prune_fn && ".
Wouldn't it make sense to invert the meaning of this bit and call
it, say, PRUNED, so that the default is off and you would only
have to check if the bit was set ?

> I wonder why you bother at all: my impression was that the revisions you 
> want to filter out here were already filtered out by 
> revision.c:rewrite_parents()...

I also want to make reference that pointed to something that has
been pruned (in either way) to now point to something in the new
history.

> > +static void rewrite_sha1(struct object *obj, unsigned char *new_sha1)
> > +{
> > +	if (!hashcmp(obj->sha1, new_sha1))
> > +		return;
> > +
> > +	add_rewrite_decoration(obj, new_sha1);
> 
> This is not so much "rewrite_sha1", as "append_rewritten_sha1", right?

Well, it's only called once on each commit.

> > +		get_rewritten_sha1(sha1);
> > +		if (!is_null_sha1(sha1)) {
> > +			hashclr(sha1);
> > +			rewrite_sha1(&list->item->object, sha1);
> 
> I guess you'll admit that it is unintuitive to read 
> "get_rewritten_sha1(sha1); rewrite_sha1(o, sha1);".  I thought: "What?  
> Again?"  IMHO that is a strong hint that "rewrite_sha1" is not an apt name 
> for that function.

I guess our brains work in a slightly different way.

> Hmm.  When looking at that code, I wonder if
> 
> 	git rewrite-commits A..B
> 
> will rewrite C, too, if it happens to lie in A..B.  That would be not 
> brilliant.

That was the idea.  Why is it not brilliant?
What would you like this to do instead?

Assume that in your new history all the commit that used to be pointed
to have been removed.  If these pointers are left to point to the
old history, then how are you going to get at the new history?

> > +	commit = lookup_commit_reference(sha1);
> > +	pruned = is_pruned(commit, !!cb_data);
> > +
> > +	hashcpy(new_sha1, sha1);
> > +	if (!pruned && get_rewritten_sha1(new_sha1))
> > +		return 0;
> 
> So if pruned == 1, you _do_ rewrite it?  I'm not quite sure.  Care to 
> explain?

Yes.  See above.

> > +	cmd.in = open(commit_path, O_RDONLY);
> > +	if (cmd.in < 0)
> > +		die("Unable to read commit from file '%s'", commit_path);
> > +	unlink(commit_path);
> 
> This will fail on Windows.  You do not catch that error, so it is almost 
> fine: just put the file into rewrite_dir, so the leftovers will be removed 
> later anyway.

You mean unlinking an opened file?

> 
> > +		hashclr(sha1);
> > +		commit->object.flags |= PRUNED;
> > +		/*
> > +		 * If the filter returns two or more commits,
> > +		 * we consider the original commit to have been
> > +		 * removed and put the list in the old commit's
> > +		 * parent list so that all the old commit's children
> > +		 * will copy them.
> > +		 */
> > +		if (list) {
> > +			free_commit_list(commit->parents);
> > +			commit->parents = list;
> > +		} else
> > +		    add_sha1_map(commit->object.sha1, NULL);
> 
> That is almost certainly wrong.

What specifically ?

> If you step away from the notion that 
> get_rewritten_sha1() returns _one_ SHA-1, all will become clearer.  And 
> the filters should know about them SHA-1s, too.

The filters do know about them.  The corresponding map file contains
all the new SHA1s.

> > +		add_sha1_map(commit->object.sha1, sha1);
> > +	} else
> > +		filter_and_write_commit(buf, p-buf, commit, sha1);
> > +	free(buf);
> 
> You can really discard the commit->buffer, too, no?

I'm not familiar enough with the internals to say for sure.

> > +static void setup_temp_dir()
> > +{
> > +	int aux;
> > +
> > +	absolute_git_dir = create_absolute_path(get_git_dir());
> > +	setenv(GIT_DIR_ENVIRONMENT, absolute_git_dir, 1);
> > +
> > +	if (!rewrite_dir) {
> > +		rewrite_dir = xstrdup(git_path("rewrite"));
> 
> I might read the code wrong, but this does not guarantee that rewrite_dir 
> is an absolute path, right?

It doesn't right now.

> > +	if (mkdir(mkpath("%s/map", rewrite_dir), 0777))
> > +		die("unable to create map directory '%s/map'", rewrite_dir);
> 
> Maybe make this dependent on --write-sha1-mappings, and have a check in 
> "map ()"?

I'll leave that to you :-)

> > +	while ((commit = get_revision(&rev)) != NULL) {
> > +		rewrite_commit(commit, !!rev.prune_fn);
> > +	}
> 
> Please lose the curly brackets for single lines; otherwise it would look 
> too perl like.

That would be
	
	rewrite_commit($commit) while $commit = get_revision;

> > +	rm_rf(git_path("refs/%s", original_prefix));
> 
> Would it not be better to move refs/original to refs/original/original?

Is that what you want?
You'd end up with refs/original/original/original/original/original/original/original/
pretty quickly.

skimo
