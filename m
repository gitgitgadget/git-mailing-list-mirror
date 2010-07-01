From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 1 Jul 2010 11:38:42 -0400
Message-ID: <20100701153842.GA15466@sigill.intra.peff.net>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Thu Jul 01 17:39:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULqw-00085L-H2
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab0GAPip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 11:38:45 -0400
Received: from peff.net ([208.65.91.99]:35217 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab0GAPip (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:38:45 -0400
Received: (qmail 6721 invoked by uid 107); 1 Jul 2010 15:39:38 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 01 Jul 2010 11:39:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jul 2010 11:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20100701150331.GA12851@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150049>

On Thu, Jul 01, 2010 at 11:03:31AM -0400, Jeff King wrote:

>   $ time git tag --contains HEAD~200
>   v1.7.1
>   v1.7.1-rc2
>   v1.7.1.1
>   v1.7.2-rc0
>   v1.7.2-rc1
> 
>   real    0m2.179s
>   user    0m2.156s
>   sys     0m0.020s
>
> [...]
>
> I suspect we could do even better by sharing information between
> traversals. That is, walk the graph from each ref, but retain marks on

Here is a quick and dirty patch to implement what I suggested. With it,
I get the same results as above, but it runs between 3 and 4 times as
fast:

  real    0m0.621s
  user    0m0.588s
  sys     0m0.032s

Implementing the timestamp-checking thing that name-rev does would
probably drop it even more (at the expense of less accuracy in the
face of clock skew).

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..d18c3ed 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,8 @@
 #include "builtin.h"
 #include "refs.h"
 #include "tag.h"
+#include "diff.h"
+#include "revision.h"
 #include "run-command.h"
 #include "parse-options.h"
 
@@ -31,6 +33,42 @@ struct tag_filter {
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
+static int in_commit_list(const struct commit_list *want, struct commit *c)
+{
+	for (; want; want = want->next)
+		if (!hashcmp(want->item->object.sha1, c->object.sha1))
+			return 1;
+	return 0;
+}
+
+static int contains(const struct commit_list *want, struct commit *candidate)
+{
+	struct commit_list *p;
+
+	/* was it previously marked as containing a want commit? */
+	if (candidate->object.flags & TMP_MARK)
+		return 1;
+	/* or marked as not possibly containing a want commit? */
+	if (candidate->object.flags & UNINTERESTING)
+		return 0;
+	/* or are we it? */
+	if (in_commit_list(want, candidate))
+		return 1;
+
+	/* If not, then try parents, and be sure to mark ourselves
+	 * for future traversals. */
+	parse_commit(candidate);
+	for (p = candidate->parents; p; p = p->next) {
+		if (contains(want, p->item)) {
+			candidate->object.flags |= TMP_MARK;
+			return 1;
+		}
+	}
+
+	candidate->object.flags |= UNINTERESTING;
+	return 0;
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
@@ -49,7 +87,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			commit = lookup_commit_reference_gently(sha1, 1);
 			if (!commit)
 				return 0;
-			if (!is_descendant_of(commit, filter->with_commit))
+			if (!contains(filter->with_commit, commit))
 				return 0;
 		}
 
