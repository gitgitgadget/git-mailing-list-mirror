From: Jeff King <peff@peff.net>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 16:54:57 -0500
Message-ID: <20110120215456.GB11468@sigill.intra.peff.net>
References: <ih1449$ul6$1@dough.gmane.org>
 <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net>
 <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephen Kelly <steveire@gmail.com>,
	KDE PIM <kde-pim@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:55:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg2TG-00081f-V1
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab1ATVzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 16:55:03 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34370 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379Ab1ATVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 16:55:03 -0500
Received: (qmail 14054 invoked by uid 111); 20 Jan 2011 21:54:59 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 20 Jan 2011 21:54:59 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 16:54:57 -0500
Content-Disposition: inline
In-Reply-To: <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165342>

On Thu, Jan 20, 2011 at 01:43:17PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. It seems like the symbolic ref is the culprit, not just HEAD. The
> > HEAD thing is the most likely, of course, but I could do something like:
> >
> >   git symbolic-ref refs/remotes/origin/convenient-alias \
> >                    refs/remotes/origin/some-name-you-dont-like
> 
> Isn't it already wrong to do the above locally, in the sense that it is
> equally wrong to do this?

Probably. My argument in favor would be "that is what we are doing with
remotes/*/HEAD", but I think the logic is somewhat circular there.

Thinking on it more, yeah, if you want "convenient-alias", you are
probably better off to do:

  git symbolic-ref refs/convenient-alias refs/remotes/origin/whatever

>     git update-ref refs/remotes/origin/no-such-thing-exists-over-there 
>     	refs/heads/master

Actually, don't we end up with that in the case of upstream deleting a
ref? Which isn't to say it isn't a stupid thing to do, but that we can
and do get into that state.

Thinking on it even more, I don't think we can cover all of the weird
"you have a ref named $foo and they suddenly created a ref named $foo"
push corner cases. There is no substitution for actual communication and
organization of ref names if you are going to be pushing along with
other people into a central repo. Because fundamentally the ref name is
the unique identifier, and matching refs during push tries to reconcile
matches based on those identifiers.

> I personally like this line of thought, especially as a thought experiment
> to see what corner cases we could find, but I doubt I will be able to say
> we covered all the corner cases with confidence without thinking long and
> very hard.  For now, I do not find this issue worth spending that kind of
> deep thinking, especially when a lot simpler and easier to explain
> workaround is available, but others may disagree and perfect your idea.

Yeah, after reading your response and considering a bit, I think the
simple "don't make HEAD" thing (or at least "don't pull or push HEAD")
is a sane workaround.

-Peff
