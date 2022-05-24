Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA85C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiEXTUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiEXTUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:20:32 -0400
X-Greylist: delayed 19081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 12:20:31 PDT
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727864BCA
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:20:30 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (unknown [69.145.56.143])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id CC9462E78E8B;
        Tue, 24 May 2022 19:20:28 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id 0C061130055D; Tue, 24 May 2022 13:20:17 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v4] setup: don't die if realpath(3) fails on getcwd(3)
Date:   Tue, 24 May 2022 13:20:12 -0600
Message-Id: <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
References: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to Git 2.35.0, git could be run from an inaccessible working
directory so long as the git repository specified by options and/or
environment variables was accessible.  For example:

    git init repo
    mkdir -p a/b
    cd a/b
    chmod u-x ..
    git -C "${PWD%/a/b}/repo" status

If this example seems a bit contrived, consider running with the
repository owner as a substitute UID (e.g. with runuser(1) or sudo(8))
without ensuring the working directory is accessible by that user.

The code added by e6f8861bd4 ("setup: introduce
startup_info->original_cwd") to preserve the working directory attempts
to normalize the path using strbuf_realpath().  If that fails, as in the
case above, it is treated as a fatal error.

This commit treats strbuf_realpath() errors as non-fatal.  If an error
occurs, setup_original_cwd() will continue without applying removal
prevention for cwd, resulting in the pre-2.35.0 behavior.  The risk
should be minimal, since git will not operate on a repository with
inaccessible ancestors, this behavior is only known to occur when cwd is
a descendant of the repository, an ancestor of cwd is inaccessible, and
no ancestors of the repository are inaccessible.

Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---

Changes since v3:
 * Free tmp_original_cwd in both codepaths.
 * Return after strbuf_realpath() fails, rather than jumping to
   no_prevention_needed, to avoid unnecessary free(NULL) and NULL
   reassignment.
 * Invert the condition and remove the else block to match the
   return-on-error code style for better readability.
 * Stop adding "Try" to comment, since strbuf_realpath() hasn't
   been optional since v1.

Changes since v2:
 * Use trace2_data_string(), rather than trace_printf(), to report
   realpath failure.

Changes since v1:
 * Set startup_info->original_cwd = NULL when strbuf_realpath() fails,
   rather than setting it to the un-normalized path.
 * Add a trace message when realpath fails to aid debugging.
 * Remove potential realpath failure cause from comment before it.
 * Improve format for reference to e6f8861bd4 in commit message.
 * Clarify when the pre-2.35.0 behavior may occur as a result of this
   commit in the commit message.
 * Remove 'Fixes:' tag from commit message.

 setup.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index a7b36f3ffbf..e0a99df512f 100644
--- a/setup.c
+++ b/setup.c
@@ -459,7 +459,16 @@ static void setup_original_cwd(void)
 	 */
 
 	/* Normalize the directory */
-	strbuf_realpath(&tmp, tmp_original_cwd, 1);
+	if (!strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
+		trace2_data_string("setup", the_repository,
+				   "realpath-path", tmp_original_cwd);
+		trace2_data_string("setup", the_repository,
+				   "realpath-failure", strerror(errno));
+		free((char*)tmp_original_cwd);
+		tmp_original_cwd = NULL;
+		return;
+	}
+
 	free((char*)tmp_original_cwd);
 	tmp_original_cwd = NULL;
 	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
-- 
2.35.1

