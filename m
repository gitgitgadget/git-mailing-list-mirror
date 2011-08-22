From: Jeff King <peff@peff.net>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Mon, 22 Aug 2011 13:57:05 -0400
Message-ID: <20110822175705.GB1945@sigill.intra.peff.net>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org>
 <20110817231922.GA28966@sigill.intra.peff.net>
 <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
 <20110822161932.GA1945@sigill.intra.peff.net>
 <CAGdFq_gx+NutDCU7egr_fYUvVG=g1t76LiV1SV-W=0KWBTjHyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 19:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvYkQ-0002LQ-Ub
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 19:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab1HVR5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 13:57:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50383
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab1HVR5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 13:57:08 -0400
Received: (qmail 18590 invoked by uid 107); 22 Aug 2011 17:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 22 Aug 2011 13:57:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2011 13:57:05 -0400
Content-Disposition: inline
In-Reply-To: <CAGdFq_gx+NutDCU7egr_fYUvVG=g1t76LiV1SV-W=0KWBTjHyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179874>

On Mon, Aug 22, 2011 at 09:54:47AM -0700, Sverre Rabbelier wrote:

> Do you agree that this is expected behavior?
> 
> $ git init test
> Initialized empty Git repository in /home/sverre/code/test/.git/
> $ cd test/
> $ echo content >> foo
> sverre@laptop-sverre:~/code/test
> $ git add foo
> $ git commit -m first
> [master (root-commit) 821176f] first
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 foo
> $ echo content >> foo
> $ git commit -am second
> [master 1934282] second
>  1 files changed, 1 insertions(+), 0 deletions(-)
> $ git branch other
> $ git fast-export ^master other
> reset refs/heads/other
> from 1934282469e3a83a5ef827fd31e074cfb4f3eadf

Yeah, that seems reasonable to me.

> Because in current git.git, this doesn't work (the above is generated
> using a git that has the patch series Dscho and I sent out). Current
> git will instead do the following:
> 
> $ git fast-export ^master other
> reset refs/heads/other
> from :0
> 
> The 'from :0' here is obviously a bug (which is fixed by our patch series).

Yep, the current behavior is definitely wrong. But I thought your
question was about accidentally mentioning refs/heads/master, which this
doesn't do (nor should it).

I just read through the remote-helper threads from early June, and the
only mention of triggering that is when you actually have a rename
(i.e., your "refs/heads/foo" becomes remote's "refs/heads/bar", but we
mention "refs/heads/foo" in the export stream). I was thinking there was
another case, but I couldn't find mention of it.

> You might wonder, 'why would anyone do that', well, for example, they
> might be using marks:
> 
> $ git fast-export --export-marks=marksfile  master > /dev/null
> $ git fast-export --import-marks=marksfile  other
> reset refs/heads/other
> from :4
> 
> Again, the above is generated with my patched git, current git.git
> simply outputs nothing.
> 
> $ git fast-export --import-marks=marksfile other

Yeah, the behavior of your patch looks fine to me. I thought the point
in contention was that having export understand refspecs would fix a lot
of _other_ cases, too.

-Peff
