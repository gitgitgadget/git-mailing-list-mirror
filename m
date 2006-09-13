From: Nathaniel Smith <njs@pobox.com>
Subject: Re: cvs import
Date: Wed, 13 Sep 2006 15:52:00 -0700
Message-ID: <20060913225200.GA10186@frances.vorpus.org>
References: <45084400.1090906@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@cvs2svn.tigris.org, monotone-devel@nongnu.org,
	Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 00:52:08 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNdaR-0003no-EB
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 00:52:07 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNdaQ-0001bS-VP
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 18:52:06 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNdaO-0001bF-7G
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 18:52:04 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNdaN-0001b3-6X
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 18:52:03 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNdaN-0001b0-2Y
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 18:52:03 -0400
Received: from [207.106.133.28] (helo=proof.pobox.com)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GNdcB-0001Io-CS
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 18:53:55 -0400
Received: from proof (localhost [127.0.0.1])
	by proof.pobox.com (Postfix) with ESMTP id 878D024E13;
	Wed, 13 Sep 2006 18:52:23 -0400 (EDT)
Received: from frances.frop.org (adsl-66-159-194-130.dslextreme.com
	[66.159.194.130]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by proof.sasl.smtp.pobox.com (Postfix) with ESMTP id E51E77501A;
	Wed, 13 Sep 2006 18:52:19 -0400 (EDT)
Received: from njs by frances.frop.org with local (Exim 4.63)
	(envelope-from <njs@pobox.com>)
	id 1GNdaK-0002mQ-AN; Wed, 13 Sep 2006 15:52:00 -0700
To: Markus Schiltknecht <markus@bluegap.ch>
Mail-Followup-To: Markus Schiltknecht <markus@bluegap.ch>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45084400.1090906@bluegap.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26962>

On Wed, Sep 13, 2006 at 07:46:40PM +0200, Markus Schiltknecht wrote:
> Hi,
> 
> I've been trying to understand the cvsimport algorithm used by monotone 
> and wanted to adjust that to be more like the one in cvs2svn.
> 
> I've had some problems with cvs2svn itself and began to question the 
> algorithm used there. It turned out that the cvs2svn people have 
> discussed an improved algorithms and are about to write a cvs2svn 2.0. 
> The main problem with the current algorithm is that it depends on the 
> timestamp information stored in the CVS repository.
> 
> Instead, it would be much better to just take the dependencies of the 
> revisions into account. Considering the timestamp an irrelevant (for the 
> import) attribute of the revision.

I just read over the thread on the cvs2svn list about this -- I have a
few random thoughts.  Take them with a grain of salt, since I haven't
actually tried writing a CVS importer myself...

Regarding the basic dependency-based algorithm, the approach of
throwing everything into blobs and then trying to tease them apart
again seems backwards.  What I'm thinking is, first we go through and
build the history graph for each file.  Now, advance a frontier across
the all of these graphs simultaneously.  Your frontier is basically a
map <filename -> CVS revision>, that represents a tree snapshot.  The
basic loop is:
  1) pick some subset of files to advance to their next revision
  2) slide the frontier one CVS revision forward on each of those
     files
  3) snapshot the new frontier (write it to the target VCS as a new
     tree commit)
  4) go to step 1
Obviously, this will produce a target VCS history that respects the
CVS dependency graph, so that's good; it puts a strict limit on how
badly whatever heuristics we use can screw us over if they guess wrong
about things.  Also, it makes the problem much simpler -- all the
heuristics are now in step 1, where we are given a bunch of possible
edits, and we have to pick some subset of them to accept next.

This isn't trivial problem.  I think the main thing you want to avoid
is:
    1  2  3  4
    |  |  |  |
  --o--o--o--o----- <-- current frontier
    |  |  |  |
    A  B  A  C
       |
       A
say you have four files named "1", "2", "3", and "4".  We want to
slide the frontier down, and the next edits were originally created by
one of three commits, A, B, or C.  In this situation, we can take
commit B, or we can take commit C, but we don't want to take commit A
until _after_ we have taken commit B -- because otherwise we will end
up splitting A up into two different commits, A1, B, A2.

There are a lot of approaches one could take here, on up to pulling
out a full-on optimal constraint satisfaction system (if we can route
chips, we should be able to pick a good ordering for accepting CVS
edits, after all).  A really simple heuristic, though, would be to
just pick the file whose next commit has the earliest timestamp, then
group in all the other "next commits" with the same commit message,
and (maybe) a similar timestamp.  I have a suspicion that this
heuristic will work really, really, well in practice.  Also, it's
cheap to apply, and worst case you accidentally split up a commit that
already had wacky timestamps, and we already know that we _have_ to do
that in some cases.

