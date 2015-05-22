From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/14] remote.c: report specific errors from
 branch_get_upstream
Date: Thu, 21 May 2015 20:46:43 -0400
Message-ID: <20150522004643.GA11739@peff.net>
References: <20150521044429.GA5857@peff.net>
 <20150521044532.GH23409@peff.net>
 <xmqq7fs1kcfd.fsf@gitster.dls.corp.google.com>
 <20150521184910.GA3490@peff.net>
 <xmqqpp5tivga.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 02:47:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvb6x-0003Nh-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbbEVAqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:46:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:34386 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754448AbbEVAqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:46:46 -0400
Received: (qmail 29841 invoked by uid 102); 22 May 2015 00:46:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 19:46:46 -0500
Received: (qmail 9841 invoked by uid 107); 22 May 2015 00:46:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 20:46:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 20:46:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp5tivga.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269677>

On Thu, May 21, 2015 at 12:25:57PM -0700, Junio C Hamano wrote:

> > Note also that the original may dereference branch->merge[0] even if it
> > is NULL. I think that can't actually happen in practice (we only
> > allocate branch->merge if we have at least one item to put in it, and
> > all of the checks of branch->merge[0] are actually being over-careful).
> > But the code I just wrote above does not have that problem.
> 
> Perhaps update the patch with this explanation in the log message,
> as a separate preparatory step?

I decided on a separate patch on top which improves the logic and
explains the issues. Here it is (it goes on top of the existing patch 8,
"report specific errors from branch_get_upstream").

-- >8 --
Subject: remote.c: untangle error logic in branch_get_upstream

The error-diagnosis logic in branch_get_upstream was copied
straight from sha1_name.c in the previous commit. However,
because we check all error cases and upfront and then later
diagnose them, the logic is a bit tangled. In particular:

  - if branch->merge[0] is NULL, we may end up dereferencing
    it for an error message (in practice, it should never be
    NULL, so this is probably not a triggerable bug).

  - We may enter the code path because branch->merge[0]->dst
    is NULL, but we then start our error diagnosis by
    checking whether our local branch exists. But that is
    only relevant to diagnosing missing merge config, not a
    missing tracking ref; our diagnosis may hide the real
    problem.

Instead, let's just use a sequence of "if" blocks to check
for each error type, diagnose it, and return NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 1b7051a..d2519c2 100644
--- a/remote.c
+++ b/remote.c
@@ -1721,18 +1721,25 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 {
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
-	if (!branch->merge || !branch->merge[0] || !branch->merge[0]->dst) {
+
+	if (!branch->merge || !branch->merge[0]) {
+		/*
+		 * no merge config; is it because the user didn't define any,
+		 * or because it is not a real branch, and get_branch
+		 * auto-vivified it?
+		 */
 		if (!ref_exists(branch->refname))
 			return error_buf(err, _("no such branch: '%s'"),
 					 branch->name);
-		if (!branch->merge)
-			return error_buf(err,
-					 _("no upstream configured for branch '%s'"),
-					 branch->name);
+		return error_buf(err,
+				 _("no upstream configured for branch '%s'"),
+				 branch->name);
+	}
+
+	if (!branch->merge[0]->dst)
 		return error_buf(err,
 				 _("upstream branch '%s' not stored as a remote-tracking branch"),
 				 branch->merge[0]->src);
-	}
 
 	return branch->merge[0]->dst;
 }
-- 
2.4.1.528.g00591e3
