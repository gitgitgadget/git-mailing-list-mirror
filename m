From: David Turner <dturner@twopensource.com>
Subject: [PATCH 8/9] rebase: use write_pseudoref
Date: Fri, 24 Jul 2015 00:45:28 -0400
Message-ID: <1437713129-19373-9-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUsA-0003xD-1C
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbGXEqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:46:10 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36234 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbGXEp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:58 -0400
Received: by qkdv3 with SMTP id v3so8126238qkd.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZoxYUpIdLVc3dMj5scnwwBw79S3Llb1FUkxZ4YN67I=;
        b=BpfKdpja5ybLQPCGW265KVkhJsh6fuDI0mpJZ04iWA5cJyDP/Ju94hZJV4fpZdgbcm
         ArVoDyWbKRHf0J+0BSr/zYuSe2Mv2sZC5bdn0YcvAAUdrGHUnnKjMvhT/sQuyq/09sN0
         EH3AtqhFfJ6HGjIQE4vbh5FFUqsW18kxNgiTiheKqcDMwDk2f60VTPboYIW3RwmoLIhP
         NJrzIIeDHMUbqmRfy/yFCSacEw0PfMhvewht/pBCQpRFaDpo5GOF+XLZMaxsf6RXObB4
         5P6NI3MDGhAzso0DNI3SuVDXgyo++JLW3yp0gT9jkvMOTM5tTerF/7VSCZdOmsWYpDIA
         mzkg==
X-Gm-Message-State: ALoCoQkmkCs3pL/ndjK4AaRZe4aSKRJy96ENI+b+Dg2oqBNQZA5TFHhV4wsi5T92GsC1wQmCK11Q
X-Received: by 10.140.201.141 with SMTP id w135mr15833752qha.0.1437713157747;
        Thu, 23 Jul 2015 21:45:57 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274548>

Instead of manually writing a pseudoref (in one case) and using git
update-ref (in another), use the new write_pseudoref function.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 bisect.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/bisect.c b/bisect.c
index 857cf59..3a9fd63 100644
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
+	write_pseudoref("BISECT_EXPECTED_REV", bisect_rev, NULL);
 
 	argv_checkout[2] = bisect_rev_hex;
 	if (no_checkout) {
-		argv_update_ref[3] = bisect_rev_hex;
-		if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
-			die("update-ref --no-deref HEAD failed on %s",
-			    bisect_rev_hex);
+		write_pseudoref("BISECT_HEAD", bisect_rev, NULL);
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
@@ -986,7 +966,6 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	}
 
 	bisect_rev = revs.commits->item->object.sha1;
-	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
@@ -1003,7 +982,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
 
-	return bisect_checkout(bisect_rev_hex, no_checkout);
+	return bisect_checkout(bisect_rev, no_checkout);
 }
 
 static inline int log2i(int n)
-- 
2.0.4.315.gad8727a-twtrsrc
