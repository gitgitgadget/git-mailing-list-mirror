From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 08/19] reset.c: share call to die_if_unmerged_cache()
Date: Wed,  9 Jan 2013 00:16:05 -0800
Message-ID: <1357719376-16406-9-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:23:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqwa-0000sU-8q
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab3AIIXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:23:08 -0500
Received: from mail-lb0-f202.google.com ([209.85.217.202]:58779 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3AIIXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:23:06 -0500
Received: by mail-lb0-f202.google.com with SMTP id s4so85628lbc.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=4C7vCUgEwamtVE8UI2oRQrEMsjhLwJsvPbWXjfWwT3Q=;
        b=E4301oFEvzx/YNzRRFHKBV/fsrypt+Z8pDNyCSnQuJGKHWIeP5Y43iehbII3jnt8s/
         Reym25X9hxUK3/X42VaeXwekKCJ+l9gwSWPH2b2eNb9OwiB3u3xI7oXtfO4Dp/uYenL6
         /HivJ9ts9hmZLN6gunvkw03P0AKbWeJO7gTUGqvkIy2FukCV1GoLNPNECxEujDDikIg4
         ohLEMy/LtowcqQmiGIAVwTRtkB3g5O45FSj81+nAf/KPk3n5bCHu8f/c/Lvljz8z0RXL
         qurN979a5CSlWqxiWhQw+xedvuCBJ/nHwqglnb2T0OqFpSnT2CcIgKO4ejGwG8JNs6s+
         +DEA==
X-Received: by 10.14.214.197 with SMTP id c45mr83806638eep.7.1357719425365;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si11043562eeo.1.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E5331200065;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 26424102FC1; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQm2ROb5VsAMjVJ9Sg6KPM47SPKgBvWNmV23ZmHv5ocIWZqoQTnAXE75235wZ2X0SwwKU9INAZ9BZXBLALdIwwqjmpzFRwvlgeu8+j76LYjavcLn5XJy039Invi4iOFEp8abBwVk1rYwQcjg8zjq5bCM/43WQSfmffHRaylX+iyyPlAIjvxaKmAP+p6j0vaWKqgeOLmj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213043>

Use a single condition to guard the call to die_if_unmerged_cache for
both --soft and --keep. This avoids the small distraction of the
precondition check from the logic following it.

Also change an instance of

  if (e)
    err = err || f();

to the almost as short, but clearer

  if (e && !err)
    err = f();

(which is equivalent since we only care whether exit code is 0)
---
 builtin/reset.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4d556e7..42d1563 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -336,15 +336,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-	if (reset_type == SOFT)
+	if (reset_type == SOFT || reset_type == KEEP)
 		die_if_unmerged_cache(reset_type);
-	else {
-		int err;
-		if (reset_type == KEEP)
-			die_if_unmerged_cache(reset_type);
-		err = reset_index_file(sha1, reset_type, quiet);
-		if (reset_type == KEEP)
-			err = err || reset_index_file(sha1, MIXED, quiet);
+
+	if (reset_type != SOFT) {
+		int err = reset_index_file(sha1, reset_type, quiet);
+		if (reset_type == KEEP && !err)
+			err = reset_index_file(sha1, MIXED, quiet);
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
 	}
-- 
1.8.1.rc3.331.g1ef2165
