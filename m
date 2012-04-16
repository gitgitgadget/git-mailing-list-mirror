From: marcnarc@xiplink.com
Subject: [PATCHv3] fetch: Use the remote's ref name to decide how to describe new refs.
Date: Mon, 16 Apr 2012 11:52:22 -0400
Message-ID: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
References: <20120416150036.GA15009@sigill.intra.peff.net>
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 17:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoDs-0005qs-8a
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab2DPPwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:52:07 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:63375 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754126Ab2DPPwF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 11:52:05 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q3GFpi6w026350;
	Mon, 16 Apr 2012 11:51:44 -0400
X-Mailer: git-send-email 1.7.10.2.ge89da.dirty
In-Reply-To: <20120416150036.GA15009@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195650>

From: Marc Branchaud <marcnarc@xiplink.com>

Also, only call a new ref a "branch" if it's under refs/heads/.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Re-rolled to work with the remote's ref names.

As before, this is atop of Jens's submodule-recursion fix.

Technically there are now 3 different changes in this patch:
	1. Switch to using remote ref names.
	2. Use prefixcomp() consistently.
	3. Only call a new ref a "branch" if its' under refs/heads.

Should I split this up?

		M.


 builtin/fetch.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cfb43df..063c63b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -293,14 +293,23 @@ static int update_local_ref(struct ref *ref,
 		const char *msg;
 		const char *what;
 		int r;
-		if (!strncmp(ref->name, "refs/tags/", 10)) {
+		/*
+		 * Nicely describe what we're fetching.
+		 * Base this on the remote's ref names, as they're
+		 * more likely to follow a standard layout.
+		 */
+		if (!prefixcmp(ref->peer_ref->name, "refs/tags/")) {
 			msg = "storing tag";
 			what = _("[new tag]");
 		}
-		else {
+		else if (!prefixcmp(ref->peer_ref->name, "refs/heads/")) {
 			msg = "storing head";
 			what = _("[new branch]");
 		}
+		else {
+			msg = "storing ref";
+			what = _("[new ref]");
+		}
 
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-- 
1.7.10.2.ge89da.dirty
