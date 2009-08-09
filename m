From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 05:14:43 -0400
Message-ID: <20090809091443.GA676@coredump.intra.peff.net>
References: <20090809065936.GA24112@coredump.intra.peff.net>
 <7vab29a1fr.fsf@alter.siamese.dyndns.org>
 <20090809074035.GA4778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 11:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma4UU-0007cL-AO
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 11:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbZHIJOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 05:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbZHIJOq
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 05:14:46 -0400
Received: from peff.net ([208.65.91.99]:41451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbZHIJOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 05:14:45 -0400
Received: (qmail 2875 invoked by uid 107); 9 Aug 2009 09:16:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 05:16:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 05:14:43 -0400
Content-Disposition: inline
In-Reply-To: <20090809074035.GA4778@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125334>

On Sun, Aug 09, 2009 at 03:40:35AM -0400, Jeff King wrote:

> > Shouldn't it instead feed what it got from the end user to the dwim
> > machinery, and make sure it dwims into refs/remotes/ hierarchy?
> 
> I'm not sure that is all that different in practice than what is
> happening now. Mainly I did it the way I did so that I didn't touch the
> code path for detecting local branches.
> 
> But assuming they are functionally identical, I think your patch is much
> more readable.

I tested your patch; the two methods aren't identical. In fact, yours
fixes a bug. :)

In t4202, we have a branch name and a tag name that are the same
(octopus-a), and we "git merge octopus-a". This actually merges the tag,
but because the branch name existed, we write "Merge branch 'octopus-a'"
in the log, which is not true. With your patch, it does the right thing
and says "Merge commit 'octopus-a'".

The simple thing is to just update the "expect" text. Though the current
behavior does show off the ability to collape the two branches and say

  Merge branches 'octopus-a' and 'octopus-b'

instead of

  Merge commit 'octopus-a'; commit 'octopus-b'

which we could preserve that by renaming the tags, as below.

---
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48e0088..9d0db2a 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -306,13 +306,13 @@ test_expect_success 'set up more tangled history' '
 	git checkout master &&
 	git merge tangle &&
 	git checkout -b reach &&
-	test_commit reach &&
+	test_commit reach-1 &&
 	git checkout master &&
 	git checkout -b octopus-a &&
-	test_commit octopus-a &&
+	test_commit octopus-a-1 &&
 	git checkout master &&
 	git checkout -b octopus-b &&
-	test_commit octopus-b &&
+	test_commit octopus-b-1 &&
 	git checkout master &&
 	test_commit seventh &&
 	git merge octopus-a octopus-b
@@ -327,12 +327,12 @@ cat > expect <<\EOF
 *-. \   Merge branches 'octopus-a' and 'octopus-b'
 |\ \ \
 * | | | seventh
-| | * | octopus-b
+| | * | octopus-b-1
 | |/ /
 |/| |
-| * | octopus-a
+| * | octopus-a-1
 |/ /
-| * reach
+| * reach-1
 |/
 *   Merge branch 'tangle'
 |\
