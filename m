From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/18] rerere: plug conflict ID leaks
Date: Fri, 17 Jul 2015 15:24:24 -0700
Message-ID: <1437171880-21590-3-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:24:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3p-00043N-5h
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbbGQWYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:48 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34374 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbbGQWYq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:46 -0400
Received: by pacan13 with SMTP id an13so67685711pac.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=jAYZwGFh0ZhYSXsToh9tkF3b2vrOXT7kWouLmKgWOhs=;
        b=P3hx2griYmu6W+L2Z6ALjWSMZ9clOGftk7FjPkd/TupLiHp0W/ZVibEr2XetiIOGaY
         41KLQ1gArGkfL0HnFBit2jkO+m0pgzrhV56gesk/Yrp5yYHqdBVheQ7RB7b3EUerfEoO
         8jyzKBP6Yq7pY8YE0EHGWs9gm5GflZcHmKtlwPzegInOobzDB6818ecxdOvFFzu3p3tm
         O9MpsiXxePmbjvVDdv6r0lsAi8jvxLm6WBKQ1CXjFd3Vv/Npp8Qh3jdCK5T0fMsoxLJm
         vNfBK4Oa+RW0clZ83jRMzDHsE6iL3+cLru5LzlA/ROFcmKsqZVH8DBZlQB8kCZ6LBlzC
         Yq3w==
X-Received: by 10.68.135.136 with SMTP id ps8mr34159533pbb.78.1437171885962;
        Fri, 17 Jul 2015 15:24:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id he9sm12350490pbc.7.2015.07.17.15.24.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274109>

The merge_rr string list stores the conflict ID (a hexadecimal
string that is used to index into $GIT_DIR/rr-cache) in the .util
field of its elements, and when do_plain_rerere() resolves a
conflict, the field is cleared.  Also, when rerere_forget()
recomputes the conflict ID to updates the preimage file, the
conflict ID for the path is updated.

We forgot to free the existing conflict ID when we did these two
operations.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index e307711..3b9104d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -559,6 +559,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 		copy_file(rerere_path(name, "postimage"), path, 0666);
 	mark_resolved:
+		free(rr->items[i].util);
 		rr->items[i].util = NULL;
 	}
 
@@ -627,6 +628,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	char *hex;
 	unsigned char sha1[20];
 	int ret;
+	struct string_list_item *item;
 
 	ret = handle_cache(path, sha1, NULL);
 	if (ret < 1)
@@ -641,8 +643,9 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	handle_cache(path, sha1, rerere_path(hex, "preimage"));
 	fprintf(stderr, "Updated preimage for '%s'\n", path);
 
-
-	string_list_insert(rr, path)->util = hex;
+	item = string_list_insert(rr, path);
+	free(item->util);
+	item->util = hex;
 	fprintf(stderr, "Forgot resolution for %s\n", path);
 	return 0;
 }
-- 
2.5.0-rc2-340-g0cccc16
