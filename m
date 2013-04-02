From: Jeff King <peff@peff.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 2 Apr 2013 15:16:41 -0400
Message-ID: <20130402191641.GB17784@sigill.intra.peff.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
 <20130402163034.GA19252@sigill.intra.peff.net>
 <7vhajog9xp.fsf@alter.siamese.dyndns.org>
 <20130402165128.GA19712@sigill.intra.peff.net>
 <7v1uasg8e0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:17:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6hn-0007Hh-E7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab3DBTQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:16:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab3DBTQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:16:46 -0400
Received: (qmail 13255 invoked by uid 107); 2 Apr 2013 19:18:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:18:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:16:41 -0400
Content-Disposition: inline
In-Reply-To: <7v1uasg8e0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219853>

On Tue, Apr 02, 2013 at 10:16:55AM -0700, Junio C Hamano wrote:

> > Yes, but as I explained later, the meaning of "apply an attribute to
> > dir" in such cases is always equivalent to "apply attribute
> > recursively to dir/*". So I do not think we are violating that rule to
> > recursively apply all attributes.
> 
> I think this is where we disagree.  Attribute does not recursively
> apply in general.  It was _never_ designed to (and that is the
> authoritative answer, as I was who designed it in Apr 2007 ;-)).

My argument was not that they apply recursively in general, but that we
followed an "as if" rule where what happens in the gitignore and
export-ignore cases are indistinguishable from recursive application.
But...

> It is not even true to say that "archive" applies export-ignore to
> the directory recursively, with or without the recent change.  Would
> it allow everything but dir/file to be excluded and still dir/file
> to be included in the archive if you have a .gitattribute file like
> this?
> 
> 	dir/ export-ignore
>         dir/file !export-ignore
> 
> I do not think so.

This is a perfect counter-example. The current behavior _is_
distinguishable from recursive application, and my "as if" above is not
correct.

Thanks for the clarification.

> > But let's take a step back. I think Jan is trying to do a very
> > reasonable thing: come up with the same set of paths that git-archive
> > would. What's the best way to solve that?
> 
> Because the attribute does not recursively apply in general, and it
> is entirely up to the application and a particular attribute key to
> decide how the key is applied in the context of the application,
> "check-attr" by itself cannot know.  You need to know how "archive"
> treats "export-ignore" attribute and then use "check-attr" with that
> knowledge.

Yeah, I had the same thought. So you would have to either:

  1. Hook the feature into git-archive, which knows about how it
     recurses, and can report the correct set of paths.

or

  2. Tell check-attr (or some post-processor) to apply the attribute to
     elements below the path (or possibly to prune out such paths). This
     is not the same as recursive application, because you cannot negate
     it (i.e., you actually find out the final attrs for both "foo" and
     "foo/bar", and then say "the attr for 'foo' overrides the attr for
     'foo/bar'".

I posted a patch for (1), but it felt not-very-general. But (2) also
feels gross and not very general. Even though it could in theory be used
for things besides git-archive, it is really just applying git-archive's
pruning rule, which other programs likely don't care about.

-Peff
