From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 5/6] rebase: use update_ref
Date: Tue, 28 Jul 2015 14:12:23 -0400
Message-ID: <1438107144-24293-6-git-send-email-dturner@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9N4-0004nU-6W
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbbG1SMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:12:51 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35722 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbbG1SMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:49 -0400
Received: by qgii95 with SMTP id i95so79988127qgi.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0M4ry7KKdPSfQ3BtgwdETgS/3oXt43QEe1QydyT5mdk=;
        b=JXpRGQJZJHKR8u6nWTwqUr9WC9ytK+DcyS6OUzNzgJUa6mLeWIXN7eVZdQt2j+n/SV
         qV6Ewx7s0bULR/7bC9MRpKaHpMqSHOg7FTegi2orwYhaigbnMpncdi05INgmHkQ/D4Uv
         0BjlQsAAlfDhO/SftBKannsDz7JNDq7G8d5dqKnlL9DYKPIC594GDjD0jf3Nj44sHvCY
         DwqK/LgrY+p1qe571YZ8ndB8FcH4ZFLMQKcVfAoFiAeUQNMd5yY6O6l2mCPbdtmsm7cS
         +b2ivjEKOryxeLFUVl9N5VyiHkAjx5I69dJwD7tJr0lcsPqJuhJu2Ax3Vjm7mbQqS2f8
         jpcA==
X-Gm-Message-State: ALoCoQmWbJLd9SrTg3PMwJRi8+qIb/MK5oX4oRJf9k9wq1g+w/8i8VsSh2iFfGKShWwz07pIMOWs
X-Received: by 10.140.20.115 with SMTP id 106mr51214162qgi.87.1438107168660;
        Tue, 28 Jul 2015 11:12:48 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274804>

Instead of manually writing a pseudoref (in one case) and shelling out
to git update-ref (in another), use the update_ref function.  This
is much simpler.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 bisect.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/bisect.c b/bisect.c
index 857cf59..33ac88d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -19,7 +19,6 @@ static struct object_id *current_bad_oid;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
-static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
 
 static const char *term_bad;
 static const char *term_good;
@@ -675,34 +674,16 @@ static int is_expected_rev(const struct object_id *oid)
 	return res;
 }
 
-static void mark_expected_rev(char *bisect_rev_hex)
-{
-	int len = strlen(bisect_rev_hex);
-	const char *filename = git_path("BISECT_EXPECTED_REV");
-	int fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-
-	if (fd < 0)
-		die_errno("could not create file '%s'", filename);
-
-	bisect_rev_hex[len] = '\n';
-	write_or_die(fd, bisect_rev_hex, len + 1);
-	bisect_rev_hex[len] = '\0';
-
-	if (close(fd) < 0)
-		die("closing file %s: %s", filename, strerror(errno));
-}
-
-static int bisect_checkout(char *bisect_rev_hex, int no_checkout)
+static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
 {
+	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
-	mark_expected_rev(bisect_rev_hex);
+	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
+	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	argv_checkout[2] = bisect_rev_hex;
 	if (no_checkout) {
-		argv_update_ref[3] = bisect_rev_hex;
-		if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
-			die("update-ref --no-deref HEAD failed on %s",
-			    bisect_rev_hex);
+		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
@@ -804,7 +785,7 @@ static void check_merge_bases(int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
-			exit(bisect_checkout(sha1_to_hex(mb), no_checkout));
+			exit(bisect_checkout(mb, no_checkout));
 		}
 	}
 
@@ -948,7 +929,6 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
-	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -986,11 +966,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	}
 
 	bisect_rev = revs.commits->item->object.sha1;
-	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first %s commit\n", bisect_rev_hex,
+		printf("%s is the first %s commit\n", sha1_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
@@ -1003,7 +982,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
 
-	return bisect_checkout(bisect_rev_hex, no_checkout);
+	return bisect_checkout(bisect_rev, no_checkout);
 }
 
 static inline int log2i(int n)
-- 
2.0.4.315.gad8727a-twtrsrc
