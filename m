From: Jeff King <peff@peff.net>
Subject: Re: Inheritance of files for parent/child branches
Date: Sat, 16 Feb 2008 13:09:03 -0500
Message-ID: <20080216180903.GB19506@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0802161110310.32252@an.sumeria>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:09:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRU3-0005Bm-8D
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYBPSJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 13:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbYBPSJJ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:09:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1378 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbYBPSJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 13:09:07 -0500
Received: (qmail 12151 invoked by uid 111); 16 Feb 2008 18:09:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 16 Feb 2008 13:09:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2008 13:09:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0802161110310.32252@an.sumeria>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74053>

On Sat, Feb 16, 2008 at 11:32:01AM -0600, Adam Flott wrote:

> The only redeeming feature in AccuRev was the ability to an use
> inheritance for files in streams (nearly analogous to branches). While
> this idea in the SCM world sounds strange, is there anything in git land
> that could mimic this sort of behavior?
>
> In case, "inheritance for files..." isn't clear, what I would like to
> accomplish is: have a branch "parent" with multiple "children" branches
> (which may have descendents of their own). If a file is committed to the
> parent branch, then the all the descendents would receive the same
> update without manually cherry-picking the commit across all the
> branches.

Wouldn't that just be a merge of the parent branch into the child
branch? Which really isn't any different than cherry-picking, except
that you retain the history instead of picking the one patch. In both
cases, you are saying "take the differences in the parent tree between
point X and point Y, and merge them into what I have now." In the case
of cherry pick, you are saying that X is really Y^. In the case of a
merge, you are saying that X is "the last point parent and child merged"
(.e., git merge-base parent child).

It won't happen _automatically_, though, and I don't think it should
(since each merge may have conflicts). But you could probably accomplish
what you want by cascading the merges. Something like:

  git checkout parent
  hack hack hack
  git commit -a -m whatever
  cascade_merge() {
    parent=$1
    for child in `somehow lookup the child branches of $parent`
    do
      git checkout $child
      git merge $parent
      cascade_merge $child
    done
  }
  cascade merge parent

This snippet is illustrative, not functional; recursion in the shell
will stomp on the variables. But more importantly, the "git merge" may
actually require human intervention. So you need to stop, let the user
fix up the working tree, and then continue.

-Peff
