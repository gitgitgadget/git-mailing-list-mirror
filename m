From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] ls-files: fix overeager pathspec optimization
Date: Fri,  8 Jan 2010 23:35:35 -0800
Message-ID: <1263022535-12822-4-git-send-email-gitster@pobox.com>
References: <1263022535-12822-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 08:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTVry-0007Gk-2L
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 08:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0AIHgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 02:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512Ab0AIHgM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 02:36:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab0AIHgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 02:36:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4BFB8FB8C;
	Sat,  9 Jan 2010 02:36:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1sEk
	O9CZxLnohQEu0qrvnsnXQEQ=; b=RAhEmDzz4e5iGMOttakbKiY1d3Rn9HmLyEnw
	7OykQpV3R0L8iGom8hiues+cmze8qzAtG5JmoF8DuDtEDmP7ydfyUzF2qUrXslal
	y6fvYt6BtvZNb9kZGIAj8/c1D7br/V3zu67+4yE8tB36iZ/qW5AuGPUFppo7YsfG
	jrE2MOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	wPX3dTlq6QvSJ8JJr2BgoQ0nwxR3Mz5aQ4YuHclH3ZDbcglcBhRjQvIaUv4Gg6LN
	O0nmMOSnDyafJ1c/2jU0y7rSN6Q8JJTsvfKxZEggJyKvPYRu/IQgWGP5WVZY9Fx8
	ZFTWdDgSRSbZzJqvr2OTaWXwbqUvbJ0Ykwc6/QLa8pY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C20E8FB8B;
	Sat,  9 Jan 2010 02:36:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 341828FB83; Sat,  9 Jan
 2010 02:35:59 -0500 (EST)
X-Mailer: git-send-email 1.6.6.209.g52296.dirty
In-Reply-To: <1263022535-12822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A516C1B8-FCF1-11DE-BF99-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136524>

Given pathspecs that share a common prefix, ls-files optimized its call
into recursive directory reader by starting at the common prefix
directory.

If you have a directory "t" with an untracked file "t/junk" in it, but the
top-level .gitignore file told us to ignore "t/", this resulted in:

    $ git ls-files -o --exclude-standard
    $ git ls-files -o --exclude-standard t/
    t/junk
    $ git ls-files -o --exclude-standard t/junk
    t/junk
    $ cd t && git ls-files -o --exclude-standard
    junk

We could argue that you are overriding the ignore file by giving a
patchspec that matches or being in that directory, but it is somewhat
unexpected.  Worse yet, these behave differently:

    $ git ls-files -o --exclude-standard t/ .
    $ git ls-files -o --exclude-standard t/
    t/junk

This patch changes the optimization so that it notices when the common
prefix directory that it starts reading from is an ignored one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                              |   38 +++++++++++++++++++++++++++++++++++-
 t/t3001-ls-files-others-exclude.sh |    2 +-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 35cc89b..00d698d 100644
--- a/dir.c
+++ b/dir.c
@@ -813,6 +813,41 @@ static void free_simplify(struct path_simplify *simplify)
 	free(simplify);
 }
 
+static int treat_leading_path(struct dir_struct *dir,
+			      const char *path, int len,
+			      const struct path_simplify *simplify)
+{
+	char pathbuf[PATH_MAX];
+	int baselen, blen;
+	const char *cp;
+
+	while (len && path[len - 1] == '/')
+		len--;
+	if (!len)
+		return 1;
+	baselen = 0;
+	while (1) {
+		cp = path + baselen + !!baselen;
+		cp = memchr(cp, '/', path + len - cp);
+		if (!cp)
+			baselen = len;
+		else
+			baselen = cp - path;
+		memcpy(pathbuf, path, baselen);
+		pathbuf[baselen] = '\0';
+		if (!is_directory(pathbuf))
+			return 0;
+		if (simplify_away(pathbuf, baselen, simplify))
+			return 0;
+		blen = baselen;
+		if (treat_one_path(dir, pathbuf, &blen, simplify,
+				   DT_DIR, NULL) == path_ignored)
+			return 0; /* do not recurse into it */
+		if (len <= baselen)
+			return 1; /* finished checking */
+	}
+}
+
 int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
@@ -821,7 +856,8 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
-	read_directory_recursive(dir, path, len, 0, simplify);
+	if (!len || treat_leading_path(dir, path, len, simplify))
+		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index e3e4d71..9e71260 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -183,7 +183,7 @@ test_expect_success 'subdirectory ignore (l1/l2)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'subdirectory ignore (l1)' '
+test_expect_success 'subdirectory ignore (l1)' '
 	(
 		cd top/l1 &&
 		git ls-files -o --exclude-standard
-- 
1.6.6.209.g52296.dirty