Handling file additions could potentially be slightly tricky in this
model.  I guess it is not so bad, if you model added files as being
present all along (so you never have to add add whole new entries to
the frontier), with each file starting out in a pre-birth state, and
then addition of the file is the first edit performed on top of that,
and you treat these edits like any other edits when considering how to
advance the frontier.

I have no particular idea on how to handle tags and branches here;
I've never actually wrapped my head around CVS's model for those :-).
I'm not seeing any obvious problem with handling them, though.

In this approach, incremental conversion is cheap, easy, and robust --
simply remember what frontier corresponded to the final revision
imported, and restart the process directly at that frontier.


Regarding storing things on disk vs. in memory: we always used to
stress-test monotone's cvs importer with the gcc history; just a few
weeks ago someone did a test import of NetBSD's src repo (~180k
commits) on a desktop with 2 gigs of RAM.  It takes a pretty big
history to really require disk (and for that matter, people with
histories that big likely have a big enough organization that they can
get access to some big iron to run the conversion on -- and probably
will want to anyway, to make it run in reasonable time).

> Now, that can be used to convert from CVS to about anything else. 
> Obviously we were discussing about subversion, but then there was git, 
> too. And monotone.
> 
> I'm beginning to question if one could come up with a generally useful 
> cleaned-and-sane-CVS-changeset-dump-format, which could then be used by 
> importers to all sort of VCSes. This would make monotone's cvsimport 
> function dependent on cvs2svn (and therefore python). But the general 
> try-to-get-something-usefull-from-an-insane-CVS-repository-algorithm 
> would only have to be written once.
> 
> On the other hand, I see that lots of the cvsimport functionality for 
> monotone has already been written (rcs file parsing, stuffing files, 
> file deltas and complete revisions into the monotone database, etc..). 
> Changing it to a better algorithm does not seem to be _that_ much work 
> anymore. Plus the hard part seems to be to come up with a good 
> algorithm, not implementing it. And we could still exchange our 
> experience with the general algorithm with the cvs2svn people.
>
> Plus, the guy who mentioned git pointed out that git needs quite a 
> different dump-format than subversion to do an efficient conversion. I 
> think coming up with a generally-usable dump format would not be that easy.

Probably the biggest technical advantage of having the converter built
into monotone is that it makes it easy to import the file contents.
Since this data is huge (100x the repo size, maybe?), and the naive
algorithm for reconstructing takes time that is quadratic in the depth
of history, this is very valuable.  I'm not sure what sort of dump
format one could come up with that would avoid making this step very
expensive.

I also suspect that SVN's dump format is suboptimal at the metadata
level -- we would essentially have to run a lot of branch/tag
inferencing logic _again_ to go from SVN-style "one giant tree with
branches described as copies, and multiple copies allowed for
branches/tags that are built up over time", to monotone-style
"DAG of tree snapshots".  This would be substantially less annoying
inferencing logic than that needed to decipher CVS in the first place,
granted, and it's stuff we want to write at some point anyway to allow
SVN importing, but it adds another step where information could be
lost.  I may be biased because I grok monotone better, but I suspect
it would be much easier to losslessly convert a monotone-style history
to an svn-style history than vice versa, possibly a generic dumping
tool would want to generate output that looks more like monotone's
model?  The biggest stumbling block I see is if it is important to
build up branches and tags by multiple copies out of trunk -- there
isn't any way to represent that in monotone.  A generic tool could
also use some sort of hybrid model (e.g., dag-of-snapshots plus
some extra annotations), if that worked better.

It's also very nice that users don't need any external software to
import CVS->monotone, just because it cuts down on hassle, but I would
rather have a more hasslesome tool that worked then a less hasslesome
tool that didn't, and I'm not the one volunteering to write the code,
so :-).

Even if we _do_ end up writing two implementations of the algorithm,
we should share a test suite.  Testing cvs importers is way harder
than writing them, because there's no ground truth to compare your
program's output to... in fact, having two separate implementations
and testing them against each other would be useful to increase
confidence in each of them.

(I'm only on one of the CC'ed lists, so reply-to-all appreciated)

-- Nathaniel

-- 
"On arrival in my ward I was immediately served with lunch. `This is
what you ordered yesterday.' I pointed out that I had just arrived,
only to be told: `This is what your bed ordered.'"
  -- Letter to the Editor, The Times, September 2000
