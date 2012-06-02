From: Jeff King <peff@peff.net>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Sat, 2 Jun 2012 12:23:36 -0400
Message-ID: <20120602162336.GC15017@sigill.intra.peff.net>
References: <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
 <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
 <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
 <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
 <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
 <20120601093039.GD32340@sigill.intra.peff.net>
 <7vmx4n3sz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lanny Ripple <lanny@spotinfluence.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sar7A-0000N2-0q
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 18:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315Ab2FBQXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 12:23:39 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41141
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab2FBQXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 12:23:39 -0400
Received: (qmail 13859 invoked by uid 107); 2 Jun 2012 16:23:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 12:23:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 12:23:36 -0400
Content-Disposition: inline
In-Reply-To: <7vmx4n3sz5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199047>

On Fri, Jun 01, 2012 at 09:19:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> > [Please don't top-post.]
> > ...
> > But you have to keep in mind all of the people who will be led down the
> > wrong path by your breadcrumb when the failure is caused by a
> > _different_ problem. What is the probability that it is helpful versus
> > not helpful?  If you are going to give advice that sed might be broken,
> > you should at least test to see if it is broken and report it.
> 
> Eek, do that at runtime in the error code path?

Yes, which I think is utterly gross, but at least it is on the error
code path, so most people will never run it.

It's slightly less gross to do it at build-time (or even as part of
configure, I guess), but of course it is a run-time dependency, so there
is nothing to stop the broken sed from being installed after git (or
even a user with a different PATH than the builder triggering it).

One gross thing about doing it at run-time is that it only affects
_this_ code path, which happens to have an easy-to-diagnose outcome from
the bug. But how many other code paths are using sed on data which might
contain utf-8 characters? And are they failing silently or otherwise
simply corrupting the output?

One other thing to think about: this particular manifestation of the
bug is to cause our shell-quoting to fail. Are there are security
implications? That is, can I execute arbitrary code by having you run
get_author_ident_from_commit on a specially-crafted commit?

> The problem I see is that at that point where we have to suspect
> something fundamental as sed broken on the platform, we cannot even
> trust printf, test, or even the shell itself behaving sanely.

I don't think that's true. We have to deal with this kind of portability
nonsense all the time. We assume that the tools work until we get a
report that they don't, and then we fix it, work around it, or whatever.
Yes, the "your sed is broken" test would not work if "test" is also
totally broken. But we have not seen such a system in real life, or have
reason to suspect that it exists. Whereas we do know there is a
common[1] platform where the sed is broken in a specific way, but
nothing else is. Dealing with that helps solve a real problem for some
people.

-Peff

[1] I am just guessing about how common it is. I still haven't seen an
    indication of how common this version of sed is, or even which
    versions are affected.
