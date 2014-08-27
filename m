From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 1/2] read_index_from(): catch out of order entries when reading an index file
Date: Wed, 27 Aug 2014 21:48:11 +0200
Message-ID: <1409168892-11345-1-git-send-email-jsorianopastor@gmail.com>
References: <xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 21:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMjDJ-0007nE-7C
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbaH0Ts5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:48:57 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:47831 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935594AbaH0Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:48:56 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so715303wgh.32
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDIGQlIztYG37PIKkqPgRzurCCHINqW+8YQtGG9d2NM=;
        b=Z9S0WH7qiUyA43VpSp+lxbthrGyprVJ0oaesy/JNW96sFY1dyHNlMtP4FTLfuOJAsA
         t9WBbQ/ti2y9QK8C6U47ez1soQPjeVKpAk7VHXIG8aKqP4BrOywRl3+lRyuxKqwg5uEF
         J/8jsKi7SmpMQwBWwVjlRfJ+xpsgSA8lBZRSYkx18MoJs85+bzNTLgDRkDcbAZkstKUp
         Se0jhrVUCy4y4gkrrSPYlk/JycflW9xRfMXSxC25Gbes7tXlYhtYdZ/+y2vhiKaREuuK
         Bl7BRkc0p+cSdUnKTprnzRzCeHQyF6WQURlucABQs5VlYbb0OKVtTZDs+IEYrov6AGJo
         RGQA==
X-Received: by 10.180.14.169 with SMTP id q9mr31585297wic.19.1409168935043;
        Wed, 27 Aug 2014 12:48:55 -0700 (PDT)
Received: from localhost.localdomain (4.Red-88-3-38.dynamicIP.rima-tde.net. [88.3.38.4])
        by mx.google.com with ESMTPSA id fx10sm42629wib.10.2014.08.27.12.48.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 12:48:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.2.g7bc378e.dirty
In-Reply-To: <xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256035>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 7f5645e..1cdb762 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1438,6 +1438,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+static void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
+{
+	int name_compare = strcmp(ce->name, next_ce->name);
+	if (0 < name_compare)
+		die("Unordered stage entries in index");
+	if (!name_compare) {
+		if (!ce_stage(ce))
+			die("Multiple stage entries for merged file '%s'",
+				ce->name);
+		if (ce_stage(ce) > ce_stage(next_ce))
+			die("Unordered stage entries for '%s'",
+				ce->name);
+	}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1499,6 +1514,9 @@ int read_index_from(struct index_state *istate, const char *path)
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
+		if (i > 0)
+			check_ce_order(istate->cache[i - 1], ce);
+
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-- 
2.0.4.2.g7bc378e.dirty
