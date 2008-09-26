From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add remove_path: a function to remove as much as possible
	of a path
Date: Sat, 27 Sep 2008 00:56:46 +0200
Message-ID: <20080926225645.GA13412@blimp.localhost>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost> <20080925201734.GA18315@blimp.localhost> <20080925202237.GB18315@blimp.localhost> <20080926152823.GA17470@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:58:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjMG9-0001zu-5L
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 00:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbYIZW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbYIZW4u
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 18:56:50 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:48918 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbYIZW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 18:56:49 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AU8zrdc=
Received: from tigra.home (Faa4e.f.strato-dslnet.de [195.4.170.78])
	by post.webmailer.de (mrclete mo64) (RZmta 17.7)
	with ESMTP id t03899k8QLr72I ; Sat, 27 Sep 2008 00:56:46 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 4A053277AE;
	Sat, 27 Sep 2008 00:56:46 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 188B536D1E; Sat, 27 Sep 2008 00:56:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080926152823.GA17470@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96891>

The function has two potential users which both managed to get wrong
their implementations (the one in builtin-rm.c one has a memleak, and
builtin-merge-recursive.c scribles over its const argument).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Shawn O. Pearce, Fri, Sep 26, 2008 17:28:23 +0200:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > It is the same as in merge-recursive, but they're so small so unless
> > we get a special file with such random routines there is no much point
> > exporting it. Actually, we do seem to have such a file: dir.c. It is
> > already plagued by file_exists kind of things, why not remove_path...
> 
> Yea.  I'm thinking remove_path should migrate to dir.c.  Hell,
> we already have rm -rf as remove_dir_recursively() in dir.c.
> remove_path is its long-lost soul mate.  I'm not applying this
> builtin-rm fix, and am hoping you'll rewrite it around a move
> of remove_path to dir.c...  ;-)
>  

Okay :) The next one is on top of the previous fix in merge-recursive
(removes ENOENT conditional)

 dir.c |   20 ++++++++++++++++++++
 dir.h |    3 +++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index acf1001..1c3c501 100644
--- a/dir.c
+++ b/dir.c
@@ -831,3 +831,23 @@ void setup_standard_excludes(struct dir_struct *dir)
 	if (excludes_file && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
+
+int remove_path(const char *name)
+{
+	char *slash;
+
+	if (unlink(name) && errno != ENOENT)
+		return -1;
+
+	slash = strrchr(name, '/');
+	if (slash) {
+		char *dirs = xstrdup(name);
+		slash = dirs + (slash - name);
+		do {
+			*slash = '\0';
+		} while (rmdir(dirs) && (slash = strrchr(dirs, '/')));
+		free(dirs);
+	}
+	return 0;
+}
+
diff --git a/dir.h b/dir.h
index 2df15de..278ee42 100644
--- a/dir.h
+++ b/dir.h
@@ -81,4 +81,7 @@ extern int is_inside_dir(const char *dir);
 extern void setup_standard_excludes(struct dir_struct *dir);
 extern int remove_dir_recursively(struct strbuf *path, int only_empty);
 
+/* tries to remove the path with empty directories along it, ignores ENOENT */
+extern int remove_path(const char *path);
+
 #endif
-- 
1.6.0.2.328.g14651
