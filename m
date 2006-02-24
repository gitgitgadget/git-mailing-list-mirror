From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 10:44:22 -0700
Organization: Hewlett Packard
Message-ID: <20060224174422.GA13367@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 18:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCgzd-0006CE-UW
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 18:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWBXRo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWBXRo1
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 12:44:27 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:3288 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750825AbWBXRo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 12:44:27 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id 16E2736199;
	Fri, 24 Feb 2006 12:44:22 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id B3CC66F1C;
	Fri, 24 Feb 2006 17:44:22 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id A3F25BCD3; Fri, 24 Feb 2006 10:44:22 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16718>

Junio,

This message came to me at exactly the right time.  Yesterday I was
exploring using git as the content storage back-end for some binary
files.  Up until now I've only used it for software projects.

I found the largest RCS file that we had in our current back-end.  It
contained twelve versions of a binary file.  Each version averaged about
20 MB.  The ,v file from RCS was about 250MB.  I did some experiments on
these binary files.

First, gzip consistantly is able to compress these files to about 10%
their original size.  So, they are quite inflated.  Second, xdelta would
produce a delta between two neighboring revisions of about 2.5MB in size
that would compress down to about 2MB.  (about the same size as the next
revision compressed without deltification so packing is ineffective
here).

I added these 12 revisions to several version control back-ends
including subversion and git.  Git produced a much smaller repository
size than the others simply due to the compression that it applies to
objects.  It also was at least as fast as the others.

The problem came when I tried to clone this repository.
git-pack-objects chewed on these 12 revisions for over an hour before I
finally interrupted it.  As far as I could tell, it hadn't made much
progress.

My other complaint was that git prune ran slow (~8 seconds on my very
fast machine with fast disk access) on a repository with only these
twelve revisions in it (37 total objects in the object store).  This is
because 'git prune' actually ends up running fsck on all of the objects
which verifies the sha1 of each object.  This seems like a lot of work
just to prune unwanted objects.  What would you say to a --fast option
to git-prune that would avoid most of what fsck does including verifying
sha1 for each object?

Anyway, that was a tangent.  I looked into to overriding the --depth
option to git-pack-objects and set it to 0.  However, this isn't
trivial.  git-pack-objects is never called directly by the user.  It is
only called through things like 'git clone', 'git push' and 'git
repack'.  What do you think about this?  Could we add a configuration
option that could be set for the repository?  Something smarter like
what you suggest where git would pack small text files but give up on
large binaries would be optimal.

I've already determined that packing a repository with this type of
largish binary file doesn't do any good but there doesn't seem to be a
way to avoid packing when doing network operations.

Thoughts?
Carl

On Fri, Feb 24, 2006 at 12:49:13AM -0800, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > Indexing based on adler32 has a match precision based on the block size 
> > (currently 16).  Lowering the block size would produce smaller deltas 
> > but the indexing memory and computing cost increases significantly.
> 
> Indeed.
> 
> I had this patch in my personal tree for a while.  I was
> wondring why sometimes progress indication during "Deltifying"
> stage stops for literally several seconds, or more.
> 
> In Linux 2.6 repository, these object pairs take forever to
> delta.
> 
>         blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f -> 
>         blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>         size (491102 -> 496045)
>         58 seconds
> 
>         blob 4917ec509720a42846d513addc11cbd25e0e3c4f -> 
>         blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>         size (495831 -> 496045)
>         64 seconds
> 
> Admittedly, these are *BAD* input samples (a binary firmware
> blob with many similar looking ", 0x" sequences).  I can see
> that trying to reuse source materials really hard would take
> significant computation.
> 
> However, this is simply unacceptable.
> 
> The new algoritm takes 58 seconds to produce 136000 bytes of
> delta, while the old takes 0.25 seconds to produce 248899 (I am
> using the test-delta program in git.git distribution).  The
> compression ratio is significantly better, but this is unusable
> even for offline archival use (remember, pack delta selection
> needs to do window=10 such deltification trials to come up with
> the best delta, so you are spending 10 minutes to save 100k from
> one oddball blob), let alone on-the-fly pack generation for
> network transfer.
> 
> Maybe we would want two implementation next to each other, and
> internally see if it is taking too much cycles compared to the
> input size then switch to cheaper version?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
