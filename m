From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed, 6 Feb 2013 19:10:13 -0500
Message-ID: <20130207001013.GA28970@sigill.intra.peff.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
 <7vmwvhmli7.fsf@alter.siamese.dyndns.org>
 <20130206221240.GC27507@sigill.intra.peff.net>
 <7vr4kt9f53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3F4b-0004yQ-4s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 01:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab3BGAKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 19:10:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37291 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757945Ab3BGAKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 19:10:17 -0500
Received: (qmail 12472 invoked by uid 107); 7 Feb 2013 00:11:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 19:11:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 19:10:13 -0500
Content-Disposition: inline
In-Reply-To: <7vr4kt9f53.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215666>

On Wed, Feb 06, 2013 at 03:49:44PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And stating it that way makes it clear that there may be other missing
> > steps (3 and up) to apply other gitattributes. For example, should "git
> > show $blob" respect crlf attributes? Smudge filters?
> 
> Yeah, I think applying these when path is availble may make sense.
> 
> Are we going to teach cat-file to honor them with "--textconv" and
> possibly other new options?
> 
> Or should the "--textconv" imply application of these other filters?
> I am tempted to say yes, but I haven't thought things through...

For diff, we should already recognize them (because we feed the diff
machinery the path name, and it does the usual attributes lookup). Of
course it only uses things like funcname, not any of the
convert-to-filesystem options (hmm, actually, I guess it may use
convert-from-filesystem, but in such a case it would not be reading from
a blob anyway, but from a filesystem path, so it is not related to this
code).

For cat-file, I don't think --textconv should necessarily imply it. The
original motivation for "cat-file --textconv" was for external blame to
be able to access the converted contents. But it would not want to do
filesystem-level conversion; it wants the canonical version of the file.
I think a better option name for smudge/crlf would be "--to-filesystem"
or something like that. And probably it should not be the default.

git-show should probably have the same option. I doubt it should be on
by default, but I can see it being useful for:

  git show --to-filesystem HEAD:Makefile >Makefile

or whatever. I don't think those features necessarily need to come as
part of Michael's series. They can wait for people who care to implement
them. But I do think the refactoring of passing along the path from the
object_context should keep in mind that we will probably want to go that
way eventually.

Are there other attributes that we might care about when showing a blob?
The only ones I can think of are the ones for converting to the
filesystem representation.

-Peff
