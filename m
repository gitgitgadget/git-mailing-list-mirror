From: Timothy Chen <tnachen@gmail.com>
Subject: [PATCH] Allow multiple merges to invalid HEAD
Date: Sat,  2 Apr 2011 23:46:56 -0700
Message-ID: <1301813216-19507-1-git-send-email-tnachen@gmail.com>
Cc: Timothy Chen <tnachen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 08:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6H5o-0004NY-W3
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 08:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802Ab1DCGrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 02:47:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53476 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab1DCGrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 02:47:04 -0400
Received: by iyb14 with SMTP id 14so4924003iyb.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=OlGPBgxlQekNR+WKJxfxn6lsoHjqYqT/CIyWYGAs6lw=;
        b=YIZnZneunBdFEXhU3+tGWFal2ltUgH3OmoK36nCTPW9gFCIvQQB+HyBoVp3UxciraP
         MxOVxQBw84B01SziAyv+LbUUB5OvuVth0iavd/voNDDBGxmlbxp8q2qSYprSdWS1HFaI
         AFZ1mZGQITNt7to/AptciBrpWtR+ranU2njeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EZlpBBj0hycBFdi7sdFoAAa1dinQSadrBU5rqeVDPWX1LcewfjfhOns+QNsT2HCTFU
         PTVDPNmP8+GC24GEf+JL2n16OclRWwAxCUYWD7U25a371gK9nTOGr6hEtcYdUkxcmtya
         UVN3Yp2JlCpBO/br8+ehBaW+7eE7E4MW8V63I=
Received: by 10.42.173.197 with SMTP id s5mr4170457icz.368.1301813223450;
        Sat, 02 Apr 2011 23:47:03 -0700 (PDT)
Received: from localhost.localdomain (c-24-19-190-111.hsd1.wa.comcast.net [24.19.190.111])
        by mx.google.com with ESMTPS id 13sm2774633ibo.25.2011.04.02.23.47.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 23:47:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170680>

Currently git merge only allows one branch when current HEAD
is not yet pointing to a valid commit.

This patch will allow multiple branches to be passed in,
and first updates current HEAD to the first branch's head then subsequently
merge the rest of the branches.
---
 builtin/merge.c |   57 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d54e7dd..290e0d4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1090,9 +1090,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * to forbid "git merge" into a branch yet to be born.
 		 * We do the same for "git pull".
 		 */
-		if (argc != 1)
-			die(_("Can merge only exactly one commit into "
-				"empty head"));
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
 		if (!allow_fast_forward)
@@ -1101,36 +1098,44 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
-		read_empty(remote_head->sha1, 0);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		return 0;
-	} else {
-		struct strbuf merge_names = STRBUF_INIT;
 
-		/* We are invoked directly as the first-class UI. */
+		if (argc < 2)
+			return 0;
+
+		hashcpy(head, remote_head->sha1);
+		read_empty(remote_head->sha1, 0);
+		head_arg = argv[0];
+		argc--;
+		argv++;
+	}
+
+	struct strbuf merge_names = STRBUF_INIT;
+
+	/* We are invoked directly as the first-class UI. */
+	if(!head_invalid)
 		head_arg = "HEAD";
 
-		/*
-		 * All the rest are the commits being merged;
-		 * prepare the standard merge summary message to
-		 * be appended to the given message.  If remote
-		 * is invalid we will die later in the common
-		 * codepath so we discard the error in this
-		 * loop.
-		 */
-		for (i = 0; i < argc; i++)
-			merge_name(argv[i], &merge_names);
-
-		if (!have_message || shortlog_len) {
-			fmt_merge_msg(&merge_names, &merge_msg, !have_message,
-				      shortlog_len);
-			if (merge_msg.len)
-				strbuf_setlen(&merge_msg, merge_msg.len - 1);
-		}
+	/*
+	 * All the rest are the commits being merged;
+	 * prepare the standard merge summary message to
+	 * be appended to the given message.  If remote
+	 * is invalid we will die later in the common
+	 * codepath so we discard the error in this
+	 * loop.
+	 */
+	for (i = 0; i < argc; i++)
+		merge_name(argv[i], &merge_names);
+
+	if (!have_message || shortlog_len) {
+		fmt_merge_msg(&merge_names, &merge_msg, !have_message,
+				  shortlog_len);
+		if (merge_msg.len)
+			strbuf_setlen(&merge_msg, merge_msg.len - 1);
 	}
 
-	if (head_invalid || !argc)
+	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
-- 
1.7.3.4
