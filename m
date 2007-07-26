From: Jeff King <peff@peff.net>
Subject: Re: git stash apply segfaulting when called in subdir
Date: Thu, 26 Jul 2007 01:07:26 -0400
Message-ID: <20070726050726.GC32617@coredump.intra.peff.net>
References: <20070725212311.GA13325@cassiopeia> <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDvZV-0001PE-2e
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbXGZFHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXGZFHa
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:07:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3046 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbXGZFH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:07:29 -0400
Received: (qmail 25747 invoked from network); 26 Jul 2007 05:07:27 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Jul 2007 05:07:27 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2007 01:07:26 -0400
Content-Disposition: inline
In-Reply-To: <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53765>

On Wed, Jul 25, 2007 at 03:28:12PM -0700, Junio C Hamano wrote:

> > zeisberg@cassiopeia:/tmp/repo$ cd dir; git stash apply
> > error: missing object referenced by '696146c2a44d7fc4d5ae4a71589c4c0d84f59789'
> > /home/zeisberg/usr/bin/git-stash: line 111: 13618 Segmentation fault      git-merge-recursive $b_tree -- $c_tree $w_tree
> 
> This probably is a merge-recursive bug, but in the meantime,
> I think this should fix it.

The merge-recursive bug is simply a failure to check for invalid input.
Patch to at least print and die rather than segfault is below.
Technically the error could be from a tag dereference, too, so maybe the
error message should be more exact?

-- >8 --
merge-recursive: don't segfault on missing input objects

This should generally never happen, but it's nicer to report
an error than to segfault.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c8539ec..2764e61 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1692,6 +1692,8 @@ static struct commit *get_ref(const char *ref)
 	if (get_sha1(ref, sha1))
 		die("Could not resolve ref '%s'", ref);
 	object = deref_tag(parse_object(sha1), ref, strlen(ref));
+	if (!object)
+		die("Object does not exist: %s", ref);
 	if (object->type == OBJ_TREE)
 		return make_virtual_commit((struct tree*)object,
 			better_branch_name(ref));
-- 
1.5.3.rc3.818.gc1dc7-dirty
