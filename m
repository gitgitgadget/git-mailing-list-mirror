From: Mike Hommey <mh@glandium.org>
Subject: Re: Is there interest in a n-sect tool?
Date: Thu, 21 Jan 2016 07:34:29 +0900
Message-ID: <20160120223429.GA28006@glandium.org>
References: <20160118075653.GA13911@glandium.org>
 <xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
 <20160118085835.GA15642@glandium.org>
 <xmqqziw2b4wi.fsf@gitster.mtv.corp.google.com>
 <20160119045719.GA11680@glandium.org>
 <xmqqd1sv52l9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:34:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM1Ks-0001lt-C2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 23:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934792AbcATWej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 17:34:39 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53808 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758424AbcATWeh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 17:34:37 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aM1Kf-0007LF-Ef; Thu, 21 Jan 2016 07:34:29 +0900
Content-Disposition: inline
In-Reply-To: <xmqqd1sv52l9.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284478>

On Wed, Jan 20, 2016 at 02:05:22PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Mon, Jan 18, 2016 at 07:54:21PM -0800, Junio C Hamano wrote:
> >
> >> Hmm, sorry.  For the two-trait example I gave (that can be extended
> >> to N-trait), I can sort of see how the UI might look and I can say
> >> it might be useful [*1*], but not with this, and especially that you
> >> do not necessarily know all the traits whose transition points you
> >> might be interested in a-priori--all of that makes the problem
> >> definition fuzzy to me, and I cannot imagine what kind of user
> >> interaction you would be envisioning to solve what kind of problem,
> >> so I cannot even say it is a good idea or a bad idea.
> >
> > How about something like this:
> >
> > $ git bisect start
> > $ git bisect state black A
> > $ git bisect state white Z
> >
> > Git then gives you commit M to test, between A and Z. Now, you test M,
> > and the result is that it's neither black or white, but gray, so you
> > would do:
> >
> > $ git bisect state gray
> 
> Is it assumed throughout the bisect session that the only boundary
> black touches is with gray (or some other color) and the only
> boundaries gray touches are either with black or with white,
> i.e. there is no path that goes from black to gray back to black and
> then to white?  That is the parallel to the requirement a
> bog-standard bisection has (i.e. "one side is all black, once you
> cross the boundary to white, remainder is all white").
> 
> I just cannot see a realistic use case where that assumption holds
> and still you do not know a-priori how many colors there are.

Well, that's exactly the use case I had. A simplified version of it is:

Find all the git-cinnabar revisions that affected the git sha1 commits
corresponding to mercurial changesets in a given repository. There are
multiple changes in git-cinnabar that affected the sha1 of git commits
because of changes in e.g. author munging, timezone munging, etc.
But without looking at the git-cinnabar `git log` extensively, I don't
remember how many such changes there were and how they affect some given
repositories.

So, for example, with git-cinnabar commit A, mercurial changeset H
would become git commit G, and with git-cinnabar commit B, mercurial
changeset H would become git commit G'. With git-cinnabar commit A and B,
mercurial changeset H2 would become git commit G2, but in git-cinnabar
commit C, it would become git commit G2'. I'm looking for B and C, and
all the others that could exist.

> If that assmption holds, what you wrote would be a usable interface
> and I suspect an implementable one.

Considering I'm going to need this a couple more times, I'm likely to
give it a spin. The main question that remains is how to make that work
with `git bisect run`. I'm thinking something like this:

$ git bisect state-number black
0
$ git bisect state-number white
1
$ git bisect state-number gray
2

The numbers would be assigned when the state is used for the first time.
And the `bisect run` script could just do:

exit $(git bisect state-number $state)

`state-number` kind of sucks as a name, though.

Mike
