From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 09/19] reset --keep: only write index file once
Date: Mon, 14 Jan 2013 21:47:41 -0800
Message-ID: <1358228871-7142-10-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzVF-0004Zi-5E
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab3AOFzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:55:45 -0500
Received: from mail-yh0-f74.google.com ([209.85.213.74]:34408 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab3AOFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:55:44 -0500
Received: by mail-yh0-f74.google.com with SMTP id w68so588049yhw.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=IgjQbTDpzZfjH4lyZl6b6hAqtizvPdW2C2BeejvhyWA=;
        b=aWBuAmbthbqVVnIeUO+P7ZlsyeJ7ljpXLVLj39NhWxt9ZWPXwjiWA4xR2s0hqMDJo/
         SS8LhqBpZu/7Z9C+xNl1WSCbuAmLOlBeQJxH2YJdZak/GtusyUPxLZ/fMuSWrepgXg9b
         yY7IHLtS5gox+rz1x25T+hYB1iBZNJZIIX/STf1gp3sjlvufWcC36vtZQ/k5fjS+b/BK
         cGpwtomXyQhPGrMby325TjoK/vj5ynIaH9MBz7Mk9mSSix1jaAMAEqBDdx8i4MEpANWY
         dBbouwiOfQqR2v8CoeGDX1geuA2x0JHq7kYASgSMvu3ne99ZMpffun6OrXteM0zrUQM6
         pQqg==
X-Received: by 10.236.127.231 with SMTP id d67mr15946959yhi.44.1358228907069;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id s58si817646yhi.6.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 9A7E7100047;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 403DF1014E4; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlLJTrh8yoZnMOYcab/xFP8kJtLZoLaVNBOEL7YM4csjyeNtpLMv+tuZ2mNvKH7h1zh3uOgFvlu1PyY4Nvx8B8XGrA4MwRVwVYR7zc/Xka6CmQwJwjNLgR3BcEe7xTxNNHMpDyp3fLY5G7P+729kJaqh2dDl1aFJL5FnMIlqRZotcEbxV8q7SfUXztAtWtn0GwPN4H6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213590>

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

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4e34195..7c440ad 100644
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
 
@@ -341,9 +333,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
1.8.1.1.454.gce43f05
