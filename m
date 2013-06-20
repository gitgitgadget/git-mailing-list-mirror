From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2] remote: make prune work for mixed mirror/non-mirror repos
Date: Fri, 21 Jun 2013 00:53:26 +0200
Message-ID: <1371768806-5666-1-git-send-email-dennis@kaarsemaker.net>
References: <1371763424.17896.32.camel@localhost>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 00:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpnpX-0005kY-CF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965675Ab3FTW7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:59:42 -0400
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:62501 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965356Ab3FTW7l (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 18:59:41 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jun 2013 18:59:41 EDT
Received: from cpsps-ews24.kpnxchange.com ([10.94.84.190]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 00:53:29 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews24.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 00:53:29 +0200
Received: from kaarsemaker.net ([82.168.11.8]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 00:53:27 +0200
Received: by kaarsemaker.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 00:53:27 +0200
X-Mailer: git-send-email 1.8.3.1-619-gbec0aa7
In-Reply-To: <1371763424.17896.32.camel@localhost>
X-OriginalArrivalTime: 20 Jun 2013 22:53:27.0817 (UTC) FILETIME=[FA487790:01CE6E08]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228555>

When cloning a repo with --mirror, and adding more remotes later,
get_stale_heads for origin would mark all refs from other repos as stale. In
this situation, with refs-src and refs->dst both equal to refs/*, we should
ignore refs/remotes/* and refs/tags/* when looking for stale refs to
prevent this from happening.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 The previous attempt only ignored refs/remotes, but that's not good enough as
 that will still delete tags. So let's ignore refs/tags too. The downside is
 that tags removed at the origin don't get removed, but prune should only be
 pruning branches anyway if I read the documentation correctly.

 remote.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/remote.c b/remote.c
index e71f66d..efc5481 100644
--- a/remote.c
+++ b/remote.c
@@ -1884,6 +1884,7 @@ struct stale_heads_info {
 	struct ref **stale_refs_tail;
 	struct refspec *refs;
 	int ref_count;
+	int is_mirror;
 };
 
 static int get_stale_heads_cb(const char *refname,
@@ -1896,6 +1897,13 @@ static int get_stale_heads_cb(const char *refname,
 
 	if (query_refspecs(info->refs, info->ref_count, &query))
 		return 0; /* No matches */
+	/*
+	 * If we're pruning a clone that was --mirror'ed, let's ignore refs/tags
+	 * and refs/remotes
+	 */
+	if (info->is_mirror && (!prefixcmp(refname, "refs/tags/") ||
+	    !prefixcmp(refname, "refs/remotes/")))
+		return 0;
 
 	/*
 	 * If we did find a suitable refspec and it's not a symref and
@@ -1917,6 +1925,8 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
+	if(!strcmp(refs->src, "refs/*") && !strcmp(refs->dst, "refs/*"))
+		info.is_mirror = 1;
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	info.refs = refs;
-- 
1.8.3.1-619-gbec0aa7
