From: Sam Vilain <sam@vilain.net>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Thu, 01 Jul 2010 15:38:54 +1200
Message-ID: <1277955534.6605.81.camel@wilber>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
	 <20100624173956.GA1600@burratino> <20100624180752.GA1642@burratino>
	 <1277862665.23613.8.camel@wilber>  <20100630124553.GA30999@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 05:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUAc3-0004EW-AM
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 05:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab0GADit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 23:38:49 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34407 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300Ab0GADir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 23:38:47 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 22D1A21D1A9; Thu,  1 Jul 2010 15:38:46 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [IPv6:::1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id B5C7221C453;
	Thu,  1 Jul 2010 15:38:41 +1200 (NZST)
In-Reply-To: <20100630124553.GA30999@debian>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150007>

On Wed, 2010-06-30 at 14:45 +0200, Ramkumar Ramachandra wrote: 
> > I wrote at length about this near the beginning of the project;
> > essentially, figuring out whether particular paths are roots or not is
> > not defined, as SVN does not distinguish between them (a misfeature
> > cargo culted from Perforce).  It becomes a data mining problem, you have
> > this scattered data, and you have to find a history inside.
> 
> Right. Implementing git-svn on top of git-remote-svn might not be a
> bad idea.

That's a good way to look at it, yes.  Probably git-svn has more
svn-specific code than import rules, so just the interface like
--stdlayout etc is worth keeping, as well as checking that the svn
import data miner could do all the same things as git-svn.

> > I consider it very important to separate the data import and tracking
> > stage from the data mining stage.
> 
> We're following this approach. At the moment, we're just focusing on
> getting all the data directly from SVN into the Git store. Instead of
> building trees for each SVN revision, we've found a way to do it
> inside the Git object store: we're currently ironing out the details,
> and I'll post an update about this shortly.

Of course no working copy need exist with these contents within; that
would hardly be 'cheap copy' would it?  :)  But it's probably worth
sticking to the standard tree/blob/commit object convention for ease of
debugging etc.

> > Once the data mining stage is well solved, then it makes sense to look
> > at ways that a tracking branch which only tracks a part of the
> > Subversion repository can be achieved.  In the simple case, where no
> > repository re-organisation or cross-project renames have occurred it is
> > relatively simple.  But in general I think this is a harder problem,
> > which cannot always be solved without intervention - and so not
> > necessary to be solved in short-term milestones.  As you are
> > discovering, it is a can of worms which you avoid if you know you always
> > have the complete SVN repository available.
> 
> Right. I'm not convinced that it necessarily requires user
> intervention though: can you systematically prove that enough
> information is not available without user intervention using an
> example? Or is it possible, but simply too difficult (and not worth
> the effort) to mine out the data?

Sure, well all you really need to do is try it with a few real-world
repositories.

But I can give you a few examples of where all attempts at heuristics
will fail.

The first is where someone puts a file somewhere in the repository,
perhaps a README.txt or something, somewhere outside the regular
location.

  r1:
  add /README.txt

Then, someone comes along and starts making their project:

  r2:
  add /trunk/README.txt

How do you know that the first commit is not part of any project, but
some out-of-band notes to people working with the repository?

The way I approached all this in my perforce converter (remember,
Perforce is like SVN in almost every way) is to progressively scan the
history and build up two tables which trace the "mined" history.

You can see the table definitions at
http://utsl.gen.nz/gitweb/?p=git-p4raw;a=blob;f=tables.sql;h=259c243;hb=7e4fc4a#l205

The first, change_branches - records that a logical branch exists at a
revision and path.

  (branchpath, change)

(you might want another 'column' in your conceptual data model: the
project name; I was dealing with a single project).

There are also cases where someone does something dumb, and then it is
repaired on the next commit.

eg

  /trunk/ProjectA
  /trunk/ProjectB
  /branches/ProjectA/foo
  /branches/ProjectB/bar

Someone comes along and does something like:

  rm /trunk
  mv /branches/ProjectA/foo /trunk

