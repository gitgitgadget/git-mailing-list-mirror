From: Jeff King <peff@peff.net>
Subject: [PATCH 43/68] transport: use strbufs for status table "quickref"
 strings
Date: Thu, 24 Sep 2015 17:07:40 -0400
Message-ID: <20150924210740.GN30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkL-00028o-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbbIXVHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:35999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753669AbbIXVHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:43 -0400
Received: (qmail 12076 invoked by uid 102); 24 Sep 2015 21:07:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:43 -0500
Received: (qmail 29368 invoked by uid 107); 24 Sep 2015 21:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:40 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278592>

We generate range strings like "1234abcd...5678efab" for use
in the the fetch and push status tables. We use fixed-size
buffers along with strcat to do so. These aren't buggy, as
our manual size computation is correct, but there's nothing
checking that this is so.  Let's switch them to strbufs
instead, which are obviously correct, and make it easier to
audit the code base for problematic calls to strcat().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 22 ++++++++++++----------
 transport.c     | 13 +++++++------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4703725..841880e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -528,36 +528,38 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (in_merge_bases(current, updated)) {
-		char quickref[83];
+		struct strbuf quickref = STRBUF_INIT;
 		int r;
-		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
-		strcat(quickref, "..");
-		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		strbuf_add_unique_abbrev(&quickref, current->object.sha1, DEFAULT_ABBREV);
+		strbuf_addstr(&quickref, "..");
+		strbuf_add_unique_abbrev(&quickref, ref->new_sha1, DEFAULT_ABBREV);
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref("fast-forward", ref, 1);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : ' ',
-			    TRANSPORT_SUMMARY_WIDTH, quickref,
+			    TRANSPORT_SUMMARY_WIDTH, quickref.buf,
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
+		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
-		char quickref[84];
+		struct strbuf quickref = STRBUF_INIT;
 		int r;
-		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
-		strcat(quickref, "...");
-		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		strbuf_add_unique_abbrev(&quickref, current->object.sha1, DEFAULT_ABBREV);
+		strbuf_addstr(&quickref, "...");
+		strbuf_add_unique_abbrev(&quickref, ref->new_sha1, DEFAULT_ABBREV);
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref("forced-update", ref, 1);
 		strbuf_addf(display, "%c %-*s %-*s -> %s  (%s)",
 			    r ? '!' : '+',
-			    TRANSPORT_SUMMARY_WIDTH, quickref,
+			    TRANSPORT_SUMMARY_WIDTH, quickref.buf,
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("unable to update local ref") : _("forced update"));
+		strbuf_release(&quickref);
 		return r;
 	} else {
 		strbuf_addf(display, "! %-*s %-*s -> %s  %s",
diff --git a/transport.c b/transport.c
index 2d51348..3b47d49 100644
--- a/transport.c
+++ b/transport.c
@@ -654,23 +654,24 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 			"[new branch]"),
 			ref, ref->peer_ref, NULL, porcelain);
 	else {
-		char quickref[84];
+		struct strbuf quickref = STRBUF_INIT;
 		char type;
 		const char *msg;
 
-		strcpy(quickref, status_abbrev(ref->old_sha1));
+		strbuf_addstr(&quickref, status_abbrev(ref->old_sha1));
 		if (ref->forced_update) {
-			strcat(quickref, "...");
+			strbuf_addstr(&quickref, "...");
 			type = '+';
 			msg = "forced update";
 		} else {
-			strcat(quickref, "..");
+			strbuf_addstr(&quickref, "..");
 			type = ' ';
 			msg = NULL;
 		}
-		strcat(quickref, status_abbrev(ref->new_sha1));
+		strbuf_addstr(&quickref, status_abbrev(ref->new_sha1));
 
-		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
+		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg, porcelain);
+		strbuf_release(&quickref);
 	}
 }
 
-- 
2.6.0.rc3.454.g204ad51
