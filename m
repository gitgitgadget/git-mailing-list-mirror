From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 13/19] commit.c: use ref transactions for updates
Date: Fri, 25 Apr 2014 09:14:48 -0700
Message-ID: <1398442494-23438-14-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdioH-00015Z-Ay
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbaDYQQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:39 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:40323 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbaDYQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:07 -0400
Received: by mail-qg0-f74.google.com with SMTP id a108so210059qge.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EhwPrMyVFsY03KPGZ5ARHr7G6XUBbEssLTIQmWL6ZDE=;
        b=daLJRbldxISsoR5Htm8NX9FzEZ/YUjeO0UdWkKf9pMhcIhlbE042RFjGCUirWFt6Rr
         LkTqxjIRWlW+RDvD2O2IBzMcztpibtbw8KQ2I9aXSoFlt9V8fyRk8UW6zgEzl0ND6KH4
         UooMDA+9q2pPqoTPimzWD/i7xLYooB+S6tAOzWtsNqia+Wb39ZfZfQv6ykQWaT6LsSCf
         SciPtMR8V5vCCS2169P9GTGlKSWyOceEIdGytlZsgcEibl2+dE4MNCnkVRYFIYFClLNa
         ZXoMINtHJMtiMA64WZeTNNQP8okDqMjlH0IZQfbwgmuk7icyA4EGI/w7/zIh81XA5Gyu
         GHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EhwPrMyVFsY03KPGZ5ARHr7G6XUBbEssLTIQmWL6ZDE=;
        b=imP0TbobgJAa+3ynJHK9LHHHxXAeh3m4hU0EiZIKrbET7eFmj0Z7c85hlKH9EBbHAS
         QyxGUVPSEkWI2XZv8mb/IcB64wrHCX4ynomz2SbdEDsCrlQ4AohuMUs7eXUtzXy1qxYG
         JtWlblK3WZFRRH/a6brj1J6e9PI9G392vmfKgJ3RjK/nmRPwpb345/h7yfvn3ry9ZWGM
         /I1h2jf+xqfwjpHRN6fOmobmUx/uXAwY1NDlWeLjFKuxGi5UPfddHsYDNWhxqTIFsUOE
         wbn5XT8T8hIjbDrDIesjRAaaGLHOVRrzdQ9AMIC8GiVW3Rv3BCP6AqZ4W4uJamLzPVO3
         hsYQ==
X-Gm-Message-State: ALoCoQlulLX20ENBVt36Sjf1nM1rsWCSWSjlqSKN/0SHgjQtBYNNWvPWQbKrvcYEDvkdUOUTtHlin/zZRZXfylXAyS6ssjgslk8gf5R4IDib2BJD6tShPD2N3UiY62wuoq0TWD9M8qrsUdyDPxgprYDvghxsCAJeMSWFIxltE3xwBaXvRta/SHe2bGCV9Xvn9ZtSeETsOmM6
X-Received: by 10.58.141.200 with SMTP id rq8mr5029303veb.31.1398442505947;
        Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r61si1051915yhf.1.2014.04.25.09.15.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C6BBC5A4211;
	Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7D69DE0855; Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247065>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..7e4c306 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1541,11 +1541,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
+	char *err = NULL;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1667,12 +1668,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1681,13 +1676,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ? 
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die(_("HEAD: cannot update ref: %s"), err);
 	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
-- 
1.9.1.521.g5dc89fa
