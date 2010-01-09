From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] read_directory(): further split treat_path()
Date: Fri,  8 Jan 2010 23:35:34 -0800
Message-ID: <1263022535-12822-3-git-send-email-gitster@pobox.com>
References: <1263022535-12822-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 08:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTVrp-0007FQ-UB
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 08:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0AIHgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 02:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352Ab0AIHgG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 02:36:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0AIHgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 02:36:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B77F8FB8A;
	Sat,  9 Jan 2010 02:36:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iSzT
	+SzMMN87y6w3o2AnhV0pqyc=; b=pPX6w2h8kgv+1hx9D/b34ayqcI7eO6f3ZHgv
	i1TdoMGEEWDufYWiNwrdBPL8Bwcf9MGZWnpoNIRxn//zpZJ3kis3EzEpG5STgjMb
	/A2v7ECit9BqFd0a4PCiM//AZ+DcuWdJw3usFRgZqEqbD0AFa3hUTMS8KHf0FDJh
	T19WR5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	MB4GkrMFouliLRx72nJU4WMUr82TuAQO+S+XGOr2R/Tjak8Wapn0izlzNJeSEtxY
	QnHDbh7Su/+gkpEO2CQpM0PjDZ4yz4jbInS8tFl67W3Ds65XQvzxMS6jtttoj08c
	k0bNkNdRpVxuB0NHBZUc1qTLXbtZx15jACxH5TthW04=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E590B8FB82;
	Sat,  9 Jan 2010 02:35:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8D478FB79; Sat,  9 Jan
 2010 02:35:51 -0500 (EST)
X-Mailer: git-send-email 1.6.6.209.g52296.dirty
In-Reply-To: <1263022535-12822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A09492D2-FCF1-11DE-B30A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136523>

The next caller I'll be adding won't have an access to struct dirent
because it won't be reading from a directory stream.  Split the main
part of the function further into a separate function to make it usable
by a caller without passing a dirent as long as it knows what type is
feeding the function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |   50 +++++++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/dir.c b/dir.c
index dec8365..35cc89b 100644
--- a/dir.c
+++ b/dir.c
@@ -631,28 +631,12 @@ enum path_treatment {
 	path_recurse,
 };
 
-static enum path_treatment treat_path(struct dir_struct *dir,
-				      struct dirent *de,
-				      char *path, int path_max,
-				      int baselen,
-				      const struct path_simplify *simplify,
-				      int *len)
+static enum path_treatment treat_one_path(struct dir_struct *dir,
+					  char *path, int *len,
+					  const struct path_simplify *simplify,
+					  int dtype, struct dirent *de)
 {
-	int dtype, exclude;
-
-	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
-		return path_ignored;
-	*len = strlen(de->d_name);
-	/* Ignore overly long pathnames! */
-	if (*len + baselen + 8 > path_max)
-		return path_ignored;
-	memcpy(path + baselen, de->d_name, *len + 1);
-	*len += baselen;
-	if (simplify_away(path, *len, simplify))
-		return path_ignored;
-
-	dtype = DTYPE(de);
-	exclude = excluded(dir, path, &dtype);
+	int exclude = excluded(dir, path, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && in_pathspec(path, *len, simplify))
 		dir_add_ignored(dir, path, *len);
@@ -703,6 +687,30 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	return path_handled;
 }
 
+static enum path_treatment treat_path(struct dir_struct *dir,
+				      struct dirent *de,
+				      char *path, int path_max,
+				      int baselen,
+				      const struct path_simplify *simplify,
+				      int *len)
+{
+	int dtype;
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
+	return treat_one_path(dir, path, len, simplify, dtype, de);
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
-- 
1.6.6.209.g52296.dirty
