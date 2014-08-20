From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 2/4] Error out when adding a file with merged and unmerged entries
Date: Wed, 20 Aug 2014 13:26:01 +0200
Message-ID: <e3abc57b58e7cfae11a1221c9a06e74a34148295.1408533065.git.jsorianopastor@gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
 <cover.1408533065.git.jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:27:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK43N-0004yh-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 13:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbaHTL1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 07:27:06 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33194 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaHTL1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 07:27:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so7719689wgh.22
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KcYm2W2wcZ/7W5EFft7gPoQFxh5IMO2etVqHCN21yoE=;
        b=rxEmEDcYQzxDAzwni/Jvn/toVpXqMXmNLI0fkuCw944Db5b+uKcRoG98vMVNgeixAs
         ljK8yOvplvTHzia5AgXwiZhKMdRQ//cORMMC17y7tmVIitRaJu7rrVPqZgqm/6joTbDQ
         qvdhhP+yZA8Srblp77GaB3/EdWY5gqGBk3gEvE4bnLos/XXW6GFiK9FVa4vVLCTLO1fE
         oNfhgwczPLnX538QQzPbpVWybJVM7L4SF79INXOj7G/IL3uUpaerm/nXZdt5x3yEXpI5
         upm9jfVOunwk6U37BKeSfmIXPSAVcJ0vnMXZYESsWDER7ey7ADfMCw22miKf09chl4Za
         vPhw==
X-Received: by 10.180.37.16 with SMTP id u16mr14635116wij.72.1408534023616;
        Wed, 20 Aug 2014 04:27:03 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (50.red-80-26-152.adsl.static.ccgg.telefonica.net. [80.26.152.50])
        by mx.google.com with ESMTPSA id je17sm8301873wic.22.2014.08.20.04.27.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 04:27:02 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.4.gaf54b2b
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
References: <cover.1408533065.git.jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255567>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c932b83..d549d0b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -935,6 +935,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
+	int replaced = 0;
 
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
 	pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
@@ -943,9 +944,10 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (pos >= 0) {
 		if (!new_only)
 			replace_index_entry(istate, pos, ce);
-		return 0;
-	}
-	pos = -pos-1;
+		replaced = 1;
+		pos++;
+	} else
+		pos = -pos-1;
 
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
@@ -953,12 +955,18 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	 */
 	if (pos < istate->cache_nr && ce_stage(ce) == 0) {
 		while (ce_same_name(istate->cache[pos], ce)) {
+			if (replaced)
+				die("Merged and unmerged entries found for "
+				    "'%s', check 'git ls-files -s \"%s\"'",
+				    ce->name, ce->name);
 			ok_to_add = 1;
 			if (!remove_index_entry_at(istate, pos))
 				break;
 		}
 	}
 
+	if (replaced)
+		return 0;
 	if (!ok_to_add)
 		return -1;
 	if (!verify_path(ce->name))
-- 
2.0.4.4.gaf54b2b
