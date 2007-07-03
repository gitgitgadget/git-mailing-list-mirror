From: Jeff King <peff@peff.net>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 3 Jul 2007 00:12:41 -0400
Message-ID: <20070703041241.GA4007@coredump.intra.peff.net>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net> <46896C3B.1050406@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:12:56 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Zkz-0005rp-1l
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbXGCEMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbXGCEMo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:12:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3900 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbXGCEMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:12:43 -0400
Received: (qmail 25874 invoked from network); 3 Jul 2007 04:13:04 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 04:13:04 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 00:12:41 -0400
Content-Disposition: inline
In-Reply-To: <46896C3B.1050406@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51449>

On Mon, Jul 02, 2007 at 11:20:59PM +0200, Christian Jaeger wrote:

> So there's no -f flag in normal git-rm usage. It thus has a different
> meaning, namely "force the operation pair of removing from index and
> unlinking", not "force this operation also onto the checked out files"
> as is the case with cogito.

Yes, git-rm is used in several situations, and the idea is that it
should behave safely in all situations; that is, without -f you can't
delete any data that can't be recovered from your history (but maybe
that means we shouldn't suggest -f in so cavalier a fashion).

Each file has three "states" that we care about: in the HEAD (H), in the
index (I), and in the working tree (W). Let's say you call 'git-rm'.
Here's a table of possibilities (A is some content "A", B is some
content not equal to "A", and N is "non-existant"):

H I W | ok? | why?
---------------------------------------------------
* N * | no  | file is not tracked
N A N | ?   | currently ok, but 'A' recoverable only through fsck
N A A | no  | 'A' recoverable only through fsck
N A B | no  | local modification 'B' would be lost
A A N | yes | 'A' recoverable through history
A A A | yes | 'A' recoverable through history
A A B | no  | local modification 'B' would be lost
A B N | ?   | currently ok, but 'B' recoverable only through fsck
A B A | no  | 'B' recoverable only through fsck
A B B | no  | 'B' recoverable only through fsck
B * * |     | equivalent to H=A

With --cached on, it is a little different:

H I W | ok? | why?
---------------------------------------------------
* N * | no  | file is not tracked
N A N |  ?  | currently ok, but 'A' recoverable only through fsck
N A A |  ?  | currently not ok, but 'A' still available in W
N A B | no  | 'A' recoverable only through fsck
A A N | yes | 'A' recoverable through history
A A A | yes | 'A' recoverable through history or working tree
A A B |  ?  | currently not ok, but 'A' still available in H
A B N |  ?  | currently ok, but 'B' recoverable only through fsck
A B A | no  | 'B' recoverable only through fsck
A B B |  ?  | currently not ok, but 'B' still available in W
B * * |     | equivalent to H=A

So it looks like our safety valve is a bit overbearing in a few
situations, and still misses some situations where data has to be pulled
out of the database with git-fsck.

I think if we actually spell out these possible states in the code, we
can get more accurate behavior, but also more accurate error messages. I
will try to work up a patch.

-Peff
