From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 6/6] Teach --id to "git reset"
Date: Wed,  5 Aug 2009 17:51:46 +0800
Message-ID: <1249465906-3940-7-git-send-email-ayiehere@gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-3-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-4-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-5-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-6-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:57:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdFD-0005br-9R
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934014AbZHEJ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933297AbZHEJ5E
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:57:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:58683 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046AbZHEJ5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:57:03 -0400
Received: by wa-out-1112.google.com with SMTP id j5so710481wah.21
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o+F+IYVQNo8MqcbksAPH1RCjQE+cQs8QgLQPP7hQa6s=;
        b=dsyR5namEWs8mEzXjT1alcWVQBSGaqsd+ZRq4E8LJ8g0QEqJmGHr/VGxTj3EQSZD+m
         +9WE3p4IaOcH4z2XiSJwWh3aumHY+hWqMhPaG3Ml7l1vDcyV+VNdge9quj6HssOcDCmk
         MCdvslZfydxcLeGedA4JKUUtVtya8kYrscp7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wUPObNOTHNlvDbNRTXOU/0knnKDTVtMGB4q77c3SKu5wwjh6M7XdlAzVuBUyIIecuy
         99jyJjU73vF5wa8l8Kj3rLK/KtJRPJU0+iyAJ1mnADeK28bmyeCAeRLgaBiEicg/Qv2P
         0vjR7x1DSCzyhp4ajtNhgz7kCnKtgrsPyhUCo=
Received: by 10.114.126.1 with SMTP id y1mr11309120wac.91.1249465827942;
        Wed, 05 Aug 2009 02:50:27 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <1249465906-3940-6-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124888>

---
 builtin-reset.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 5fa1789..cad5cf5 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -183,6 +183,8 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	char *file_id;
+	char **new_argv;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
@@ -198,6 +200,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", MERGE),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
+		OPT_STRING('d', "id", &file_id, "FILE_ID", "file id"),
 		OPT_END()
 	};
 
@@ -205,7 +208,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-	reflog_action = args_to_str(argv);
+	if (file_id)
+		new_argv = (char **) expand_file_ids(file_id, &argc, (char **) argv);
+	else
+		new_argv = (char **) argv;
+
+	reflog_action = args_to_str((const char **) new_argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
 	/*
@@ -216,30 +224,30 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	 * git reset [-opts] -- <paths>...
 	 * git reset [-opts] <paths>...
 	 *
-	 * At this point, argv[i] points immediately after [-opts].
+	 * At this point, new_argv[i] points immediately after [-opts].
 	 */
 
 	if (i < argc) {
-		if (!strcmp(argv[i], "--")) {
+		if (!strcmp(new_argv[i], "--")) {
 			i++; /* reset to HEAD, possibly with paths */
-		} else if (i + 1 < argc && !strcmp(argv[i+1], "--")) {
-			rev = argv[i];
+		} else if (i + 1 < argc && !strcmp(new_argv[i+1], "--")) {
+			rev = new_argv[i];
 			i += 2;
 		}
 		/*
-		 * Otherwise, argv[i] could be either <rev> or <paths> and
+		 * Otherwise, new_argv[i] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1(argv[i], sha1)) {
+		else if (!get_sha1(new_argv[i], sha1)) {
 			/*
-			 * Ok, argv[i] looks like a rev; it should not
+			 * Ok, new_argv[i] looks like a rev; it should not
 			 * be a filename.
 			 */
-			verify_non_filename(prefix, argv[i]);
-			rev = argv[i++];
+			verify_non_filename(prefix, new_argv[i]);
+			rev = new_argv[i++];
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[i]);
+			verify_filename(prefix, new_argv[i]);
 		}
 	}
 
@@ -260,7 +268,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		else if (reset_type != NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
-		return read_from_tree(prefix, argv + i, sha1,
+		return read_from_tree(prefix, (const char **) argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_SAY_CHANGED);
 	}
 	if (reset_type == NONE)
-- 
1.6.4.13.ge6580
