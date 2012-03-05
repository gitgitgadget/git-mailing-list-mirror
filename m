From: Stephen Bash <bash@genarts.com>
Subject: Approaches to SVN to Git conversion (was: Re: [RFC] "Remote helper for Subversion" project)
Date: Mon, 05 Mar 2012 10:27:27 -0500 (EST)
Message-ID: <3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
References: <4F536FE9.1050000@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 16:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ZwF-0000Sv-QG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 16:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871Ab2CEPe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 10:34:58 -0500
Received: from hq.genarts.com ([173.9.65.1]:28040 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789Ab2CEPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 10:34:57 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Mar 2012 10:34:56 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5A983BE7BAC;
	Mon,  5 Mar 2012 10:27:34 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOsFz8msCn0t; Mon,  5 Mar 2012 10:27:27 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8879CBE7BA2;
	Mon,  5 Mar 2012 10:27:27 -0500 (EST)
In-Reply-To: <4F536FE9.1050000@pileofstuff.org>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC17 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192250>

All-

This turned out to be longer than I intended, but actually summarizes some of my modern thoughts on SVN to Git conversion (as always, I'm more interested in one time migration than bidirectional operation, so read with a grain of salt).

More inline...

----- Original Message -----
> From: "Andrew Sayers" <andrew-git@pileofstuff.org>
> Sent: Sunday, March 4, 2012 8:36:41 AM
> Subject: Re: [RFC] "Remote helper for Subversion" project
> 
> ... snip ...
> 
> While researching the problem, I found Stephen Bash's original
> proposal[1] and snerp-vortex[2] quite inspiring, but wasn't able to
> find any details on SoC-related work in the branching-and-merging
> department - hopefully the following isn't just a retread of ideas
> developed since then.  I've concentrated on importing from SVN so far,
> but have kept an eye on update and half an eye on bi-direction in the
> hopes of being useful there some day.
> 
> It seems to me the "svn export" and "git import" steps make most sense
> as two unrelated projects.  Snerp-vortex and Stephen's scripts both
> cut the history import problem at that point, as do
> svn-fe/git-fast-import with code import.  Exporting SVN history is a
> messy and sometimes project-specific job, so allowing a project to
> concentrate on that part makes it possible for SVN experts to use all
> their skills without having to learn git plumbing before they make
> their first commit (much respect to Stephen for managing that feat
> BTW).

After many a long conversation with Ram and Jonathan (and others), I'm actually going the other direction.  My current thinking (and this is very much open for discussion) is that as long as the SVN properties are available (especially the copyfrom information) Git has just as much information (if not more) to reconstruct the SVN history as SVN does.  (And going through our messy history I haven't found any counterpoint to this yet)

> I've written a proof-of-concept history converter that can be split
> into three parts: a format for describing SVN history; a large, often
> messy Perl program that writes files in that format; and a small Perl
> program that reads the format and translates it into git.  With
> hindsight, Perl is the right language for the SVN exporter, but the
> git importer would have been better written in C.
> 
> Personally, I think SVN export will always need a strong manual
> component to get the best results, so I've put quite a bit of work
> into designing a good SVN history format.  Like git-fast-import, it's
> an ASCII format designed both for human and machine consumption...

First, I'm very impressed that you managed to get a language like this up and working.  It could prove very useful going forward.  On the flip side, from my experiments over the last year I've actually been leaning toward a solution that is more implicit than explicit.  Taking git-svn as a model, I've been trying to define a mapping system (in Perl):

  my %branch_spec = { '/trunk/projname' => 'master',
                      '/branches/*/projname' => '/refs/heads/*' };
  my %tag_spec = { '/tags/*/projname' => '/refs/tags/*' };

(See [1] for notes on our SVN structure.  In a std-layout-style repo it would be:

  my %branch_spec = { '/projname/trunk' => 'master',
                      '/projname/branches/*' => '/refs/heads/*' };
  my %tag_spec = { '/projname/tags/*' => '/refs/tags/*' };)

Now I know this simple mapping will fail as I get further in our history -- in particular we have one branch that came from:

  svn cp $SVN_REPO/trunk/ $SVN_REPO/foo  # OOPS! not in branches!
  svn mv $SVN_REPO/foo $SVN_REPO/branches/foo

>From an automation perspective, I expect the first svn operation to produce an error saying "Possible branch created at /foo from known branch trunk (master), but doesn't match any known branch spec", while the second (if "continue-on-error" is turned on) would error "Branch /branches/foo created from unknown branch located at /foo".  It's then up to the user to modify the branch map to something that accounts for this behavior:

  my %branch_spec = { '/trunk/projname' => 'master',
                      '/branches/*/projname' => '/refs/heads/*',
                      '/foo' => '/refs/heads/foo' };
  my %tag_spec = { '/tags/*/projname' => '/refs/tags/*' };

So in this case I'm making an explicit branch mapping, but the use of glob-style syntax allows the user to catch larger classes of branches if desired (I'll also note that depending on the implementation /foo may need to map to /refs/heads/bad-foo so that /branches/foo can map to /refs/heads/foo, but my intention has been to squash empty commits, so it's possible the name conflict is a non-issue since content didn't change).  I also know that we have some copy operations that are just weird, so it might be helpful to have an ignore mechanism that tells the system to ignore copies into/out-of certain SVN paths.

