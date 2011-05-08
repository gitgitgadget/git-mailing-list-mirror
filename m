From: Boris Faure <billiob@gmail.com>
Subject: [PATCH/RFC v3] Do not strip empty lines / trailing spaces from a commit message template
Date: Sun,  8 May 2011 20:55:22 +0200
Message-ID: <1304880922-19879-1-git-send-email-billiob@gmail.com>
References: <7vy62hrrf3.fsf@alter.siamese.dyndns.org>
Cc: Boris Faure <billiob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 20:47:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ90Z-0001n3-Ko
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 20:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab1EHSrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 14:47:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40093 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab1EHSrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 14:47:04 -0400
Received: by wwa36 with SMTP id 36so5074032wwa.1
        for <git@vger.kernel.org>; Sun, 08 May 2011 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xXFvXJnq0C2LMbqQGXP9h98ucr0rjzLkkEnEmPL4Cak=;
        b=nogLFe50ctWieYH3mDbx3YQIlKfF6Jcn1alcWSw9UpKehc1IhZA9ETYwDQ6a3d6iap
         lWhT24MxKTi1ddQZRVNf1qYESGjWPao4ocXvoALK7C70QcEDUOnRYaUcYHhKylgieVxL
         5+dg1+lINk7xtMGQyt0m/1O+jik7FROlb06+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MAT25ADcELyyBNfThLy3343ShZmPfdYC3yDun6JvGLva0hK+sc0Niox1tLK+2jqiK4
         pxU2d8Vvd1iwOOYp+SR2mFlrBiUnY+R8KH3WhJA9OONOMpeFXixasMQJ96LXJMU07wHY
         fGg+hEo624AcYV8/WQT9AmbbBgbvfW7hXuzTs=
Received: by 10.227.93.36 with SMTP id t36mr2085551wbm.11.1304880423400;
        Sun, 08 May 2011 11:47:03 -0700 (PDT)
Received: from localhost.localdomain (ADijon-259-1-88-55.w90-33.abo.wanadoo.fr [90.33.231.55])
        by mx.google.com with ESMTPS id z13sm3292135wbd.46.2011.05.08.11.47.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 11:47:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.217.g4e3aa.dirty
In-Reply-To: <7vy62hrrf3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173171>

Templates should be just that: A form that the user fills out, and forms
have blanks. If people are attached to not having extra whitespace in the
editor, they can simply clean up their templates.

Added test with editor adding even more whitespace.

Signed-off-by: Boris Faure <billiob@gmail.com>
Based-on-patch-by:Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/commit.c                |    4 +++-
 t/t7500-commit.sh               |   14 ++++++++++++++
 t/t7500/add-whitespaced-content |    8 ++++++++
 3 files changed, 25 insertions(+), 1 deletions(-)
 create mode 100755 t/t7500/add-whitespaced-content

diff --git a/builtin/commit.c b/builtin/commit.c
index 67757e9..411d5e4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -615,6 +615,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
+	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -681,6 +682,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die_errno(_("could not read '%s'"), template_file);
 		hook_arg1 = "template";
+		clean_message_contents = 0;
 	}
 
 	/*
@@ -708,7 +710,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (s->fp == NULL)
 		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
 
-	if (cleanup_mode != CLEANUP_NONE)
+	if (clean_message_contents)
 		stripspace(&sb, 0);
 
 	if (signoff) {
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 47096f9..dedbc0d 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -123,6 +123,20 @@ test_expect_success 'commit message from file should override template' '
 	commit_msg_is "standard input msg"
 '
 
+cat > "$TEMPLATE" << EOF
+
+
+### template
+
+EOF
+test_expect_success 'commit message from template with whitespace issue' '
+	echo "content galore" >> foo &&
+	git add foo &&
+	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-whitespaced-content git commit \
+		--template "$TEMPLATE" &&
+	commit_msg_is "commit message"
+'
+
 test_expect_success 'using alternate GIT_INDEX_FILE (1)' '
 
 	cp .git/index saved-index &&
diff --git a/t/t7500/add-whitespaced-content b/t/t7500/add-whitespaced-content
new file mode 100755
index 0000000..9cb5860
--- /dev/null
+++ b/t/t7500/add-whitespaced-content
@@ -0,0 +1,8 @@
+#!/bin/sh
+cat >> "$1" << EOF
+ 
+
+commit message       	 
+
+EOF
+exit 0
-- 
1.7.5.1.217.g4e3aa.dirty
