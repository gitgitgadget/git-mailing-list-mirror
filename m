From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 02/22] use cache iterator in checkout-index.c
Date: Mon, 12 Sep 2005 10:55:47 -0400
Message-ID: <20050912145547.28120.22685.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:02:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEplj-0001hk-Fz
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVILO5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVILOzv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:55:51 -0400
Received: from citi.umich.edu ([141.211.133.111]:26405 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751288AbVILOzs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:48 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id C06C91BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:47 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8399>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 checkout-index.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/checkout-index.c b/checkout-index.c
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -61,17 +61,12 @@ static int checkout_file(const char *nam
 	return checkout_entry(active_cache[pos], &state);
 }
 
-static int checkout_all(void)
+static int checkout_one(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i;
-
-	for (i = 0; i < active_nr ; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce))
-			continue;
+	if (!ce_stage(ce))
 		if (checkout_entry(ce, &state) < 0)
 			return -1;
-	}
+	next_cc(cc);
 	return 0;
 }
 
@@ -85,15 +80,14 @@ int main(int argc, char **argv)
 	int i, force_filename = 0;
 	int newfd = -1;
 
-	if (read_cache() < 0) {
+	if (read_cache() < 0)
 		die("invalid cache");
-	}
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_filename) {
 			if (!strcmp(arg, "-a")) {
-				checkout_all();
+				walk_cache(checkout_one);
 				continue;
 			}
 			if (!strcmp(arg, "--")) {
