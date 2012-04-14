From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Sat, 14 Apr 2012 22:15:53 +0200
Message-ID: <2407098.F5IbgLFxk2@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <2104868.dCxFQtJHdU@flomedio> <20120413191908.GC2387@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 22:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ9Pu-0000DD-Ss
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 22:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab2DNURt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 16:17:49 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:10449 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab2DNURs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 16:17:48 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q3EKH3g0008960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2012 22:17:04 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20120413191908.GC2387@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195516>

Hi!

Thanks for your help.
I updated the wiki page.

On Friday 13 April 2012 14:19:08 Jonathan Nieder wrote:

> > Really -c? My installed git doesn't have that switch. Should it pass
> > arguments to the remote-helper?
> 
> What git version do you use?  "man git clone" tells me that -c is an
> abbreviation for --config and "grep -e --config Documentation/RelNotes/*"
> tells me it was introduced in v1.7.7.

Sorry, that was clumsy, I should use build and search the docs of the current 
version, not the one my distro ships!

> > 
> > What does it mean, "import the entire project tree"? Importing other
> > directories than "trunk"?
> 
> Yes.  For an import that is going to be dumping the subdirectories of
> tags/ and branches/ anyway, it seems sensible to ask svnrdump to dump
> the entire {trunk,tags,branches} hierarchy and sort it out on the git
> side.  The question is then: for each rev, in addition to making
> commits for each branch that changed, should we keep a commit
> representing the state of the combined whole-project tree for internal
> use?  A person trying to check out this commit would get to see the
> enormous
> 
> 	trunk/
> 	tags/
> 	branches/
> 
> directories.  My rough answer was "yes, it's convenient to keep that
> information around, especially given that with git's repository model
> it doesn't waste a lot of space and makes debugging easier".

Sounds reasonable.

> 
> > About the mapping of git commits to svn refs .. I've seen the thread
> > about the marks-to-notes converter.
> > But can somebody please explain what it's for? There is this mark file
> > mentioned in the git-fast-import help page ..
> 
> There are two operations that need to be very fast:
> 
>  1. Given a Subversion revision number, what is the corresponding git
>     commit?  svn-fe uses this to get the preimage data when executing
>     an "svn copy" operation that refers to an old rev.  For example:
> 
> 	svn copy some/path@a-long-time-ago another/path
> 
>     Code tracking branches would use this same map to find the
>     appropriate parent commit for a new branch.  For example:
> 
> 	svn copy trunk@a-long-time-ago branches/new-branch
> 
>     becomes:
> 
> 	parent f572d396fae9206628714fb2ce00f72e94f2258f
> 
>  2. Given a git commit, what is the corresponding Subversion revision
>     number?  For example, "git fetch" needs this information in order
>     to get a first unfetched revision number when updating an existing
>     clone of a Subversion repository.
> 
> "git notes" is a mechanism for efficiently storing a mapping from git
> commit names to arbitrary data.  For example, it can be used to cache
> the compiled form of some slow-to-compile source code, or it can be
> used to store reminders to a human that has reviewed these commits and
> wanted to scribble a little in the margin.  A patch (in Dmitry's tree,
> not in git.git yet) teaches svn-fe to use the notes facility to store
> the mapping from git commit names to Subversion revision numbers,
> addressing problem (2) above.  Tomas's human-friendly importer used
> the same trick.
> 
> As you noticed, "git fast-import" has a facility that fits well for
> mapping in the other direction: a marks file can store an arbitrary
> mapping from numbers to objects (usually objects that were part of the
> import).  svn-fe writes a mark for each Subversion revision it imports
> to address problem (1) above.
> 
> Because "git notes" are stored in the git object db as native objects,
> they can be shared using the usual "git fetch" / "git push" commands
> as long as you specify the appropriate source and destination refs on
> the command line or in git's configuration file.  Commands like "git
> rebase" that modify history also have some support for carrying notes
> along.  By contrast, a marks file is just a flat text file and there
> is no standard facility for updating it when commit names change or
> sharing it using ordinary git transport.
> 
> The marks-to-notes converter I wrote was a toy to show how the notes
> and marks can easily be kept in sync.  If I remember correctly the
> last time this was discussed there was some feeling that when the two
> tables fall out of synch the notes should be considered authoritative
> and marks can be recomputed from them.

Oh, thats intersting, I haven't heard of git notes yet. (I should have greped 
the Documentation ..). 
Because of the possibility that one revision is  transformed into two commits, 
the bi-directional mapping has to support 1-to-n or probably n-to-n mappings, 
I think. But this should be possible with these mechanisms.

> 
> > Do we create two commits from one revision if it's some special case,
> > like modifying two branches at once?
> 
> remote-svn-alpha and svn-fe do not currently split by branch at all so
> the problem doesn't come up.
> 
> Yes, I think the only sane way to represent a Subversion revision that
> modifies multiple branches is with a git commit on each branch.
> 
> [...]
> 
> >>    For example, there could be a parallel directory structure
> >>    
> >>    in the tree:
> >>         foo/
> >>         
> >>                 bar.c
> >>         
> >>         baz/
> >>         
> >>                 qux.c
> >>         
> >>         .properties/
> >>         
> >>                 foo.properties
> >>                 foo/
> >>                 
> >>                         bar.c.properties
> >>                 
> >>                 baz/
> >>                 
> >>                         qux.c.properties
> >>    
> >>    with properites for <path> stored at
> >>    .properties/<path>.properties.
> >>    This strawman scheme doesn't work if the repository being
> >>    imported
> >>    has any paths ending with ".properties", though.  Ideas?
> > 
> > This includes collecting which metadata we actually need to store? We
> > could probably collect a list of important svn properties.
> 
> I imagined the importer just collecting all path properties, like "git
> svn" does in its .git/svn/refs/remotes/git-svn/unhandled.log.  They're
> easy to iterate through on the svn side.

Ok, and it will be useful for pushing to svn in the future.

> 
> > Is there a general policy how to store additional metadata for git's
> > helpers? I guess it would live somewhere in the .git dir. (.git/info/
> > ?)
> 
> One simple design would be to keep properties in the "entire project"
> commit objects for internal use, since that's easy to share.
> 
> I think David had a few other ideas. ;-)

Commit objects that are actually not commits but store metadata?


> 
> [...]
> 
> >>  . tracing second-parent history using svn:mergeinfo properties.
> > 
> > This is about detection when to create a git merge-commit, right?
> 
> Yep.  A goal would be to allow a person would be able to push a git
> merge to an svn repository, fetch from another machine, and get the
> same commit back.
> 
> >> In other words, in the above list the strategy is:
> > .. still to come..
> 
> Thanks for your thoughtfulness.
> 
> Jonathan

Florian
