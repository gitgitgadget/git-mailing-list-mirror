From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] ls-files -k: a directory only can be killed if the index has a non-directory
Date: Thu, 15 Aug 2013 14:28:09 -0700
Message-ID: <1376602090-19142-3-git-send-email-gitster@pobox.com>
References: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
 <1376602090-19142-1-git-send-email-gitster@pobox.com>
Cc: Petr Baudis <pasky@ucw.cz>, Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 23:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA55n-0000iF-V2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3HOV2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:28:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3HOV2S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:28:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C29397DB;
	Thu, 15 Aug 2013 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oEda
	NV64qDeIf/AW4byI1rZRJS8=; b=KQNrjko3tLwqhw9HoA/GzDJhHosDcLy9hDft
	pcIFyx1hR9aF/9B7u64hkSYXxWMbSrRi/u1aNYSKJyHa2W70ErVOne4cXXppjtEN
	+Xiii+IbObVwN1//KW0XK2MMe3Xk34xKvDwGgPcejcYEt073A7Tlq03BqQuUXsbx
	vAU1dq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	RWPJ7dtUPNpjY5d6B9D9XoeTB4bQCroegX3cTzCtHttj2KFw6eCCfTJc1liup0WR
	oNihLZY3Qf21vtXuBogYgs7yapQkVG2gjWMDXqU39g77+XfUH68CNCseVG5VVWQb
	FD8qTkhFFw3VzrnkiMZH1XUQwz1Id7a0fxcQRvfF/vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23F71397DA;
	Thu, 15 Aug 2013 21:28:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48CC6397D9;
	Thu, 15 Aug 2013 21:28:16 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc3-232-ga8053f8
In-Reply-To: <1376602090-19142-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 98FAD27C-05F1-11E3-9481-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232373>

"ls-files -o" and "ls-files -k" both traverse the working tree down
to find either all untracked paths or those that will be "killed"
(removed from the working tree to make room) when the paths recorded
in the index are checked out.  It is necessary to traverse the
working tree fully when enumerating all the "other" paths, but when
we are only interested in "killed" paths, we can take advantage of
the fact that paths that do not overlap with entries in the index
can never be killed.

The treat_one_path() helper function, which is called during the
recursive traversal, is the ideal place to implement an
optimization.

When we are looking at a directory P in the working tree, there are
three cases:

 (1) P exists in the index.  Everything inside the directory P in
     the working tree needs to go when P is checked out from the
     index.

 (2) P does not exist in the index, but there is P/Q in the index.
     We know P will stay a directory when we check out the contents
     of the index, but we do not know yet if there is a directory
     P/Q in the working tree to be killed, so we need to recurse.

 (3) P does not exist in the index, and there is no P/Q in the index
     to require P to be a directory, either.  Only in this case, we
     know that everything inside P will not be killed without
     recursing.

Note that this helper is called by treat_leading_path() that decides
if we need to traverse only subdirectories of a single common
leading directory, which is essential for this optimization to be
correct.  This caller checks each level of the leading path
component from shallower directory to deeper ones, and that is what
allows us to only check if the path appears in the index.  If the
call to treat_one_path() weren't there, given a path P/Q/R, the real
traversal may start from directory P/Q/R, even when the index
records P as a regular file, and we would end up having to check if
any leading subpath in P/Q/R, e.g. P, appears in the index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c |  2 ++
 dir.c              | 29 +++++++++++++++++++++++++++--
 dir.h              |  3 ++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2202072..c7eb6f4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -213,6 +213,8 @@ static void show_files(struct dir_struct *dir)
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
+		if (!show_others)
+			dir->flags |= DIR_COLLECT_KILLED_ONLY;
 		fill_directory(dir, pathspec);
 		if (show_others)
 			show_other_files(dir);
diff --git a/dir.c b/dir.c
index 2f82cd1..ff768f3 100644
--- a/dir.c
+++ b/dir.c
@@ -1173,12 +1173,37 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
+	int has_path_in_index = !!cache_name_exists(path->buf, path->len, ignore_case);
+
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, path->buf, path->len);
 
 	/* Always exclude indexed files */
-	if (dtype != DT_DIR &&
-	    cache_name_exists(path->buf, path->len, ignore_case))
+	if (dtype != DT_DIR && has_path_in_index)
+		return path_none;
+
+	/*
+	 * When we are looking at a directory P in the working tree,
+	 * there are three cases:
+	 *
+	 * (1) P exists in the index.  Everything inside the directory P in
+	 * the working tree needs to go when P is checked out from the
+	 * index.
+	 *
+	 * (2) P does not exist in the index, but there is P/Q in the index.
+	 * We know P will stay a directory when we check out the contents
+	 * of the index, but we do not know yet if there is a directory
+	 * P/Q in the working tree to be killed, so we need to recurse.
+	 *
+	 * (3) P does not exist in the index, and there is no P/Q in the index
+	 * to require P to be a directory, either.  Only in this case, we
+	 * know that everything inside P will not be killed without
+	 * recursing.
+	 */
+	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
+	    (dtype == DT_DIR) &&
+	    !has_path_in_index &&
+	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
 		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
diff --git a/dir.h b/dir.h
index 3d6b80c..4677b86 100644
--- a/dir.h
+++ b/dir.h
@@ -80,7 +80,8 @@ struct dir_struct {
 		DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
 		DIR_NO_GITLINKS = 1<<3,
 		DIR_COLLECT_IGNORED = 1<<4,
-		DIR_SHOW_IGNORED_TOO = 1<<5
+		DIR_SHOW_IGNORED_TOO = 1<<5,
+		DIR_COLLECT_KILLED_ONLY = 1<<6
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
-- 
1.8.4-rc3-232-ga8053f8
