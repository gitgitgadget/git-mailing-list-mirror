From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/3] clone: do not include authentication data in guessed dir
Date: Wed,  5 Aug 2015 12:06:17 +0200
Message-ID: <1438769179-5943-2-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438769179-5943-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 12:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMvag-0003jI-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 12:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbHEKG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 06:06:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39360 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838AbbHEKG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 06:06:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BB0EC20B40
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 06:06:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 05 Aug 2015 06:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qS2+
	Y5jksHHUA5ufjrmkgyfzD7I=; b=X2F2anV/UNs9F09j70sB1DJCSOsm6RAJDM/W
	N+OQazNoCGA/QW6AyNX6ojQOiyKUysWwnjouNoh15+e6cJcxUIsITFkuU0B3qGm7
	QW01ZtDnOyHLSl3NIYAMdVBBuFNM9MjJm2eXbOT/ueoLJjp3LkG3GQRjg/xvIwAO
	6mDRURk=
X-Sasl-enc: ZghY5PoEWA2Y8B8PxNvutuqXZn4JZdbCsqWCOLnaUoGx 1438769185
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4BE166801C2;
	Wed,  5 Aug 2015 06:06:25 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438769179-5943-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275365>

If the URI contains authentication data and the URI's path
component is empty we fail to guess a sensible directory name.
E.g. cloning a repository 'ssh://user:password@example.com/' we
guess a directory name 'password@example.com' where we would want
the hostname only, e.g. 'example.com'.

Fix this by first skipping authentication data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c          | 40 ++++++++++++++++++++++++++++++----------
 t/t5603-clone-dirname.sh |  3 ++-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bf45199..3ddf8b9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -146,30 +146,50 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 
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
+	 * Skip authentication data.
+	 */
+	ptr = start;
+	while (ptr < end && !is_dir_sep(*ptr) && *ptr != '@')
+		ptr++;
+	if (*ptr == '@')
+		start = ptr + 1;
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
index 46725b9..3a454f9 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -64,6 +64,7 @@ test_clone_dir ssh://host/foo/.git/ foo
 # omitting the path should default to the hostname
 test_clone_dir ssh://host/ host
 test_clone_dir ssh://host:1234/ host fail
-test_clone_dir ssh://user@host/ host fail
+test_clone_dir ssh://user@host/ host
+test_clone_dir ssh://user:password@host/ host
 
 test_done
-- 
2.5.0
