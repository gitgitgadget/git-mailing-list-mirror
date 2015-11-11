From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Wed, 11 Nov 2015 15:12:05 +0000
Message-ID: <20151111151204.GA4249@salo>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <5643107B.20501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 11 16:12:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwX4L-0008So-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 16:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbbKKPMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 10:12:13 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:49568 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbbKKPMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 10:12:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 20E404620D7;
	Wed, 11 Nov 2015 15:12:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8aZkYb4mpN2v; Wed, 11 Nov 2015 15:12:06 +0000 (GMT)
Received: from salo (salo.dyn.ducie.codethink.co.uk [10.24.1.218])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 48029461E2A;
	Wed, 11 Nov 2015 15:12:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <5643107B.20501@alum.mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281169>

On Wed, Nov 11, 2015 at 10:55:07AM +0100, Michael Haggerty wrote:
> On 11/10/2015 01:56 PM, Richard Ipsum wrote:
> > I've continued my work[1] to add patch tracking and candidate review capability
> > to git.
> > 
> > git-candidate now has a more git-like user interface, so remote candidates
> > can now be specified in a similar way to remote refs (e.g. origin/candidate)
> > as well as various other improvements, such as versioned metadata.
> 
> This is a really interesting project. I've seen a blog post or two
> proposing to store bug tracker information in Git in a distributed way,
> but I don't recall anything about doing the same for code review
> information.
> 
> I would be interested to hear about the design of your system at an
> abstract technical level. What do you store in Git and in what layout?
> Do you need to record any extra metadata within the commits that are
> merged to master? How do you merge and/or reconcile code review comments
> that come from multiple sources (or are they just tabulated)? Can your
> system handle the rebasing of topic branches? What about nonlinear topic
> branches (branches branches that themselves include merges)?

Extra metadata tracks the latest revision of a candidate
and the metadata version, the metadata objects for the revisions and reviews
are stored in trees, each object is keyed on the hash of the content
that is stored within the object, so reviews from multiple sources
cannot conflict. There's no ordering of reviews or comments,
the status command simply sorts reviews based on their timestamp.

The system reserves a portion of the refspace under refs/candidates/
the root tree object is stored in a commit under refs/candidate/heads/foo__meta
where foo is the name of the candidate. Anchors are also stored in this space,
an anchor is made for every revision of a candidate to ensure that commits
referred to by a candidate are not garbage collected.

The operations performed on a topic branch don't matter, all the candidate
knows about is the head sha of the branch we want to merge. Merging a
candidate is no different from merging any other git branch, you have
a ref candidate/foo so you can choose to merge that, or you can
check it out rebase it and then merge it.

> 
> All that being said, my gut feeling is that a system like this should
> not be developed within the Git project itself. Code review is a
> complicated thing, and I expect that different people will have very
> different ideas about how it should work. It would be a bad idea for the
> Git project to "bless" one system by including it in our source tree.
> (Earlier in the Git's history it was easier to get something accepted
> into "contrib", but that has gotten much harder over time.)

The aim is not to bless one particular system but to eventually
provide a common data model that all review systems can share,
so that it is possible to do distributed reviews with arbitrary UIs
in a widely compatible way.

If we add git-candidate to contrib then it can act as a reference
implementation, so that this data model can be validated and tested
by additional developers.

> 
> If, someday, one system becomes crushingly dominant, then conceivably it
> would make sense for it to be distributed along with Git for the
> convenience of users. Or if a bunch of review systems standardize on a
> single data model for storing review information in a Git repo, it might
> make sense for the plumbing for handling that data to reside in git-core
> for performance and data integrity reasons. Until then, I think it would
> be better for code review systems to live on their own, as independent
> projects.

I don't feel too strongly either way, that said I do think it may be
advantageous for all concerned to have this data model, we don't necessarily
need to wait for a particular system to become crushingly dominant.

> 
> In my opinion it would be fine to discuss the design of your system and
> solicit feedback about the design on the Git mailing list, and also to
> publish occasional announcement emails when you release new versions or
> whatever. You might also want to list your system on the Git SCM wiki,
> for example here [1].

Thanks, it would be good to add git-candidate to the list there.

Thanks,
Richard Ipsum
