From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] not making corruption worse
Date: Tue, 17 Mar 2015 03:27:51 -0400
Message-ID: <20150317072750.GA22155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 08:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXluw-0003Nj-KD
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 08:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbbCQH1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 03:27:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:33906 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751686AbbCQH1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 03:27:53 -0400
Received: (qmail 25476 invoked by uid 102); 17 Mar 2015 07:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 02:27:54 -0500
Received: (qmail 22745 invoked by uid 107); 17 Mar 2015 07:28:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 03:28:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 03:27:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265613>

This is a grab bag of fixes related to performing destructive operations
in a repository with minor corruption. Of course we hope never to see
corruption in the first place, but I think if we do see it, we should
err on the side of not making things worse. IOW, it is better to abort
and say "fix this before pruning" than it is to just start deleting
objects.

The issue that spurred this is that I noticed recent versions of git
will omit funny-named refs from iteration. This comes from d0f810f
(refs.c: allow listing and deleting badly named refs, 2014-09-03), in
v2.2.0.  That's probably a good idea in general, but for things like
"prune" we need to be more careful (and we were, prior to that commit).

Similarly, if you have a ref whose tip object is missing, we tend to
just ignore it in our traversals, and it presents a similar problem for
pruning. I didn't trace it back, but I think this problem is much older.

The general strategy for these is to use for_each_rawref traversals in
these situations. That doesn't cover _every_ possible scenario. For
example, you could do:

  git clone --no-local repo.git backup.git &&
  rm -rf repo.git

and you might be disappointed if "backup.git" omitted some broken refs
(upload-pack will simply skip the broken refs in its advertisement).  We
could tighten this, but then it becomes hard to access slightly broken
repositories (e.g., you might prefer to clone what you can, and not have
git die() when it tries to serve the breakage). Patch 2 provides a
tweakable safety valve for this.

And not strictly related to the above, but in the same ballpark, is the
issue with packed-refs that I noted here:

  http://thread.gmane.org/gmane.comp.version-control.git/256051/focus=256896

where we can drop broken refs from the packed-refs file during the
deletion of an unrelated ref.

The patches are:

  [1/5]: t5312: test object deletion code paths in a corrupted repository
  [2/5]: refs: introduce a "ref paranoia" flag
  [3/5]: prune: turn on ref_paranoia flag
  [4/5]: repack: turn on "ref paranoia" when doing a destructive repack
  [5/5]: refs.c: drop curate_packed_refs

-Peff
