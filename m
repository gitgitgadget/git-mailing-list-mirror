From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Return error when not checking out an entry due to dirtiness.
Date: Mon, 03 Oct 2005 22:11:03 -0700
Message-ID: <7vu0fxhno8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 04 07:12:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMf55-0007og-CL
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 07:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJDFLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 01:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVJDFLH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 01:11:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63452 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751187AbVJDFLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 01:11:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004051101.IMTX4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 01:11:01 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9661>

Without -f flag, 'git-checkout-index foo.c' issued an error message
when foo.c already existed in the working tree and did not match index.
However it did not return an error from the underlying checkout_entry()
function and resulted in a successful exit(0).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I've made sure that the existing scripts do not use
   checkout-index without -f in a way that could be affected by
   this change.  However, third-party scripts may be affected by
   this.  Cogito and StGIT should be OK -- they either run
   checkout with -f, do not check the error return when it does
   not use -f, or runs checkout without -f in an empty working
   tree.

 checkout-index.c |   11 ++++++++---
 entry.c          |    2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

5a166f6a9d1b7ca2de673139fbfc4112b1b2e308
diff --git a/checkout-index.c b/checkout-index.c
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -63,15 +63,20 @@ static int checkout_file(const char *nam
 
 static int checkout_all(void)
 {
-	int i;
+	int i, errs;
 
-	for (i = 0; i < active_nr ; i++) {
+	for (errs = i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce))
 			continue;
 		if (checkout_entry(ce, &state) < 0)
-			return -1;
+			errs++;
 	}
+	if (errs)
+		/* we have already done our error reporting.
+		 * exit with the same code as die().
+		 */
+		exit(128);
 	return 0;
 }
 
diff --git a/entry.c b/entry.c
--- a/entry.c
+++ b/entry.c
@@ -132,7 +132,7 @@ int checkout_entry(struct cache_entry *c
 		if (!state->force) {
 			if (!state->quiet)
 				fprintf(stderr, "git-checkout-index: %s already exists\n", path);
-			return 0;
+			return -1;
 		}
 
 		/*
