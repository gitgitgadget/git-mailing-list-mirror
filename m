From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 01/19] reset $pathspec: no need to discard index
Date: Mon, 14 Jan 2013 21:47:33 -0800
Message-ID: <1358228871-7142-2-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:48:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOE-00073O-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726Ab3AOFsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:30 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:52418 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3AOFs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:27 -0500
Received: by mail-qc0-f202.google.com with SMTP id s25so588710qcq.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=nBCD/yVANlxqaYUXGYNm+M+Lo/qQGt1MzxdrCeM0RN4=;
        b=c9IzjWOYTF0kAu+AxkeJhOhwdx97UPkv7dFS4W93WNDfH4gBHCVb4XoCSqD/WSFfQ+
         4YVaENr7o/sg7xzZX1XdkQCU6T1DNtqBvoSzu96h1Y7CiwxP2ODj3MlvC3hDw7MNNtvw
         jyGBSecTbr4jriAy6bWv8U0vOZVDodORMthGeYtiiSdANCDBaFjzGY9xHDw2882cu9Ma
         ERDlT6siThdjvJaIIn7oJflUFk4TYxdJDKjdmuQyIhWXuWeozol6hazOyRpdWDpSI8r5
         527+gZ9W+1pdEBlf7loQmZvht+Ei8Wyx4CdWL892cb2TfuaBKQ51cdVof6Rmlv3mhzL+
         m9FQ==
X-Received: by 10.100.243.11 with SMTP id q11mr12389202anh.2.1358228906260;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r6si817634yhc.7.2013.01.14.21.48.26
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1F24631C174;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id C27FE10002A; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnUVPRPiAhErXlXxmAlVdIkqfvoPgZ1Mj9gIZOWMYwsPabdZSKhx1MVWnrCzmBsBD1/Sa9UD9y7HDroop9Cj83J0yq5tkvQ5jFAU5auxVqlmExdQRP9ZL7ajzVURX3j41zVz2uR/55ynRQWmNx4qP6qJwWVqf0KLBWnU2ZFylDKnkleXQWqMsNu5RtsG2rEmcTVOoF/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213575>

Since 34110cd (Make 'unpack_trees()' have a separate source and
destination index, 2008-03-06), the index no longer gets clobbered by
do_diff_cache() and we can remove the code for discarding and
re-reading it.

There are two paths to update_index_refresh() from cmd_reset(), but on
both paths, either read_cache() or read_cache_unmerged() will have
been called, so the call to read_cache() in this method is redundant
(although practically free).

This speeds up "git reset -- ." a little on the linux-2.6 repo (best
of five, warm cache):

        Before      After
real    0m0.093s    0m0.080s
user    0m0.040s    0m0.020s
sys     0m0.050s    0m0.050s

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 915cc9f..8cc7c72 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -126,9 +126,6 @@ static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
 		fd = hold_locked_index(index_lock, 1);
 	}
 
-	if (read_cache() < 0)
-		return error(_("Could not read index"));
-
 	result = refresh_index(&the_index, (flags), NULL, NULL,
 			       _("Unstaged changes after reset:")) ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
@@ -141,12 +138,6 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
-	int *discard_flag = data;
-
-	/* do_diff_cache() mangled the index */
-	discard_cache();
-	*discard_flag = 1;
-	read_cache();
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
@@ -179,17 +170,15 @@ static int read_from_tree(const char *prefix, const char **argv,
 		unsigned char *tree_sha1, int refresh_flags)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int index_fd, index_was_discarded = 0;
+	int index_fd;
 	struct diff_options opt;
 
 	memset(&opt, 0, sizeof(opt));
 	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
-	opt.format_callback_data = &index_was_discarded;
 
 	index_fd = hold_locked_index(lock, 1);
-	index_was_discarded = 0;
 	read_cache();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
@@ -197,9 +186,6 @@ static int read_from_tree(const char *prefix, const char **argv,
 	diff_flush(&opt);
 	diff_tree_release_paths(&opt);
 
-	if (!index_was_discarded)
-		/* The index is still clobbered from do_diff_cache() */
-		discard_cache();
 	return update_index_refresh(index_fd, lock, refresh_flags);
 }
 
-- 
1.8.1.1.454.gce43f05
