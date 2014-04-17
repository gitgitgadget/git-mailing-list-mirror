From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/11] branch.c: use ref transaction for all ref updates
Date: Thu, 17 Apr 2014 12:46:26 -0700
Message-ID: <1397763987-4453-11-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasHm-0005E4-T0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbaDQTre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:47:34 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:36612 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaDQTqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:43 -0400
Received: by mail-ig0-f202.google.com with SMTP id uq10so85359igb.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vyN2WqFJhSBM4W+lGQGUoB+mkRvmy2TkimT4SA+KiC0=;
        b=kAiqhPUhY4gc8g0OHyeK4frh1Qq/NSV+b6D8b5sIo3JghU5miwIbBPAGzzzJPaiES1
         5svVreEY3TwwYQ6FyG0PjEljs7evBDNKAnJ3qKvOHGuMwKP4yEcg3VrWpHkWetnhadVX
         hbu40y1U9lYuQF7fuR4GSjZEnMScHKSJv/oT+jnkFqjTM0VBwXOCK80Z9nrAt5RVwRLg
         vI0Pd0HVt6RwejXZYx5hhrh0tz/HLvMuO6WJEFMJN01E+zy+j5OLTI6051xp8fhK2Ncc
         0a7/ZUOd4CUxQmLRfkm/lTporpOUHLIoqlpZuR36yFndc1TvCZuQy4s1V1RYHUz2UWMa
         PvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vyN2WqFJhSBM4W+lGQGUoB+mkRvmy2TkimT4SA+KiC0=;
        b=hsIQKbsaaYkvYZGCnpKun1zP+CEHTtrWzLJhIv6RBI8Ib6oXx6DaPKW8ZM80b87TxT
         ImKO0lE6GcLAGvGX3p6+6CuJrAiUXNrCgp0zd1BQZ1bU0653IYIiTyhN5BJ0rJ6YIuYl
         LOd1E7Ny37OWS4lAeS9hOAT9F1rpqKpy8obknYldT93XEub8EmqJNCNTBUjOBBzRXTyl
         xIFFZON6ygGQdnSSxD5cP31NaVPmD4501X1bnbPhuE6gniL97UQ+fdtJhvMM/8luQaIb
         kdkGWd7TajLUryhwpNn6auVadkkH2o+OYICTHy13kIErdYcCW2hUzZwDR33lEdYi6XyP
         8UOw==
X-Gm-Message-State: ALoCoQkO7zLC32LNgWkvsjU8lKQnbAao8FzLF79AXJLf3j3nSomIPfSkjTR/wZz3k89DNK72T0Se6eXIfWzuwoIvbKTSgqn2LV6/II1KmIkdFZze455GTibjJ20oXBB15zvZZvxXXbQ4Z/CHfvUqDUH9gqFBrUxCbQy0JvLPHo07R5B0/SlHiULfk+R563G3psYDqJt0ySKi
X-Received: by 10.43.75.198 with SMTP id zb6mr5626192icb.22.1397764002660;
        Thu, 17 Apr 2014 12:46:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id s65si3654804yhc.2.2014.04.17.12.46.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7D19331C20C;
	Thu, 17 Apr 2014 12:46:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 41D5DE0967; Thu, 17 Apr 2014 12:46:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246446>

Change branch.c to use ref transactions when doing updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..45c7766 100644
--- a/branch.c
+++ b/branch.c
@@ -226,7 +226,7 @@ void create_branch(const char *head,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
-	struct ref_lock *lock = NULL;
+	struct ref_transaction *transaction;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
@@ -286,9 +286,12 @@ void create_branch(const char *head,
 	hashcpy(sha1, commit->object.sha1);
 
 	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
-		if (!lock)
-			die_errno(_("Failed to lock ref for update"));
+		transaction = ref_transaction_begin();
+		if (!transaction)
+			die_errno(_("Failed to begin transaction"));
+		if (ref_transaction_update(transaction, ref.buf, sha1, NULL,
+				   0, 0))
+			die_errno(_("Failed to update transaction"));
 	}
 
 	if (reflog)
@@ -305,8 +308,9 @@ void create_branch(const char *head,
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno(_("Failed to write ref"));
+		if (ref_transaction_commit(transaction, msg,
+				     UPDATE_REFS_DIE_ON_ERR))
+			die_errno(_("Failed to commit transaction"));
 
 	strbuf_release(&ref);
 	free(real_ref);
-- 
1.9.1.513.gd486896
