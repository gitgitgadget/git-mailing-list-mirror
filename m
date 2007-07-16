From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Mon, 16 Jul 2007 01:38:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160054340.14781@racer.site>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 16 02:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAEbf-0006Wy-CR
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 02:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799AbXGPAi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 20:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758370AbXGPAi1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 20:38:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:60460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757755AbXGPAi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 20:38:26 -0400
Received: (qmail invoked by alias); 16 Jul 2007 00:38:24 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp004) with SMTP; 16 Jul 2007 02:38:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0g34c3330+9+G3WRRlOyE8l/K5ke7lx3NxJf1ID
	X8SX/5vUiC4/ut
X-X-Sender: gene099@racer.site
In-Reply-To: <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52614>

Hi,

On Sun, 15 Jul 2007, Sven Verdoolaege wrote:

> On Sat, Jul 14, 2007 at 01:49:59PM +0100, Johannes Schindelin wrote:
> > On Thu, 12 Jul 2007, skimo@liacs.nl wrote:
> > > +struct decoration rewrite_decoration = { "rewritten as" };
> > > [...]
> > > +
> > > +struct rewrite_decoration {
> > > +	struct rewrite_decoration *next;
> > > +	unsigned char sha1[20];
> > > +};
> > 
> > I wonder why you give the instance of a "struct decoration" the same name 
> > as that of a _different_ struct. IOW it is confusing that there is a 
> > "struct rewrite_decoration", but the variable "rewrite_decoration" is no 
> > instance of that struct.
> 
> I was just following Linus's example.

*Sigh*  I hate to repeat arguments.

> > > +static char *add_parents(char *dest, struct commit_list *parents)
> > 
> > Since one commit can be rewritten to multiple commits now, you do not 
> > know how much space you need to add the parents.
> 
> I count them beforehand.

Yes.  And it is extremely hard to follow through your code, just to verify 
that it really works.  Using ALLOC_GROW instead of trying to play cute 
games would spare these tours, and I am quite convinced that it makes for 
less bugs.  If not now, then when somebody _else_ than you touches the 
code.

> > > +		    !get_short_sha1(buf, ll, sha1, 1) &&
> > > +		    !get_rewritten_sha1(sha1))
> > > +			memcpy(dest, sha1_to_hex(sha1), ll);
> > > +		else
> > > +			memcpy(dest, buf, ll);
> > 
> > What do you do if the rewritten sha1, truncated to ll characters, is 
> > ambiguous?  Wouldn't you need more than
> 
> More than what?

Right.  I did not complete that sentence.  But isn't it obvious?  Usually, 
you put in short, but (at least for some time) _unambiguous_ short names.  
IMHO people would expect the same to be true of rewritten commit messages.

> Are you saying I should add some more of it then? (As you can see, I 
> simply don't consider that case here, so right now I just leave it 
> possibly ambiguous.)

Yes, I saw that.  Just wanted to remind you that some people might 
consider this a bug.

> > > +	if (!prefixcmp(ref+5, original_prefix))
> > 
> > Should original_prefix not be "refs/original", then?
> 
> The idea was that we could add a command line option later to override 
> it.

Okay, I'll try again.  You do not use the canonical form.  Why not use 
it, if only for consistency?  Besides, if you want to be able to override 
it with a command line option, you _will_ have to canonicalise _that_ 
original_prefix.

