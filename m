From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Tue, 12 Aug 2014 17:31:31 +0200
Message-ID: <1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 17:31:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHE36-000729-2z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 17:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaHLPbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 11:31:41 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:42630 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbaHLPbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 11:31:40 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so5994530wib.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEaDTgzhngMKAP5AmfRr5gPnW8UecW6PgkdrK7akf+Y=;
        b=q/HLlMS7MPeSv8XjFDF+oBmSvvHI97nUiWmUZQUJR6rI2YvhadL5fYs/23+KqFyekO
         4vkjroJBZGqor8MAE5qGnrXp/DNUMP3dVGLuf6Kwef5kBIYPeannVZj5d032O1y3/nVP
         Hqm6QGJJ98WtdpclcT+p8/nw8UldivVo6WbhfyZ5TfZKr+yW6GvwvcmjSVlPLqpU8Oo0
         dOuYQUGNorliFpm7LvXNOL89N6xMpZhcdetQZ6foD8mva/Oa/uIxbOE3sf5+oRF2A3po
         03TYW5hdJO3ChJ0WxjjbJv6ek0RRuqOqlspLJSmmERVeioGuG22PFW9LFohZ/iuQ+R/q
         ZXgw==
X-Received: by 10.180.91.47 with SMTP id cb15mr33165532wib.10.1407857499214;
        Tue, 12 Aug 2014 08:31:39 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (94.red-80-28-98.adsl.static.ccgg.telefonica.net. [80.28.98.94])
        by mx.google.com with ESMTPSA id a4sm57320438wie.21.2014.08.12.08.31.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 08:31:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.1.g8a38f21.dirty
In-Reply-To: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255150>

Wrong implementations of tools that modify the index can left
some files as merged and unmerged at the same time. Avoid undesiderable
behaviours by handling this situation.

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7f5645e..23e46e1 100644
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
+		pos++;
+		replaced = 1;
+	} else
+		pos = -pos-1;
 
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
@@ -959,6 +961,8 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		}
 	}
 
+	if (replaced)
+		return 0;
 	if (!ok_to_add)
 		return -1;
 	if (!verify_path(ce->name))
-- 
2.0.4.1.g8a38f21.dirty
