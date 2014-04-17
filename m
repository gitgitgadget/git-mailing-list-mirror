From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/3] i18n: Only extract comments marked by special tag
Date: Thu, 17 Apr 2014 13:37:18 +0800
Message-ID: <2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 07:38:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waf1v-0001q0-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbaDQFiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 01:38:01 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:48725 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbaDQFhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:37:51 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so11560275pdb.14
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vdSyMHstTa0wdvntoeF+XG4UeOTnY/b93NlrvxwvFoQ=;
        b=aoTUyF/c7I+k2d0X77H+YMp2p/wDWBsesiJnSD3S2ndahWUiHIoOPrC4gxW1kOS/4Q
         Bhj6TbFZUjOgPLFy7K2uTrSeef7jgLrmtjqZ1vCd9eoviIVl457BbhDmpiqGDF/VD+Uh
         F4KmM0ZlBiGFLAo14WUqVBU/IGI0wPMBTcTCi1F4O+pFycL23onmzyJ+oUlTDvX8vJU6
         i3U9cFSWISRSuWRN9mB4Hta4bx7bm+4sHODb0IA3ZhLeALARxznXRhiyRiCBs9cMZI+X
         2m/8PiaTi65nP9h8Fx5QLBRZOeN/EGi+EEVA45wChxRlPiMtHnLRwP3GI/s9uvVwRePc
         4aEw==
X-Received: by 10.68.215.68 with SMTP id og4mr13155411pbc.112.1397713071108;
        Wed, 16 Apr 2014 22:37:51 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id n6sm50901640pbj.22.2014.04.16.22.37.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 22:37:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.461.g942803f
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com> <cover.1397712142.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246404>

When extract l10n messages, we use "--add-comments" option to keep
comments right above the l10n messages for references.  But sometimes
irrelevant comments are also extracted.  For example in the following
code block, the comment in line 2 will be extracted as comment for the
l10n message in line 3, but obviously it's wrong.

        { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
          NULL /* takes no arguments */,
          N_("ignore paths removed in the working tree (same as
          --no-all)"),
          PARSE_OPT_NOARG, ignore_removal_cb },

Since almost all comments for l10n translators are marked with the same
prefix (tag): "TRANSLATORS:", it's safe to only extract comments with
this special tag.  I.E. it's better to call xgettext as:

        xgettext --add-comments=TRANSLATORS: ...

Also tweaks the multi-line comment in "init-db.c", to make it start with
the proper tag, not "* TRANSLATORS:" (which has a star before the tag).

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile          | 2 +-
 builtin/init-db.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 2128ce3..a53f3a8 100644
--- a/Makefile
+++ b/Makefile
@@ -2102,7 +2102,7 @@ pdf:
 
 XGETTEXT_FLAGS = \
 	--force-po \
-	--add-comments \
+	--add-comments=TRANSLATORS: \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
diff --git a/builtin/init-db.c b/builtin/init-db.c
index c7c76bb..56f85e2 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -412,11 +412,9 @@ int init_db(const char *template_dir, unsigned int flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
-		/*
-		 * TRANSLATORS: The first '%s' is either "Reinitialized
-		 * existing" or "Initialized empty", the second " shared" or
-		 * "", and the last '%s%s' is the verbatim directory name.
-		 */
+		/* TRANSLATORS: The first '%s' is either "Reinitialized
+		   existing" or "Initialized empty", the second " shared" or
+		   "", and the last '%s%s' is the verbatim directory name. */
 		printf(_("%s%s Git repository in %s%s\n"),
 		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
 		       shared_repository ? _(" shared") : "",
-- 
1.9.2.461.g942803f
