From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] submodule: use prepare_submodule_repo_env consistently
Date: Thu, 28 Apr 2016 09:39:15 -0400
Message-ID: <20160428133914.GE25319@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:39:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmA5-0005S7-Rj
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbcD1NjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:39:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:58319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752546AbcD1NjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:39:17 -0400
Received: (qmail 25685 invoked by uid 102); 28 Apr 2016 13:39:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:39:17 -0400
Received: (qmail 9645 invoked by uid 107); 28 Apr 2016 13:39:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:39:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:39:15 -0400
Content-Disposition: inline
In-Reply-To: <20160428133534.GA19056@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292880>

Before 14111fc (git: submodule honor -c credential.* from
command line, 2016-02-29), it was sufficient for code which
spawned a process in a submodule to just set the child
process's "env" field to "local_repo_env" to clear the
environment of any repo-specific variables.

That commit introduced a more complicated procedure, in
which we clear most variables but allow through sanitized
config. For C code, we used that procedure only for cloning,
but not for any of the programs spawned by submodule.c. As a
result, things like "git fetch --recurse-submodules" behave
differently than "git clone --recursive"; the former will
not pass through the sanitized config.

We can fix this by using prepare_submodule_repo_env()
everywhere in submodule.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c                | 14 +++++++-------
 t/t5550-http-fetch-dumb.sh | 11 +++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 02eaf0e..4e76b98 100644
--- a/submodule.c
+++ b/submodule.c
@@ -394,7 +394,7 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
 
 		argv[1] = sha1_to_hex(sha1);
 		cp.argv = argv;
-		cp.env = local_repo_env;
+		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.out = -1;
@@ -481,7 +481,7 @@ static int push_submodule(const char *path)
 		const char *argv[] = {"push", NULL};
 
 		cp.argv = argv;
-		cp.env = local_repo_env;
+		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.dir = path;
@@ -527,7 +527,7 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 
 		argv[3] = sha1_to_hex(sha1);
 		cp.argv = argv;
-		cp.env = local_repo_env;
+		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.dir = path;
@@ -710,7 +710,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (is_directory(git_dir)) {
 			child_process_init(cp);
 			cp->dir = strbuf_detach(&submodule_path, NULL);
-			cp->env = local_repo_env;
+			prepare_submodule_repo_env(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -825,7 +825,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		argv[2] = "-uno";
 
 	cp.argv = argv;
-	cp.env = local_repo_env;
+	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
@@ -886,7 +886,7 @@ int submodule_uses_gitfile(const char *path)
 
 	/* Now test that all nested submodules use a gitfile too */
 	cp.argv = argv;
-	cp.env = local_repo_env;
+	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.no_stderr = 1;
@@ -919,7 +919,7 @@ int ok_to_remove_submodule(const char *path)
 		return 0;
 
 	cp.argv = argv;
-	cp.env = local_repo_env;
+	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 13ac788..3484b6f 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -112,6 +112,17 @@ test_expect_success 'cmdline credential config passes to submodule via clone' '
 	expect_askpass pass user@host
 '
 
+test_expect_success 'cmdline credential config passes submodule via fetch' '
+	set_askpass wrong pass@host &&
+	test_must_fail git -C super-clone fetch --recurse-submodules &&
+
+	set_askpass wrong pass@host &&
+	git -C super-clone \
+	    -c "credential.$HTTPD_URL.username=user@host" \
+	    fetch --recurse-submodules &&
+	expect_askpass pass user@host
+'
+
 test_expect_success 'cmdline credential config passes submodule update' '
 	# advance the submodule HEAD so that a fetch is required
 	git commit --allow-empty -m foo &&
-- 
2.8.1.617.gbdccc2d
