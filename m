From: Jeff King <peff@peff.net>
Subject: [PATCH v2 03/10] lazily load core.sharedrepository
Date: Fri, 11 Mar 2016 17:36:53 -0500
Message-ID: <20160311223653.GC449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVg4-0003hg-LI
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbcCKWg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:36:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:58649 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932659AbcCKWg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:36:56 -0500
Received: (qmail 20911 invoked by uid 102); 11 Mar 2016 22:36:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:36:56 -0500
Received: (qmail 7439 invoked by uid 107); 11 Mar 2016 22:37:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:36:53 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288710>

The "shared_repository" config is loaded as part of
check_repository_format_version, but it's not quite like the
other values we check there. Something like
core.repositoryformatversion only makes sense in per-repo
config, but core.sharedrepository can be set in a per-user
config (e.g., to make all "git init" invocations shared by
default).

So it would make more sense as part of git_default_config.
Commit 457f06d (Introduce core.sharedrepository, 2005-12-22)
says:

  [...]the config variable is set in the function which
  checks the repository format. If this were done in
  git_default_config instead, a lot of programs would need
  to be modified to call git_config(git_default_config)
  first.

This is still the case today, but we have one extra trick up
our sleeve. Now that we have the git_configset
infrastructure, it's not so expensive for us to ask for a
single value. So we can simply lazy-load it on demand.

This should be OK to do in general. There are some problems
with loading config before setup_git_directory() is called,
but we shouldn't be accessing the value before then (if we
were, then it would already be broken, as the variable would
not have been set by check_repository_format_version!). The
trickiest caller is git-init, but it handles the values
manually itself.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 9 +++++++++
 setup.c       | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index b42e238..8b8c8e8 100644
--- a/environment.c
+++ b/environment.c
@@ -326,13 +326,22 @@ const char *get_commit_output_encoding(void)
 }
 
 static int the_shared_repository = PERM_UMASK;
+static int need_shared_repository_from_config = 1;
 
 void set_shared_repository(int value)
 {
 	the_shared_repository = value;
+	need_shared_repository_from_config = 0;
 }
 
 int get_shared_repository(void)
 {
+	if (need_shared_repository_from_config) {
+		const char *var = "core.sharedrepository";
+		const char *value;
+		if (!git_config_get_value(var, &value))
+			the_shared_repository = git_config_perm(var, value);
+		need_shared_repository_from_config = 0;
+	}
 	return the_shared_repository;
 }
diff --git a/setup.c b/setup.c
index ac777c5..a02932b 100644
--- a/setup.c
+++ b/setup.c
@@ -376,8 +376,6 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		repository_format_version = git_config_int(var, value);
-	else if (strcmp(var, "core.sharedrepository") == 0)
-		set_shared_repository(git_config_perm(var, value));
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		/*
 		 * record any known extensions here; otherwise,
-- 
2.8.0.rc2.328.g39e2a47
