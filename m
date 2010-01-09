From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] read_directory_recursive(): refactor handling of a
 single path into a separate function
Date: Fri,  8 Jan 2010 23:35:33 -0800
Message-ID: <1263022535-12822-2-git-send-email-gitster@pobox.com>
References: <1263022535-12822-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 08:36:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTVrc-0007BO-S2
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 08:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab0AIHf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 02:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909Ab0AIHf5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 02:35:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0AIHf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 02:35:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3EC48FB7D;
	Sat,  9 Jan 2010 02:35:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mxwf
	DItOJWM2r5dF5sSof1mGhps=; b=dmhfkNhxbOARTPKIcocmAYIMUGraNqDMg0Tb
	d3NaaweK3nugZ+iA9pGEsh1ja9j4R2cGCc8MXxbOMUrrlftapevUX211wZvX6Euu
	LHB92MZy8Yh2zle6pv+Jb5t5E8F/mzY9HoctsGoyfT3Qt1nqix+O7Q2Cysc4YlGu
	KLVJJJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	w3JPDoxKQ/I6z31rxNAWGfXHUFQIIKqhWrJ0bmR6oKppWH6y0EeUGG0zLceFjLh9
	d6RtOYnwAHi7vdFW6S8NFDLRjo996WgGfjepKL8MIPg7GJqxe+1fDlI3a/l3cjjo
	MaI+Qcd49j+oOGBRcuHffpcbQ4TOMIpqsomaB8Fv94Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82E358FB78;
	Sat,  9 Jan 2010 02:35:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 366F78FB75; Sat,  9 Jan
 2010 02:35:44 -0500 (EST)
X-Mailer: git-send-email 1.6.6.209.g52296.dirty
In-Reply-To: <1263022535-12822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9C2A4E94-FCF1-11DE-B07B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136522>

Primarily because I want to reuse it in a separate function later,
but this de-dents a huge function by one tabstop which by itself is
an improvement as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |  153 ++++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 90 insertions(+), 63 deletions(-)

diff --git a/dir.c b/dir.c
index d0999ba..dec8365 100644
--- a/dir.c
+++ b/dir.c
@@ -625,6 +625,84 @@ static int get_dtype(struct dirent *de, const char *path, int len)
 	return dtype;
 }
 
+enum path_treatment {
+	path_ignored,
+	path_handled,
+	path_recurse,
+};
+
+static enum path_treatment treat_path(struct dir_struct *dir,
+				      struct dirent *de,
+				      char *path, int path_max,
+				      int baselen,
+				      const struct path_simplify *simplify,
+				      int *len)
+{
+	int dtype, exclude;
+
+	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
+		return path_ignored;
+	*len = strlen(de->d_name);
+	/* Ignore overly long pathnames! */
+	if (*len + baselen + 8 > path_max)
+		return path_ignored;
+	memcpy(path + baselen, de->d_name, *len + 1);
+	*len += baselen;
+	if (simplify_away(path, *len, simplify))
+		return path_ignored;
+
+	dtype = DTYPE(de);
+	exclude = excluded(dir, path, &dtype);
+	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
+	    && in_pathspec(path, *len, simplify))
+		dir_add_ignored(dir, path, *len);
+
+	/*
+	 * Excluded? If we don't explicitly want to show
+	 * ignored files, ignore it
+	 */
+	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
+		return path_ignored;
+
+	if (dtype == DT_UNKNOWN)
+		dtype = get_dtype(de, path, *len);
+
+	/*
+	 * Do we want to see just the ignored files?
+	 * We still need to recurse into directories,
+	 * even if we don't ignore them, since the
+	 * directory may contain files that we do..
+	 */
+	if (!exclude && (dir->flags & DIR_SHOW_IGNORED)) {
+		if (dtype != DT_DIR)
+			return path_ignored;
+	}
+
+	switch (dtype) {
+	default:
+		return path_ignored;
+	case DT_DIR:
+		memcpy(path + *len, "/", 2);
+		(*len)++;
+		switch (treat_directory(dir, path, *len, simplify)) {
+		case show_directory:
+			if (exclude != !!(dir->flags
+					  & DIR_SHOW_IGNORED))
+				return path_ignored;
+			break;
+		case recurse_into_directory:
+			return path_recurse;
+		case ignore_directory:
+			return path_ignored;
+		}
+		break;
+	case DT_REG:
+	case DT_LNK:
+		break;
+	}
+	return path_handled;
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -634,7 +712,10 @@ static int get_dtype(struct dirent *de, const char *path, int len)
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
+static int read_directory_recursive(struct dir_struct *dir,
+				    const char *base, int baselen,
+				    int check_only,
+				    const struct path_simplify *simplify)
 {
 	DIR *fdir = opendir(*base ? base : ".");
 	int contents = 0;
@@ -645,70 +726,16 @@ static int read_directory_recursive(struct dir_struct *dir, const char *base, in
 		memcpy(path, base, baselen);
 
 		while ((de = readdir(fdir)) != NULL) {
-			int len, dtype;
-			int exclude;
-
-			if (is_dot_or_dotdot(de->d_name) ||
-			     !strcmp(de->d_name, ".git"))
-				continue;
-			len = strlen(de->d_name);
-			/* Ignore overly long pathnames! */
-			if (len + baselen + 8 > sizeof(path))
+			int len;
+			switch (treat_path(dir, de, path, sizeof(path),
+					   baselen, simplify, &len)) {
+			case path_recurse:
+				contents += read_directory_recursive
+					(dir, path, len, 0, simplify);
 				continue;
-			memcpy(path + baselen, de->d_name, len+1);
-			len = baselen + len;
-			if (simplify_away(path, len, simplify))
+			case path_ignored:
 				continue;
-
-			dtype = DTYPE(de);
-			exclude = excluded(dir, path, &dtype);
-			if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-			    && in_pathspec(path, len, simplify))
-				dir_add_ignored(dir, path,len);
-
-			/*
-			 * Excluded? If we don't explicitly want to show
-			 * ignored files, ignore it
-			 */
-			if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
-				continue;
-
-			if (dtype == DT_UNKNOWN)
-				dtype = get_dtype(de, path, len);
-
-			/*
-			 * Do we want to see just the ignored files?
-			 * We still need to recurse into directories,
-			 * even if we don't ignore them, since the
-			 * directory may contain files that we do..
-			 */
-			if (!exclude && (dir->flags & DIR_SHOW_IGNORED)) {
-				if (dtype != DT_DIR)
-					continue;
-			}
-
-			switch (dtype) {
-			default:
-				continue;
-			case DT_DIR:
-				memcpy(path + len, "/", 2);
-				len++;
-				switch (treat_directory(dir, path, len, simplify)) {
-				case show_directory:
-					if (exclude != !!(dir->flags
-							& DIR_SHOW_IGNORED))
-						continue;
-					break;
-				case recurse_into_directory:
-					contents += read_directory_recursive(dir,
-						path, len, 0, simplify);
-					continue;
-				case ignore_directory:
-					continue;
-				}
-				break;
-			case DT_REG:
-			case DT_LNK:
+			case path_handled:
 				break;
 			}
 			contents++;
-- 
1.6.6.209.g52296.dirty
