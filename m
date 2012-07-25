From: Jeff King <peff@peff.net>
Subject: Re: False positive from orphaned_commit_warning() ?
Date: Wed, 25 Jul 2012 17:57:30 -0400
Message-ID: <20120725215730.GA30966@sigill.intra.peff.net>
References: <20120725185343.GA6937@windriver.com>
 <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9aM-00066o-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2GYV5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:57:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34031 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab2GYV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:57:32 -0400
Received: (qmail 686 invoked by uid 107); 25 Jul 2012 21:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jul 2012 17:57:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jul 2012 17:57:30 -0400
Content-Disposition: inline
In-Reply-To: <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202206>

On Wed, Jul 25, 2012 at 02:52:54PM -0700, Junio C Hamano wrote:

> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
> > Has anyone else noticed false positives coming from the
> > orphan check?
> 
> Thanks.  This should fix it.

I've just been hunting the same bug and came up with the same answer.
Here's a commit message. Feel free to apply or steal text for your
commit.

-- >8 --
Subject: [PATCH] checkout: don't confuse ref and object flags

When we are leaving a detached HEAD, we do a revision
traversal to check whether we are orphaning any commits,
marking the commit we're leaving as the start of the
traversal, and all existing refs as uninteresting.

Prior to commit 468224e5, we did so by calling for_each_ref,
and feeding each resulting refname to setup_revisions.
Commit 468224e5 refactored this to simply mark the pending
objects, saving an extra lookup.

However, it confused the "flags" parameter to the
each_ref_fn clalback, which is about the flags we found
while looking up the ref (e.g., REF_ISSYMREF) with the
object flag (UNINTERESTING), leading to unpredictable
results, as we were setting random flag bits on objects in
the traversal.
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a76899d..f855489 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -592,7 +592,7 @@ static int add_pending_uninteresting_ref(const char *refname,
 					 const unsigned char *sha1,
 					 int flags, void *cb_data)
 {
-	add_pending_sha1(cb_data, refname, sha1, flags | UNINTERESTING);
+	add_pending_sha1(cb_data, refname, sha1, UNINTERESTING);
 	return 0;
 }
 
