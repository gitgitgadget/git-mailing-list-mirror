From: Jeff King <peff@peff.net>
Subject: [PATCH] fetch: report local storage errors in status table
Date: Thu, 26 Jun 2008 23:59:50 -0400
Message-ID: <20080627035950.GA21382@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local> <20080627030245.GA7144@sigill.intra.peff.net> <20080627035747.GC7144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>
X-From: git-owner@vger.kernel.org Fri Jun 27 06:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC58i-0007n9-T0
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 06:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbYF0D7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 23:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYF0D7x
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 23:59:53 -0400
Received: from peff.net ([208.65.91.99]:4545 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbYF0D7w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 23:59:52 -0400
Received: (qmail 31500 invoked by uid 111); 27 Jun 2008 03:59:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 23:59:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 23:59:50 -0400
Content-Disposition: inline
In-Reply-To: <20080627035747.GC7144@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86520>

Previously, if there was an error while storing a local
tracking ref, the low-level functions would report an error,
but fetch's status output wouldn't indicate any problem.
E.g., imagine you have an old "refs/remotes/origin/foo/bar" but
upstream has deleted "foo/bar" in favor of a new branch
"foo". You would get output like this:

  error: there are still refs under 'refs/remotes/origin/foo'
  From $url_of_repo
   * [new branch]      foo        -> origin/foo

With this patch, the output takes into account the status of
updating the local ref:

  error: there are still refs under 'refs/remotes/origin/foo'
  From $url_of_repo
   ! [new branch]      foo        -> origin/foo  (unable to update local ref)

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-fetch.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index e81ee2d..7c16d38 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -233,10 +233,12 @@ static int update_local_ref(struct ref *ref,
 
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		sprintf(display, "- %-*s %-*s -> %s",
+		int r;
+		r = s_update_ref("updating tag", ref, 0);
+		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
 			SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
-			pretty_ref);
-		return s_update_ref("updating tag", ref, 0);
+			pretty_ref, r ? "  (unable to update local ref)" : "");
+		return r;
 	}
 
 	current = lookup_commit_reference_gently(ref->old_sha1, 1);
@@ -244,6 +246,7 @@ static int update_local_ref(struct ref *ref,
 	if (!current || !updated) {
 		const char *msg;
 		const char *what;
+		int r;
 		if (!strncmp(ref->name, "refs/tags/", 10)) {
 			msg = "storing tag";
 			what = "[new tag]";
@@ -253,27 +256,36 @@ static int update_local_ref(struct ref *ref,
 			what = "[new branch]";
 		}
 
-		sprintf(display, "* %-*s %-*s -> %s", SUMMARY_WIDTH, what,
-			REFCOL_WIDTH, remote, pretty_ref);
-		return s_update_ref(msg, ref, 0);
+		r = s_update_ref(msg, ref, 0);
+		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
+			SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
+			r ? "  (unable to update local ref)" : "");
+		return r;
 	}
 
 	if (in_merge_bases(current, &updated, 1)) {
 		char quickref[83];
+		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "..");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-		sprintf(display, "  %-*s %-*s -> %s", SUMMARY_WIDTH, quickref,
-			REFCOL_WIDTH, remote, pretty_ref);
-		return s_update_ref("fast forward", ref, 1);
+		r = s_update_ref("fast forward", ref, 1);
+		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : ' ',
+			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
+			pretty_ref, r ? "  (unable to update local ref)" : "");
+		return r;
 	} else if (force || ref->force) {
 		char quickref[84];
+		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "...");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-		sprintf(display, "+ %-*s %-*s -> %s  (forced update)",
-			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote, pretty_ref);
-		return s_update_ref("forced-update", ref, 1);
+		r = s_update_ref("forced-update", ref, 1);
+		sprintf(display, "%c %-*s %-*s -> %s  (%s)", r ? '!' : '+',
+			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
+			pretty_ref,
+			r ? "unable to update local ref" : "forced update");
+		return r;
 	} else {
 		sprintf(display, "! %-*s %-*s -> %s  (non fast forward)",
 			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
-- 
1.5.6.1.79.g7b3a7.dirty
