From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH/RFC] autocrlf: Make it work also for un-normalized
	repositories
Date: Mon, 10 May 2010 19:11:19 +0200
Message-ID: <20100510171119.GA17875@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 10 19:11:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWVu-0004Hk-17
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0EJRLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:11:24 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:51998 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0EJRLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:11:23 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OBWVj-0004xU-7I; Mon, 10 May 2010 19:11:19 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146828>

Previously, autocrlf would only work well for normalized
repositories. Any text files that contained CRLF in the repository
would cause problems, and would be modified when handled with
core.autocrlf set.

Change autocrlf to not do any conversions to files that in the
repository already contain a CR. git with autocrlf set will never
create such a file, or change a LF only file to contain CRs, so the
(new) assumption is that if a file contains a CR, it is intentional,
and autocrlf should not change that.

The following sequence should now always be a NOP even with autocrlf
set (assuming a clean working directory):

git checkout <something>
touch *
git add -A .    (will add nothing)
git comit       (nothing to commit)

Previously this would break for any text file containing a CR

Signed-off-by: Finn Arne Gangstad <finag@pvv.org>
---

Some of you may have been folowing Eyvind's excellent thread about
trying to make end-of-line translation in git a bit smoother.

I decided to attack the problem from a different angle: Is it possible
to make autocrlf behave non-destructively for all the previous problem cases?

Stealing the problem from Eyvind's initial mail (paraphrased and
summarized a bit):

1. Setting autocrlf globally is a pain since autocrlf does not work well
   with CRLF in the repo
2. Setting it in individual repos is hard since you do it "too late"
   (the clone will get it wrong)
3. If someone checks in a file with CRLF later, you get into problems again
4. If a repository once has contained CRLF, you can't tell autocrlf
   at which commit everything is sane again
5. autocrlf does needless work if you know that all your users want
   the same EOL style.

I belive that this patch makes autocrlf a safe (and good) default
setting for Windows, and this solves problems 1-4.

I implemented it by looking for CR charactes in the index, and
aborting any conversion attempt if this is found. The code to read
the index contents was copied pretty verbatim from attr.c, and should
probably be made into a non-static function instead if there is no
better way of doing this.

Note that ALL the tests still pass unmodified. This is a bit
surprising perhaps, but think it is an indication that no one ever
intented autocrlf to do what it does to files containing CRs.


 convert.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index 4f8fcb7..9d062c8 100644
--- a/convert.c
+++ b/convert.c
@@ -120,6 +120,43 @@ static void check_safe_crlf(const char *path, int action,
 	}
 }
 
+static int has_cr_in_index(const char *path)
+{
+	int pos, len;
+	unsigned long sz;
+	enum object_type type;
+	void *data;
+	int has_cr;
+	struct index_state *istate = &the_index;
+
+	len = strlen(path);
+	pos = index_name_pos(istate, path, len);
+	if (pos < 0) {
+		/*
+		 * We might be in the middle of a merge, in which
+		 * case we would read stage #2 (ours).
+		 */
+		int i;
+		for (i = -pos - 1;
+		     (pos < 0 && i < istate->cache_nr &&
+		      !strcmp(istate->cache[i]->name, path));
+		     i++)
+			if (ce_stage(istate->cache[i]) == 2)
+				pos = i;
+	}
+	if (pos < 0)
+		return 0;
+	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return 0;
+	}
+
+	has_cr = memchr(data, '\r', sz) != NULL;
+	free(data);
+	return has_cr;
+}
+
 static int crlf_to_git(const char *path, const char *src, size_t len,
                        struct strbuf *buf, int action, enum safe_crlf checksafe)
 {
@@ -147,6 +184,10 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
+	/* If the file in the index has any CR in it, do not convert. */
+	if (has_cr_in_index(path))
+		return 0;
+
 	check_safe_crlf(path, action, &stats, checksafe);
 
 	/* Optimization: No CR? Nothing to convert, regardless. */
@@ -202,6 +243,10 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	if (stats.lf == stats.crlf)
 		return 0;
 
+	/* Are there ANY lines at all with CRLF? If so, ignore */
+	if (stats.crlf > 0)
+		return 0;
+
 	if (action == CRLF_GUESS) {
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
-- 
1.7.1.1.g653e8