Whoops!  The /trunk path just got wiped.  How do we fix it?  In a hurry,
the system administrator checks out the old revision, tars them all up,
then uses 'svn add' to put them back.

  rm -r /trunk/*
  add /trunk/ProjectA
  add /trunk/ProjectB

After this, people working on it realise the mistake: the disconnected
history won't merge, etc.  But the change is permanent, and they work
around this error in the history.  They don't want to do the more
correct thing, which is restore the history from the broken commit,

  rm -r /trunk/*
  cp /trunk@42 /trunk

They don't want to do this because SVN has taught them that version
control is a fragile thing, and you don't want to monkey with it.
Because it can break and then your whole world is changed as the
precious black box which all your work is going into doesn't work quite
as before.  Because there is no "undo".  Because it has all these opaque
files inside it no-one can understand.  What happened before with the
rename upset and embarrassed you, and you don't want to risk making it
worse.

This sort of thing does actually happen.  The lesson is that you can't
trust heuristics, or the revision control breadcrumbs (copied-from etc)
to be perfect.  They are invisible - impossible to inspect directly
using the SVN command-line API, and impossible to revise once they are
there.  by contrast, with git we have grafts, refs/replace/OBJID,
filter-branch, rebase, etc.  We have visualization tools, git-add -p,
git gui.  We have an object store which is robust, simple and widely
understood.  We have a simple data model, so that the actual information
can be understood by people and not just buggy software.

Of course with SVN you have the fact that for the entire of its life as
a relevant version control system, it did not support merge tracking.
So, most history being imported will not have any reliable merge
information.  If you read early versions of the SVN manual, they
actually advocate recording, in natural language, a human-readable
description of the work done, in the commit message.  I've seen people
working around this lack of functionality by developing their own
systems, sometimes not even being able to reconstruct what what merged
where (eg, in parrot SVN).

Yet another situation is partial merging; unlike SVN, Perforce had
detailed merge tracking from the very beginning.  With Perforce it
worked on a per-file level only, so it is slightly different in that
respect.  But what you find is that sometimes, people will merge only a
part of another tree in to their "trunk" at a time.

  r45: merged
  /branches/ProjectA/src -> /trunk/ProjectA/dest

  r46: merged
  /branches/ProjectB/doc -> /trunk/ProjectB/doc

What I normally find in this case is that there is no useful history
recorded in those intermediate commits; they were just committing to
save their intermediate work from being lost.  This doesn't happen quite
so much in Perforce, because it has a concept of "index" missing
entirely from (the user API of) Subversion.  In that case, it makes more
sense to omit the intermediate commits, and simply record a single merge
and leave out the intermediate commits.

To work around parenting mistakes - both those caused by misuse and from
a lack of SVN functionality, you need to be able to readily and easily
revise the parent information.

To do this, the second important table in git-p4raw recorded parents;

  (branchpath, change, parent_branchpath, parent_change)
or, if I was stitching on a pre-perforce or otherwise manually converted
history;
  (branchpath, change, parent_sha1)

So, in the Perl code, I wrote a command called "find_branches", which
correlates the information already there in the database with the
changes for that revision, and progressively looks for new revisions.
It also creates provisional parent information based on the integration
breadcrumbs.

What I would then do is look at the result in 'gitk', and if there were
problems, they could usually be fixed by fiddling with the parent
information, rewinding the export (see 'unexport_commits') and
re-running it.  Sometimes this meant adding a missing merge parent,
sometimes my fuzzy logic for guessing the merge parents guessed badly.
Obviously, I was also developing the importer along the way, so as well
as data errors there were bugfixes to make, etc.

This was not arduous; the speed of postgres' query evaluation (with some
tuning) and git fast-import meant I was typically exporting at several
*hundred* commits per second.

As I had a facility to graft manually converted history using git-p4raw
(above, that's where the "parent" is a commit SHA1, not a Perforce
revision number and path), I even went back and found various changes in
Perforce that looked more like incremental Perl releases, and run the
script I had for pre-perforce history over the diff and changelog
contained within (by then, it had a personality; it was called the
Timinator: http://perl5.git.perl.org/perl.git/tag/timinator).

Anyway, with that information in place, you then have all the
information you need to do a test export.  The exporter already has all
of the blobs in the git repository; all it has to do is refer to these
in a fast-export stream.  It marks as it goes along; once it has
finished an export batch, it waits for the fast-import process to finish
successfully, reads all of the SHA1s corresponding to the marks it
already emitted, and then updates the database tables with the SHA1s
accordingly.  Due to extensive use of deferred check constraints, only
then will Postgres let it commit :-).  That way, when I hit "ctrl+c"
along the way, I knew everything was safe.  Restartability and
robustness in the face of crashes is very useful for this sort of tool.

Another strange case which affects some of the largest repositories in
the world I don't have an answer for, but suspect it can be represented
by either subtree merging or by submodules:

  mv /trunk/ProjectA /trunk/ProjectB/lib/ProjectA

"ProjectA" is now included in "ProjectB" - what is the intent of this?
The first possibility is a subtree merge, the second is that a submodule
is desired.  How to represent it in git will depend on what happens
later.  If the directory is moved or copied elsewhere, then it is
probably going to be better to represent it as a submodule.

And here, the lesson is: people use SVN in ways which defy a single
mapping into git.  This one in particular affects the KDE project
heavily, as directories are copied around extensively.  SVN can remember
the history and produce logs, but it requires the entire repository
available to be able to do so.  Thiago wrote a tool called
svn-fast-export-all, which hoped to parse the svnadmin dump file and
split the data into separate repositories as it went, but as it is a
very long batch job it is difficult to produce a high quality
conversion.

Important points to take from this;

  * model the source data cleanly, completely and robustly.
  * start with heuristics, hopefully they will work for people following
the SVN guide, but allow for human input for when it doesn't.
  * aim for quick export/rewind, and robust operation.
  * this will make it very easy for revisionists to clean up the
mistakes of the past

Keep up the good work!
Sam
