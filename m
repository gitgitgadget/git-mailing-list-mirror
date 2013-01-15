From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 12/19] reset.c: move update_index_refresh() call out of read_from_tree()
Date: Mon, 14 Jan 2013 21:47:44 -0800
Message-ID: <1358228871-7142-13-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzVb-0004qg-On
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab3AOF4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:56:07 -0500
Received: from mail-qa0-f73.google.com ([209.85.216.73]:59826 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab3AOF4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:56:05 -0500
Received: by mail-qa0-f73.google.com with SMTP id a19so345758qad.0
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=TJxGlqiVpcmKU5wAB8tgLP7W7qr+oY91w+CJSovjEX4=;
        b=N3MU9DJAabOSSBJUj8VUZC2fmWXXHLG8LFRq3Oc0+kK7yiTVAvljLK2gY1IvQ0c1cU
         yA6Kvp3LnORYzyz9gILNElCEZxAa9dRQh1hXnhQOA6TGFPzwLyPKjpg8t4Dw8WYmZ34T
         n6CxT6Ng+AYS148GJ5OjjrvZsPjEQfecYQ1jOCTc4oEHTdu3dwedMsIqAOZkQpsdNSrp
         L434y8pIItACa6ItRz7U7vZjDGEzfIPCgYJiyLHgurjQC7UR0gaXefIGd5nOR14sAOgk
         x2sJwCmFkshFNhWQDHHOi5T/hhHaaZrvbQsOq7zi+EAOIyqc9ulNi2vNEt7thDoIj7ow
         3hWQ==
X-Received: by 10.236.135.236 with SMTP id u72mr43678909yhi.21.1358228906880;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id s78si818550yhh.3.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id B1D4A820050;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 6A9DA101991; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQl3zHo8GkCeO91lTTmtH5w6xk19Rd2LQu/23PKzpfxjPzW+iwlyflmr3mb9KOxXf3PrHyw8LsU2EAvGEvCojmEdMRg2D08Im6wKzkmC7QDFUGpCOzaNodni5kNXyTRfKnPsgZWpy41qEUBkyJlKY5S4VobjKlLy/AM+eXbyO/QOD2QdFs+l8loTUeL1Ph/fDBLEwFt7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213592>

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

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index c3eb2eb..70733c2 100644
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
@@ -322,9 +318,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
1.8.1.1.454.gce43f05
