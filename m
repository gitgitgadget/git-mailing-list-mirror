From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH v2] autocrlf: Make it work also for un-normalized
	repositories
Date: Wed, 12 May 2010 00:37:57 +0200
Message-ID: <20100511223757.GB16974@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed May 12 00:38:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBy5a-0001ZP-6C
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 00:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab0EKWiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 18:38:04 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:34797 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab0EKWiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 18:38:01 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OBy5N-0006x7-JV; Wed, 12 May 2010 00:37:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146908>

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
git commit      (nothing to commit)

Previously this would break for any text file containing a CR.

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
setting for Windows, and this solves problems 1-4 (it solves 2 by being
set by default, which is early enough for clone).

I implemented it by looking for CR charactes in the index, and
aborting any conversion attempt if this is found.

Signed-off-by: Finn Arne Gangstad <finag@pvv.org>
---

Changes since v1:

Only check for CRs in the index if we're in CRLF_GUESS mode, if any
crlf attributes are set, we assume the attributes are set correctly
and do not scan for CRs.

Added tests. Note that I only ran these on Linux, so I'm not 100% sure
they are written portably.

I have talked a bit to Eyvind about his eol-patch, so this is
rewritten slightly to be easier to merge with his changes.


 convert.c       |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0020-crlf.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index 4f8fcb7..3458bca 100644
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
@@ -145,6 +182,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		 */
 		if (is_binary(len, &stats))
 			return 0;
+
+		/*
+		 * If the file in the index has any CR in it, do not convert.
+		 * This is the new safer autocrlf handling.
+		 */
+		if (has_cr_in_index(path))
+			return 0;
 	}
 
 	check_safe_crlf(path, action, &stats, checksafe);
@@ -203,6 +247,11 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 		return 0;
 
 	if (action == CRLF_GUESS) {
+		/* If we have any CR or CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats.cr > 0 || stats.crlf > 0)
+			return 0;
+		
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
 			return 0;
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index c3e7e32..f425302 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -453,5 +453,59 @@ test_expect_success 'invalid .gitattributes (must not crash)' '
 	git diff
 
 '
+# Some more tests here to add new autocrlf functionality.
+# We want to have a known state here, so start a bit from scratch
+
+test_expect_success 'setting up for new autocrlf tests' '
+
+	git config core.autocrlf false &&
+	git config core.safecrlf false &&
+	rm -rf .????* * &&
+ 	for w in I am all LF; do echo $w; done >alllf &&
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
+	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	git add -A . &&
+	git commit -m "alllf, allcrlf and mixed only" &&
+	git tag -a -m "message" autocrlf-checkpoint
+'
+
+test_expect_success 'setting autocrlf gives empty diff' '
+
+	git config core.autocrlf true && 
+	touch * &&
+	git diff --exit-code
+'
+
+test_expect_success 'files are clean after checkout' '
+	rm * &&
+	git checkout -f &&
+	git diff --exit-code
+'
+
+cr_to_Q_no_NL () {
+    tr '\015' Q | tr -d '\012'
+}
+
+test_expect_success 'LF only file gets CRLF with autocrlf' '
+	[ $(cr_to_Q_no_NL < alllf) = "IQamQallQLFQ" ]
+'
+
+test_expect_success 'Mixed file is still mixed with autocrlf' '
+	[ $(cr_to_Q_no_NL < mixed) = "OhhereisCRLFQintext" ]
+'
+
+test_expect_success 'CRLF only file has CRLF with autocrlf' '
+	[ $(cr_to_Q_no_NL < allcrlf) = "IQamQallQCRLFQ" ]
+'
+
+test_expect_success 'New CRLF file gets LF in repo' '
+	tr -d "\015" < alllf | append_cr > alllf2 &&
+	git add alllf2 &&
+	git commit -m "alllf2 added" &&
+	git config core.autocrlf false &&
+	rm * &&
+	git checkout -f &&
+	test_cmp alllf alllf2 
+'
 
 test_done
-- 
1.7.1.1.g653e8
