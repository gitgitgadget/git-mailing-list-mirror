From: Jeff King <peff@peff.net>
Subject: [PATCH v2 02/10] use xstrfmt in favor of manual size calculations
Date: Thu, 19 Jun 2014 17:19:18 -0400
Message-ID: <20140619211918.GB28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:19:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxjjw-0005dB-7W
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934585AbaFSVTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:19:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:47771 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933503AbaFSVTT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:19:19 -0400
Received: (qmail 16537 invoked by uid 102); 19 Jun 2014 21:19:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:19:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:19:18 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252185>

In many parts of the code, we do an ugly and error-prone
malloc like:

  const char *fmt = "something %s";
  buf = xmalloc(strlen(foo) + 10 + 1);
  sprintf(buf, fmt, foo);

This makes the code brittle, and if we ever get the
allocation wrong, is a potential heap overflow. Let's
instead favor xstrfmt, which handles the allocation
automatically, and makes the code shorter and more readable.

Signed-off-by: Jeff King <peff@peff.net>
---
These could actually be squashed into later commits, I suppose, but I
left it separate since it had already been reviewed.

 remote.c       |  6 +-----
 unpack-trees.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index 0e9459c..bf27e44 100644
--- a/remote.c
+++ b/remote.c
@@ -170,7 +170,6 @@ static struct branch *make_branch(const char *name, int len)
 {
 	struct branch *ret;
 	int i;
-	char *refname;
 
 	for (i = 0; i < branches_nr; i++) {
 		if (len ? (!strncmp(name, branches[i]->name, len) &&
@@ -186,10 +185,7 @@ static struct branch *make_branch(const char *name, int len)
 		ret->name = xstrndup(name, len);
 	else
 		ret->name = xstrdup(name);
-	refname = xmalloc(strlen(name) + strlen("refs/heads/") + 1);
-	strcpy(refname, "refs/heads/");
-	strcpy(refname + strlen("refs/heads/"), ret->name);
-	ret->refname = refname;
+	ret->refname = xstrfmt("refs/heads/%s", ret->name);
 
 	return ret;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 97fc995..c237370 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -56,17 +56,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	int i;
 	const char **msgs = opts->msgs;
 	const char *msg;
-	char *tmp;
 	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
+
 	if (advice_commit_before_merge)
 		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
 			"Please, commit your changes or stash them before you can %s.";
 	else
 		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
-	sprintf(tmp, msg, cmd, cmd2);
-	msgs[ERROR_WOULD_OVERWRITE] = tmp;
-	msgs[ERROR_NOT_UPTODATE_FILE] = tmp;
+	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
+		xstrfmt(msg, cmd, cmd2);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		"Updating the following directories would lose untracked files in it:\n%s";
@@ -76,12 +74,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			"Please move or remove them before you can %s.";
 	else
 		msg = "The following untracked working tree files would be %s by %s:\n%%s";
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
-	sprintf(tmp, msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = tmp;
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
-	sprintf(tmp, msg, "overwritten", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = tmp;
+
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, "removed", cmd, cmd2);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, "overwritten", cmd, cmd2);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
-- 
2.0.0.566.gfe3e6b2
