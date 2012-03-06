From: Stephen Bash <bash@genarts.com>
Subject: Re: Approaches to SVN to Git conversion
Date: Tue, 06 Mar 2012 09:36:31 -0500 (EST)
Message-ID: <9130e486-21bd-4c8c-9647-b627dbc1e5c6@mail>
References: <4F554BE4.5010401@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4vVP-0001pa-C6
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 15:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030786Ab2CFOgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 09:36:42 -0500
Received: from hq.genarts.com ([173.9.65.1]:38201 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030748Ab2CFOgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 09:36:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 52CA3BE8071;
	Tue,  6 Mar 2012 09:36:38 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rDmZwdm1-+bL; Tue,  6 Mar 2012 09:36:32 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id F321DBE806B;
	Tue,  6 Mar 2012 09:36:31 -0500 (EST)
In-Reply-To: <4F554BE4.5010401@pileofstuff.org>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC17 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192353>

----- Original Message -----
> From: "Andrew Sayers" <andrew-git@pileofstuff.org>
> Sent: Monday, March 5, 2012 6:27:32 PM
> Subject: Re: Approaches to SVN to Git conversion
> 
> > My current thinking (and this is very much open for discussion) is
> > that as long as the SVN properties are available (especially the
> > copyfrom information) Git has just as much information (if not more)
> > to reconstruct the SVN history as SVN does.  (And going through our
> > messy history I haven't found any counterpoint to this yet)
> 
> I agree that git can be taught a superset of the information in SVN,
> but you'll need absolutely all SVN properties available...

I'm pretty sure Jonathan won't be happy with anything less ;)

> I wrote my SVN exporter based on SVN dumps for three reasons - I
> figured people switching from SVN would be more comfortable
> customising a solution that only used technologies they understood, I
> figured it might be useful to Mercurial or Bazaar some day if it was
> DVCS-neutral, and I have to use SVN for my day job so I'm more
> interested in getting a good migration story today than a great one
> tomorrow.

The multiple systems argument is a good one.

> >   my %branch_spec = { '/trunk/projname' => 'master',
> >                       '/branches/*/projname' => '/refs/heads/*' };
> >   my %tag_spec = { '/tags/*/projname' => '/refs/tags/*' };
> > 
> > Now I know this simple mapping will fail as I get further in our
> > history -- in particular we have one branch that came from:
> > 
> >   svn cp $SVN_REPO/trunk/ $SVN_REPO/foo  # OOPS! not in branches!
> >   svn mv $SVN_REPO/foo $SVN_REPO/branches/foo
> > 
> > It's then up to the user to modify the branch
> > map to something that accounts for this behavior:
> > 
> >   my %branch_spec = { '/trunk/projname' => 'master',
> >                       '/branches/*/projname' => '/refs/heads/*',
> >                       '/foo' => '/refs/heads/foo' };
> >   my %tag_spec = { '/tags/*/projname' => '/refs/tags/*' };
> 
> I started with an approach like you describe, but as you say it winds
> up in a mess of special cases.  A friend pointed me to Perl's catalyst
> repository[2], which is a wonderful haven of every mad SVN thing ever
> dreamt up.  That got me playing with more general heuristics, and
> while writing this e-mail I think I've finally nailed it.  What do you
> say to defining SVN branches like this:
> 
> A directory is a branch if...
> 1. it is not a subdirectory of an existing branch; and
> 2. either:
> 2a. it is in a list of branches specified by the user, or
> 2b. it is copied from a (subdirectory of a) branch

I think I started with a very similar set of rules...  Looking at my code now I'm having a hard time summarizing them (probably because they evolved with the code, so what started simple morphed into something pretty complicated).  I guess as long as the user has the option to say "no, don't treat this copy as a branch" (or equivalently the Git side of things has a way to say "ignore this branch") these rules would be okay.  But at that point we're back to a list of exceptions -- really we're arguing white-list vs black-list... I eventually chose to go the white-list route for our conversion after starting with black-list (a white-list that still required a few manual edits before manipulating the Git history).  So take that single data point for what it's worth.

> > > Once the format is defined, git import is fairly straightforward.
> > > Proof-of-concept code to follow, but it's really just a wrapper
> > > around git-commit-tree, git-mktag etc.  I wrote this in Perl
> > > thinking it would relate somehow to git-svn, but eventually
> > > realised it didn't and that a few hundred calls to (plumbing)
> > > processes per second isn't so good for performance.  The only
> > > interesting part of the problem is how to tackle SVN tags.  I went
> > > for an ambitious approach, making normal tags where possible and
> > > downgrading them to lightweight tags when necessary.  This does
> > > involve managing something that is effectively a branch in
> > > refs/tags/, but what else is an SVN tag but a branch in the wrong
> > > namespace?
> > 
> > I don't understand how "normal" and "lightweight" apply in this
> > situation? ... In the case of actual content changes in a tag's
> > life, I think it's up to the user to decide between three options:
> > 
> >   1) only retain the last SVN tag
> >   2) tag using the git-svn-style 'tagname@rev' for all but the last
> >   3) Do (2), but move older tags to some hidden namespace
> >      (refs/hidden/tags or the like)
> > 
> > ... In the bidirectional case things get murky (maybe always tag
> > with tagname@rev and hope for tab completion?).
> 
> I didn't explain this particularly well, as it's based largely on the
> vague desire to make update work some day.  Imagine the user does
> this:
> 
> * git svn-pull # get tags/foo, a candidate for an annotated tag
> ... time passes ...
> * git svn-pull # tags/foo has now been updated in another revision
> 
> If we create an annotated tag in step 1, what do we do in step 2?  You
> can't make the tag object the parent of a new revision, so you need to
> do something unpleasant.  The solution I proposed was to convert the
> tag message to a commit message (i.e. pretend a lightweight tag had
> been created all along), then add another commit on top of it and make
> a lightweight tag from the new commit (i.e. treat it like a branch).
> In retrospect that's far too much magic without user involvement - a
> better solution would be to give the user this option along with the
> ones you outlined, and let git-config remember their preference if
> they want.

Okay, that's what I thought you meant (and what I classified as a bidirectional problem, but I guess it's not strictly a bidirectional problem, but a one-time migration does not have the problem).  If you want to continue to update Git from SVN there are two cases to consider:

  1) Each Git repository *only* talks to SVN
  2) The Git repository is cloned for further use 
     (So the chain is something like SVN->Git->Git)

In (1) your lightweight tag solution is probably okay (but I'm pretty sure creating/deleting annotated tags would behave the same way because no one else sees the Git tag object).  In (2) I think there would still be a tag conflict when the upstream Git repo replaces a lightweight tag and the downstream repo attempts to fetch it.  I don't know what the fetch/pull machinery does when there's a lightweight tag conflict (I'm guessing either bails out or keeps the local one?).  Case (2) motivates me to say always generate (annotated?) tags named tagname@rev so there can be no conflicts.  In that case the only difference I see is if we create an empty Git commit with the tag message plus a lightweight tag or tag the original commit with an annotated tag (I think it's fairly obvious I'm a fan of
  the latter).

> [1] http://en.wikipedia.org/wiki/Full_employment_theorem
> [2] http://dev.catalyst.perl.org/repos/bast/

Thanks,
Stephen
