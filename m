From: Jeff King <peff@peff.net>
Subject: Re: merge recursive and code movement
Date: Fri, 25 Mar 2011 06:12:04 -0400
Message-ID: <20110325101204.GB9047@sigill.intra.peff.net>
References: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
 <20110325093758.GA9047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:12:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3408-0005hJ-FS
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 11:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738Ab1CYKMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 06:12:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39426
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679Ab1CYKMG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 06:12:06 -0400
Received: (qmail 12142 invoked by uid 107); 25 Mar 2011 10:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 06:12:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 06:12:04 -0400
Content-Disposition: inline
In-Reply-To: <20110325093758.GA9047@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169978>

On Fri, Mar 25, 2011 at 05:37:58AM -0400, Jeff King wrote:

> It _almost_ works. The merge completes automatically, and the tweak ends
> up in foo.h, as you expect. But the merge silently deletes the
> placeholder revision.h!
> 
> I suspect it is a problem of merge-recursive either not handling the
> broken filepair properly, or perhaps reading too much into what a rename
> means. I haven't dug further.

Ah, found it. In process_renames, we explicitly call remove_file() on
the source, which is assuming the rename did not come from a broken
pair. What we actually want to do, I think, is to just take the changes
from the renaming side literally. There's no point in doing a 3-way
merge because the other side's changes will end up applied to the rename
destination.  It just happens that without break_opt, the renaming sides
change is _always_ a deletion, or else it would not have been a rename
candidate. So the current code is a special case for that rule.

Now, as far as how to do that, I haven't a clue. I've been staring at
merge-recursive code for 30 minutes. ;)

-Peff
