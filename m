From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 10/19] reset --keep: only write index file once
Date: Wed,  9 Jan 2013 00:16:07 -0800
Message-ID: <1357719376-16406-11-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsquz-0007JY-ET
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab3AIIRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:24 -0500
Received: from mail-ye0-f202.google.com ([209.85.213.202]:38359 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324Ab3AIIRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:06 -0500
Received: by mail-ye0-f202.google.com with SMTP id r9so191223yen.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=wXJAaDUXUyvHWK6iuBF1GoPjl3FrbXyaS9Ln+LjqrX0=;
        b=eNX1JO4TQbECN4S2Pr7iVp8k8QBdHWIVFSON4+Lyzn3oeiMHFobFDg+ANT75kZy0sk
         n3bmSLXriX9d09MzsBN6VGdrVO/lLfLCvTY3A6svQrCICUpjniPLNTGiiNxuaqgC4+Yv
         N0F8oAZcG9hIt82KmJNdJkhcQc/PkttnE++g2npXy+8a8Mph3QcweoVLuVz0t/aLzNe2
         afPLfcQIPQ3ihGcFzShIJesL6APHL2jb55Crz4vwgkyFykVXk4Ushd1lTixMNMjKDgnv
         x0oeiaIdo9WsRxdYc9anuk+uzI1oe0zqNa7OootD3e27qrWGiJJv4lpMaWdAA5ASPhTQ
         DIpA==
X-Received: by 10.236.59.8 with SMTP id r8mr36975498yhc.8.1357719424798;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id p19si5739581yhi.1.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id AE848820050;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 3EF5C102FD2; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmP+b5gdn5AyNR1tJS4iZdcxJJaMVDI5NjviN9rkKMg9DNW/PpmwYa4P91cXhMFALhHyFBseirHRhdo8Cmy+vLxjf+eAUuLEAmSXSHWZ99lHIizjdxrC1NVVedDm/VARgjqEhKFT0EySJKA5IEaduYq16TwbzIV4rRboXuUN2CPF/e6hMcIhWhOlBfksvRAG41QDLCH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213038>

"git reset --keep" calls reset_index_file() twice, first doing a
two-way merge to the target revision, updating the index and worktree,
and then resetting the index. After each call, we write the index
file.

In the unlikely event that the second call to reset_index_file()
fails, the index will have been merged to the target revision, but
HEAD will not be updated, leaving the user with a dirty index.

By moving the locking, writing and committing out of
reset_index_file() and into the caller, we can avoid writing the index
twice, thereby making the sure we don't end up in the half-way reset
state. As a bonus, we speed up "git reset --keep" a little on the
linux-2.6 repo (best of five, warm cache):

        Before      After
real    0m0.315s    0m0.296s
user    0m0.290s    0m0.280s
sys     0m0.020s    0m0.010s
---
 builtin/reset.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 05ccfd4..8e5d097 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -38,14 +38,12 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
-static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
+static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 {
 	int nr = 1;
-	int newfd;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
@@ -67,8 +65,6 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 		opts.reset = 1;
 	}
 
-	newfd = hold_locked_index(lock, 1);
-
 	read_cache_unmerged();
 
 	if (reset_type == KEEP) {
@@ -91,10 +87,6 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 		prime_cache_tree(&active_cache_tree, tree);
 	}
 
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(lock))
-		return error(_("Could not write new index file."));
-
 	return 0;
 }
 
@@ -340,9 +332,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die_if_unmerged_cache(reset_type);
 
 	if (reset_type != SOFT) {
-		int err = reset_index_file(sha1, reset_type, quiet);
+		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+		int newfd = hold_locked_index(lock, 1);
+		int err = reset_index(sha1, reset_type, quiet);
 		if (reset_type == KEEP && !err)
-			err = reset_index_file(sha1, MIXED, quiet);
+			err = reset_index(sha1, MIXED, quiet);
+		if (!err &&
+		    (write_cache(newfd, active_cache, active_nr) ||
+		     commit_locked_index(lock))) {
+			err = error(_("Could not write new index file."));
+		}
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
 	}
-- 
1.8.1.rc3.331.g1ef2165
