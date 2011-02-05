From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 00:39:57 +0100
Message-ID: <201102060039.57588.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 00:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plrjm-0003AR-3A
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 00:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab1BEXkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 18:40:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:42773 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936Ab1BEXkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 18:40:03 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG600L6X4EOOT40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 00:40:00 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D3CEA1EA5680_D4DDFD0B	for <git@vger.kernel.org>; Sat,
 05 Feb 2011 23:40:00 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E893B1EA28FB_D4DDFCFF	for <git@vger.kernel.org>; Sat,
 05 Feb 2011 23:39:59 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG600HCR4ENBC30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 00:39:59 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166129>

On Saturday 05 February 2011, Nicolas Pitre wrote:
> On Sat, 5 Feb 2011, Jeff King wrote:
> > On Sat, Feb 05, 2011 at 01:39:57PM -0500, Nicolas Pitre wrote:
> > > So that's what has to be fixed.  If you get duplicated tag names then
> > > just warn the user and give priority to the local one, or error out
> > > with a "ambiguous tag specification" if no local but multiple remote
> > > tags with the same name are found (the user would have to be more
> > > precise in the tag scope in that case).
> > 
> > The latter seems like a regression for the common case of fetching from
> > two upstreams. E.g., I usually pull from Junio, getting
> > remotes/origin/v1.7.0.  One day Shawn is the interim maintainer, and I
> > pull from him, getting remotes/spearce/v1.7.0, which he previously
> > fetched from Junio. Under the current code, I can still do "git show
> > v1.7.0"; under the scheme described above I now have to say
> > "origin/v1.7.0" to disambiguate.
> 
> Let's suppose that both tags are identical, as in your scenario above
> they would be, then there is no need to call for any ambiguity in that
> case.
> 
> > The real issue, I think, is that we are claiming ambiguity even though
> > those tags almost certainly point to the same sha1. When handling
> > ambiguous tags, should we perhaps check to see if all of the
> > ambiguities point to the same sha1, and in that case, just pick one at
> > random?
> 
> If they're identical then there is no randomness.  If they refer to
> different tag objects, even if those tag objects do refer to the same
> commit object, then I'd say there is an ambiguity only if the tag object
> content matters i.e. when displaying the tag content.
> 
> > In the case of resolving a ref to a sha1, then by definition they are
> > all equivalent to pick. For things that care (e.g., "git checkout") we
> > should probably still complain (although many of those commands have
> > their own disambiguation code to prefer refs/heads/ or whatever
> > anyway).
> 
> We are probably more or less saying the same thing.

Yes, I believe this was all covered by a footnote in my proposal. Quote:

[2]: When looking up a shorthand tag name (e.g. v1.7.4): If a local tag 
(refs/tags/v1.7.4) is found, then we have an unambiguous match. If no local 
tag is found, we look up the tag name in all configured remotes (using the 
method described in [1]). If the tag name exists in one or more remotes, and 
those remotes all agree on its ultimate object name (after applying e.g. 
^{commit} or whatever is appropriate in the context of the lookup), then we 
also have an unambiguous match. However, if the tag name exists in multiple 
remotes, and they do NOT all agree on its ultimate object name, then the 
shorthand tag name is ambiguous and the lookup fails. The user can always 
resolve this ambiguity by creating a local tag (refs/tags/v1.7.4) pointing 
to the desired object.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
