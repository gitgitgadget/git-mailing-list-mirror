From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/10] bisect: add "check_good_are_ancestors_of_bad" function
Date: Sat, 09 May 2009 17:55:46 +0200
Message-ID: <20090509155548.5387.30838.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:05:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p2f-0006Vt-OP
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbZEIQEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbZEIQD5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:57 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:60686 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbZEIQDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:41 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DCFF9E08117;
	Sat,  9 May 2009 18:03:36 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DFC7FE08169;
	Sat,  9 May 2009 18:03:33 +0200 (CEST)
X-git-sha1: bbc2393167c2b641322bdc6f40151feaeaca0b6e 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118668>

This is a port of the function with the same name that is in
"git-bisect.sh". The new function is not used yet but will be in
a later patch.

We also implement an helper "check_ancestors" function that use
"start_command" and "finish_command" to launch
"git rev-list $good ^$bad".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/bisect.c b/bisect.c
index b24ee78..09102da 100644
--- a/bisect.c
+++ b/bisect.c
@@ -751,6 +751,81 @@ static void check_merge_bases(void)
 }
 
 /*
+ * This function runs the command "git rev-list $_good ^$_bad"
+ * and returns 1 if it produces some output, 0 otherwise.
+ */
+static int check_ancestors(void)
+{
+	struct argv_array rev_argv = { NULL, 0, 0 };
+	struct strbuf str = STRBUF_INIT;
+	int i, result = 0;
+	struct child_process rls;
+	FILE *rls_fout;
+
+	argv_array_push(&rev_argv, xstrdup("rev-list"));
+	argv_array_push_sha1(&rev_argv, current_bad_sha1, "^%s");
+	for (i = 0; i < good_revs.sha1_nr; i++)
+		argv_array_push_sha1(&rev_argv, good_revs.sha1[i], "%s");
+	argv_array_push(&rev_argv, NULL);
+
+	memset(&rls, 0, sizeof(rls));
+	rls.argv = rev_argv.argv;
+	rls.out = -1;
+	rls.git_cmd = 1;
+	if (start_command(&rls))
+		die("Could not launch 'git rev-list' command.");
+	rls_fout = fdopen(rls.out, "r");
+	while (strbuf_getline(&str, rls_fout, '\n') != EOF) {
+		strbuf_trim(&str);
+		if (*str.buf) {
+			result = 1;
+			break;
+		}
+	}
+	fclose(rls_fout);
+	finish_command(&rls);
+
+	return result;
+}
+
+/*
+ * "check_good_are_ancestors_of_bad" checks that all "good" revs are
+ * ancestor of the "bad" rev.
+ *
+ * If that's not the case, we need to check the merge bases.
+ * If a merge base must be tested by the user, its source code will be
+ * checked out to be tested by the user and we will exit.
+ */
+static void check_good_are_ancestors_of_bad(const char *prefix)
+{
+	const char *filename = git_path("BISECT_ANCESTORS_OK");
+	struct stat st;
+	int fd;
+
+	if (!current_bad_sha1)
+		die("a bad revision is needed");
+
+	/* Check if file BISECT_ANCESTORS_OK exists. */
+	if (!stat(filename, &st) && S_ISREG(st.st_mode))
+		return;
+
+	/* Bisecting with no good rev is ok. */
+	if (good_revs.sha1_nr == 0)
+		return;
+
+	if (check_ancestors())
+		check_merge_bases();
+
+	/* Create file BISECT_ANCESTORS_OK. */
+	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+	if (fd < 0)
+		warning("could not create file '%s': %s",
+			filename, strerror(errno));
+	else
+		close(fd);
+}
+
+/*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
-- 
1.6.3.rc1.112.g17e25
