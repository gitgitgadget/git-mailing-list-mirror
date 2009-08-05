From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 3/6] Teach --id to "git checkout"
Date: Wed,  5 Aug 2009 17:51:43 +0800
Message-ID: <1249465906-3940-4-git-send-email-ayiehere@gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-3-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdFE-0005br-2P
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934052AbZHEJ5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933297AbZHEJ5G
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:57:06 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:65447 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933243AbZHEJ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:57:04 -0400
Received: by pzk34 with SMTP id 34so3444152pzk.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S88wCaS0PK3x4TeqaCQ7dbTw/VMODzqVm3AcLOug6Cg=;
        b=F1cOl3vydVgySVF1KUGcPubxBpT95VgOzQgjqJKbykIh2z4sohYkQdyvDcjWRdvjEv
         5Y9FjZe7REOC/uDz6bp3ONjXvsn9xFHHGKEQ+SJvPlE7pLVJw4SoWgMV5e+WTKQWKKON
         5YRv2H1Za3Q7C/tLW8QDgkIuONOE5tBnlOcCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LHeiEG4kBmt2bszXoolTA9AikVQOpJJWZCB59vbR4b5qFQdjVkjTGhP1aB1WOeKTz6
         AwCfvkH9bp3dbNytsBwcysRlrEXhSiddgyw/B473zd1PSJxOK54anUTcDTc4ebYF5iVj
         jRgFBSXqRyIcm7CDvswU+/m2BTdAoHskFa7eU=
Received: by 10.114.67.3 with SMTP id p3mr11377180waa.63.1249465818664;
        Wed, 05 Aug 2009 02:50:18 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <1249465906-3940-3-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124889>

---
 builtin-checkout.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 8a9a474..94ef419 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -32,6 +32,7 @@ struct checkout_opts {
 	int writeout_error;
 
 	const char *new_branch;
+	const char *file_id;
 	int new_branch_log;
 	enum branch_track track;
 };
@@ -583,6 +584,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_STRING('d', "id", &opts.file_id, "FILE_ID", "file id"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -597,6 +599,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	int has_dash_dash;
+	char **new_argv;
 
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
@@ -608,9 +611,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (opts.file_id)
+		new_argv = (char **) expand_file_ids(opts.file_id, &argc, (char **) argv);
+	else
+		new_argv = (char **) argv;
+
 	/* --track without -b should DWIM */
 	if (0 < opts.track && !opts.new_branch) {
-		const char *argv0 = argv[0];
+		const char *argv0 = new_argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die ("--track needs a branch name");
 		if (!prefixcmp(argv0, "refs/"))
@@ -655,14 +663,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *
 	 */
 	if (argc) {
-		if (!strcmp(argv[0], "--")) {       /* case (2) */
-			argv++;
+		if (!strcmp(new_argv[0], "--")) {       /* case (2) */
+			new_argv++;
 			argc--;
 			goto no_reference;
 		}
 
-		arg = argv[0];
-		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
+		arg = new_argv[0];
+		has_dash_dash = (argc > 1) && !strcmp(new_argv[1], "--");
 
 		if (!strcmp(arg, "-"))
 			arg = "@{-1}";
@@ -674,7 +682,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		}
 
 		/* we can't end up being in (2) anymore, eat the argument */
-		argv++;
+		new_argv++;
 		argc--;
 
 		new.name = arg;
@@ -702,14 +710,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				verify_non_filename(NULL, arg);
 		}
 		else {
-			argv++;
+			new_argv++;
 			argc--;
 		}
 	}
 
 no_reference:
 	if (argc) {
-		const char **pathspec = get_pathspec(prefix, argv);
+		const char **pathspec = get_pathspec(prefix, (const char **) new_argv);
 
 		if (!pathspec)
 			die("invalid path specification");
@@ -717,7 +725,7 @@ no_reference:
 		/* Checkout paths */
 		if (opts.new_branch) {
 			if (argc == 1) {
-				die("git checkout: updating paths is incompatible with switching branches.\nDid you intend to checkout '%s' which can not be resolved as commit?", argv[0]);
+				die("git checkout: updating paths is incompatible with switching branches.\nDid you intend to checkout '%s' which can not be resolved as commit?", new_argv[0]);
 			} else {
 				die("git checkout: updating paths is incompatible with switching branches.");
 			}
-- 
1.6.4.13.ge6580
