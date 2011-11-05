From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 3/3] fast-export: output reset command for commandline revs
Date: Sun,  6 Nov 2011 00:23:27 +0100
Message-ID: <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Nov 06 00:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMpcT-0001pt-Sh
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1KEXZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:25:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51987 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1KEXZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:25:35 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so2888126eye.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K2XmdwLIng/61dC37g7L30guO8WUQ9Oy8AAoy+PMGuc=;
        b=dMXq+OedOQH80ISM2xtIWkD0uRHVH8+CpX7Wnf97fc3mvOK8r2YimH5AJzy1q/SdBl
         LxSnU/DoSmnyUAhnrGOUR1MTIe3i5rwjOlofelm7G/o43Kg0wAXgt7yTgkKcdoi11bpt
         imTD76XLNAuct4ycPB1MGGf83EiUwdhazWrdE=
Received: by 10.213.22.211 with SMTP id o19mr691463ebb.6.1320535534080;
        Sat, 05 Nov 2011 16:25:34 -0700 (PDT)
Received: from laptop-sverre.lijbrandt.nl ([188.142.63.148])
        by mx.google.com with ESMTPS id v3sm37271459eej.7.2011.11.05.16.25.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 16:25:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.rc0.36.g67522.dirty
In-Reply-To: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184877>

When a revision is specified on the commandline we explicitly output
a 'reset' command for it if it was not handled already. This allows
for example the remote-helper protocol to use fast-export to create
branches that point to a commit that has already been exported.

Initial-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Most of the hard work for this patch was done by Dscho. The rest of
  it was basically me applying the technique used by jch in c3502fa
  (25-08-2011 do not include sibling history in --ancestry-path).

  The if statement dealing with tag_of_filtered_mode is not as
  elegant as either me or Dscho would have liked, but we couldn't
  find a better way to determine if a ref is a tag at this point
  in the code.

  Additionally, the elem->whence != REV_CMD_RIGHT case should really
  check if REV_CMD_RIGHT_REF, but as this is not provided by the
  ref_info structure this is left as is. A result of this is that
  incorrect input will result in incorrect output, rather than an
  error message. That is: `git fast-export a..<sha1>` will
  incorrectly generate a `reset <sha1>` statement in the fast-export
  stream.

  The dwim_ref bit is a double work (it has already been done by the
  caller of this function), but I decided it would be more work to
  pass this information along than to recompute it for the few
  commandline refs that were relevant.

 builtin/fast-export.c  |   31 +++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh |    2 +-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c4c4391..bcfec38 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -18,6 +18,8 @@
 #include "parse-options.h"
 #include "quote.h"
 
+#define REF_HANDLED (ALL_REV_FLAGS + 1)
+
 static const char *fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
 	NULL
@@ -541,10 +543,34 @@ static void handle_reset(const char *name, struct object *object)
 		       sha1_to_hex(object->sha1));
 }
 
-static void handle_tags_and_duplicates(struct string_list *extra_refs)
+static void handle_tags_and_duplicates(struct rev_info *revs, struct string_list *extra_refs)
 {
 	int i;
 
+	/* even if no commits were exported, we need to export the ref */
+	for (i = 0; i < revs->cmdline.nr; i++) {
+		struct rev_cmdline_entry *elem = &revs->cmdline.rev[i];
+
+		if (elem->flags & UNINTERESTING)
+			continue;
+
+		if (elem->whence != REV_CMD_REV && elem->whence != REV_CMD_RIGHT)
+			continue;
+
+		char *full_name;
+		dwim_ref(elem->name, strlen(elem->name), elem->item->sha1, &full_name);
+
+		if (!prefixcmp(full_name, "refs/tags/") &&
+			(tag_of_filtered_mode != REWRITE ||
+			!get_object_mark(elem->item)))
+			continue;
+
+		if (!(elem->flags & REF_HANDLED)) {
+			handle_reset(full_name, elem->item);
+			elem->flags |= REF_HANDLED;
+		}
+	}
+
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
 		const char *name = extra_refs->items[i].string;
 		struct object *object = extra_refs->items[i].util;
@@ -698,11 +724,12 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 		else {
 			handle_commit(commit, &revs);
+			commit->object.flags |= REF_HANDLED;
 			handle_tail(&commits, &revs);
 		}
 	}
 
-	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates(&revs, &extra_refs);
 
 	if (export_filename)
 		export_marks(export_filename);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 74914dc..ea7dc21 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -446,7 +446,7 @@ from $(git rev-parse master)
 
 EOF
 
-test_expect_failure 'refs are updated even if no commits need to be exported' '
+test_expect_success 'refs are updated even if no commits need to be exported' '
 	git fast-export master..master > actual &&
 	test_cmp expected actual
 '
-- 
1.7.8.rc0.36.g67522.dirty
