From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 03/19] reset.c: pass pathspec around instead of (prefix, argv) pair
Date: Wed,  9 Jan 2013 00:16:00 -0800
Message-ID: <1357719376-16406-4-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsqyR-0003Bu-AV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410Ab3AIIYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:24:55 -0500
Received: from mail-ee0-f74.google.com ([74.125.83.74]:38000 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab3AIIYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:24:39 -0500
Received: by mail-ee0-f74.google.com with SMTP id t10so92272eei.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=xTqkXb+bmAwqNSmmJKSF63qHhgjMRK0NBOxgvxCIMSw=;
        b=jrPKVhdcETwkI+fP+D8g3v97NnJFgZDZHS8rvIGbqQQHffkjROUTvkhZ8yPspBUXWZ
         5hF2jUgZwKiK+FaAg5ctZFhTkwcam04bE/s+Tt7v/ZuoZTUgQL6U5DN1WutSlMy2Prlr
         r6WqV0VLfFv8HSWxMSCQMBfuF/kQO19a94+bMFCiuS6k3ukeCYjsgcNVQC8lMmPSZWYB
         zYMV0EuKnLFPQkfiZ62oqbZe8zZqsK6vOzouJepaCTIsDg3wCR/dgEzg1dqNmMascLWH
         uNggKSZca3Ggvc4w8kwYLF35F8a1EWIgZXFuJnpS407664FvcSvaz218TVsDqNMU5jeZ
         23Tg==
X-Received: by 10.14.208.198 with SMTP id q46mr83817185eeo.0.1357719424982;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si11043509eeo.1.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 852BA200061;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id DA93D102C3C; Wed,  9 Jan 2013 00:17:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmvT9i3pTjN0WM8gnWfd+8ISogoGwthJ3OlrEXa2H0aVoek2dNHU26LlVmr3VBk4eVA6EiKzINAu+aOF8iaJ8TXxBbYH7ggSTnh6OTJI0eAWFDKnUEBjadixiFk9IgPLySxH8DRDFamfeUBHi1jRJEV3Vw8rzKnDrVATuAr3ieZkKtGhxOJOLYWma32MnZX9v80zFzn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213047>

We use the path arguments in two places in reset.c: in
interactive_reset() and read_from_tree(). Both of these call
get_pathspec(), so we pass the (prefix, arv) pair to both
functions. Move the call to get_pathspec() out of these methods, for
two reasons: 1) One argument is simpler than two. 2) It lets us use
the (arguably clearer) "if (pathspec)" in place of "if (i < argc)".
---
If I understand correctly, this should be rebased on top of
nd/parse-pathspec. Please let me know.

 builtin/reset.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 65413d0..045c960 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -153,26 +153,15 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
-static int interactive_reset(const char *revision, const char **argv,
-			     const char *prefix)
-{
-	const char **pathspec = NULL;
-
-	if (*argv)
-		pathspec = get_pathspec(prefix, argv);
-
-	return run_add_interactive(revision, "--patch=reset", pathspec);
-}
-
-static int read_from_tree(const char *prefix, const char **argv,
-		unsigned char *tree_sha1, int refresh_flags)
+static int read_from_tree(const char **pathspec, unsigned char *tree_sha1,
+			  int refresh_flags)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd;
 	struct diff_options opt;
 
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
+	diff_tree_setup_paths(pathspec, &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 
@@ -216,6 +205,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
+	const char **pathspec = NULL;
 	struct commit *commit;
 	struct strbuf msg = STRBUF_INIT;
 	const struct option options[] = {
@@ -287,22 +277,25 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("Could not parse object '%s'."), rev);
 	hashcpy(sha1, commit->object.sha1);
 
+	if (i < argc)
+		pathspec = get_pathspec(prefix, argv + i);
+
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return interactive_reset(rev, argv + i, prefix);
+		return run_add_interactive(rev, "--patch=reset", pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
-	if (i < argc) {
+	if (pathspec) {
 		if (reset_type == MIXED)
 			warning(_("--mixed with paths is deprecated; use 'git reset -- <paths>' instead."));
 		else if (reset_type != NONE)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
-		return read_from_tree(prefix, argv + i, sha1,
+		return read_from_tree(pathspec, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 	if (reset_type == NONE)
-- 
1.8.1.rc3.331.g1ef2165
