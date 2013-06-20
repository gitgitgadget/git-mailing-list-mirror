From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] remote: make prune work for mixed mirror/non-mirror repos
Date: Fri, 21 Jun 2013 00:11:44 +0200
Message-ID: <1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
References: <1371763424.17896.32.camel@localhost>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 00:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upn5X-0004nc-IQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481Ab3FTWMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:12:13 -0400
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:56109 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758476Ab3FTWMM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 18:12:12 -0400
Received: from cpsps-ews16.kpnxchange.com ([10.94.84.197]) by cpsmtpb-ews08.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 00:12:10 +0200
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews16.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 00:12:10 +0200
Received: from kaarsemaker.net ([82.168.11.8]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 00:12:08 +0200
Received: by kaarsemaker.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 00:12:08 +0200
X-Mailer: git-send-email 1.8.3.1-619-gbec0aa7
In-Reply-To: <1371763424.17896.32.camel@localhost>
X-OriginalArrivalTime: 20 Jun 2013 22:12:08.0915 (UTC) FILETIME=[34BE0A30:01CE6E03]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228549>

When cloning a repo with --mirror, and adding more remotes later,
get_stale_heads for origin would mark all refs from other repos as stale. In
this situation, with refs-src and refs->dst both equal to refs/*, we should
ignore refs/remotes/* when looking for stale refs to prevent this from
happening.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 remote.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index e71f66d..863c183 100644
--- a/remote.c
+++ b/remote.c
@@ -1884,6 +1884,7 @@ struct stale_heads_info {
 	struct ref **stale_refs_tail;
 	struct refspec *refs;
 	int ref_count;
+	int ignore_remotes;
 };
 
 static int get_stale_heads_cb(const char *refname,
@@ -1903,7 +1904,8 @@ static int get_stale_heads_cb(const char *refname,
 	 * remote we consider it to be stale.
 	 */
 	if (!((flags & REF_ISSYMREF) ||
-	      string_list_has_string(info->ref_names, query.src))) {
+	      string_list_has_string(info->ref_names, query.src) ||
+	      (info->ignore_remotes && !prefixcmp(refname, "refs/remotes/")))) {
 		struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
 		hashcpy(ref->new_sha1, sha1);
 	}
@@ -1917,6 +1919,8 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
+	if(!strcmp(refs->src, "refs/*") && !strcmp(refs->dst, "refs/*"))
+		info.ignore_remotes = 1;
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	info.refs = refs;
-- 
1.8.3.1-619-gbec0aa7
