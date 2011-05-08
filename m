From: Boris Faure <billiob@gmail.com>
Subject: [PATCH/RFC v2] Do not strip empty lines / trailing spaces from a commit message template
Date: Sun,  8 May 2011 12:31:02 +0200
Message-ID: <1304850662-6424-1-git-send-email-billiob@gmail.com>
References: <4DC65888.7090309@gmail.com>
Cc: Boris Faure <billiob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 12:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ189-0002zo-J3
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 12:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1EHKW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 06:22:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34563 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1EHKWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 06:22:24 -0400
Received: by wwa36 with SMTP id 36so4839941wwa.1
        for <git@vger.kernel.org>; Sun, 08 May 2011 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CkDQFCVujVX9hwzZ+uFkhli2n+AbDSTrWx6E7xAJgN4=;
        b=rsGfAFtRs71Q7IN6STlqlKjfMHQdA8m10QcZYV3yYk7UOkge6Wl8sa/WCW2noIYpYC
         PzIpiEJsakI6X/efszaS8TEDM5cXBmU1G5PK0C3eR4dBg2JjcZ6urvpoNJE+6OzNrdrl
         jxfLoH4ryVrRYwKHG75O2Za00VNbsMVWagaKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EGgFMdxbmlnz6CRfjEtycjl5wsyf8gIFZmkpKDAOYoMNXT/HK9FwOMtR9RWHczRXt9
         RNuNidGV/DneCuSNgjr3kk03tQWQ4zFlpuciSlZpnou7p64nPHpsnIIEW6VEhFxnzJ/m
         FxEdGhQC36XSYquxmrzwJ+q8dKz4Gs0RlUZv8=
Received: by 10.216.205.26 with SMTP id i26mr1881523weo.58.1304850142864;
        Sun, 08 May 2011 03:22:22 -0700 (PDT)
Received: from localhost.localdomain (ADijon-259-1-88-55.w90-33.abo.wanadoo.fr [90.33.231.55])
        by mx.google.com with ESMTPS id n2sm2464555wej.22.2011.05.08.03.22.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 03:22:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.217.g4e3aa.dirty
In-Reply-To: <4DC65888.7090309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173088>

Templates should be just that: A form that the user fills out, and forms
have blanks. If people are attached to not having extra whitespace in the
editor, they can simply clean up their templates.

Added test with editor adding even more whitespace.

Signed-off-by: Boris Faure <billiob@gmail.com>
Based-on-patch-by:Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/commit.c                |    4 +++-
 t/t7500-commit.sh               |   14 ++++++++++++++
 t/t7500/add-whitespaced-content |    3 +++
 3 files changed, 20 insertions(+), 1 deletions(-)
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
index 0000000..3d71c68
--- /dev/null
+++ b/t/t7500/add-whitespaced-content
@@ -0,0 +1,3 @@
+#!/bin/sh
+echo -e "\n \ncommit message  	 \n\n" >> "$1"
+exit 0
-- 
1.7.5.1.217.g4e3aa.dirty