> > > +static int is_pruned(struct commit *commit, int path_pruning)
> > > +{
> > > +	if (commit->object.flags & PRUNED)
> > > +		return 1;
> > 
> > Hmm.  I thought about changing get_revision_1() to mark that commit as 
> > uninteresting, since the parents were already added.  But I guess this 
> > has too much side effect potential.
> > 
> > In any case, I think that "NO_MATCH" would be a more descriptive name.
> 
> Right now, it's only set for matching stuff, but it could be set for 
> other kinds of pruning too.

Yes, it could.

> > > +	if (path_pruning &&
> > > +	    !(commit->object.flags & (TREECHANGE | UNINTERESTING)))
> > > +		return 1;
> > 
> > Why only with "path_pruning"?  Ah yes.  Because otherwise, you would 
> > assume "A" in "A..B" to be pruned.
> 
> TREECHANGE is only set when path pruning is in effect.
> If I didn't check for path_pruning, then all commits would be
> considered to have been pruned.  (Or am I missing something?
> Honestyl, I found all that TREECHANGE stuff difficult to follow.)

AFAICT TREECHANGE means that parents were rewritten.

> revision.c itself is also riddled with "prune_fn && ".
> Wouldn't it make sense to invert the meaning of this bit and call
> it, say, PRUNED, so that the default is off and you would only
> have to check if the bit was set ?

You meant the TREECHANGE bit?  No.

BTW what do you plan to do about my objection to UNINTERESTING, given the 
example "git rewrite-commits A..B x/y"?

> > I wonder why you bother at all: my impression was that the revisions 
> > you want to filter out here were already filtered out by 
> > revision.c:rewrite_parents()...
> 
> I also want to make reference that pointed to something that has
> been pruned (in either way) to now point to something in the new
> history.

I did not understand that intention.  Maybe I am too dumb, that's all.

> > > +static void rewrite_sha1(struct object *obj, unsigned char *new_sha1)
> > > +{
> > > +	if (!hashcmp(obj->sha1, new_sha1))
> > > +		return;
> > > +
> > > +	add_rewrite_decoration(obj, new_sha1);
> > 
> > This is not so much "rewrite_sha1", as "append_rewritten_sha1", right?
> 
> Well, it's only called once on each commit.

Didn't I mention that it was a severe limitation to think of the sha1 
mapping of a 1-to-1 mapping?  Think of it more as a relation.

> > > +		get_rewritten_sha1(sha1);
> > > +		if (!is_null_sha1(sha1)) {
> > > +			hashclr(sha1);
> > > +			rewrite_sha1(&list->item->object, sha1);
> > 
> > I guess you'll admit that it is unintuitive to read 
> > "get_rewritten_sha1(sha1); rewrite_sha1(o, sha1);".  I thought: "What?  
> > Again?"  IMHO that is a strong hint that "rewrite_sha1" is not an apt 
> > name for that function.
> 
> I guess our brains work in a slightly different way.

I doubt that.  What would you expect a code

	get_tagged_commit(commit);
	tag_commit(tag, commit);

to do, if not tag a tagged commit _again_?  So I bet if it wasn't your 
code to begin with, you would have experienced the same confusion as me.

> > Hmm.  When looking at that code, I wonder if
> > 
> > 	git rewrite-commits A..B
> > 
> > will rewrite C, too, if it happens to lie in A..B.  That would be not 
> > brilliant.
> 
> That was the idea.  Why is it not brilliant?

Because it is called rewrite-commits, not 
rewrite-all-refs-that-touch-this-commit-range.

> What would you like this to do instead?

Only touch the positive refs given in the command line.  If you say 
"--all", then it's all.  If you say "A..B", then it's "B".

> Assume that in your new history all the commit that used to be pointed 
> to have been removed.  If these pointers are left to point to the old 
> history, then how are you going to get at the new history?

I still have the superproject splitting as the main application in mind.  
Only for big applications like these does the performance improvement of 
rewrite-commits over filter-branch buy us anything.

> > > +	commit = lookup_commit_reference(sha1);
> > > +	pruned = is_pruned(commit, !!cb_data);
> > > +
> > > +	hashcpy(new_sha1, sha1);
> > > +	if (!pruned && get_rewritten_sha1(new_sha1))
> > > +		return 0;
> > 
> > So if pruned == 1, you _do_ rewrite it?  I'm not quite sure.  Care to 
> > explain?
> 
> Yes.  See above.

Sorry, this explanation does not help me.  My impression was that a pruned 
commit should be _mapped_ to the rewritten sha1s of the original parents, 
but not be rewritten.

> > > +	cmd.in = open(commit_path, O_RDONLY);
> > > +	if (cmd.in < 0)
> > > +		die("Unable to read commit from file '%s'", commit_path);
> > > +	unlink(commit_path);
> > 
> > This will fail on Windows.  You do not catch that error, so it is almost 
> > fine: just put the file into rewrite_dir, so the leftovers will be removed 
> > later anyway.
> 
> You mean unlinking an opened file?

Yes, I mean unlinking an opened file.

> > > +		hashclr(sha1);
> > > +		commit->object.flags |= PRUNED;
> > > +		/*
> > > +		 * If the filter returns two or more commits,
> > > +		 * we consider the original commit to have been
> > > +		 * removed and put the list in the old commit's
> > > +		 * parent list so that all the old commit's children
> > > +		 * will copy them.
> > > +		 */
> > > +		if (list) {
> > > +			free_commit_list(commit->parents);
> > > +			commit->parents = list;
> > > +		} else
> > > +		    add_sha1_map(commit->object.sha1, NULL);
> > 
> > That is almost certainly wrong.
> 
> What specifically ?

It takes a few minutes to verify that the correct calls to add_sha1_map() 
are done in every case.

Also, why should commit->parents be reset only in the multiple-sha1 case?

But most seriously, why do you replace the _parents_ of a given commit by 
the sha1s of the _rewritten_ commits?  They are not even the rewritten 
_parents_.

> > If you step away from the notion that 
> > get_rewritten_sha1() returns _one_ SHA-1, all will become clearer.  And 
> > the filters should know about them SHA-1s, too.
> 
> The filters do know about them.  The corresponding map file contains
> all the new SHA1s.

But the code does not reflect that in some parts.  For example when you 
call "get_rewritten_sha1(sha1);" which one is it?  And what is it if the 
commit was rewritten to no commit at all, i.e. the history was cut 
forcefully?

> > > +		add_sha1_map(commit->object.sha1, sha1);
> > > +	} else
> > > +		filter_and_write_commit(buf, p-buf, commit, sha1);
> > > +	free(buf);
> > 
> > You can really discard the commit->buffer, too, no?
> 
> I'm not familiar enough with the internals to say for sure.

Hmm.  You play with them pretty heavily, then, for example when you just 
reset commit->parents.

> > > +static void setup_temp_dir()
> > > +{
> > > +	int aux;
> > > +
> > > +	absolute_git_dir = create_absolute_path(get_git_dir());
> > > +	setenv(GIT_DIR_ENVIRONMENT, absolute_git_dir, 1);
> > > +
> > > +	if (!rewrite_dir) {
> > > +		rewrite_dir = xstrdup(git_path("rewrite"));
> > 
> > I might read the code wrong, but this does not guarantee that rewrite_dir 
> > is an absolute path, right?
> 
> It doesn't right now.

Umm.  Sorry to ask so bluntly: are you planning to change that?

> > > +	if (mkdir(mkpath("%s/map", rewrite_dir), 0777))
> > > +		die("unable to create map directory '%s/map'", rewrite_dir);
> > 
> > Maybe make this dependent on --write-sha1-mappings, and have a check in 
> > "map ()"?
> 
> I'll leave that to you :-)

IMHO the first part should be in the initial commit of 
builtin-rewrite-commits.c, so I will not do that.

> > > +	while ((commit = get_revision(&rev)) != NULL) {
> > > +		rewrite_commit(commit, !!rev.prune_fn);
> > > +	}
> > 
> > Please lose the curly brackets for single lines; otherwise it would look 
> > too perl like.
> 
> That would be
> 	
> 	rewrite_commit($commit) while $commit = get_revision;

No, it would not, because it is not valid C.

> > > +	rm_rf(git_path("refs/%s", original_prefix));
> > 
> > Would it not be better to move refs/original to 
> > refs/original/original?
> 
> Is that what you want? You'd end up with 
> refs/original/original/original/original/original/original/original/ 
> pretty quickly.

We are pretty anal about not losing data too quickly, and possibly 
unwantedly.

It would be surprising to me if this would be the first program to change 
that behaviour.

IOW, refs/original/ is not a temporary directory that you easily blow 
away.  It is meant for the user to be inspected.  And it is the user's 
obligation to say when that happened, and that it should go now.

Thinking about it again, I'd even go so far as to disallow operation with 
an existing refs/original/.

Ciao,
Dscho
