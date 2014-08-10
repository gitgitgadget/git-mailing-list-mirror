From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 2/2] prepare_revision_walk: Check for return value in all places
Date: Sun, 10 Aug 2014 23:33:26 +0200
Message-ID: <1407706406-30455-2-git-send-email-stefanbeller@gmail.com>
References: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 23:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGakM-0002xi-J0
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 23:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbaHJVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 17:33:36 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51347 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaHJVdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 17:33:35 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so3305461wib.10
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XQB3QlEVgO/h38ymzjs0T3Dj6A/L0L4uoSd2b6WfN1M=;
        b=Y1N0uLtkt64r2mz1r8PMPfuftB/omNm8VpFOAyJaccnLy1umxcCjyLTZoPgD0wtXt1
         fBmqtKvvkOIcCT2j0AOit6AF7g9rrtf7olW5GgmR1rydypbjQNGjoooFy2DW7ZtkZBd9
         J0ZYMJvNsFzHo4ln25jzO9k/9vsK59AeNXPbKrCujWtoBvV98tbCNvEJ/4vgekkr6W1h
         llGVkYCyRIvLTH94WeHGfPNtGD74y0vI0PMh+FlobcRfWQHqeKdmayozXBSn7d2PP8q3
         aC8lrl0UtcI835vQQfLrNoUvrf6yA85BdNFHXVe9cwFEenxPulmFyh9YCCmNZUUAyBkL
         ES5g==
X-Received: by 10.194.71.132 with SMTP id v4mr13470117wju.102.1407706414380;
        Sun, 10 Aug 2014 14:33:34 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id fb12sm34839864wjc.43.2014.08.10.14.33.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 Aug 2014 14:33:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
In-Reply-To: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255109>

Even the documentation tells us:
	You should check if it
	returns any error (non-zero return code) and if it does not, you can
	start using get_revision() to do the iteration.

In preparation for this commit, I grepped all occurrences of
prepare_revision_walk and added error messages, when there were none.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 builtin/branch.c | 4 +++-
 builtin/commit.c | 3 ++-
 remote.c         | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0591b22..ced422b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -653,7 +653,9 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		add_pending_object(&ref_list.revs,
 				   (struct object *) filter, "");
 		ref_list.revs.limited = 1;
-		prepare_revision_walk(&ref_list.revs);
+
+		if (prepare_revision_walk(&ref_list.revs))
+			die(_("revision walk setup failed"));
 		if (verbose)
 			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 7867768..bb84e1d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1055,7 +1055,8 @@ static const char *find_author_by_nickname(const char *name)
 	revs.mailmap = &mailmap;
 	read_mailmap(revs.mailmap, NULL);
 
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
diff --git a/remote.c b/remote.c
index 894db09..112e4d5 100644
--- a/remote.c
+++ b/remote.c
@@ -1893,7 +1893,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 
 	init_revisions(&revs, NULL);
 	setup_revisions(rev_argc, rev_argv, &revs, NULL);
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 
 	/* ... and count the commits on each side. */
 	*num_ours = 0;
-- 
2.1.0.rc2
