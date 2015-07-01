From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/13] rerere: plug conflict ID leaks
Date: Tue, 30 Jun 2015 23:04:48 -0700
Message-ID: <1435730699-9124-3-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB92-0004E7-2a
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbbGAGFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:09 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36907 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbGAGFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:04 -0400
Received: by igblr2 with SMTP id lr2so27948307igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=JqD23woDMb5GnVTm+lfjESsuhWWU5BHde4LMUtawe5E=;
        b=L9MFJjG8dsJ6ZMS2UKf51JKQl021tD8TMhJe+1mjn823ff3pNV3Xy6I4TZC5yWjRRU
         SSPz2yo2zzNz/7PSknCMRSfM7Y9M+OPajscSCLzP9/VC86pD3GEVHA3jWKaHZAWM7azK
         iG/uPItXz1H9kVgVG+wv69nvvPeoxkX65sneBlW4a9sDYIFND7GqQrXzXFwUYto7X1TP
         K83TvWDquamim5irEyrBm+ZCuXZTLRAPhRxhsjgdbnLolYIJaiuy3i00SM9ZV4yOyS3d
         JTOYfhw1DGEJNVWaKqNgs/jua3Mn/EKrhOWfHkGjNeGlp3KSr1qfspukuQJJuvFsDrYL
         8vrA==
X-Received: by 10.42.72.194 with SMTP id p2mr1867084icj.33.1435730703888;
        Tue, 30 Jun 2015 23:05:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id p196sm686808iop.15.2015.06.30.23.05.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273119>

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
2.5.0-rc0-209-g5e1f148
