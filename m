From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 08/17] rebase-common: let refresh_and_write_cache() take a flags argument
Date: Sat, 12 Mar 2016 18:46:28 +0800
Message-ID: <1457779597-6918-9-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh54-0005yz-Tx
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbcCLKr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:28 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33479 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcCLKrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:20 -0500
Received: by mail-pf0-f171.google.com with SMTP id 124so101676799pfg.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EAu+1PrT9r7sjIAN83wmnkyGr3hhIGp2QXgHWOzI1h0=;
        b=BluqkCM2kt4Jaaqj08AgX51Y7lsZRxmJrltueprkj8S0jBZP1ejspMo5+hBpMcXT1S
         MuicNoAMdQxxs03See6C96jHGW4aFOqn6h2Jv+X7g8p64sfh3ZrrAXJfQlb/8zn/8dl9
         BMc11njRDKJ2CLZ8jQ/ClGjEAk5K5k6oywJjaEayo2vbLW65xIbxvNXFgCuVEzBhWV3/
         YSY0NmjprnUkXzRam6NE76q6hlMIacKewjIVp/sPoxqPXVOqosQUwWLPkdvBlfY5CeqF
         OrivoloVBzo2npnrY9QSWDfoqupNluYBx8kGpF+NWIGfY/QWdGHBRzZtI/DiLfDsg2bI
         xUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EAu+1PrT9r7sjIAN83wmnkyGr3hhIGp2QXgHWOzI1h0=;
        b=Uevu4ikYliIYiLcqtCYuVj3XLr6lli1Mc20IIBb7HaT0N3H+4G1r1qW56XGEkcXW57
         Af60U6qS5dez4eCjmPqHcvM0ZvqBLClhU+pWH5yzIfZhaDo2Z4BneRKkPOMwAoLgErkO
         V4uIeYjPi7rDkQZv8OzZIU57IJAj/SvhoanKDXPFpuDjE99nVTNesZZg7vKG69HsYuY4
         f4VZzysP+f+RfN2EaVqetL9tsv0dSVcsob/NsfTFMNQDKY1Y6hIRKcvqSiYP/h0wAfs6
         YbI7kvozeycEH5iyXT5QQaYVh2mI/dadJ3+mJ5PUREbb13zIxwbMH7nHR8cW+a3LiUVw
         JtrQ==
X-Gm-Message-State: AD7BkJIZ6K+X9Q22J+n1Yv683QyA/g3pNmgJVpQGRU3CzRE+DgmBykFJhZgJoPQYoDhfqA==
X-Received: by 10.98.80.150 with SMTP id g22mr14893526pfj.132.1457779639916;
        Sat, 12 Mar 2016 02:47:19 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:18 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288740>

refresh_and_write_cache() is a handy function for refreshing the index
and writing the resulting index back to the filesystem. However, it
always calls refresh_cache() with REFRESH_QUIET. Allow callers to modify
the behavior of refresh_cache() by allowing callers to pass a flags
argument to refresh_cache().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c    | 2 +-
 rebase-common.c | 4 ++--
 rebase-common.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 504b604..5185719 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1815,7 +1815,7 @@ static void am_run(struct am_state *state, int resume)
 
 	unlink(am_path(state, "dirtyindex"));
 
-	refresh_and_write_cache();
+	refresh_and_write_cache(REFRESH_QUIET);
 
 	if (index_has_changes(&sb)) {
 		write_state_bool(state, "dirtyindex", 1);
diff --git a/rebase-common.c b/rebase-common.c
index b07e1f1..97b0687 100644
--- a/rebase-common.c
+++ b/rebase-common.c
@@ -5,12 +5,12 @@
 #include "refs.h"
 #include "lockfile.h"
 
-void refresh_and_write_cache(void)
+void refresh_and_write_cache(unsigned int flags)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	hold_locked_index(lock_file, 1);
-	refresh_cache(REFRESH_QUIET);
+	refresh_cache(flags);
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write index file"));
 }
diff --git a/rebase-common.h b/rebase-common.h
index 8620e8c..4586f03 100644
--- a/rebase-common.h
+++ b/rebase-common.h
@@ -4,7 +4,7 @@
 /**
  * Refresh and write index.
  */
-void refresh_and_write_cache(void);
+void refresh_and_write_cache(unsigned int);
 
 /* common rebase backend options */
 struct rebase_options {
-- 
2.7.0
