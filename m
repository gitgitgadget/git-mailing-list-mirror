From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/2] improve missing repository error message
Date: Wed, 4 Mar 2009 03:32:29 -0500
Message-ID: <20090304083229.GA31798@coredump.intra.peff.net>
References: <20090303184106.GH14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 09:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LemYY-0000as-1v
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 09:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbZCDIch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 03:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbZCDIch
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 03:32:37 -0500
Received: from peff.net ([208.65.91.99]:32961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZCDIcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 03:32:36 -0500
Received: (qmail 22723 invoked by uid 107); 4 Mar 2009 08:32:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 03:32:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 03:32:29 -0500
Content-Disposition: inline
In-Reply-To: <20090303184106.GH14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112188>

Certain remote commands, when asked to do something in a
particular directory that was not actually a git repository,
would say "unable to chdir or not a git archive". The
"chdir" bit is an unnecessary detail, and the term "git
archive" is much less common these days than "git repository".

So let's switch them all to:

  fatal: '%s' does not appear to be a git repository

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Mar 03, 2009 at 10:41:06AM -0800, Shawn O. Pearce wrote:

> IMHO, maybe we also should change the error message that receive-pack
> produces when the path its given isn't a Git repository.  Its really
> not very human friendly to say "unable to chdir or not a git archive".
> Hell, we don't even call them archives, we call them repositories.

I agree completely.

Perhaps this should match the local "Not a git repository: %s". I prefer
this text, but maybe there is value in consistency.

 builtin-receive-pack.c   |    2 +-
 builtin-upload-archive.c |    2 +-
 daemon.c                 |    2 +-
 upload-pack.c            |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 849f1fe..a970b39 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -675,7 +675,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	setup_path();
 
 	if (!enter_repo(dir, 0))
-		die("'%s': unable to chdir or not a git archive", dir);
+		die("'%s' does not appear to be a git repository", dir);
 
 	if (is_repository_shallow())
 		die("attempt to push into a shallow repository");
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index a9b02fa..0206b41 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -35,7 +35,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
 
 	if (!enter_repo(buf, 0))
-		die("not a git archive");
+		die("'%s' does not appear to be a git repository", buf);
 
 	/* put received options in sent_argv[] */
 	sent_argc = 1;
diff --git a/daemon.c b/daemon.c
index d93cf96..13401f1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -229,7 +229,7 @@ static char *path_ok(char *directory)
 	}
 
 	if (!path) {
-		logerror("'%s': unable to chdir or not a git archive", dir);
+		logerror("'%s' does not appear to be a git repository", dir);
 		return NULL;
 	}
 
diff --git a/upload-pack.c b/upload-pack.c
index 19c24db..e15ebdc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -645,7 +645,7 @@ int main(int argc, char **argv)
 	dir = argv[i];
 
 	if (!enter_repo(dir, strict))
-		die("'%s': unable to chdir or not a git archive", dir);
+		die("'%s' does not appear to be a git repository", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
 	if (getenv("GIT_DEBUG_SEND_PACK"))
-- 
1.6.2.rc2.24.g55bc2
