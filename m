From: Jeff King <peff@peff.net>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 15:38:40 -0500
Message-ID: <20110120203840.GA11468@sigill.intra.peff.net>
References: <ih1449$ul6$1@dough.gmane.org>
 <7v62tjs66r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephen Kelly <steveire@gmail.com>,
	KDE PIM <kde-pim@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 21:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg1HN-00013p-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 21:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab1ATUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 15:38:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab1ATUio (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 15:38:44 -0500
Received: (qmail 13386 invoked by uid 111); 20 Jan 2011 20:38:43 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 20 Jan 2011 20:38:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 15:38:40 -0500
Content-Disposition: inline
In-Reply-To: <7v62tjs66r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165334>

On Thu, Jan 20, 2011 at 11:53:16AM -0800, Junio C Hamano wrote:

> The refs/remotes/origin/HEAD in Bob's repository is supposed to be a
> symbolic ref that points at the primary branch of the 'origin' remote
> (typically its master), e.g. "ref: refs/remotes/origin/master".  But in
> general, local 'refs/remotes/origin/X' for any value of X is to copy
> 'refs/heads/X' from the 'origin'.
> 
> Oops.  If the origin repository has 'refs/heads/HEAD', these rules
> obviously conflict with each other.
>
> [...]
>
> I personally think it is reasonable to forbid HEAD or anything all caps
> that ends with "_HEAD" as branch names.  Opinions?

Hmm. It seems like the symbolic ref is the culprit, not just HEAD. The
HEAD thing is the most likely, of course, but I could do something like:

  git symbolic-ref refs/remotes/origin/convenient-alias \
                   refs/remotes/origin/some-name-you-dont-like

which is basically the same as the HEAD case (except that the
"convenient alias" for HEAD is "origin" and not
"origin/convenient-alias" due to the lookup table in dwim_ref).

Now imagine the remote creates a branch called convenient-alias. When I
fetch, am I corrupting my local tracking branches by falsely equating
the two? And/or when I push, am I then corrupting the remote?

So I wonder if the safety valve here should be about symbolic refs, and
not about the special name HEAD. Maybe we should not follow symbolic
refs during fetch. So if we are fetching the refspec "foo:bar", and the
RHS "bar" is a symref, we should _not_ follow it, but instead just
overwrite the symref with a regular ref.

For pushing, one rule could be to allow pushing from a named symref, but
not allow the matching rules to use a symref as a source. So I could do:

  git push origin convenient-alias:new-name

but

  git push origin

would never overwrite upstream's convenient-alias.

I dunno. That's just off the top of my head, so maybe I'm missing some
corner cases. I would be tempted to put the push rule into receive-pack,
so it could look at the local refs, but I don't think receive-pack has
any way of knowing what is a symref and what is not on the pushing end.

-Peff
