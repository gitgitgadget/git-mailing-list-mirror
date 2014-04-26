From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 1/4] replace: refactor command-mode determination
Date: Sat, 26 Apr 2014 22:00:54 +0200
Message-ID: <20140426200058.21546.78905.chriscool@tuxfamily.org>
References: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 26 22:02:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We8oL-0000ML-S0
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbaDZUCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 16:02:46 -0400
Received: from [194.158.98.45] ([194.158.98.45]:56637 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751293AbaDZUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 16:01:58 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id BE2875F;
	Sat, 26 Apr 2014 22:01:34 +0200 (CEST)
X-git-sha1: c378ca90a4cdfd829cfaba9306b7f793be977997 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247184>

From: Jeff King <peff@peff.net>

The git-replace command has three modes: listing, deleting,
and replacing. The first two are selected explicitly. If
none is selected, we fallback to listing when there are no
arguments, and replacing otherwise.

Let's figure out up front which operation we are going to
do, before getting into the application logic. That lets us
simplify our option checks (e.g., we currently have to check
whether a useless "--force" is given both along with an
explicit list, as well as with an implicit one).

This saves some lines, makes the logic easier to follow, and
will facilitate further cleanups.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..28db96f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -182,12 +182,16 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
+	if (!list && !delete)
+		if (!argc)
+			list = 1;
+
 	if (list && delete)
 		usage_msg_opt("-l and -d cannot be used together",
 			      git_replace_usage, options);
 
-	if (format && delete)
-		usage_msg_opt("--format and -d cannot be used together",
+	if (format && !list)
+		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
 	if (force && (list || delete))
@@ -207,9 +211,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			usage_msg_opt("bad number of arguments",
 				      git_replace_usage, options);
-		if (format)
-			usage_msg_opt("--format cannot be used when not listing",
-				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 	}
 
@@ -217,9 +218,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_msg_opt("only one pattern can be given with -l",
 			      git_replace_usage, options);
-	if (force)
-		usage_msg_opt("-f needs some arguments",
-			      git_replace_usage, options);
 
 	return list_replace_refs(argv[0], format);
 }
-- 
1.9.1.636.g20d5f34
