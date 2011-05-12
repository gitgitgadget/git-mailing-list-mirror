From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t3503: test cherry picking and reverting root commits
Date: Thu, 12 May 2011 08:37:03 -0400
Message-ID: <20110512123703.GA21078@sigill.intra.peff.net>
References: <20110512110855.GA5240@sigill.intra.peff.net>
 <20110512111007.GC5292@sigill.intra.peff.net>
 <4DCBD087.90302@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 12 14:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKV8j-000553-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 14:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1ELMhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 08:37:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58138
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab1ELMhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 08:37:06 -0400
Received: (qmail 13815 invoked by uid 107); 12 May 2011 12:39:04 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 08:39:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 08:37:03 -0400
Content-Disposition: inline
In-Reply-To: <4DCBD087.90302@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173467>

On Thu, May 12, 2011 at 02:20:23PM +0200, Johannes Sixt wrote:

> Am 5/12/2011 13:10, schrieb Jeff King:
> > +test_expect_success 'cherry-pick a root commit with an external strategy' '
> > +
> > +	git cherry-pick --strategy=resolve master &&
> > +	test first = $(cat file1)
> 
> What if file1 does not exist? Then cat fails loudly. But this does not
> fail the entire command immediately; rather, the test command fails, but
> not because of a non-equality, but because of an invalid usage ("syntax
> error"). IOW, the test does the right thing, but for the wrong reason.
> 
> Yes, an earlier test gave a bad precedent, and the following fixup (to
> be squashed in) fixes it, too.

Yeah, sorry, I blindly copied the earlier test without thinking. If we
are going to tweak, my preference is actually to use test_cmp. And while
we're at it, I should be using test_path_is_missing.

So:

diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 1f9ed67..9aefe3a 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -23,28 +23,30 @@ test_expect_success setup '
 test_expect_success 'cherry-pick a root commit' '
 
 	git cherry-pick master &&
-	test first = $(cat file1)
+	echo first >expect &&
+	test_cmp expect file1
 
 '
 
 test_expect_success 'revert a root commit' '
 
 	git revert master &&
-	! test -f file1
+	test_path_is_missing file1
 
 '
 
 test_expect_success 'cherry-pick a root commit with an external strategy' '
 
 	git cherry-pick --strategy=resolve master &&
-	test first = $(cat file1)
+	echo first >expect &&
+	test_cmp expect file1
 
 '
 
 test_expect_success 'revert a root commit with an external strategy' '
 
 	git revert --strategy=resolve master &&
-	! test -f file1
+	test_path_is_missing file1
 
 '
 
