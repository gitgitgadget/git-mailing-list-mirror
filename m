From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 02/37] merge-recursive: Restructure showing how to chain more process_* functions
Date: Mon, 20 Sep 2010 02:28:35 -0600
Message-ID: <1284971350-30590-3-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblS-0006R4-3s
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab0ITI3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:29:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63516 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab0ITI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:37 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070478pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MGkgylzjWBLffsS/9I20c2JlGcvJeAh9Yzy4Vz5wu6A=;
        b=xpzVxH7beC+jmI5LGcJJh8fuyP+ai9FyR+VJt23j3SPJ4nSdjyOaWYl+lGL0oM0WQf
         5rVkFhsoqORmr5lnxU/8mUcMhRo6KFSL4RGpXbxw9TZwP2SzOnGrQVMMXRxSx6DTEKc5
         2LwvAE68Trm6FXze2MWx6v9SGFqHfVZRXigbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eeZ71twOWmDyingwSFO/vQw+liwPX/oKQosOtfG/N3s2ZXFml+GfA5ecv2U2r17u+j
         FgiJMQKIMgAcbadqZtAsp2vae/lxgPkn8RknvWX/gToYf+ditPItyAIbofSwStDf7TEQ
         uKaNR/7ddZcXTUf2nqxAi3FgbSkgDOmRVwQlc=
Received: by 10.142.247.9 with SMTP id u9mr501155wfh.263.1284971253688;
        Mon, 20 Sep 2010 01:27:33 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156593>

From: Junio C Hamano <gitster@pobox.com>

In 3734893 (merge-recursive: Fix D/F conflicts 2010-07-09),
process_df_entry() was added to process_renames() and process_entry() but
in a somewhat restrictive manner.  Modify the code slightly to make it
clearer how we could chain more such functions if necessary, and alter
process_df_entry() to handle such chaining.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bf611ae..4d9c165 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1260,9 +1260,8 @@ static int process_df_entry(struct merge_options *o,
 	const char *conf;
 	struct stat st;
 
-	/* We currently only handle D->F cases */
-	assert((!o_sha && a_sha && !b_sha) ||
-	       (!o_sha && !a_sha && b_sha));
+	if (! ((!o_sha && a_sha && !b_sha) || (!o_sha && !a_sha && b_sha)))
+		return 1; /* we don't handle non D-F cases */
 
 	entry->processed = 1;
 
@@ -1351,6 +1350,12 @@ int merge_trees(struct merge_options *o,
 				&& !process_df_entry(o, path, e))
 				clean = 0;
 		}
+		for (i = 0; i < entries->nr; i++) {
+			struct stage_data *e = entries->items[i].util;
+			if (!e->processed)
+				die("Unprocessed path??? %s",
+				    entries->items[i].string);
+		}
 
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
-- 
1.7.3.271.g16009
