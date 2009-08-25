From: Jeff King <peff@peff.net>
Subject: Re: Possible regression: overwriting untracked files in a fresh
 repo
Date: Mon, 24 Aug 2009 21:47:38 -0400
Message-ID: <20090825014738.GA7655@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
 <20090824190710.GB25168@coredump.intra.peff.net>
 <7vab1o3ikz.fsf@alter.siamese.dyndns.org>
 <20090825013601.GA3515@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 03:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfl8b-00005N-Rh
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 03:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbZHYBrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 21:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbZHYBrj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 21:47:39 -0400
Received: from peff.net ([208.65.91.99]:50034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbZHYBri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 21:47:38 -0400
Received: (qmail 12906 invoked by uid 107); 25 Aug 2009 01:47:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 Aug 2009 21:47:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2009 21:47:38 -0400
Content-Disposition: inline
In-Reply-To: <20090825013601.GA3515@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126987>

On Mon, Aug 24, 2009 at 09:36:01PM -0400, Jeff King wrote:

> I don't think this is the right thing to do. We have _no_ current
> branch, which means that everything in the working tree can be
> considered untracked (and therefore precious). So I think the right
> thing to do is barf and say "this untracked file would be overwritten".
> The user can sort it out as appropriate, either deleting files that are
> in the way, or using "-f" themselves (after they make the decision that
> what they have can be overwritten).

Actually, let me clarify that a bit. If we have no branch _and_ we have
no index, then everything is untracked. If we do have an index, then we
do a two-way merge from the HEAD. So if we have no branch in that case,
it makes sense to me to treat every element of the index as an addition,
meaning that anything in the new tree that is different should be a
conflict.

And that is what my patch does: it pretends that the HEAD is the empty
tree, which should produce sane output in both cases:

  $ echo content >file
  $ git checkout -b foo origin ;# origin has 'file' in it
  error: Untracked working tree file 'file' would be overwritten by merge.
  $ git add file
  $ git checkout -b foo origin
  error: Entry 'file' would be overwritten by merge. Cannot merge.

and it even handles the matching-index case when the merge is a no-op:

  $ git show origin:file >file ;# match contents
  $ git checkout -b foo origin
  error: Untracked working tree file 'file' would be overwritten by merge.
  $ git add file
  $ git checkout -b foo origin
  Switched to a new branch 'foo'

-Peff
