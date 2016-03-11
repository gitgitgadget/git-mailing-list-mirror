From: Jeff King <peff@peff.net>
Subject: [PATCH v2 04/10] check_repository_format_gently: stop using
 git_config_early
Date: Fri, 11 Mar 2016 17:36:59 -0500
Message-ID: <20160311223659.GD449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVgC-0003rh-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbcCKWhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:37:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:58656 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932397AbcCKWhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:37:03 -0500
Received: (qmail 20926 invoked by uid 102); 11 Mar 2016 22:37:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:02 -0500
Received: (qmail 7498 invoked by uid 107); 11 Mar 2016 22:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:36:59 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288711>

There's a chicken-and-egg problem with using the regular
git_config during the repository setup process. We get
around it here by using a special interface that lets us
specify the per-repo config, and avoid calling
git_pathdup().

But this interface doesn't actually make sense. It will look
in the system and per-user config, too; we definitely would
not want to accept a core.repositoryformatversion from
there.

The git_config_from_file interface is a better match, as it
lets us look at a single file.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index a02932b..a6013e6 100644
--- a/setup.c
+++ b/setup.c
@@ -409,15 +409,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	repo_config = sb.buf;
 
 	/*
-	 * git_config() can't be used here because it calls git_pathdup()
-	 * to get $GIT_CONFIG/config. That call will make setup_git_env()
-	 * set git_dir to ".git".
-	 *
-	 * We are in gitdir setup, no git dir has been found useable yet.
-	 * Use a gentler version of git_config() to check if this repo
-	 * is a good one.
+	 * Ignore return value; for historical reasons, we must treat a missing
+	 * config file as a noop (git-init relies on this).
 	 */
-	git_config_early(fn, NULL, repo_config);
+	git_config_from_file(fn, repo_config, NULL);
 	if (GIT_REPO_VERSION_READ < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <= %d, found %d",
-- 
2.8.0.rc2.328.g39e2a47
