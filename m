From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd .gitignore behaviour
Date: Thu, 15 Nov 2007 13:51:55 -0800
Message-ID: <7vir4341ok.fsf@gitster.siamese.dyndns.org>
References: <80ir431xny.fsf@tiny.isode.net>
	<alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
	<80ir43e04o.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:52:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsmdN-00047N-Cr
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbXKOVwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbXKOVwF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:52:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60577 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993AbXKOVwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:52:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 34E292F0;
	Thu, 15 Nov 2007 16:52:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D1D195FF6;
	Thu, 15 Nov 2007 16:52:19 -0500 (EST)
In-Reply-To: <80ir43e04o.fsf@tiny.isode.net> (Bruce Stephens's message of
	"Thu, 15 Nov 2007 20:15:19 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65164>

Bruce Stephens <bruce.stephens@isode.com> writes:

> So I think the output from git-ls-files is as expected (as I interpret
> the manpage and your explanation).  So is git-add just using some
> different code?

No, you found one of the longstanding bugs in dir.c:read_directory().

The funny thing is that I just sent out a message pointing out
bogus handling of per-directory exclude files in ls-files last
night.  Somehow people have a tendency to encounter the bugs in
the same vicinity independently.

The initial loop in read_directory() to push per-directory
exclusion elements into the stack for directories above the
given base forgets that push() does not make a copy of the path
given as its parameter but stores the pointer to it instead, so
multiple calls to push() need to use separate path buffers.

Here is a tentative patch.  I do not think the patch is broken
but I call it tentative because:

 - It is ugly -- I never get this "walking path delimited by
   slashes" loop right;

 - It leaks the path buffer given to push(), but it is inherent
   in the design of "push/pop exclude per-directory" API.  They
   were designed to be called from the recursive directory
   walking, and the path buffers are placed on the function call
   stack to be reclaimed automatically upon function return;

---

 dir.c |   55 ++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/dir.c b/dir.c
index fa9f902..d32f437 100644
--- a/dir.c
+++ b/dir.c
@@ -651,38 +651,51 @@ static void free_simplify(struct path_simplify *simplify)
 		free(simplify);
 }
 
+static int push_excludes(struct dir_struct *dir, const char *base, int len)
+{
+	/*
+	 * base is like "a/b/c/" -- cause .gitignore, b/.gitignore and
+	 * b/c/.gitignore to be read in this order, as if we recursed
+	 * into it.
+	 */
+	int stk = -1;
+	int partlen = 0;
+
+	if (!(dir->exclude_per_dir && len))
+		return stk;
+
+	while (1) {
+		char *part = xmalloc(partlen + 1);
+		memcpy(part, base, partlen);
+		part[partlen] = '\0';
+		stk = push_exclude_per_directory(dir, part, partlen);
+
+		if (len <= partlen++)
+			break;
+
+		while (partlen < len && base[partlen] != '/')
+			partlen++;
+		partlen++; /* point at one past the found '/' */
+	}
+	return stk;
+}
+
 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
 {
 	struct path_simplify *simplify = create_simplify(pathspec);
+	int stk;
 
 	/*
 	 * Make sure to do the per-directory exclude for all the
 	 * directories leading up to our base.
 	 */
-	if (baselen) {
-		if (dir->exclude_per_dir) {
-			char *p, *pp = xmalloc(baselen+1);
-			memcpy(pp, base, baselen+1);
-			p = pp;
-			while (1) {
-				char save = *p;
-				*p = 0;
-				push_exclude_per_directory(dir, pp, p-pp);
-				*p++ = save;
-				if (!save)
-					break;
-				p = strchr(p, '/');
-				if (p)
-					p++;
-				else
-					p = pp + baselen;
-			}
-			free(pp);
-		}
-	}
+	stk = push_excludes(dir, base, baselen);
 
 	read_directory_recursive(dir, path, base, baselen, 0, simplify);
 	free_simplify(simplify);
+	if (0 <= stk)
+		pop_exclude_per_directory(dir, stk);
+
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
