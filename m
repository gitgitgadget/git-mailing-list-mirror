From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 5/5] Use xdiff caching to improve git blame performance
Date: Thu, 21 Aug 2008 18:22:01 -0500
Message-ID: <1219360921-28529-6-git-send-email-bdowning@lavos.net>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
 <1219360921-28529-2-git-send-email-bdowning@lavos.net>
 <1219360921-28529-3-git-send-email-bdowning@lavos.net>
 <1219360921-28529-4-git-send-email-bdowning@lavos.net>
 <1219360921-28529-5-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJfG-0003Ti-UE
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbYHUXc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756305AbYHUXcz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:32:55 -0400
Received: from mail.somat.com ([63.252.84.66]:50096 "EHLO somat1.somat.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756095AbYHUXcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:32:52 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 19:32:39 EDT
Received: from silvara.lavos.net ([192.168.0.108]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Aug 2008 18:22:01 -0500
Received: (nullmailer pid 28574 invoked by uid 1000);
	Thu, 21 Aug 2008 23:22:01 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <1219360921-28529-5-git-send-email-bdowning@lavos.net>
X-OriginalArrivalTime: 21 Aug 2008 23:22:01.0757 (UTC) FILETIME=[B72FF4D0:01C903E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93230>

git blame -C -C diffs all entries against the same file.  To avoid having
to recompute the line hashes for this file over and over again, use the
xddiff cache feature to store the hashes in struct origin.

Note that because this bypasses the xdi_diff tail trimming, it can
return different (but still valid) blame results for certain cases.
See http://article.gmane.org/gmane.comp.version-control.git/93112 for
more details.

This yields another significant speed improvement for some cases:

:; time git-blame -M -C -C -p --incremental server.c >/dev/null
Before:
48.66user 0.08system 0:48.75elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+36961minor)pagefaults 0swaps
After:
29.68user 0.22system 0:29.98elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+37897minor)pagefaults 0swaps

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-blame.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 66b7d15..3e90668 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -80,6 +80,7 @@ struct origin {
 	int refcnt;
 	struct commit *commit;
 	mmfile_t file;
+	xdcache_t xdcache;
 	unsigned char blob_sha1[20];
 	char path[FLEX_ARRAY];
 };
@@ -119,6 +120,7 @@ static inline struct origin *origin_incref(struct origin *o)
 static void origin_decref(struct origin *o)
 {
 	if (o && --o->refcnt <= 0) {
+	        xdl_cache_free(&o->xdcache);
 		free(o->file.ptr);
 		free(o);
 	}
@@ -494,7 +496,8 @@ static int process_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	return 0;
 }
 
-static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
+static struct patch *compare_buffer(mmfile_t *file_p, xdcache_t *cache_p,
+				    mmfile_t *file_o, xdcache_t *cache_o,
 				    int context)
 {
 	struct patch *patch;
@@ -504,6 +507,8 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = xdl_opts;
+	xpp.mf1_cache = cache_p;
+	xpp.mf2_cache = cache_o;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
 	patch = xmalloc(sizeof(struct patch));
@@ -511,7 +516,7 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	patch->num = 0;
 	xecfg.emit_func = (void (*)())process_diff;
 	ecb.priv = patch;
-	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
+	xdl_diff(file_p, file_o, &xpp, &xecfg, &ecb);
 
 	return patch;
 }
@@ -530,7 +535,8 @@ static struct patch *get_patch(struct origin *parent, struct origin *origin)
 	fill_origin_blob(origin, &file_o);
 	if (!file_p.ptr || !file_o.ptr)
 		return NULL;
-	patch = compare_buffer(&file_p, &file_o, 0);
+	patch = compare_buffer(&file_p, &parent->xdcache,
+			       &file_o, &origin->xdcache, 0);
 	num_get_patch++;
 	return patch;
 }
@@ -937,7 +943,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	}
 	file_o.size = cp - file_o.ptr;
 
-	patch = compare_buffer(file_p, &file_o, 1);
+	patch = compare_buffer(file_p, &parent->xdcache, &file_o, NULL, 1);
 
 	/*
 	 * file_o is a part of final image we are annotating.
-- 
1.5.6.1
