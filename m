From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 01/19] reset $pathspec: no need to discard index
Date: Wed,  9 Jan 2013 00:15:58 -0800
Message-ID: <1357719376-16406-2-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqvl-0008Iw-1E
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab3AIIRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:23 -0500
Received: from mail-we0-f202.google.com ([74.125.82.202]:60565 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340Ab3AIIRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:06 -0500
Received: by mail-we0-f202.google.com with SMTP id t57so91463wey.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=dgPL0sQmubnit8I01xnHjNsaOckY8rUGhI7WVgWj3ms=;
        b=IyxUS5PSA7jz6DNCb+xKBhDFtydLl/lNpLcMCXivLAzvXk7JthfHVmq/kTJuTVw1AN
         PTV+GPttMMRMRiP5o0Jil080nHv9yj+0ElEcK9k6ht+zoe06z3Hwv7qC0p4Eu2kGKRNT
         YQGDvLUW1ovGvvCsd5mclaubZfuNdpBNqioXnRT2KAQeIzpDcwKZbjWm1QJYjWRQCtw5
         mzGjS9FAQN+aUdFUnjb/ZYqZBZxnZuDAX2wV4Kqz//cm6k05Bz+tJUI719zRQTchcIng
         vYq4vdUWdNgsRFuRzyAsiyuM04+YR3jNfyYZryQJlEIpqMS1piMJ29zbZB7qfuWyIiRV
         CZVA==
X-Received: by 10.14.205.194 with SMTP id j42mr83812735eeo.2.1357719424825;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z44si25287493een.0.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 5FC38200059;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id BD8BE102B64; Wed,  9 Jan 2013 00:17:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkw8Q6HLtzIs+sLbSYFRHmejfCY9JoNQsGBCObGnYUV7mgdKwWVIdO8A3daI5jZAVM8zwx6NwLd628jqrEgB5vygha03AukFMzkeeBfmW1txlTv9y+QbtXY2rRT9KhbuFLWaw+cJlfgp+o8Hm+b0j6fXvbiV6Jy/ix7nlx7IVq+iR7WesIS4YNjyDL4vphlWZ/eoHJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213039>

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
1.8.1.rc3.331.g1ef2165
