From: Jeff King <peff@peff.net>
Subject: Re: encrypted repositories?
Date: Mon, 20 Jul 2009 11:30:24 -0400
Message-ID: <20090720153024.GD5347@coredump.intra.peff.net>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
 <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
 <op.uxc712eh1e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuot-0004Ah-JX
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbZGTPaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbZGTPaU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:30:20 -0400
Received: from peff.net ([208.65.91.99]:42483 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZGTPaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:30:20 -0400
Received: (qmail 26763 invoked by uid 107); 20 Jul 2009 15:32:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Jul 2009 11:32:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 11:30:24 -0400
Content-Disposition: inline
In-Reply-To: <op.uxc712eh1e62zd@balu.cs.uni-paderborn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123614>

On Mon, Jul 20, 2009 at 02:09:28PM +0200, Matthias Andree wrote:

> No, the server can't be allowed access to the keys or decrypted data.
> 
> I'm not sure about the graph, and if I should be concerned. Exposing
> the DAG might be in order.
> 
> It would be ok if the disk storage and the over-the-wire format
> cannot use delta compression then. It would suffice to just send a
> set of objects efficiently - and perhaps smaller revisions can be
> delta-compressed by the clients when pushing.

The problem is that you need to expose not just the DAG, but also the
hashes of trees and blobs. Because if I know you have master^, and I want
to send you master, then I need to know which objects are referenced by
master that are not referenced by master^.

So now you have security implications, because I can do an offline
guessing attack against your files (i.e., calculate git blob hashes for
likely candidates and see if you have them). Whether that is a problem
really depends on your data.

Not to mention that it makes the protocol a lot more complex, as you
would be encrypting _parts_ of objects, like the filenames of a tree,
and the commit message of a commit object.

I suppose in theory you could obfuscate the sha1's in a way that
preserved the object relationships but revealed no information. That is,
the server would have one "fake" set of sha1's, and the client would map
its real sha1's to the fake ones when talking with the server. But that
is again potentially getting complex.

-Peff
