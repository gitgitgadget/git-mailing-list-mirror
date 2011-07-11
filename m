From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/17] sequencer: Announce sequencer state location
Date: Mon, 11 Jul 2011 14:54:01 +0000
Message-ID: <1310396048-24925-11-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsf-0005F4-J3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757853Ab1GKOya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60018 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757807Ab1GKOy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:28 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so2748281vws.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GmHlDT2695tgVRnyW/W9QNh59S3vOS1OtcaRIe2tsbc=;
        b=rX78vIUIECWWN8iTBYSb8PGbEz2WIr8orJfH/iSGPTYKH4QMQXxfNI+6IEqwNTgsoM
         7GHn+AXAH7LUVWyuqBvdzwe2PE9UZd1d8yn+zWKYwCUD86HtD81kwrmb4Sts4eU37XaU
         vQ7jEonJKUs4L7WmPYQy8QbTyvWIkbErXr1Gc=
Received: by 10.52.65.208 with SMTP id z16mr836769vds.386.1310396068096;
        Mon, 11 Jul 2011 07:54:28 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176847>

The plan to build a generic sequencer involves fist writing the
functionality into builtin/revert.c (for cherry-pick and revert), and
then factoring it out into sequencer.c and exposing it through
sequencer.h as a nice API.  As a prelude to this, announce the
location of the sequencer state in sequencer.h and write a function to
remove it.  Later in the series, two indepenent Git programs, namely
cherry-pick/ revert and reset, will use this to save and clear
sequencer state in a uniform manner.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile    |    2 ++
 sequencer.c |   17 +++++++++++++++++
 sequencer.h |   14 ++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h

diff --git a/Makefile b/Makefile
index f8c72e1..4ac09df 100644
--- a/Makefile
+++ b/Makefile
@@ -551,6 +551,7 @@ LIB_H += rerere.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
+LIB_H += sequencer.h
 LIB_H += sha1-array.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
@@ -655,6 +656,7 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
+LIB_OBJS += sequencer.o
 LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_file.o
diff --git a/sequencer.c b/sequencer.c
new file mode 100644
index 0000000..8c1de63
--- /dev/null
+++ b/sequencer.c
@@ -0,0 +1,17 @@
+#include "cache.h"
+#include "sequencer.h"
+#include "strbuf.h"
+#include "dir.h"
+
+void remove_sequencer_state(void)
+{
+	struct strbuf seq_dir = STRBUF_INIT;
+	struct strbuf seq_old_dir = STRBUF_INIT;
+
+	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
+	strbuf_addf(&seq_old_dir, "%s", git_path(SEQ_OLD_DIR));
+	remove_dir_recursively(&seq_old_dir, 0);
+	rename(git_path(SEQ_DIR), git_path(SEQ_OLD_DIR));
+	strbuf_release(&seq_dir);
+	strbuf_release(&seq_old_dir);
+}
diff --git a/sequencer.h b/sequencer.h
new file mode 100644
index 0000000..673616b
--- /dev/null
+++ b/sequencer.h
@@ -0,0 +1,14 @@
+#ifndef SEQUENCER_H
+#define SEQUENCER_H
+
+#define SEQ_DIR		"sequencer"
+#define SEQ_OLD_DIR	"sequencer-old"
+#define SEQ_HEAD_FILE	"sequencer/head"
+#define SEQ_TODO_FILE	"sequencer/todo"
+
+/* Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
+ * any errors.  Intended to be used by 'git reset --hard'.
+ */
+void remove_sequencer_state(void);
+
+#endif
-- 
1.7.5.GIT
