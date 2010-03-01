From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] builtin-add: fix exclude handling
Date: Mon, 01 Mar 2010 00:26:37 -0800
Message-ID: <7vzl2s4fcy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 09:26:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm0xj-0007st-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 09:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813Ab0CAI0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 03:26:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0CAI0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 03:26:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CFD9D306;
	Mon,  1 Mar 2010 03:26:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Fhzv
	c+lkDmD94NaHrwH4E/V7WHA=; b=cxW7aaRB3GofqozjD4p4bQR0Pe2dkQ3upEXn
	IPhJqgsUCjwc+qzgZK4J8HCOvflKVL9U/y/adxfQ05xw85ND58AaQWLThWbEzRkJ
	oPWPhFVCRrXp7rLx1ocJ5s212sARWfkjqfPxtt55wDMEVeVGlP600Ptal0DsIZts
	9FYAYDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Fyl
	l2QPEP89wU1Ujml6ATMLsb768bFD7a8wQEjD11L/CsTa6QFcSWBwkeL4Jhavpgsm
	C4QEetwAVISSVtrmxA3QYbTepkWB4BC68fX1u97nsZ2M0sIpWlUEvvWM3VXBhb7B
	WLlwus6m0aoIfYSPCOkXXC1bTWilWNZjZoTzYGoA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BBC29D305;
	Mon,  1 Mar 2010 03:26:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99F2A9D302; Mon,  1 Mar
 2010 03:26:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2913B9FC-250C-11DF-AC17-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141305>

After we finish walking the working tree to find paths to add, the
prune_directory() function checks the pathspecs to find typoes in
them.  When a given pathspec did not produce any match (either in the
untracked files, or paths already in the index), there are two cases:

 - "git add no-such-file", i.e. the pathspec was misspelled; or

 - "git add ignored-pattern.o", i.e. the pathspec exactly matches but is
   ignored by the traversal.

For the former, the function immediately errored out.  The latter were
queued in the dir structure and later used to give an error message with
"use -f if you really mean it" advice.

e96980e (builtin-add: simplify (and increase accuracy of) exclude
handling, 2007-06-12) somehow lost the latter.  This adds the logic back,
but with a bit of twist, as the code after e96980e uses collect_ignored
option that does half the necessary work during the traversal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |   23 ++++++++++++++++++++---
 dir.c         |   10 ++++------
 dir.h         |    2 ++
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index cb6e590..c24c1bf 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -63,9 +63,26 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	fill_pathspec_matches(pathspec, seen, specs);
 
 	for (i = 0; i < specs; i++) {
-		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
-			die("pathspec '%s' did not match any files",
-					pathspec[i]);
+		const char *match;
+		if (seen[i])
+			continue;
+		match = pathspec[i];
+		if (!match[0])
+			continue;
+
+		/* Existing file?  We must have ignored it */
+		if (file_exists(match)) {
+			int len = strlen(match);
+			int i;
+			for (i = 0; i < dir->ignored_nr; i++)
+				if (dir->ignored[i]->len == len &&
+				    !memcmp(dir->ignored[i]->name, match, len))
+					break;
+			if (dir->ignored_nr <= i)
+				dir_add_ignored(dir, match, strlen(match));
+			continue;
+		}
+		die("pathspec '%s' did not match any files", match);
 	}
         free(seen);
 }
diff --git a/dir.c b/dir.c
index 00d698d..11d8954 100644
--- a/dir.c
+++ b/dir.c
@@ -413,13 +413,10 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
-static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+void dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (!cache_name_is_other(pathname, len))
-		return NULL;
-
 	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
-	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
+	dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
 }
 
 enum exist_status {
@@ -638,7 +635,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude = excluded(dir, path, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && in_pathspec(path, *len, simplify))
+	    && in_pathspec(path, *len, simplify)
+	    && cache_name_is_other(path, *len))
 		dir_add_ignored(dir, path, *len);
 
 	/*
diff --git a/dir.h b/dir.h
index 320b6a2..9bc3337 100644
--- a/dir.h
+++ b/dir.h
@@ -96,4 +96,6 @@ extern int remove_dir_recursively(struct strbuf *path, int flag);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
+extern void dir_add_ignored(struct dir_struct *, const char *, int);
+
 #endif
-- 
1.7.0.1.241.g6604f
