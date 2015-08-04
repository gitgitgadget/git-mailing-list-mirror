From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/6] clone: do not include authentication data in guessed dir
Date: Tue,  4 Aug 2015 13:29:54 +0200
Message-ID: <1438687797-14254-4-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQR-0006sg-8t
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413AbbHDLaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36856 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933201AbbHDLaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:16 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id BF02120C14
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:15 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 04 Aug 2015 07:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3pzT
	Hg7fCsIEk/U8/n1zFLNcbTI=; b=QWKyToY80+6BlRj2YaWvvPt6ML46qcTbO60g
	aJrzLkXxSPwag/kOlt4ojT4Zw4HYtprwZ4IxL7LjWCBCB26hXQoC1Sk0tHNvoBmA
	TF05ARvBxNDLJGXV3W90N91vQ86a/Q0QmLf+NmCKs0XGVNqkGD6WIZSEpf+P5GlZ
	6ZT5wBc=
X-Sasl-enc: jygk3DQ8KsoeEoffVUby+trjB1mZVFpIw59mrQ4XdXrT 1438687815
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 41674C00012;
	Tue,  4 Aug 2015 07:30:15 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275244>

If the URI contains authentication data and the URI's path
component is empty we fail to guess a sensible directory name.
E.g. cloning a repository 'ssh://user:password@example.com/' we
guess a directory name 'password@example.com' where we would want
the hostname only, e.g. 'example.com'.

Fix this by first skipping authentication data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a72ff7e..794a933 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -146,35 +146,59 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 
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
+	 * directory 'bar' being guessed. This is skipped if the
+	 * current path does not contain any path separators.
 	 */
-	start = end;
-	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
-		start--;
+	if (memchr(start, '/', end - start) != NULL
+	    || memchr(start, ':', end - start) != NULL) {
+		start = end;
+		while (!is_dir_sep(start[-1]) && start[-1] != ':')
+			start--;
+	}
+	len = end - start;
 
 	/*
 	 * Strip .{bundle,git}.
 	 */
-	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
+	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
 
 	if (is_bare)
 		dir = xstrfmt("%.*s.git", (int)len, start);
-- 
2.5.0
