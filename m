From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/19] prune_refs(): use delete_refs()
Date: Mon, 22 Jun 2015 16:02:59 +0200
Message-ID: <a338a63f4c3225c7faa001a5bdde92c7690eba79.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Kk-0005vu-86
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705AbbFVOEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50569 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933182AbbFVODe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:34 -0400
X-AuditID: 1207440d-f79136d00000402c-60-558815ad4bb1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 52.42.16428.DA518855; Mon, 22 Jun 2015 10:03:25 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc6030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:24 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLtWtCPUoOm5ikXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4Mxb8+8Nc8Ja/4tb820wNjJd5uhg5OSQETCTOnmxigrDFJC7cW8/WxcjFISRwmVHizpa7
	7CAJIYGTTBIL5uWB2GwCuhKLeprBGkQE1CQmth1iAWlgFuhglLiwfBtYg7CApcS5vo2MIDaL
	gKrElWPPgIo4OHgFoiS+bhWFWCYncf74T2YQm1PAQmL+vv9Qu8wlJs58xDKBkXcBI8MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJCA4t3B+H+dzCFGAQ5GJR7eGfbtoUKs
	iWXFlbmHGCU5mJREeQ+8BgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4W05C5TjTUmsrEotyodJ
	SXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwnhXpCBUSLEpNT61Iy8wpQUgzcXCCDOeS
	EilOzUtJLUosLcmIB0VGfDEwNkBSPEB7c0DaeYsLEnOBohCtpxgVpcR5/UESAiCJjNI8uLGw
	NPGKURzoS2HeYpAqHmCKget+BTSYCWjwl9w2kMEliQgpqQbGCVGpmapTj0hUMX56Fe7I+P6+
	6tLPi859fxA99dZn1Wzj17PcvZifVbMu2v1uwZXTfKdk/oevf3Oj3JmthHuSZK1tzI21PbNN
	ds1Tu7JeUVClbLWuTtwFjQNBu3WDFGZvfxej7Tzx8+30/F3L/NXddjGeW9olMGWC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272357>

The old version just looped over the references to delete, calling
delete_ref() on each one. But that has quadratic behavior, because
each call to delete_ref() might have to rewrite the packed-refs file.
This can be very expensive in a repository with a large number of
references. In some (admittedly extreme) repositories, we've seen
cases where the ref-pruning part of fetch takes multiple tens of
minutes.

Instead call delete_refs(), which (aside from being less code) has the
optimization that it only rewrites the packed-refs file a single time.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8d5b2db..34b6f5e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -790,20 +790,29 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 	if (4 < i && !strncmp(".git", url + i - 3, 4))
 		url_len = i - 3;
 
-	for (ref = stale_refs; ref; ref = ref->next) {
-		if (!dry_run)
-			result |= delete_ref(ref->name, NULL, 0);
-		if (verbosity >= 0 && !shown_url) {
-			fprintf(stderr, _("From %.*s\n"), url_len, url);
-			shown_url = 1;
-		}
-		if (verbosity >= 0) {
+	if (!dry_run) {
+		struct string_list refnames = STRING_LIST_INIT_NODUP;
+
+		for (ref = stale_refs; ref; ref = ref->next)
+			string_list_append(&refnames, ref->name);
+
+		result = delete_refs(&refnames);
+		string_list_clear(&refnames, 0);
+	}
+
+	if (verbosity >= 0) {
+		for (ref = stale_refs; ref; ref = ref->next) {
+			if (!shown_url) {
+				fprintf(stderr, _("From %.*s\n"), url_len, url);
+				shown_url = 1;
+			}
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
 				TRANSPORT_SUMMARY(_("[deleted]")),
 				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
+
 	free(url);
 	free_refs(stale_refs);
 	return result;
-- 
2.1.4
