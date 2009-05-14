From: Josh Micich <josh.micich@gmail.com>
Subject: [PATCH 1/3] '--missing' option for mktree: re-added =?utf-8?b?c3RyYnVmX3JlbGVhc2UoJnBfdXEpLA==?= Updated man page
Date: Thu, 14 May 2009 05:09:51 +0000 (UTC)
Message-ID: <loom.20090514T050742-791@post.gmane.org>
References: <loom.20090514T050424-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 07:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4TRT-0007v2-5L
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZENFZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 01:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbZENFZG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:25:06 -0400
Received: from main.gmane.org ([80.91.229.2]:44403 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbZENFZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 01:25:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M4TRH-0007Ey-3m
	for git@vger.kernel.org; Thu, 14 May 2009 05:25:03 +0000
Received: from adsl-69-104-91-41.dsl.pltn13.pacbell.net ([69.104.91.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:25:03 +0000
Received: from josh.micich by adsl-69-104-91-41.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:25:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.104.91.41 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119141>

Re-added call to strbuf_release(&p_uq) that got lost in earlier changes.
Updated mktree_usage msg.

Updated man page to explain new '--missing' option.
Also clarified sorting behaviour.

Signed-off-by: Josh Micich <josh.micich@gmail.com>
---
 Documentation/git-mktree.txt |   11 ++++++++---
 builtin-mktree.c             |    5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index af19f06..0461062 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,18 +8,23 @@ git-mktree - Build a tree-object from ls-tree formatted text
 
 SYNOPSIS
 --------
-'git mktree' [-z]
+'git mktree' [-z] [--missing]
 
 DESCRIPTION
 -----------
-Reads standard input in non-recursive `ls-tree` output format,
-and creates a tree object.  The object name of the tree object
+Reads standard input in non-recursive `ls-tree` output format, and creates
+a tree object.  The order of the tree entries is normalised by mktree so
+pre-sorting the input is not required.  The object name of the tree object
 built is written to the standard output.
 
 OPTIONS
 -------
 -z::
 	Read the NUL-terminated `ls-tree -z` output instead.
+--missing::
+	Allow missing objects.  The default behaviour (without this option)
+	is to verify that each tree entry's sha1 identifies an existing
+	object.
 
 Author
 ------
diff --git a/builtin-mktree.c b/builtin-mktree.c
index e1c9a27..db647ce 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -63,7 +63,7 @@ static void write_tree(unsigned char *sha1)
 }
 
 static const char *mktree_usage[] = {
-	"git mktree [-z]",
+	"git mktree [-z] [--missing]",
 	NULL
 };
 
@@ -112,6 +112,9 @@ static void mktree_line(char *buf, size_t len, int 
line_termination, int allow_m
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
 		path = strbuf_detach(&p_uq, NULL);
+		append_to_tree(mode, sha1, path);
+		strbuf_release(&p_uq);
+		return;
 	}
 	append_to_tree(mode, sha1, path);
 }
-- 
1.6.3.165.g2cce5.dirty
