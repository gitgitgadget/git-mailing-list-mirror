From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 15/19] reset.c: finish entire cmd_reset() whether or not pathspec is given
Date: Wed,  9 Jan 2013 00:16:12 -0800
Message-ID: <1357719376-16406-16-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqqx-000285-C3
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab3AIIRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:13 -0500
Received: from mail-lb0-f202.google.com ([209.85.217.202]:50973 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab3AIIRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:08 -0500
Received: by mail-lb0-f202.google.com with SMTP id s4so84915lbc.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=/DpZTS8wxuIBc+CMR80GTX1iJ+y44o9aB6ovevdhn1M=;
        b=nZ2l2/yf34198cCBSY8/XhzdjlfLND9XqocdXiPq5Sae4MSNhQZ4EgqbNOlhEnPuNd
         +yhWPug1VzBo3VrgN1KAUq1jBYC2cJ8Vi8sXH4YlLVfCKI8u2br/i4UqQ29b3ssLJ9p1
         UT9YmFxUmSmkohyGLwfMUHdKOOYtkAco3SeRfeUp4iQQciesex4imKzUlAEW2C1c4rIs
         zycLgABzkPgRo08OlRWBON7MVfgt0Lomd9GeVa3ljltjQAU2twk93fnjTJQaqSk5tT7/
         dY2ilSFdmUDeFJb9BvjfZ2qJq4WxyHrOXnmlWcpSul0Hb7NXREpfz7uvjCRtCj4aDgMG
         54Aw==
X-Received: by 10.14.214.197 with SMTP id c45mr83806662eep.7.1357719425720;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si11043608eeo.1.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 47BBD20004E;
	Wed,  9 Jan 2013 00:17:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 7B0AF102E2E; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkK7rFQmbhVDSnayX3UemWuI/NuXtHBHZIIKb9IXyLOroksc6KT2C9mkwg/g22i2sc6sNf0WLdIvQiu6SEAFTm6yZRXqVhDuV/svAMGUFagHUybOCRNjTOzGNmO+mQZEIjrkCtQL+Z6+M7LaWh613MR21MoMM1kDIwjKkIk3bd5PHEC/Kc26vJq9dWJJv0RssHuF2Oy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213034>

By not returning from inside the "if (pathspec)" block, we can let the
pathspec-aware and pathspec-less code share a bit more, making it
easier to make future changes that should affect both cases. This also
highlights the similarity between read_from_tree() and reset_index().
---
Should error reporting be aligned too? Speaking of which,
do_diff_cache() never returns anything by 0. Is the return value for
future-proofing?

 builtin/reset.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 254afa9..9bcad29 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -308,19 +308,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
@@ -330,11 +317,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
@@ -345,14 +337,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
1.8.1.rc3.331.g1ef2165
