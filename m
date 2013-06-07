From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] Move sequencer to builtin
Date: Fri,  7 Jun 2013 17:16:49 -0500
Message-ID: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4zk-0004Ja-Bx
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab3FGWSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:18:47 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:33915 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab3FGWSq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:18:46 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so3889208oag.13
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fFbnccyGbKUI2J9n/VkVwvNzWxAhr9kJs10RoDKgBIc=;
        b=zePt0eMza9/eRxrpYmvdudtpQQcCmO7j/9pVgG1+qz1uZt18nYht45qrHwLX8HdaSp
         EPGE677yPkGTur8jwEUWaeRkNL3vJeacQB527zywrUFjcQ7QTYCVqxCvMBmzNdgkLnId
         wTVF3SOJjGFZ4dO9+QhH5HW4zYhRaKaoGMiqQKJkbGm5X0VUnj/Rxtgk1bMZT+0Kf/Z5
         w7XBCv2wMC9Fefv/nqyQN6z9J1MqO+GZ4GBtSveZzRbDuzYeKt18nlT+4FXGdIVdji1b
         PyEco4DuvI47QR4MORNIET9GY6i+din40YUeSEv9eGB9nscQE+QitRp7/Slw7lTGs9Cv
         r5ww==
X-Received: by 10.60.44.168 with SMTP id f8mr440620oem.133.1370643525559;
        Fri, 07 Jun 2013 15:18:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm957112obb.5.2013.06.07.15.18.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:18:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226752>

This code is only useful for cherry-pick and revert built-ins, nothing
else, so let's make it a builtin object, but make sure 'git-sequencer'
is not generated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                           | 9 ++++++---
 sequencer.c => builtin/sequencer.c | 0
 sequencer.h => builtin/sequencer.h | 0
 3 files changed, 6 insertions(+), 3 deletions(-)
 rename sequencer.c => builtin/sequencer.c (100%)
 rename sequencer.h => builtin/sequencer.h (100%)

diff --git a/Makefile b/Makefile
index 03524d0..d28bf7f 100644
--- a/Makefile
+++ b/Makefile
@@ -583,7 +583,8 @@ TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
-BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
+BUILT_INS_OBJS = $(filter-out $(BUILTIN_HELPER_OBJS),$(BUILTIN_OBJS))
+BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILT_INS_OBJS))
 
 BUILT_INS += git-cherry$X
 BUILT_INS += git-cherry-pick$X
@@ -714,7 +715,6 @@ LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
 LIB_H += send-pack.h
-LIB_H += sequencer.h
 LIB_H += sha1-array.h
 LIB_H += sha1-lookup.h
 LIB_H += shortlog.h
@@ -856,7 +856,6 @@ LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
-LIB_OBJS += sequencer.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
@@ -894,6 +893,8 @@ LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
+BUILTIN_HELPER_OBJS += builtin/sequencer.o
+
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
@@ -990,6 +991,8 @@ BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+BUILTIN_OBJS += $(BUILTIN_HELPER_OBJS)
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
diff --git a/sequencer.c b/builtin/sequencer.c
similarity index 100%
rename from sequencer.c
rename to builtin/sequencer.c
diff --git a/sequencer.h b/builtin/sequencer.h
similarity index 100%
rename from sequencer.h
rename to builtin/sequencer.h
-- 
1.8.3.698.g079b096
