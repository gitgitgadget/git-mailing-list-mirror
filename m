From: Jeff King <peff@peff.net>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 14:47:10 -0500
Message-ID: <20120112194710.GA28148@sigill.intra.peff.net>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
 <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
 <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQcL-0007te-GP
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab2ALTrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:47:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36240
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2ALTrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:47:13 -0500
Received: (qmail 3143 invoked by uid 107); 12 Jan 2012 19:54:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 14:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 14:47:10 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188478>

On Fri, Jan 13, 2012 at 12:55:58AM +0530, Ramkumar Ramachandra wrote:

> Junio C Hamano wrote:
> > You should be able to look at revs->cmdline and tell if you need to let
> > cherry-pick walk (i.e. "cherry-pick master..next"), or if the user wants
> > individual commits (i.e. "cherry-pick A B C").
> >
> > And you do prepare_revision_walk() only when you need to walk; otherwise
> > you use the contents of revs->pending in order.

I am tempted to suggest that cherry-pick should not feed its arguments
to the revision machinery in the first place, but instead accept a set
of arguments, each argument of which is either a single commit
(interpreted by get_sha1) or a range specifier (which can be fed to
setup-revisions). And then get a linearized set of commits for _each_
argument independently and concatenate them (possibly eliminating
duplicates). That would make all of these work as most people would
expect:

  git cherry-pick A B C
  git cherry-pick A..B
  git cherry-pick A..B B..C

but would be a regression for:

  git cherry-pick B ^A

versus the current code. I suspect that the latter form is not all that
commonly used, though, and certainly I would accept it as a casualty of
making the "A B C" form work. My only hesitation is that it is in fact a
regression.

> Okay, just to make sure I understand this correctly: if more than one
> argument is literally specified, I should not set up the revision
> walker and pick the commits listed in revs->pending, correct?  Then,
> when I encounter the following command,
> 
>   $ git cherry-pick maint ^master
> 
> I should just pick two commits: maint, and ^master.

But ^master is not a commit, it is a negation. So it is nonsensical if
the arguments are considered independent of each other (you _could_
use a heuristic to guess that they are not independent, but I'd rather
not go there). So you'd probably end up just rejecting the arguments.

-Peff
