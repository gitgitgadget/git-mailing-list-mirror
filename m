From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 1/4] autocrlf: Make it work also for un-normalized repositories
Date: Thu, 13 May 2010 23:44:39 +0200
Message-ID: <4dc62dfef759eca02dd7debd833b25ac47956370.1273786317.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 23:45:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCgDJ-0005HK-G1
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 23:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046Ab0EMVow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 17:44:52 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34169 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab0EMVot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 17:44:49 -0400
Received: by ewy8 with SMTP id 8so702713ewy.28
        for <git@vger.kernel.org>; Thu, 13 May 2010 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IQVZpM7Qn7hTPcLnTwusAermxwu5PdlzZTTWq5lbhv4=;
        b=XtTsERtpGS0a8qKgCYHy104VIlzeTmabMAlcqXzuq01sWNHOATeOl6id+xP9NEtrco
         ZzXEniignQRsXY3BucJdGcmgRdX5d+sqB50eruk/IYY7CuSRRzJ3oLdH1FFaQMLlF+Ar
         Pj5iP/R9r1MhvOjXrDdsy8NQESc5p74FuGGfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AB5cXOuLUPdcM6nlKMpQrng3+w2RF6SGED7S4NrdFbpE9swkP5F2c/VI5DDQPgTYim
         8PPTU1VEMzryxytTaqJ1wiy7VHb7MQjElQUXC0JIROeKbdi8nk0GbJp6tx1D18QJHPLo
         tWUEEM2AaGRKCItZZDnIJmF+COwfcMigVua8M=
Received: by 10.213.79.76 with SMTP id o12mr255000ebk.19.1273787088333;
        Thu, 13 May 2010 14:44:48 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm906408ewy.4.2010.05.13.14.44.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 14:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147032>

From: Finn Arne Gangstad <finnag@pvv.org>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 convert.c       |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0020-crlf.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index 4f8fcb7..46622b0 100644
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
index c3e7e32..234a94f 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -453,5 +453,57 @@ test_expect_success 'invalid .gitattributes (must not crash)' '
 	git diff
 
 '
+# Some more tests here to add new autocrlf functionality.
+# We want to have a known state here, so start a bit from scratch
+
+test_expect_success 'setting up for new autocrlf tests' '
+	git config core.autocrlf false &&
+	git config core.safecrlf false &&
+	rm -rf .????* * &&
+	for w in I am all LF; do echo $w; done >alllf &&
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
+	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	git add -A . &&
+	git commit -m "alllf, allcrlf and mixed only" &&
+	git tag -a -m "message" autocrlf-checkpoint
+'
+
+test_expect_success 'report no change after setting autocrlf' '
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
+	test "$(cr_to_Q_no_NL < alllf)" = "IQamQallQLFQ"
+'
+
+test_expect_success 'Mixed file is still mixed with autocrlf' '
+	test "$(cr_to_Q_no_NL < mixed)" = "OhhereisCRLFQintext"
+'
+
+test_expect_success 'CRLF only file has CRLF with autocrlf' '
+	test "$(cr_to_Q_no_NL < allcrlf)" = "IQamQallQCRLFQ"
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
1.7.1.5.gd739a
