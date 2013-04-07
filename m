From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] rev-parse: add --filename-prefix option
Date: Sun,  7 Apr 2013 20:55:20 +0100
Message-ID: <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
References: <cover.1365364193.git.john@keeping.me.uk>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p7-0000sy-EB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793Ab3DGTzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:55:40 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55068 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933430Ab3DGTzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:55:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 986E06064E0;
	Sun,  7 Apr 2013 20:55:39 +0100 (BST)
X-Quarantine-ID: <lKaleIshpoSn>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lKaleIshpoSn; Sun,  7 Apr 2013 20:55:39 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 7223C6064EA;
	Sun,  7 Apr 2013 20:55:32 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365364193.git.john@keeping.me.uk>
In-Reply-To: <cover.1365364193.git.john@keeping.me.uk>
References: <cover.1365364193.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220366>

This adds a prefix string to any filename arguments encountered after it
has been specified.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/rev-parse.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f267a1d..11501a4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -212,11 +212,12 @@ static void show_datestring(const char *flag, const char *datestr)
 	show(buffer);
 }
 
-static int show_file(const char *arg)
+static int show_file(const char *arg, const char *prefix)
 {
 	show_default();
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
-		show(arg);
+		size_t prefixlen = prefix ? strlen(prefix) : 0;
+		show(prefix_filename(prefix, prefixlen, arg));
 		return 1;
 	}
 	return 0;
@@ -470,6 +471,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+	const char *filename_prefix = NULL;
 	unsigned char sha1[20];
 	const char *name = NULL;
 
@@ -503,7 +505,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (as_is) {
-			if (show_file(arg) && as_is < 2)
+			if (show_file(arg, filename_prefix) && as_is < 2)
 				verify_filename(prefix, arg, 0);
 			continue;
 		}
@@ -527,7 +529,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				as_is = 2;
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
-					show_file(arg);
+					show_file(arg, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
@@ -535,6 +537,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				i++;
 				continue;
 			}
+			if (!strcmp(arg, "--filename-prefix")) {
+				filename_prefix = argv[i+1];
+				i++;
+				continue;
+			}
 			if (!strcmp(arg, "--revs-only")) {
 				filter &= ~DO_NOREV;
 				continue;
@@ -754,7 +761,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (verify)
 			die_no_single_rev(quiet);
 		as_is = 1;
-		if (!show_file(arg))
+		if (!show_file(arg, filename_prefix))
 			continue;
 		verify_filename(prefix, arg, 1);
 	}
-- 
1.8.2.694.ga76e9c3.dirty
