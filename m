From: Jeff King <peff@peff.net>
Subject: [PATCH 14/14] clone: give advice on how to resume a failed clone
Date: Thu, 10 Nov 2011 02:56:55 -0500
Message-ID: <20111110075654.GN27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPVO-0006IT-HT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab1KJH46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:56:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38935
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab1KJH45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:56:57 -0500
Received: (qmail 22644 invoked by uid 107); 10 Nov 2011 07:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:56:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:56:55 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185212>

When clone fails, we usually delete the partial directory.
However, if cloning was fetching a bundle, that is resumable
and we should consider those results precious.

This patch detects when a partial bundle is present,
preserves the directory, and gives the user some advice
about how to resume.

Signed-off-by: Jeff King <peff@peff.net>
---
We could make "git clone ..." automatically resume, but I'm a little
nervous about that. I wrote a patch that did so, and it did work, but
there are a lot of little hiccups as we violate the assumption that the
directory didn't already exist (e.g., it writes multiple fetch refspec
lines to the config).

But more importantly, I really worry about destroying the safety valve
of not overwriting an existing directory. Yes, we can check to see that
it is a git directory and that it has a partially-downloaded bundle
file. But that could also describe an existing git repo with unstaged
changes. And you sure don't want to "checkout -f" over them.

So I'd rather at least start with giving the user some advice and
having them explicitly say "yeah, I do want to resume this".

 builtin/clone.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..c242e20 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,36 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	return ret;
 }
 
+static int git_dir_is_resumable(const char *dir)
+{
+	const char *objects = mkpath("%s/objects", dir);
+	DIR *dh = opendir(objects);
+	struct dirent *de;
+
+	if (!dh)
+		return 0;
+
+	while ((de = readdir(dh))) {
+		if (!prefixcmp(de->d_name, "tmp_bundle_")) {
+			closedir(dh);
+			return 1;
+		}
+	}
+
+	closedir(dh);
+	return 0;
+}
+
+static void give_resume_advice(void)
+{
+	advise("Cloning failed, but partial results were saved.");
+	advise("You can resume the fetch with:");
+	advise("  git fetch");
+	if (!option_bare)
+		advise("  git checkout %s",
+		       option_branch ? option_branch : "master");
+}
+
 static const char *junk_work_tree;
 static const char *junk_git_dir;
 static pid_t junk_pid;
@@ -402,6 +432,10 @@ static void remove_junk(void)
 	if (getpid() != junk_pid)
 		return;
 	if (junk_git_dir) {
+		if (git_dir_is_resumable(junk_git_dir)) {
+			give_resume_advice();
+			return;
+		}
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
-- 
1.7.7.2.7.g9f96f
