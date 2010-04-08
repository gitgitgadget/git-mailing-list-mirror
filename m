From: Jeff King <peff@peff.net>
Subject: Re: Re*: Extremely slow progress during 'git reflog expire --all'
Date: Thu, 8 Apr 2010 03:00:50 -0400
Message-ID: <20100408070050.GG30473@coredump.intra.peff.net>
References: <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
 <20100405062621.GA30934@coredump.intra.peff.net>
 <7v1vetpw63.fsf@alter.siamese.dyndns.org>
 <20100406060217.GF3901@coredump.intra.peff.net>
 <7vochvcdkc.fsf_-_@alter.siamese.dyndns.org>
 <7vk4sjcddh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:01:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzljq-0004ST-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758408Ab0DHHBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:01:12 -0400
Received: from peff.net ([208.65.91.99]:46593 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758076Ab0DHHBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:01:11 -0400
Received: (qmail 16991 invoked by uid 107); 8 Apr 2010 07:01:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 03:01:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 03:00:50 -0400
Content-Disposition: inline
In-Reply-To: <7vk4sjcddh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144334>

On Wed, Apr 07, 2010 at 11:43:22AM -0700, Junio C Hamano wrote:

> Side note.
> 
> It may be an improvement to dig the history even more incrementally.

I doubt it matters much in practice. The important features of the
solution are:

  - for most refs, which are either all-reachable or which don't have
    clock skew, don't go to the roots at all. This is the fast case that
    we should do most of the time.

  - for others, don't go to the roots over and over for each entry. This
    is the slow case, but we just need to make sure it's a not the
    horrible slow case that Frans saw.

Your suggestion speeds up the slow case a little bit, but it is already
acceptably fast. Plus this is an optimistic optimization. There are
still cases where you might have to dig to the roots anyway (e.g.,
whenever you have anything unreachable).

> Inside unreachable(), we currently dig immediately down to root, but it
> may give us a better performance in a long history with reflog entries
> that wildly jump everywhere in that history if we dug down to the
> timestamp of the commit we are looking at.  A patch to do so on top of the
> previous one may look like this.

Why dig to the timestamp? You know you're looking for a particular
commit, so you can dig down to that commit. If it's reachable, stop
there and you have your answer. Any work you do beyond that might be
used for a further entry lookup, but it might not at all. If it's not
reachable, then you're going to end up digging down to the roots anyway.

With an unreachable ref and your scheme, you would just end up not
finding it, extending again, not finding it, extending again, etc. But
you can never be sure it's truly unreachable without going to the roots
or assuming no clock skew, so that is what we'll end up doing.

-Peff
