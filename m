From: Jeff King <peff@peff.net>
Subject: Re: looking for example of following code across files
Date: Sat, 16 Feb 2008 12:54:45 -0500
Message-ID: <20080216175445.GA19506@sigill.intra.peff.net>
References: <57E76010-D0F8-420C-A11D-8884832FD00D@gmail.com> <m3pruxb6rh.fsf@localhost.localdomain> <44F74AD0-CD8E-4715-BA88-4355F4513AB0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 18:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRGD-0000aV-C6
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 18:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbYBPRyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 12:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbYBPRyt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 12:54:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1028 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273AbYBPRys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 12:54:48 -0500
Received: (qmail 11976 invoked by uid 111); 16 Feb 2008 17:54:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 16 Feb 2008 12:54:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2008 12:54:45 -0500
Content-Disposition: inline
In-Reply-To: <44F74AD0-CD8E-4715-BA88-4355F4513AB0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74052>

On Sat, Feb 16, 2008 at 12:10:11PM -0500, Rhodes, Kate wrote:

> In order to find the original commit of each block is the system looking 
> up the commit for each block via it's SHA1, then following its parent 
> commits until it finds another commit that affected the same block or runs 
> out of commits?

Not exactly. You don't have a sha1 for each block, you have a sha1 for
the whole file. So you walk the parent tree looking for the first time a
particular chunk showed up. The basic idea is sketched out here:

http://article.gmane.org/gmane.comp.version-control.git/28826

> I'm thinking that while this would be possible to do manually it would  
> way too many lookups to be practical. Or, is there a simpler way to do it 
> on the command line?

You could do it manually, but it would be horribly slow. An overly
simplified version of the algorithm is:

  1. Assume I'm interesed in a line that says "int foo() {"
  2. Check whether my parent has that line
     2a. If yes, then pass blame to parent, starting at '1'.
     2b. If no, then I introduced the line. Accept blame.

[When you talk about content movement, it gets a little trickier. See
Junio's original explanation for more details.]

So you would end up pass blame for some lines through many commits that
didn't touch those lines. I don't think you would want to do that by
hand.

-Peff
