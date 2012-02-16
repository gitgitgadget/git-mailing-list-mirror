From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] config: provide a version of git_config with more options
Date: Thu, 16 Feb 2012 03:05:56 -0500
Message-ID: <20120216080555.GE11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwLq-0001hc-VK
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab2BPIF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:05:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38589
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab2BPIF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:05:58 -0500
Received: (qmail 28056 invoked by uid 107); 16 Feb 2012 08:13:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:13:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:05:56 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190880>

Callers may want to provide a specific version of a file in
which to look for config. Right now this can be done by
setting the magic global config_exclusive_filename variable.
By providing a version of git_config that takes a filename,
we can take a step towards making this magic global go away.

Furthermore, by providing a more "advanced" interface, we
now have a a natural place to add new options for callers
like git-config, which care about tweaking the specifics of
config lookup, without disturbing the large number of
"simple" users (i.e., every other part of git).

The astute reader of this patch may notice that the logic
for handling config_exclusive_filename was taken out of
git_config_early, but added into git_config. This means that
git_config_early will no longer respect config_exclusive_filename.
That's OK, because the only other caller of git_config_early
is check_repository_format_gently, but the only function
which sets config_exclusive_filename is cmd_config, which
does not call check_repository_format_gently (and if it did,
it would have been a bug, anyway, as we would be checking
the repository format in the wrong file).

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this could also learn about a respect_includes flag, and it in
fact does in patch 8. I didn't include it in the initial version because
this part of the series is really about refactoring the
config_exclusive_filename stuff (and is semantically independent of the
notion of included files).

 cache.h  |    1 +
 config.c |   22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 7e375ce..7cb8874 100644
--- a/cache.h
+++ b/cache.h
@@ -1115,6 +1115,7 @@ extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
+extern int git_config_with_options(config_fn_t fn, void *, const char *filename);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index c456600..fbf883d 100644
--- a/config.c
+++ b/config.c
@@ -942,9 +942,6 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	int ret = 0, found = 0;
 	const char *home = NULL;
 
-	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
-	if (config_exclusive_filename)
-		return git_config_from_file(fn, config_exclusive_filename, data);
 	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
@@ -980,7 +977,8 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	return ret == 0 ? found : ret;
 }
 
-int git_config(config_fn_t fn, void *data)
+int git_config_with_options(config_fn_t fn, void *data,
+			    const char *filename)
 {
 	char *repo_config = NULL;
 	int ret;
@@ -988,14 +986,28 @@ int git_config(config_fn_t fn, void *data)
 
 	inc.fn = fn;
 	inc.data = data;
+	fn = git_config_include;
+	data = &inc;
+
+	/*
+	 * If we have a specific filename, use it. Otherwise, follow the
+	 * regular lookup sequence.
+	 */
+	if (filename)
+		return git_config_from_file(fn, filename, data);
 
 	repo_config = git_pathdup("config");
-	ret = git_config_early(git_config_include, &inc, repo_config);
+	ret = git_config_early(fn, data, repo_config);
 	if (repo_config)
 		free(repo_config);
 	return ret;
 }
 
+int git_config(config_fn_t fn, void *data)
+{
+	return git_config_with_options(fn, data, config_exclusive_filename);
+}
+
 /*
  * Find all the stuff for git_config_set() below.
  */
-- 
1.7.9.1.4.g8ffed
