From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 1/2] Check order when reading index
Date: Sun, 24 Aug 2014 19:57:26 +0200
Message-ID: <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 19:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLc2t-0004u6-5a
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 19:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbaHXR5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 13:57:35 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:54580 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbaHXR5e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 13:57:34 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so12012951wgh.21
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d7c5oNvh58wx2uE67DaBPdeVtT9i2+IwAz91VGpvmzs=;
        b=SQwUNU3xeIdZSJCwzjxPe05f2p+npdN6reInbbWaEfIoZ5B6Q1y/e28zLJDAhCCgeg
         zk1b8PNim/SLzrxgl9LFJinsXH8ZCBveTc6R98MbDkaqIvhpCnpQ7t/hleuwIWWDX2Pd
         q57Lc9bt3AE8qLddpGEiWl0i5Phx+m9qXBj6WrYoNzALJmNQgbGhvHpabMCicDu9DrSR
         u91EDYfpu/VhA/B84aB+/q+9NABrMBN2vBp3S7tqZub9F3Ut80rWzmIsovyv+I3e33wu
         7A2pJwyiZfKLp7OFccy3tqIGhlQLuJQ2hiPEmEljwYo2Cai66OhCK1zAUeJgtk+Qk9C0
         41oQ==
X-Received: by 10.180.218.4 with SMTP id pc4mr10495550wic.15.1408903052848;
        Sun, 24 Aug 2014 10:57:32 -0700 (PDT)
Received: from localhost.localdomain (4.Red-88-3-38.dynamicIP.rima-tde.net. [88.3.38.4])
        by mx.google.com with ESMTPSA id fi1sm22712870wib.5.2014.08.24.10.57.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Aug 2014 10:57:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.1.g0b8a4f9.dirty
In-Reply-To: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255807>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 7f5645e..c1a9619 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1438,6 +1438,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
+{
+	int name_compare = strcmp(ce->name, next_ce->name);
+	if (0 < name_compare)
+		die("Unordered stage entries in index");
+	if (!name_compare) {
+		if (!ce_stage(ce))
+			die("Multiple stage entries for merged file '%s'",
+				ce->name);
+		if (ce_stage(ce) >= ce_stage(next_ce))
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
2.0.4.1.g0b8a4f9.dirty
