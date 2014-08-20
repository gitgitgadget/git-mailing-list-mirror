From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 1/4] read_index_unmerged doesn't loop forever if merged stage exists for unmerged file
Date: Wed, 20 Aug 2014 13:26:00 +0200
Message-ID: <3c1dfe8a1cc03c083e93ce834aac574e4e321f6e.1408533065.git.jsorianopastor@gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
 <cover.1408533065.git.jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK43N-0004yh-EY
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 13:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbaHTL1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 07:27:04 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:35772 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaHTL1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 07:27:03 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so7812821wes.31
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hazDB7qZw7Y8iUeZiBc/6Vuiu9bbR/Kh5t97cVwaN9g=;
        b=SK/bGBOBow9HBwfjaR3PzTNNY1SDIMdEZtiJ8QBb8V+yz0t03wkFjkrNf+cRaSOKV0
         N4e8ZarHui5yeTtWF2TYWO6tQBxg7Nl7SE00mBIeTp/zcLUyS+OKKoYSsZMnMP6tsCF9
         w1bK6nIFCz72TR7nA5tkRrm6jOE5UW3jfZ9lNLJS5AhuogRi47qJR8NTEpIAueBtlqmO
         jnbq25dzDy6mgTtpb+shFWe+bkJBKntDirmw9IG8sNtYk0rSO5QvzSJC38PHSgIgD0mx
         DcJ0diUsc7ugFnXk2/I8cs9VMsVt/0N81Wk1ysTdCFcoZ6x6aqKDhZ+9OOv4Wba9ABa8
         jxPg==
X-Received: by 10.180.221.65 with SMTP id qc1mr14803164wic.28.1408534021976;
        Wed, 20 Aug 2014 04:27:01 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (50.red-80-26-152.adsl.static.ccgg.telefonica.net. [80.26.152.50])
        by mx.google.com with ESMTPSA id je17sm8301873wic.22.2014.08.20.04.27.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 04:27:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.4.gaf54b2b
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
References: <cover.1408533065.git.jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255566>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7f5645e..c932b83 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1933,6 +1933,7 @@ int read_index_unmerged(struct index_state *istate)
 {
 	int i;
 	int unmerged = 0;
+	struct cache_entry *merged_ce = NULL;
 
 	read_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
@@ -1940,9 +1941,26 @@ int read_index_unmerged(struct index_state *istate)
 		struct cache_entry *new_ce;
 		int size, len;
 
-		if (!ce_stage(ce))
+		if (!ce_stage(ce)) {
+			merged_ce = ce;
 			continue;
+		}
 		unmerged = 1;
+		if (merged_ce && ce_same_name(merged_ce, ce)) {
+			warning("Unexpected stages for merged file '%s':",
+				merged_ce->name);
+			i--;
+			while (i < istate->cache_nr &&
+				   ce_same_name(merged_ce, istate->cache[i])) {
+				ce = istate->cache[i++];
+				warning("%06o %s %d",
+				        ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+			}
+			i--;
+			merged_ce->ce_flags = create_ce_flags(0) | CE_CONFLICTED;
+			merged_ce = NULL;
+			continue;
+		}
 		len = ce_namelen(ce);
 		size = cache_entry_size(len);
 		new_ce = xcalloc(1, size);
@@ -1953,7 +1971,6 @@ int read_index_unmerged(struct index_state *istate)
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
 				     new_ce->name);
-		i = index_name_pos(istate, new_ce->name, len);
 	}
 	return unmerged;
 }
-- 
2.0.4.4.gaf54b2b
