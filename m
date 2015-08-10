From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/5] clone: use computed length in guess_dir_name
Date: Mon, 10 Aug 2015 17:48:22 +0200
Message-ID: <1439221705-20336-3-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1439221705-20336-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOpJo-0002XR-PB
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbbHJPsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:48:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36726 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754437AbbHJPse (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 11:48:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A356C20F98
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:33 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 10 Aug 2015 11:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qLNB
	duNXpROmAiX/a2glPqzm3Zw=; b=oi9wta0/G+QGFD3j05fQLMoyqKWB2iNuPa9Q
	1hyRQduIVGIbHPy3P5wuMei4WjZS7MjXZTgKswnKUNND0IP2+CE73vAa68GEyiLr
	4RoXo3MFg47GJCvSNpnARJcxrcaYxTyr8w095rbuhhmS0terlDubXl8mVv8pMVs2
	6qvmW5c=
X-Sasl-enc: aNqfw07dDa706IweqlyhtkboHpL6aKTyYvUpUYVaI8Xz 1439221713
Received: from localhost (x5ce1243b.dyn.telefonica.de [92.225.36.59])
	by mail.messagingengine.com (Postfix) with ESMTPA id 37BF368011F;
	Mon, 10 Aug 2015 11:48:33 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439221705-20336-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275627>

From: Jeff King <peff@peff.net>

Commit 7e837c6 (clone: simplify string handling in
guess_dir_name(), 2015-07-09) changed clone to use
strip_suffix instead of hand-rolled pointer manipulation.
However, strip_suffix will strip from the end of a
NUL-terminated string, and we may have already stripped some
characters (like directory separators, or "/.git"). This
leads to commands like:

  git clone host:foo.git/

failing to strip the ".git".

We must instead convert our pointer arithmetic into a
computed length and feed that to strip_suffix_mem, which will
then reduce the length further for us.

It would be nicer if we could drop the pointer manipulation
entirely, and just continually strip using strip_suffix. But
that doesn't quite work for two reasons:

  1. The early suffixes we're stripping are not constant; we
     need to look for is_dir_sep, which could be one of
     several characters.

  2. Mid-way through the stripping we compute the pointer
     "start", which shows us the beginning of the pathname.
     Which really give us two lengths to work with: the
     offset from the start of the string, and from the start
     of the path. By using pointers for the early part, we
     can just compute the length from "start" when we need
     it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c          |  3 ++-
 t/t5603-clone-dirname.sh | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 303a3a7..bf45199 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -174,7 +174,8 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	/*
 	 * Strip .{bundle,git}.
 	 */
-	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
+	len = end - start;
+	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
 
 	if (is_bare)
 		dir = xstrfmt("%.*s.git", (int)len, start);
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index b009a87..10f5d09 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -46,7 +46,7 @@ test_clone_dir host:foo foo.git bare
 test_clone_dir host:foo.git foo
 test_clone_dir host:foo.git foo.git bare
 test_clone_dir host:foo/.git foo
-test_clone_dir host:foo/.git foo.git bare fail
+test_clone_dir host:foo/.git foo.git bare
 
 # similar, but using ssh URL rather than host:path syntax
 test_clone_dir ssh://host/foo foo
@@ -54,20 +54,20 @@ test_clone_dir ssh://host/foo foo.git bare
 test_clone_dir ssh://host/foo.git foo
 test_clone_dir ssh://host/foo.git foo.git bare
 test_clone_dir ssh://host/foo/.git foo
-test_clone_dir ssh://host/foo/.git foo.git bare fail
+test_clone_dir ssh://host/foo/.git foo.git bare
 
 # we should remove trailing slashes and .git suffixes
 test_clone_dir ssh://host/foo/ foo
 test_clone_dir ssh://host/foo/// foo
-test_clone_dir ssh://host/foo.git/ foo fail
-test_clone_dir ssh://host/foo.git/// foo fail
+test_clone_dir ssh://host/foo.git/ foo
+test_clone_dir ssh://host/foo.git/// foo
 test_clone_dir ssh://host/foo///.git/ foo
 test_clone_dir ssh://host/foo/.git/// foo
 
 test_clone_dir host:foo/ foo
 test_clone_dir host:foo/// foo
-test_clone_dir host:foo.git/ foo fail
-test_clone_dir host:foo.git/// foo fail
+test_clone_dir host:foo.git/ foo
+test_clone_dir host:foo.git/// foo
 test_clone_dir host:foo///.git/ foo
 test_clone_dir host:foo/.git/// foo
 
-- 
2.5.0
