From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cvs import
Date: Fri, 15 Sep 2006 23:39:18 -0400
Message-ID: <20060916033917.GA24269@spearce.org>
References: <45084400.1090906@bluegap.ch> <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com> <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com> <450872AE.5050409@bluegap.ch> <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com> <4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org> <450A581E.2050509@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org
X-From: dev-return-1661-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sat Sep 16 05:39:31 2006
Return-path: <dev-return-1661-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GOR1e-0007L5-KU
	for gcvscd-dev@gmane.org; Sat, 16 Sep 2006 05:39:30 +0200
Received: (qmail 9709 invoked by uid 5000); 16 Sep 2006 03:39:28 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 9699 invoked from network); 16 Sep 2006 03:39:28 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAHYOC0WBToofAQgOKg
X-IronPort-AV: i="4.09,173,1157353200"; 
   d="scan'208"; a="26981016:sNHT18302823"
X-IRONPORT: SCANNED
To: Markus Schiltknecht <markus@bluegap.ch>
Content-Disposition: inline
In-Reply-To: <450A581E.2050509@bluegap.ch>
Sender: spearce@spearce.org
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - cvs2svn.tigris.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27107>

Markus Schiltknecht <markus@bluegap.ch> wrote:
> Shawn Pearce wrote:
> >I don't know how the Monotone guys feel about it but I think Git
> >is happy with the data in any order, just so long as the dependency
> >chains aren't fed out of order.  Which I think nearly all changeset
> >based SCMs would have an issue with.  So we should be just fine
> >with the current chronological order produced by cvs2svn.
> 
> I'd vote for splitting into file data (and delta / patches) import and 
> metadata import (author, changelog, DAG).
> 
> Monotone would be happiest if the file data were sent one file after 
> another and (inside each file) in the order of each file's single 
> history. That guarantees good import performance for monotone. I imagine 
> it's about the same for git. And if you have to somehow cache the files 
> anyway, subversion will benefit, too. (Well, at least the cache will 
> thank us with good performance).
>
> After all file data has been delivered, the metadata can be delivered. 
> As neigther monotone nor git care much if they are chronological across 
> branches, I'd vote for doing it that way.

Right.  I think that one of the cvs2svn guys had the right idea
here.  Provide two hooks: one early during the RCS file parse which
supplies a backend each full text file revision and another during
the very last stage which includes the "file" in the metadata stream
for commit.

This would give Git and Monotone a way to grab the full text for each
file and stream them out up front, then include only a "token" in the
metadata stream which identifies the specific revision.  Meanwhile
SVN can either cache the file revision during the early part or
ignore it, then dump out the full content during the metadata.


As it happens Git doesn't care what order the file revisions come in.
If we don't repack the imported data we would prefer to get the
revisions in newest->oldest order so we can delta the older versions
against the newer versions (like RCS).  This is also happens to be
the fastest way to extract the revision data from RCS.

On the other hand from what I understand of Monotone it needs
the revisions in oldest->newest order, as does SVN.

Doing both orderings in cvs2noncvs is probably ugly.  Doing just
oldest->newest (since 2/3 backends want that) would be acceptable
but would slow down Git imports as the RCS parsing overhead would
be much higher.

-- 
Shawn.
