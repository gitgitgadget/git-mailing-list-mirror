From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: [PATCH] merge: Preserve ORIG_HEAD if already up-to-date with remote.
Date: Mon, 13 Jun 2011 13:05:25 +0530
Message-ID: <1307950525-8011-2-git-send-email-kunal.gangakhedkar@gmail.com>
References: <1307950525-8011-1-git-send-email-kunal.gangakhedkar@gmail.com>
Cc: git@vger.kernel.org,
	Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 13 09:35:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW1gZ-0001kP-AW
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 09:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab1FMHfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 03:35:41 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:38000 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1FMHfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 03:35:40 -0400
Received: by pxi2 with SMTP id 2so2783402pxi.10
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=C0ZzSquuMGxGysjh8ArENyOSnAAQAorlKo26/pkZeB8=;
        b=C07eO7QvGKPDToZRqY/yjkDwy6AxnBCbZ0YgCPSX50h0ZY94S+2niY7j+xwkNmripI
         IG6MqkoIgaB2Pc/iyv/LOeU45tuGMNyqgHGo2uxsZOZ+miH+y8VEWvaGtNiZgA1oketr
         nOPKm8d9y0qox74F/i6x9h+Cl433FrjA2MM4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EFvS24WdawZDlMmmMdvYaWFp+jTTWmEaw1blUVhZ16ykrFlgBgnmUlQu59RDM4gh/m
         ucA+z349e6cGczREzUGWS1lcLRqNGtRiZP7kPyRqiwE/1gWmAt/GV0LhHbYret99iU19
         DYtzuedDtqCI0xFtfz3tX8ZzdtRxjxQjOW/BU=
Received: by 10.68.5.168 with SMTP id t8mr2000317pbt.342.1307950540216;
        Mon, 13 Jun 2011 00:35:40 -0700 (PDT)
Received: from plutonium.lan ([122.169.26.91])
        by mx.google.com with ESMTPS id n1sm4438331pbi.63.2011.06.13.00.35.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 00:35:39 -0700 (PDT)
Received: by plutonium.lan (Postfix, from userid 1000)
	id 290C2B8564; Mon, 13 Jun 2011 13:05:33 +0530 (IST)
X-Mailer: git-send-email 1.7.6.rc1.2.g20c4a.dirty
In-Reply-To: <1307950525-8011-1-git-send-email-kunal.gangakhedkar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175690>

Do not update ORIG_HEAD ref to current HEAD if the repo is already
in-sync with the remote.

Otherwise, it becomes difficult to keep track of last set of changes.

With this patch, it's possible to do a diffstat/log for last set of
changes even after a pull/merge that returns 'Already up-to-date'.
This is especially useful when the pull is performed via a cronjob/script.

The old behaviour can still be forced via:
o. --force-update-orig-head cmd line option
o. merge.forceupdateorighead config option

Signed-off-by: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
---
 builtin/merge.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 325891e..6ac26f0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -63,6 +63,7 @@ static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
+static int force_update_orig_head = 0;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -206,6 +207,8 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
 		"abort the current in-progress merge"),
 	OPT_SET_INT(0, "progress", &show_progress, "force progress reporting", 1),
+	OPT_BOOLEAN(0, "force-update-orig-head", &force_update_orig_head,
+			"force-update ORIG_HEAD even if in sync with remote"),
 	OPT_END()
 };
 
@@ -563,7 +566,11 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
+	} else if (!strcmp(k, "merge.forceupdateorighead")) {
+		force_update_orig_head = git_config_bool(k, v);
+		return 0;
 	}
+
 	return git_diff_ui_config(k, v, cb);
 }
 
@@ -1017,6 +1024,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
+	int orig_head_updated = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
@@ -1212,8 +1220,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
-		DIE_ON_ERR);
+	if (force_update_orig_head) {
+		update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
+			DIE_ON_ERR);
+		orig_head_updated = 1;
+	}
 
 	if (!common)
 		; /* No common ancestors found. We need a real merge. */
@@ -1254,6 +1265,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		finish(o->sha1, msg.buf);
 		drop_save();
+		if (!orig_head_updated) {
+			update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
+				DIE_ON_ERR);
+			orig_head_updated = 1;
+		}
 		return 0;
 	} else if (!remoteheads->next && common->next)
 		;
@@ -1306,6 +1322,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (!orig_head_updated) {
+		update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
+			DIE_ON_ERR);
+		orig_head_updated = 1;
+	}
+
 	if (fast_forward_only)
 		die(_("Not possible to fast-forward, aborting."));
 
-- 
1.7.6.rc1.2.g20c4a.dirty
