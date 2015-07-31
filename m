From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 4/5] bisect: use update_ref
Date: Fri, 31 Jul 2015 02:06:20 -0400
Message-ID: <1438322781-21181-4-git-send-email-dturner@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 08:06:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL3Ss-0002GR-2I
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 08:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbGaGGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 02:06:34 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36319 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbGaGGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 02:06:33 -0400
Received: by qkdv3 with SMTP id v3so25943769qkd.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 23:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0M4ry7KKdPSfQ3BtgwdETgS/3oXt43QEe1QydyT5mdk=;
        b=SRYQk9GOffcmjAqVKh2ujytcexBaG/PSZQgBN4vxxyqiLeCmRe97x8Uc/JMOOEsACF
         4KapK2bJGdudqyRDFMPjK5QUFjjM4nbkFniUV1ldD18TPNqiuHk1lqBo8lFWSx5aZT6w
         vp3LVb5H9TsR+c7KzsNc+Vur9k//sj5hFuVGCIzYdwJhpLuMhgxa5ltA5IpNbiq/5NqQ
         Ee0mapJg3tE3PEx8TZiYHow+bTI6yuNJJ5iBP3Afp1lByYLbqnEuCRAFSbT63TUQqxEG
         9UVHZgC46U6lmKRoNLMLG+W1JII+GhVAZ5MDcDwTUYLD4OYHZGa60n0X1M1aWbghHFCj
         KGjQ==
X-Gm-Message-State: ALoCoQmmlfjpPvC73yBUJlGS1/AXetGsyH3drPM4zpctONKXx9TfXTL1YK/hLPQUTDf2WnJi1ekL
X-Received: by 10.55.21.14 with SMTP id f14mr1633147qkh.64.1438322792403;
        Thu, 30 Jul 2015 23:06:32 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c35sm1737073qgc.47.2015.07.30.23.06.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 23:06:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275039>

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
