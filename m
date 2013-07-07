From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 09/22] name-hash.c: use index api
Date: Sun,  7 Jul 2013 10:11:47 +0200
Message-ID: <1373184720-29767-10-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5s-0006Au-AM
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab3GGING (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:06 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:52218 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3GGIMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:55 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so2298756eaj.3
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7dj8r35PW5Rw+SJaRYTajkqnED+aVAO3d96q+GI3s/Y=;
        b=Ed08DJI8iOTSbXn3jonu1o0hmpcoqG0uskQukF/C2kS+0IuOupzv6RkvDAnd64OnTK
         2H9n9c1WnMQj7rZfQWJP/2OOeNu8tjT7HpFsBJ/cyF5WQTfeNyj5lIrnJpxdUhQYOS6i
         WgT1GhiDih1HD+gM9UALWljYlLMNHUcCw/6S04u7lkVrPRHyW+DvM0BQDj5i9LjZaErR
         kvEdN7xon/bNDKSQyinSdSYyEiG435umxoBSlhvV2GbT98MVw57k6S5PWZYkdkrkLunV
         AiTzbL2bJ/d1didWrEDxb/iBvER2zaopAvfEA215ad4GbRGauM4CO9LNORz8O+29Xhz6
         TVcQ==
X-Received: by 10.14.53.75 with SMTP id f51mr19776421eec.30.1373184773215;
        Sun, 07 Jul 2013 01:12:53 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id c44sm30730970eeb.8.2013.07.07.01.12.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229740>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 name-hash.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 617c86c..6551849 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -144,16 +144,19 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		add_dir_entry(istate, ce);
 }
 
-static void lazy_init_name_hash(struct index_state *istate)
+static int hash_entry(struct cache_entry *ce, void *istate)
 {
-	int nr;
+	hash_index_entry((struct index_state *)istate, ce);
+	return 0;
+}
 
+static void lazy_init_name_hash(struct index_state *istate)
+{
 	if (istate->name_hash_initialized)
 		return;
 	if (istate->cache_nr)
 		preallocate_hash(&istate->name_hash, istate->cache_nr);
-	for (nr = 0; nr < istate->cache_nr; nr++)
-		hash_index_entry(istate, istate->cache[nr]);
+	for_each_index_entry(istate, hash_entry, istate);
 	istate->name_hash_initialized = 1;
 }
 
-- 
1.8.3.453.g1dfc63d
