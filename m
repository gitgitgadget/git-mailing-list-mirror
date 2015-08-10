From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 3/5] clone: do not include authentication data in guessed dir
Date: Mon, 10 Aug 2015 17:48:23 +0200
Message-ID: <1439221705-20336-4-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1439221705-20336-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOpJm-0002XR-SU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbbHJPsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:48:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36880 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754503AbbHJPsf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 11:48:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2AD1220DB1
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:35 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 10 Aug 2015 11:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=UYLo
	LPwyamK4Ligh4Ugnz9l+uWM=; b=QC9N7ZuHOudcb7Xn5IMfbNQbBPc7wiAxRtdi
	4IchcYBEMuwKZe/7KINcLpjH6/LKkvjW/ndPos71JYv1vXpbAHkmLhS8k4dmJZEA
	6Nsy4qmrSSZS3+tXdCoBhC6XTxH0hAk8W4m628NC1BQ2oMCqvC4mQA7viUBvUjYx
	rFqz3vc=
X-Sasl-enc: 5ghPRJtQrFCjQsKy/GCKJl8Ii7MiQ4bivKD5SEdzcJQS 1439221714
Received: from localhost (x5ce1243b.dyn.telefonica.de [92.225.36.59])
	by mail.messagingengine.com (Postfix) with ESMTPA id AD240C00022;
	Mon, 10 Aug 2015 11:48:34 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439221705-20336-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275629>

If the URI contains authentication data and the URI's path
component is empty we fail to guess a sensible directory name.
E.g. cloning a repository 'ssh://user:password@example.com/' we
guess a directory name 'password@example.com' where we would want
the hostname only, e.g. 'example.com'.

The naive way of just adding '@' as a path separator would break
cloning repositories like 'foo/bar@baz.git' (which would
currently become 'bar@baz' but would then become 'baz' only).
Instead fix this by first dropping the scheme and then greedily
scanning for an '@' sign until we find the first path separator.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c          | 41 +++++++++++++++++++++++++++++++----------
 t/t5603-clone-dirname.sh |  4 ++--
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bf45199..da51792 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -146,30 +146,51 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
-	const char *end = repo + strlen(repo), *start;
+	const char *end = repo + strlen(repo), *start, *ptr;
 	size_t len;
 	char *dir;
 
 	/*
+	 * Skip scheme.
+	 */
+	start = strstr(repo, "://");
+	if (start == NULL)
+		start = repo;
+	else
+		start += 3;
+
+	/*
+	 * Skip authentication data. The stripping does happen
+	 * greedily, such that we strip up to the last '@' inside
+	 * the host part.
+	 */
+	for (ptr = start; ptr < end && !is_dir_sep(*ptr); ptr++) {
+		if (*ptr == '@')
+			start = ptr + 1;
+	}
+
+	/*
 	 * Strip trailing spaces, slashes and /.git
 	 */
-	while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
+	while (start < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
 		end--;
-	if (end - repo > 5 && is_dir_sep(end[-5]) &&
+	if (end - start > 5 && is_dir_sep(end[-5]) &&
 	    !strncmp(end - 4, ".git", 4)) {
 		end -= 5;
-		while (repo < end && is_dir_sep(end[-1]))
+		while (start < end && is_dir_sep(end[-1]))
 			end--;
 	}
 
 	/*
-	 * Find last component, but be prepared that repo could have
-	 * the form  "remote.example.com:foo.git", i.e. no slash
-	 * in the directory part.
+	 * Find last component. To remain backwards compatible we
+	 * also regard colons as path separators, such that
+	 * cloning a repository 'foo:bar.git' would result in a
+	 * directory 'bar' being guessed.
 	 */
-	start = end;
-	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
-		start--;
+	ptr = end;
+	while (start < ptr && !is_dir_sep(ptr[-1]) && ptr[-1] != ':')
+		ptr--;
+	start = ptr;
 
 	/*
 	 * Strip .{bundle,git}.
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 10f5d09..a9aba72 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -74,11 +74,11 @@ test_clone_dir host:foo/.git/// foo
 # omitting the path should default to the hostname
 test_clone_dir ssh://host/ host
 test_clone_dir ssh://host:1234/ host fail
-test_clone_dir ssh://user@host/ host fail
+test_clone_dir ssh://user@host/ host
 test_clone_dir host:/ host fail
 
 # auth materials should be redacted
-test_clone_dir ssh://user:password@host/ host fail
+test_clone_dir ssh://user:password@host/ host
 test_clone_dir ssh://user:password@host:1234/ host fail
 test_clone_dir ssh://user:passw@rd@host:1234/ host fail
 test_clone_dir user@host:/ host fail
-- 
2.5.0
