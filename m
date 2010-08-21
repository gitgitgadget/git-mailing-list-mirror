From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] git-format-patch: Print a diagnostic message when ignoring commits
Date: Sun, 22 Aug 2010 01:58:50 +0530
Message-ID: <1282422531-29673-2-git-send-email-artagnon@gmail.com>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 22:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omuik-0000GE-0S
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616Ab0HUUbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:31:03 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44165 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0HUUbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:31:01 -0400
Received: by pzk26 with SMTP id 26so1745996pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XNGZJAKG4gZixXn9iR+C2mqvjCKCiY0PizP2vA/tkRY=;
        b=RCVIoLszN2jxfCIqG42GM2Yzb/mDwqEjWCY8z6uhcWire1snaLQCd/a8trwFv52+OM
         W19pfcrHS1No1xGK9ORvliHzc5Qdl1JIoeovs3hKWSV4zCl9etNJcOL6kJ5qAQwl4vj8
         TdR1EHhlvFWxikdBY236v9+oYpRT636hsoSR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EDqgvqC0/GWc1vw8y/HuDppVg4hxnie2lXmQTnZnU/Dna5E2uCL7ZY86ozaJGyrXQ4
         lr3zLwuiP8UWBnmjJfqF3Dr+fNAr/PLISOp3CiNZRC/1ivsK/GSLwG2X+Zd+Xt457Jpb
         2II6TvuJqDVri6N7krrs68UN8W2IAH9bae6/w=
Received: by 10.114.121.16 with SMTP id t16mr3435207wac.169.1282422660720;
        Sat, 21 Aug 2010 13:31:00 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm8096273waa.9.2010.08.21.13.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 13:30:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154158>

Earlier, git-format-patch used to silently skip over commits that it
didn't intend to make patches out of. As a consequence, a command like
'git-format-patch -3' would just do nothing and print nothing if the
topmost three commits were merge commits. Instead, print a useful
message similar to "Skipping: Merge branch ..." when ignoring a
commit.

Suggested-by: Jakub Narebski <jnareb@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/log.c |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0151d2f..b64de7c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1090,7 +1090,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct commit **list = NULL;
 	struct rev_info rev;
 	struct setup_revision_opt s_r_opt;
-	int nr = 0, total, i;
+	int nr = 0, nr_i = 0, total, i;
 	int use_stdout = 0;
 	int start_number = -1;
 	int numbered_files = 0;		/* _just_ numbers */
@@ -1098,6 +1098,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
+	int *list_i = NULL;
 	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -1342,19 +1343,22 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
-		if (ignore_if_in_upstream &&
-				has_commit_patch_id(commit, &ids))
-			continue;
+		/* ignore merge commits and optionally ignore commits
+		   already in upstream */
+		if ((commit->parents && commit->parents->next) ||
+		    (ignore_if_in_upstream &&
+		     has_commit_patch_id(commit, &ids))) {
+			/* Store the nr of the ignored commits in list_i */
+			nr_i++;
+			list_i = xrealloc(list_i, nr_i * sizeof(list_i[0]));
+			list_i[nr_i - 1] = nr;
+		}
 
 		nr++;
 		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
 	}
-	total = nr;
+	total = nr - nr_i;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
@@ -1376,10 +1380,25 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		start_number--;
 	}
 	rev.add_signoff = add_signoff;
-	while (0 <= --nr) {
+	for (i = nr - nr_i; --nr >= 0;) {
 		int shown;
 		commit = list[nr];
-		rev.nr = total - nr + (start_number - 1);
+
+		/* Ignore commits in list whose index is list_i */
+		if (list_i[nr_i - 1] == nr) {
+			struct strbuf commit_msg = STRBUF_INIT;
+			struct pretty_print_context ctx = {0};
+			format_commit_message(commit, "%s", &commit_msg, &ctx);
+			fprintf(realstdout, "Skipping: %s\n",
+				commit_msg.buf);
+			strbuf_release(&buf);
+			--nr_i;
+			continue;
+		}
+		else
+			--i;
+
+		rev.nr = total - i + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
 		if (thread) {
 			/* Have we already had a message ID? */
@@ -1443,6 +1462,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fclose(stdout);
 	}
 	free(list);
+	free(list_i);
 	string_list_clear(&extra_to, 0);
 	string_list_clear(&extra_cc, 0);
 	string_list_clear(&extra_hdr, 0);
-- 
1.7.2.2.409.gdbb11.dirty
