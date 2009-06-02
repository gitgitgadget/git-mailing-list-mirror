From: Jeff King <peff@peff.net>
Subject: Re: Am able to delete a file with no trace in the log
Date: Tue, 2 Jun 2009 17:34:39 -0400
Message-ID: <20090602213439.GA7584@coredump.intra.peff.net>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Graham Perks <gperks@ausperks.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:34:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBbdI-0000q6-3d
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 23:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbZFBVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbZFBVep
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:34:45 -0400
Received: from peff.net ([208.65.91.99]:36920 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970AbZFBVep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 17:34:45 -0400
Received: (qmail 16132 invoked by uid 107); 2 Jun 2009 21:34:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 02 Jun 2009 17:34:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2009 17:34:39 -0400
Content-Disposition: inline
In-Reply-To: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120550>

On Tue, Jun 02, 2009 at 02:33:14PM -0500, Graham Perks wrote:

> # File b.txt deleted! Woah! How did that happen?
> # gitk and git log show nothing about the deletion.
> # There seems to be no evidence about who, how, why, or when the file got 
> deleted.
> # So it's hard to track down which user mis-used the system and educate 
> them.

I think this is a funny interaction with the way the diffs for merge
commits are shown. The diff you are looking for is definitely available.
In your example:

  # compare the second parent of the merge to the merge result
  $ git diff-tree HEAD^2 HEAD
  :100644 100644 31e0fce560e96c8b357f5b8630c7d8fbeb0a3ec8 2dc6d98afe942589307d7c0166971b3a2ec8706d M      a.txt
  :100644 000000 b023018cabc396e7692c70bbf5784a93d3f738ab 0000000000000000000000000000000000000000 D      b.txt

But it doesn't show up in "git log". I believe this is because the rule
for what to show in a merge commit is "if content is exactly the same as
one of the parents, it's not interesting". That is, deleting "b.txt"
from the second parent ends up being exactly as it is in the first
parent -- nonexistent. So git has no idea that you deleted "b.txt"
accidentally, and it was not simply part of the conflict resolution.

So I think this is working as intended, and is not a bug exactly. But
certainly the behavior leaves something to be desired for actually
tracking down the source of the change later on. I don't think there is
a way to get "git show $merge" to show the deletion, and nor does it
show up under "git log -- b.txt". Even worse, the latter produces no
output at all for your example (you need "--full-history" to tell it to
follow both parents of a merge).

I wonder if we need some kind of "--verbose-merges" option to tell the
diff engine that we really are interested in all of the changes that
happened in a merge. But maybe we even have something and I don't know
about it.

-Peff
