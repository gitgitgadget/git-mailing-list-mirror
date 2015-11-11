From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 3/5] ff-refs: add --dry-run and --skip-worktree options
Date: Tue, 10 Nov 2015 21:11:23 -0500
Message-ID: <1447207885-10911-4-git-send-email-rappazzo@gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 03:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKun-0007SP-KI
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbKKCNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:13:33 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34763 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbKKCNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:13:23 -0500
Received: by ykfs79 with SMTP id s79so28235233ykf.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uD155kaB4ZB/FHBhYnDripbrEMixMNrNL+CiwJLY/Sk=;
        b=Qj2+ti+AhPF/5pVDLRuRDmWRqTOyb272fRK6tlwcTJxxQsKNKh4XiiJs1SXcdxQ4aI
         APBONWWoQhQg5CM5crg771GNqcbSetitaP6DsacySqPFMW9YdpJFu2oORFqh7oHeJOBw
         ZL7uEk6EQT8Wtb50WgjY9xepS0zCxhAv5B4bcSwRJJ5BRPMgPqrxcTOOL4wxFm7qBXiA
         54wlbAmcW/Eou3VeS2fgPsrZInHjcfhrzF8aZKl+8KBiB8/rHpiczgrn3Ddhj6Va1yd5
         VvDTQLRIYYukpr0i1pcb+gWU7kdsanfomSOW06W1Dg+eC96bn/DNJ3TRr8HXrpqPH+Ga
         4CwA==
X-Received: by 10.129.51.82 with SMTP id z79mr6367736ywz.198.1447208002643;
        Tue, 10 Nov 2015 18:13:22 -0800 (PST)
Received: from localhost.localdomain (ool-18e4990e.dyn.optonline.net. [24.228.153.14])
        by smtp.gmail.com with ESMTPSA id m128sm7948819ywm.34.2015.11.10.18.13.21
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 18:13:22 -0800 (PST)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281146>

'--dry-run' reports the updatable state of each ref without acutally
updating any refs.  Refs which are fast-forwardable are reported as
'WOULD-UPDATE'.

'--skip-worktrees' does not update refs which are checked out in any
worktree.  Branches which are fast-forwardable but checked out in a
worktree are reported as 'SKIPPED'.  With `--dry-run` these are reported
'WOULD-SKIP'.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/ff-refs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/ff-refs.c b/builtin/ff-refs.c
index f14afc5..ae68cfb 100644
--- a/builtin/ff-refs.c
+++ b/builtin/ff-refs.c
@@ -5,6 +5,8 @@
 #include "run-command.h"
 #include "worktree.h"
 
+int dry_run = 0;
+int no_wt = 0;
 struct worktree **worktrees;
 const char *padding = ".....................................................";
 
@@ -18,6 +20,7 @@ enum ff_result_type {
 	UPDATABLE,
 	REMOTE_MISSING,
 	NON_FAST_FORWARD,
+	SKIPPED,
 	UNABLE_TO_UPDATE
 };
 
@@ -48,11 +51,13 @@ static const char *result_type_str(enum ff_result_type result_type)
 	case UP_TO_DATE:
 		return _("UP-TO-DATE");
 	case UPDATABLE:
-		return _("WOULD-UPDATE");
+		return dry_run ? _("WOULD-UPDATE") : _("UPDATED");
 	case REMOTE_MISSING:
 		return _("REMOTE-MISSING");
 	case NON_FAST_FORWARD:
 		return _("NON-FAST-FORWARD");
+	case SKIPPED:
+		return dry_run ? _("WOULD-SKIP") : _("SKIPPED");
 	default:
 		return _("UNABLE-TO-UPDATE");
 	}
@@ -135,7 +140,7 @@ static void process_refs(struct ff_ref_data *data)
 
 		printf("     %s -> %s%*.*s",
 			details->branch->name, details->shortened_upstream, padLen, padLen, padding);
-		if (details->result_type == UPDATABLE)
+		if (!dry_run && details->result_type == UPDATABLE)
 			do_ref_update(data, details);
 
 		printf("[%s]\n", result_type_str(details->result_type));
@@ -208,6 +213,9 @@ static int analize_refs(const char *refname,
 			else if (!in_merge_bases(details->branch_commit, details->upstream_commit))
 				details->result_type = NON_FAST_FORWARD;
 
+			else if (no_wt && details->wt)
+				details->result_type = SKIPPED;
+
 			else
 				details->result_type = UPDATABLE;
 		}
@@ -233,6 +241,9 @@ int cmd_ff_refs(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 
 	struct option options[] = {
+		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be fast-forwarded")),
+		OPT_BOOL(0, "skip-worktrees", &no_wt,
+				N_("skip refs checked out in any worktree")),
 		OPT_END()
 	};
 
-- 
2.6.2
