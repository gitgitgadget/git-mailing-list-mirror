From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 13/19] reset.c: move lock, write and commit out of update_index_refresh()
Date: Wed,  9 Jan 2013 00:16:10 -0800
Message-ID: <1357719376-16406-14-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:22:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqw5-0000Gr-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251Ab3AIIRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:20 -0500
Received: from mail-qa0-f74.google.com ([209.85.216.74]:59638 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360Ab3AIIRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:07 -0500
Received: by mail-qa0-f74.google.com with SMTP id r4so87458qaq.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=pEzdqFP7/d4nnrmpu8EqnxjteXFBOSDDLyHn/alGpW8=;
        b=f16v3aORtxVgMWJBK7ndvMnqhb+KBTWCGc+tpcY5SXSCUW2e0u3lzuxJFcBD4NIeew
         +qfBHN5+mKxjzLRPezaklT0XA62ICw1Q+icRJHO4cDndkHqkwsP19EqLbRRw0vC8hg9H
         UnZxIovksav+tnctcVK2QqZGSIkYwWVNnwEczvl09u5r/oSGx+XJ4O0eSWP05AqRLIiA
         eMlVSAT3wQZpSUHjXQUQ0vmiwwMS16jkorYfCSrcVBYyjhnwLyCRzGzSJN0Z6iwxeILD
         DolzXv7EpsOZgQGUxHMwvZS4b7G2uoq9uXhFPBZ3qgThSwyp1m6kM/vIUzRsMjwx3kFC
         EOVA==
X-Received: by 10.236.158.168 with SMTP id q28mr36981821yhk.20.1357719424972;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i63si5738057yhk.5.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id D9826820055;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 6202E103085; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQl0BpkvjZZYtZUzoy9Eso3OWwEFyGgnJSIzCKgQrMd3e9fSFB3wELwtOpGy89LLsaNuc5tigLIEwsOjOl54/pCyzvNPUfVASMkKAULIUrjP9w/I8xBXdde6hCg69nzXIyOM+UL7R6Pv1+y9LdCl9cFt+rgoJQbfr/NgZ/ilAq41G40ggqnX85Pw0XlQTzQftfW9f2sU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213040>

In preparation for the/a following patch, move the locking, writing
and committing of the index file out of update_index_refresh(). The
code duplication caused will soon be taken care of. What remains of
update_index_refresh() is just one line, but it is still called from
two places, so let's leave it for now.

In the process, we expose and fix the minor UI bug that makes us print
"Could not refresh index" when we fail to write the index file when
invoked with a pathspec. Copy the error message from the pathspec-less
codepath ("Could not write new index file.").
---
 builtin/reset.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index a21ba31..2243b95 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -109,19 +109,10 @@ static void print_new_head_line(struct commit *commit)
 		printf("\n");
 }
 
-static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
+static void update_index_refresh(int flags)
 {
-	if (!index_lock) {
-		index_lock = xcalloc(1, sizeof(struct lock_file));
-		fd = hold_locked_index(index_lock, 1);
-	}
-
 	refresh_index(&the_index, (flags), NULL, NULL,
 		      _("Unstaged changes after reset:"));
-	if (write_cache(fd, active_cache, active_nr) ||
-			commit_locked_index(index_lock))
-		return error ("Could not refresh index");
-	return 0;
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
@@ -320,9 +311,14 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (pathspec) {
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int index_fd = hold_locked_index(lock, 1);
-		return read_from_tree(pathspec, sha1) ||
-			update_index_refresh(index_fd, lock,
-					quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+		if (read_from_tree(pathspec, sha1))
+			return 1;
+		update_index_refresh(
+			quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+		if (write_cache(index_fd, active_cache, active_nr) ||
+		    commit_locked_index(lock))
+			return error("Could not write new index file.");
+		return 0;
 	}
 
 	/* Soft reset does not touch the index file nor the working tree
@@ -350,9 +346,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (reset_type == HARD && !update_ref_status && !quiet)
 		print_new_head_line(commit);
-	else if (reset_type == MIXED) /* Report what has not been updated. */
-		update_index_refresh(0, NULL,
-				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+	else if (reset_type == MIXED) { /* Report what has not been updated. */
+		struct lock_file *index_lock = xcalloc(1, sizeof(struct lock_file));
+		int fd = hold_locked_index(index_lock, 1);
+		update_index_refresh(
+			quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+		if (write_cache(fd, active_cache, active_nr) ||
+		    commit_locked_index(index_lock))
+			error("Could not refresh index");
+	}
 
 	remove_branch_state();
 
-- 
1.8.1.rc3.331.g1ef2165
