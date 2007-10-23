From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 01:42:38 -0400
Message-ID: <20071023054238.GE14735@spearce.org>
References: <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org> <20071023045632.GD27132@thunk.org> <20071023050726.GD14735@spearce.org> <20071023053003.GE27132@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCXY-0006Qu-Rz
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbXJWFmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbXJWFmp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:42:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41386 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbXJWFmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:42:44 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkCXH-0004fR-Op; Tue, 23 Oct 2007 01:42:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8F2E320FBAE; Tue, 23 Oct 2007 01:42:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071023053003.GE27132@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62095>

Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Oct 23, 2007 at 01:07:26AM -0400, Shawn O. Pearce wrote:
> > Junio has in the past proposed rewinding next, especially after a
> > significant release (e.g. 1.5.3).  
> 
> Hmm, yes.  I think I'd want to rewind next after a while; the thought
> of next drifting hundreds or thousands of commits away from master
> just gives me the heebee-jeebies.  I'm sure it mostly works, but it
> just feels wrong.  :-)

There's been a couple of times in git history where Junio has basically
done this to whack next back into line:

	git checkout next
	git diff next master | git apply --index
	git commit -m "Whack next back in line"

Because we've found a change or two lurking in there that shouldn't
have been there after a while.  I think it was related to a merge
conflict that happened in next but didn't in master or something
like that.  But usually this difference exists as there's usually
always something cooking in next.
 
> > A bunch of folks (myself included if I recall correctly) didn't want
> > to do this, as we create topic branches locally from things in next
> > and sometimes make commits over them to improve the topic further.
> 
> I guess I don't see why this would be a hardship; would a quick rebase
> on the topic branches more or less take care of the problem?  

Yes.  But you need the prior value of the branch so you can do
something easy like:

	git checkout yourtopic
	git rebase --onto $newtopic $oldtopic

which means you probably need to look through the logs for not just
pu but also pu@{1}.  A script to break out the topic branches from
pu post fetch and store them as proper tracking branches would make
this easier, but that much.  If you plan ahead you can save that
$oldtopic point so you can do something like this:

	git log pu ; # find $newtopic
	git checkout yourtopic
	git rebase --onto $newtopic base-yourtopic
	git tag -f base-yourtopic $newtopic

> I guess that brings up another question; I've been regularly rebasing
> the topics branches as master and next advances... probably more out
> of superstition than anything else.  Is that a bad idea for any reason?

It keeps the history shorter in gitk.  But otherwise it isn't bad.
Unless you are running into a lot of conflicts every time you rebase
and its wasting your time.  ;-)

I prefer to rebase the topics until they've merged to an integration
branch that doesn't rewind (e.g. master or next in git.git).
That way they have the shortest line possible in gitk between the
final merge and the start point.

There are good reasons why there's an "author" and a "committer"
field in commits.  Rebasing will change the committer field's
timestamp, but not the author field.  And author comes from the
email, to preserve the original date of development.
 
> Hmm... I guess some of this would be really good to get into the Howto
> section of the user guide when talking about git workflows!

Yea, I think so too.  We've adopted this model in git.git because
it works for our community.  A lot of other communities aren't
too far away, as we have a lot of crossover in members.  E.g. we
learned a lot from the kernel community.

-- 
Shawn.
