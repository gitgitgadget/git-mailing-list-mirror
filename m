From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 15/19] reset.c: finish entire cmd_reset() whether or not pathspec is given
Date: Mon, 14 Jan 2013 21:47:47 -0800
Message-ID: <1358228871-7142-16-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOR-0007EL-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab3AOFsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:45 -0500
Received: from mail-vb0-f74.google.com ([209.85.212.74]:55382 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686Ab3AOFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:28 -0500
Received: by mail-vb0-f74.google.com with SMTP id r6so505003vbi.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=vMG3OnrkM979KNYrWbQLPEBgAr0qEBXRbJLXzbjsWAU=;
        b=PLOdj/3yJowQmY1edxJUSm2Oa2Oqbp0S0BixJgZW7/LP6cMxHnCGj1dZ+qUyaq2X5o
         LPwgpf7zTAmupNhIe0vJJajzbHmlmeoqjK7Nk/nuq2ro6+B5Fz+EucVZ+JKmrMTA+9GA
         yhc3AK/1Dm+ZrmJL7K5z84j0UV+ZB4qknqM1u8PO3ImBp2bZETP10yKPqpccoDhrE7ZT
         MlB1zzWNX3bAtQWATq26dOiwicfU5zcqM/BM1ZS/kG7K3ErqUS0D/mtNFuBddVJy6saT
         3knTAIEubIrlUvWaJPdYWPT8u6TuUEf4mvVsKSCNXxlbJfzdV0GIG+rJijnIFIsNf2yc
         AcJA==
X-Received: by 10.236.156.227 with SMTP id m63mr7704533yhk.17.1358228907065;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j11si451117ank.2.2013.01.14.21.48.27
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D22D931C174;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 76FB810002A; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlrD5P7YNwQk+dLYtFT0cD/eYRP0018h9IEDMNXaWAiB15nYr2KqVDjiWlWVPrv4Z+LCKNGMivNRVptleQE3FGLF71bVGTgE0HFc5e0DJTmONkvS/F/vglN6WPYs8J4Zn87rnRS8uxwrkDF+JxoFVpW8G6TiXVPAbw7rSfs66eJp1xTjBPrp4VIOerevr0s64GZ/tdW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213581>

By not returning from inside the "if (pathspec)" block, we can let the
pathspec-aware and pathspec-less code share a bit more, making it
easier to make future changes that should affect both cases. This also
highlights the similarity between read_from_tree() and reset_index().

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index e8a3e41..c316d9b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -309,19 +309,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
-	if (pathspec) {
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-		int index_fd = hold_locked_index(lock, 1);
-		if (read_from_tree(pathspec, sha1))
-			return 1;
-		update_index_refresh(
-			quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
-		if (write_cache(index_fd, active_cache, active_nr) ||
-		    commit_locked_index(lock))
-			return error("Could not write new index file.");
-		return 0;
-	}
-
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
@@ -331,11 +318,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type != SOFT) {
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int newfd = hold_locked_index(lock, 1);
-		int err = reset_index(sha1, reset_type, quiet);
-		if (reset_type == KEEP && !err)
-			err = reset_index(sha1, MIXED, quiet);
-		if (err)
-			die(_("Could not reset index file to revision '%s'."), rev);
+		if (pathspec) {
+			if (read_from_tree(pathspec, sha1))
+				return 1;
+		} else {
+			int err = reset_index(sha1, reset_type, quiet);
+			if (reset_type == KEEP && !err)
+				err = reset_index(sha1, MIXED, quiet);
+			if (err)
+				die(_("Could not reset index file to revision '%s'."), rev);
+		}
 
 		if (reset_type == MIXED) /* Report what has not been updated. */
 			update_index_refresh(
@@ -346,14 +338,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("Could not write new index file."));
 	}
 
-	/* Any resets update HEAD to the head being switched to,
-	 * saving the previous head in ORIG_HEAD before. */
-	update_ref_status = update_refs(rev, sha1);
+	if (!pathspec) {
+		/* Any resets without paths update HEAD to the head being
+		 * switched to, saving the previous head in ORIG_HEAD before. */
+		update_ref_status = update_refs(rev, sha1);
 
-	if (reset_type == HARD && !update_ref_status && !quiet)
-		print_new_head_line(commit);
+		if (reset_type == HARD && !update_ref_status && !quiet)
+			print_new_head_line(commit);
 
-	remove_branch_state();
+		remove_branch_state();
+	}
 
 	return update_ref_status;
 }
-- 
1.8.1.1.454.gce43f05
