From: Jeff King <peff@peff.net>
Subject: Re: BUG: mergetool fails on gitignore:d files
Date: Sat, 30 May 2009 17:54:18 -0400
Message-ID: <20090530215418.GA19241@coredump.intra.peff.net>
References: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Sandberg <mandolaerik@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 23:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAWVe-0001Li-Kq
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 23:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbZE3VyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 17:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZE3VyZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 17:54:25 -0400
Received: from peff.net ([208.65.91.99]:59870 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbZE3VyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 17:54:24 -0400
Received: (qmail 1508 invoked by uid 107); 30 May 2009 21:54:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 30 May 2009 17:54:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 May 2009 17:54:18 -0400
Content-Disposition: inline
In-Reply-To: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120365>

On Sat, May 30, 2009 at 05:30:52PM +0200, Erik Sandberg wrote:

> If a version-controlled file is ignored by git, and a conflict arises
> on the file, and I use mergetool to resolve the conflict, then
> mergetool fails with a message like:
> 
> The following paths are ignored by one of your .gitignore files:
> a
> Use -f if you really want to add them.
> 
> The problem disappears if I edit the git-mergetool script to always
> pass -f to "git add", but I'm not sure if that's the right fix; I have
> a vague feeling that "git-update-index --add" could be more correct.

Actually, I think the problem is not in mergetool at all, but with the
dir.c code underlying "git add". "git add" really should not be
complaining, because you are not adding a new path at all, but are
rather adding content to a tracked path.

So this should work (and does):

  $ echo file >.gitignore
  $ echo content >file
  $ git add -f file ;# need -f because we are adding new path
  $ echo more content >>file
  $ git add file ;# don't need -f; it is not actually an "other" file

This is handled under the hood by the COLLECT_IGNORED option to
read_directory. When that code finds an ignored file, it checks the
index to make sure it is not actually a tracked file. However, the test
it uses does not take into account unmerged entries, and considers them
to still be ignored. "git ls-files" uses a more elaborate test and gets
the right answer. So I think we want to use the same test:

---
diff --git a/dir.c b/dir.c
index 0e6b752..bbfcb56 100644
--- a/dir.c
+++ b/dir.c
@@ -396,7 +396,7 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 
 static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_pos(pathname, len) >= 0)
+	if (!cache_name_is_other(pathname, len))
 		return NULL;
 
 	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