> Once the format is defined, git import is fairly straightforward.
> Proof-of-concept code to follow, but it's really just a wrapper around
> git-commit-tree, git-mktag etc.  I wrote this in Perl thinking it
> would relate somehow to git-svn, but eventually realised it didn't and
> that a few hundred calls to (plumbing) processes per second isn't so
> good for performance.  The only interesting part of the problem is how
> to tackle SVN tags.  I went for an ambitious approach, making normal
> tags where possible and downgrading them to lightweight tags when
> necessary.  This does involve managing something that is effectively a
> branch in refs/tags/, but what else is an SVN tag but a branch in the
> wrong namespace?

I don't understand how "normal" and "lightweight" apply in this situation?  As I mentioned before I'd like to squash empty commits (in the case of a one-time migration, in the bidirectional case it's probably easier not to), so many SVN tagging operations wouldn't produce new commits, and the (technically) correct commit is tagged.  In the case of actual content changes in a tag's life, I think it's up to the user to decide between three options:

  1) only retain the last SVN tag
  2) tag using the git-svn-style 'tagname@rev' for all but the last
  3) Do (2), but move older tags to some hidden namespace (refs/hidden/tags or the like)

Option (3) is predicated on gc searching accepting all subdirectories of refs/ as valid (it did this when I wrote my original scripts, and I don't believe this behavior has changed).  For a one-time migration I think all three of these options can be implemented using annotated tags.  In the bidirectional case things get murky (maybe always tag with tagname@rev and hope for tab completion?).

> ... snip ...
>
> SVN export is much more complicated, and has taken most of my time.
> Although there's no way to tell automatically which directories are
> branches, I realised you can detect trunks automatically about 90% of
> the time by looking for where files/directories are first created, and
> can detect non-trunk branches at least 99% of the time once you know
> the trunks.  Trunk detection is normally just a convenience, but can
> be a lifesaver when importing from a sufficiently messy repository.
> There's a lot you can do with merge detection, but between
> svn:mergeinfo, svnmerge.py[4], svk[5] and log messages I realise I've
> only scratched the surface.  In many ways, this is a classic Perl
> problem - take a bunch of messy textual input, string it all together
> and make some neat textual output.  The code I've got right now seems
> fine for anything up to about 20,000 commits, but eats way too much
> memory for huge repos.  Depending on how much time I get, I might have
> tackled that problem by the time I put this code online.

Branch detection falls into my branch mapping mentioned above.  I realized that for as much as I slaved over finding every last branch (regardless of location) in our repo, it really came down to "list the known branches, find copies of those, if any copies leave the list of known branches warn the user/revise branch spec, repeat".  Now there are probably SVN repositories out there that can't write a well-formed branch spec (I had one at a previous job where the definition of a branch changed halfway through history), but I'm attempting to convince myself something is better than nothing and we'll catch the exceptions as they come up.

Merge detection and translation is (IMO) not a well formed problem.  As you point out, there's no real way to know if it's a real merge or a cherry-pick.  It occurred to me last night after reading your e-mail a tool could attempt to look at the diffs in the branch history and compare that with the diff created by the merge, but that gets into all kinds of diff machinery/text processing hijinks that I don't want to contemplate (others might be more willing).
 
> [1] http://comments.gmane.org/gmane.comp.version-control.git/158940
> [2] https://github.com/rcaputo/snerp-vortex
> [3] http://repo.or.cz/w/svn-merge2git.git
> [4] http://www.orcaware.com/svn/wiki/Svnmerge.py
> [5] http://search.cpan.org/dist/SVK/

Thanks for the brain dump.  I hope this brain dump in response is helpful in someway.  I seem to revisit this topic about once every three months or so, and this was a good chance to share some of my recent revelations.

Thanks,
Stephen
