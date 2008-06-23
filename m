From: Jeff King <peff@peff.net>
Subject: Re: Git clone behaviour change in 1.5.6 (vs 1.5.5.1)
Date: Mon, 23 Jun 2008 16:38:36 -0400
Message-ID: <20080623203835.GA8105@sigill.intra.peff.net>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: zuh@iki.fi, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsp5-00039Y-0v
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbYFWUii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbYFWUii
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:38:38 -0400
Received: from peff.net ([208.65.91.99]:4277 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbYFWUih (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 16:38:37 -0400
Received: (qmail 29175 invoked by uid 111); 23 Jun 2008 20:38:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 16:38:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 16:38:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0806231554380.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85921>

On Mon, Jun 23, 2008 at 03:56:41PM -0400, Daniel Barkalow wrote:

> > Switching to the 1.5.6 release from 1.5.5.1, I found out that the
> > rewritten git-clone command changed its behaviour wrt cloning to a
> > non-existing destination directory structure. In the shell version the
> > destination (work tree) is created with 'mkdir -p' but in the C
> > version with just the mkdir() call which doesn't create the parent
> > directories.
> > 
> > I can't find any indication that this would be intended in the repo
> > history nor in the mailing list, so I'm left thinking that this is an
> > unwanted regression. Could someone confirm this?
> 
> It wasn't an intentional change, anyway.

Here is a partial fix. For --bare repo creation, we follow a different
codepath, and I think the fix is likely to be a bit tricky. We actually
fail in make_absolute_path, before we try creating the directory. But I
suspect we can't just create the directory ourselves because init_db
expects it not to exist.

-- >8 --
clone: create intermediate directories of repo destination

The shell version used to use "mkdir -p" to create the repo
path, but the C version just calls "mkdir". Let's replicate
the old behavior.
---
 builtin-clone.c  |   40 +++++++++++++++++++++++++++++++++++++++-
 t/t5601-clone.sh |   14 ++++++++++++++
 2 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5c5acb4..758d02c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -168,6 +168,44 @@ static void setup_reference(const char *repo)
 	free(ref_git_copy);
 }
 
+static int mkdirp_recurse(char *path, int mode)
+{
+	int n;
+	char tmp;
+	int r;
+
+	if (mkdir(path, mode) == 0)
+		return 0;
+	if (errno != ENOENT)
+		return -1;
+
+	for (n = strlen(path); n > 0 && path[n] != '/'; n--)
+		;
+	if (n == 0)
+		return -1;
+	tmp = path[n];
+	path[n] = '\0';
+	r = mkdirp_recurse(path, mode);
+	path[n] = tmp;
+	if (r < 0)
+		return -1;
+	return mkdir(path, mode);
+}
+
+static int mkdirp(const char *path, int mode)
+{
+	char buf[PATH_MAX];
+	int n;
+
+	n = strlen(path);
+	if (n >= PATH_MAX) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	memcpy(buf, path, n+1);
+	return mkdirp_recurse(buf, mode);
+}
+
 static void copy_or_link_directory(char *src, char *dest)
 {
 	struct dirent *de;
@@ -404,7 +442,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (!option_bare) {
 		junk_work_tree = work_tree;
-		if (mkdir(work_tree, 0755))
+		if (mkdirp(work_tree, 0755))
 			die("could not create work tree dir '%s'.", work_tree);
 		set_git_work_tree(work_tree);
 	}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 593d1a3..c2c83f0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -30,4 +30,18 @@ test_expect_success 'clone checks out files' '
 
 '
 
+test_expect_success 'clone creates intermediate directories' '
+
+	git clone src long/path/to/dst &&
+	test -f long/path/to/dst/file
+
+'
+
+test_expect_failure 'clone creates intermediate directories for bare repo' '
+
+	git clone --bare src long/path/to/bare/dst &&
+	test -f long/path/to/bare/dst/config
+
+'
+
 test_done
-- 
1.5.6.105.gceec6.dirty
