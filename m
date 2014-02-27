From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] GSoC2014 microprojects  Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname
Date: Thu, 27 Feb 2014 22:20:42 +0800
Message-ID: <1393510842-31769-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 15:22:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ1qy-0004qj-K5
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 15:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaB0OWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 09:22:17 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48546 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbaB0OWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 09:22:15 -0500
Received: by mail-pd0-f175.google.com with SMTP id x10so2493279pdj.20
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XRuhptAN8a86gI4pCe+UD1uY/pI+akm7fYcuhqrT3pI=;
        b=Nw8twKJ94snDRIFj11Ew8ebGfkP4yQ7sjJO6YDw46+clrtHz1FaFDylT6bhdsqqAqc
         jXPhemPxP65d3JnGcam0DC8rhri5S8ICLIGLUWsu1Lyyg+8pyEJfLhLwIzVQQy6u6ZYB
         orIpRU7OevZ5diJJwRJYyGh4wbkKpKh7Tgi+H0FXbIQrdeH3Czv5dkVOh2SNJCG4Dz7v
         cHAbv3qsAZcibYOnMc92i8gMh7ZwLyiYpeJ6yLY6zirybrN7Wc+7qsNEIcAwNHxnRlFr
         eItqhJciXuPiZviDkqzn9StlKrg3yzotpz4IEmbvTYqfZX0043+CMlIoLhzFqkw8jH9z
         7+6g==
X-Received: by 10.66.20.10 with SMTP id j10mr13384401pae.11.1393510934723;
        Thu, 27 Feb 2014 06:22:14 -0800 (PST)
Received: from localhost.localdomain ([61.150.43.99])
        by mx.google.com with ESMTPSA id bz4sm14040986pbb.12.2014.02.27.06.22.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 06:22:13 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242826>


Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 bulk-checkin.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..e3c7fb2 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,7 +23,8 @@ static struct bulk_checkin_state {
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char sha1[20];
-	char packname[PATH_MAX];
+    char *packname;
+    struct strbuf sb;
 	int i;
 
 	if (!state->f)
@@ -43,6 +44,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		close(fd);
 	}
 
+     /* 64-1 is more than the sum of len(sha1_to_hex(sha1)) and len(".pack") */
+    strbuf_init(&sb,strlen(get_object_directory())+64);
+    packname = sb.buf;
+
 	sprintf(packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
@@ -54,6 +59,9 @@ clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
 
+    /* release sb space */
+    strbuf_release(&sb);
+
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
 }
-- 
1.7.1

> Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname, and explain why this is useful.

char packname[PATH_MAX] (PATH_MAX=4096) in a local function costs too much space, it may cause stack overflow.
Using strbuf to deal with packname is more space-friendly.
I only use the API strbuf_init to alloc enough space for packname. I didn't use other APIs because I want to make the change as little as possible that I don't have to fix other functions which may import new bugs.
Because the space spared for sb is on heap, we must release it after it is not useful.

> Also check if the first argument of pack-write.c:finish_tmp_packfile() can be made const.

Tht first argument of pack-write.c:finish_tmp_packfile() can be made const because we didn't use *name_buffer to change anything.

Cheers,
He Sun

PS: 
Why I cannot sent email to git@vger.kernel.org via my Firefox?
Can you receive my former emails?
Thanks.
