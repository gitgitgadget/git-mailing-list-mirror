From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 12/19] reset.c: move update_index_refresh() call out of read_from_tree()
Date: Wed,  9 Jan 2013 00:16:09 -0800
Message-ID: <1357719376-16406-13-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqym-0003cm-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367Ab3AIIZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:25:24 -0500
Received: from mail-la0-f73.google.com ([209.85.215.73]:49682 "EHLO
	mail-la0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3AIIZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:25:23 -0500
Received: by mail-la0-f73.google.com with SMTP id fq13so93795lab.2
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=7BLlytxwb15+c1PTgf+b1aBvQPlGkNMTZahsQrISBJo=;
        b=VRjF39hPIA6ztVSsDQRCMHFpTHRGmE90kFNBg+iHILv0ablQPLgNb551MdzohLVajW
         jVRWw/baJLafwtVWsrtndHAEKCYbbw+OhcC0RpFbhazfCQoF1tDoqVkDEUMIhzWfCXnx
         jr5T0hEjtxDByf/CRuUG9j6BoLGqbLthNWE9qb3rjcIEYRdJJKIzpCBqKoWJ6sw/JYuM
         YJgwt9kEt8HrQmMHuBGwsNTjMl9L4H34OMXSb8h6fL2Ek93glFWtehd07hkPprE5+U6J
         WHo/1MUQ0yeloVRB5erIxvHU9TMLV7SabL7lZ61973j6blhrCwiHJpqvRTYrIDDqkT7i
         ksSQ==
X-Received: by 10.14.0.196 with SMTP id 44mr83784616eeb.6.1357719425620;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si11043557eeo.1.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 2E049200057;
	Wed,  9 Jan 2013 00:17:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 559FC100F9D; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkhvB7pcM40TLHCPPsFIzNDMHxhDp8vKCedsudLmw2+YpijuEqb6vQSvQjM0XXEtJkAkN9DmqWhm80x6V26NvcniSLfHfrLfFusPqW4IfCHrYcRkN4JDwkFbDQSeyGnw9z3RZ1WuMvr46383SvZ/VgiO16B07qfXuQhVPXulCq+2GlwnkyUyKUyr2N6IxFCFm8608sD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213050>

The final part of cmd_reset() essentially looks like:

  if (pathspec) {
    ...
    read_from_tree(...);
  } else {
    ...
    reset_index(...);
    update_index_refresh(...);
    ...
  }

where read_from_tree() internally also calls
update_index_refresh(). Move the call to update_index_refresh() out of
read_from_tree for symmetry with the 'else' block, making
read_from_tree() and reset_index() closer in functionality.
---
 builtin/reset.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 54e3c5b..a21ba31 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -145,11 +145,8 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
-static int read_from_tree(const char **pathspec, unsigned char *tree_sha1,
-			  int refresh_flags)
+static int read_from_tree(const char **pathspec, unsigned char *tree_sha1)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int index_fd;
 	struct diff_options opt;
 
 	memset(&opt, 0, sizeof(opt));
@@ -157,7 +154,6 @@ static int read_from_tree(const char **pathspec, unsigned char *tree_sha1,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 
-	index_fd = hold_locked_index(lock, 1);
 	read_cache();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
@@ -165,7 +161,7 @@ static int read_from_tree(const char **pathspec, unsigned char *tree_sha1,
 	diff_flush(&opt);
 	diff_tree_release_paths(&opt);
 
-	return update_index_refresh(index_fd, lock, refresh_flags);
+	return 0;
 }
 
 static void set_reflog_message(struct strbuf *sb, const char *action,
@@ -321,9 +317,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
-	if (pathspec)
-		return read_from_tree(pathspec, sha1,
-				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+	if (pathspec) {
+		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+		int index_fd = hold_locked_index(lock, 1);
+		return read_from_tree(pathspec, sha1) ||
+			update_index_refresh(index_fd, lock,
+					quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+	}
 
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
-- 
1.8.1.rc3.331.g1ef2165
