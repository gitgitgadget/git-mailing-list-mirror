From: Jeff King <peff@peff.net>
Subject: Re: Zero padded file modes...
Date: Thu, 5 Sep 2013 15:35:08 -0400
Message-ID: <20130905193507.GB15910@sigill.intra.peff.net>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
 <20130905153646.GA12372@sigill.intra.peff.net>
 <CAEBDL5UiEurFeZg1AuNUKEvBMDs3K3D5ZiF5rB-dYWjp5nvrEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHfKv-00053a-67
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126Ab3IETfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:35:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:48344 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757119Ab3IETfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:35:11 -0400
Received: (qmail 31518 invoked by uid 102); 5 Sep 2013 19:35:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Sep 2013 14:35:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Sep 2013 15:35:08 -0400
Content-Disposition: inline
In-Reply-To: <CAEBDL5UiEurFeZg1AuNUKEvBMDs3K3D5ZiF5rB-dYWjp5nvrEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233987>

On Thu, Sep 05, 2013 at 01:13:40PM -0400, John Szakmeister wrote:

> > Yep. These were mostly caused by a bug in Grit that is long-fixed.  But
> > the objects remain in many histories. It would have painful to rewrite
> > them back then, and it would be even more painful now.
> 
> I guess there's still the other side of the question though.  Are
> these repositories busted in the sense that something no longer works?

No, as far as I know, everything still works fine. However, some diffs
may be suboptimal, because we may have two different sha1s for the same
subtree (so we may descend into the tree unnecessarily only to find that
they are equivalent). And by the same token, any scripts doing
non-recursive diffs may erroneously mark the trees as differing, even
though they do not contain any differing files.

But neither is a big problem in practice. If you had two clients in
active use which were flip-flopping a sub-tree back and forth between
representations, it would be a problem. But we are talking about a few
isolated incidents far back in history.

> I doesn't appear to be the case, but I've not used it extensively say
> I can't say for certain one way or another.  In the sense that the
> content is not strictly compliant, transfer.fsckObjects did its job,
> but I wonder if fsck needs to be a little more tolerant now (at least
> with respect to transfer objects)?

Fsck actually treats this as a warning, not an error. It is
transfer.fsckObjects (via "index-pack --strict") that actually treats
warnings as errors.

It's possible that this should be loosened to allow through problems
marked as FSCK_WARN (with a message, kind of like...a warning). Though
it may also make sense to revisit some of the classifications in fsck
(e.g., many of the warnings are indicative of seriously broken objects).

GitHub uses transfer.fsckObjects, rejecting all warnings[1]. In practice
it is not usually a big deal, as people are happy to fix up their
objects _before_ they get widely published. The biggest push-back we get
is when somebody tries to re-push history they got from another GitHub
repo, and then says "But why are you complaining? You served this crappy
broken history?" And it's a fair point. If you are forking (but not
joining the existing fork network) of an existing project with
irregularities in the history, it's not really an option to simply
rewrite the history you are basing on.

-Peff

[1] Actually, we do let through 0-padded modes with a warning,
    explicitly because of the problem mentioned above.
