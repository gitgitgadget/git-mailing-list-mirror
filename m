From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 3/6] merge-base: split handle_fork_point to make reuse easier
Date: Wed,  6 May 2015 01:00:50 +0100
Message-ID: <1430870453-5408-4-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:01:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmlv-0004Wn-89
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbbEFABB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:01:01 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36626 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbEFAAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:53 -0400
Received: by wgiu9 with SMTP id u9so37097743wgi.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L2pG9MfDJvmGz9s0avIwzyfrg24ycMuKsFHuwsg2NwA=;
        b=LFWuFavobLrVGuL097WrPnRzhFxqHg57Ty/j3vuHpRAHgkk2nSPJxR/FvRydxLTLOW
         t2ZQk4e5sy0oROGOKWOebdJV7t1Ylvz8f7kkEMgIzw4ea3OjrtNalHpM5x6OfjsH9pzb
         zERPHhqOc3fXcGbmdHjXw39Tn/k8Z202ASnVarEEtOyvaRF5OK4QZ7J1YIwtjbsbthY/
         YOfTuCF3yd59QASOrGig1jU4cnITeENLmrIp+j46ttZBJ1G7qh9mVkRkpk8DylH9puAI
         K65CA5k+d3Di4JxGdyn9Ch2/YIrjp7siSPzQmMQrWR6qsoVWsvJca6vz9N6yYAgMtt46
         eYDA==
X-Received: by 10.194.60.43 with SMTP id e11mr57867840wjr.36.1430870452516;
        Tue, 05 May 2015 17:00:52 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id ha4sm439873wib.0.2015.05.05.17.00.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268436>

THIS PATCH SERIES IS NOT CODE-COMPLETE OR FULLY TESTED.
See code comments beginning TODO for work remaining.

Separate function handle_fork_point into one part that deals with command
line arguments, printing error messages and exiting the process, and a
second part that contains only the algorithm.  The later part can be
re-used elsewhere.

Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
---
 builtin.h            |  2 ++
 builtin/merge-base.c | 64 ++++++++++++++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/builtin.h b/builtin.h
index b87df70..d8e0e5a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -27,6 +27,8 @@ extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
+extern const unsigned char *get_fork_point(const char *refname, const unsigned char *derived_sha1);
+
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08a8217..7a22cf1 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -145,30 +145,19 @@ static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int handle_fork_point(int argc, const char **argv)
+const unsigned char *get_fork_point(const char *refname, const unsigned char *derived_sha1)
 {
-	unsigned char sha1[20];
-	char *refname;
-	const char *commitname;
+	/*
+	 * TODO I dislike exporting this function via builtin.h. I would prefer to
+	 * move it to libgit if possible.
+	 */
+	unsigned const char *fork_point_sha1 = null_sha1;
 	struct rev_collect revs;
 	struct commit *derived;
 	struct commit_list *bases;
-	int i, ret = 0;
-
-	switch (dwim_ref(argv[0], strlen(argv[0]), sha1, &refname)) {
-	case 0:
-		die("No such ref: '%s'", argv[0]);
-	case 1:
-		break; /* good */
-	default:
-		die("Ambiguous refname: '%s'", argv[0]);
-	}
-
-	commitname = (argc == 2) ? argv[1] : "HEAD";
-	if (get_sha1(commitname, sha1))
-		die("Not a valid object name: '%s'", commitname);
+	int i;
 
-	derived = lookup_commit_reference(sha1);
+	derived = lookup_commit_reference(derived_sha1);
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
@@ -182,25 +171,50 @@ static int handle_fork_point(int argc, const char **argv)
 	 * There should be one and only one merge base, when we found
 	 * a common ancestor among reflog entries.
 	 */
-	if (!bases || bases->next) {
-		ret = 1;
+	if (!bases || bases->next)
 		goto cleanup_return;
-	}
 
 	/* And the found one must be one of the reflog entries */
 	for (i = 0; i < revs.nr; i++)
 		if (&bases->item->object == &revs.commit[i]->object)
 			break; /* found */
 	if (revs.nr <= i) {
-		ret = 1; /* not found */
+		/* not found */
 		goto cleanup_return;
 	}
 
-	printf("%s\n", sha1_to_hex(bases->item->object.sha1));
+	fork_point_sha1 = bases->item->object.sha1;
 
 cleanup_return:
 	free_commit_list(bases);
-	return ret;
+	return fork_point_sha1;
+}
+
+static int handle_fork_point(int argc, const char **argv)
+{
+	unsigned char sha1[20];
+	char *refname;
+	const char *commitname;
+	const unsigned char *fork_point_sha1;
+
+	switch (dwim_ref(argv[0], strlen(argv[0]), sha1, &refname)) {
+	case 0:
+		die("No such ref: '%s'", argv[0]);
+	case 1:
+		break; /* good */
+	default:
+		die("Ambiguous refname: '%s'", argv[0]);
+	}
+
+	commitname = (argc == 2) ? argv[1] : "HEAD";
+	if (get_sha1(commitname, sha1))
+		die("Not a valid object name: '%s'", commitname);
+
+	fork_point_sha1 = get_fork_point(refname, sha1);
+	if (!is_null_sha1(fork_point_sha1))
+		printf("%s\n", sha1_to_hex(fork_point_sha1));
+
+	return is_null_sha1(fork_point_sha1);
 }
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
-- 
2.4.0.7.gf20f26f
