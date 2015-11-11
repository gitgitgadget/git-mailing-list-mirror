From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 2/5] ff-refs: update each updatable ref
Date: Tue, 10 Nov 2015 21:11:22 -0500
Message-ID: <1447207885-10911-3-git-send-email-rappazzo@gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 03:13:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKud-0007Gn-99
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbbKKCNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:13:24 -0500
Received: from mail-yk0-f194.google.com ([209.85.160.194]:36579 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbKKCNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:13:22 -0500
Received: by ykdr82 with SMTP id r82so2561005ykd.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUhemYteM3mkD79EZbhon1/A86xViz027rk9qr3ZnAM=;
        b=l3JkmMrOA5oXHHlT3/jQw9I9dSK/g+jReoYI7Pve7qUxaS14KacVRmKY/GHF1stonu
         ypxLrzy/tq8LP3dHBPUbSbZh64PdPeym1YQjTMdRYnso1+vU7o3vxjs6/MPUnWumMonQ
         K4PLRIS01Bgj4y4eXC5I2Ao8gYXsDzax+HDrM115TjQ1FmMry2ixnl4+T/9zHAJL1q3T
         Nn7T1gofjvxdD6dutu07rdl1LMSTz8QsZl1mW2bmqF6Db3aR7jMz8wjBBdKkf+x5pLVX
         F+tuxiOalAeHyTUOsRbTxCiQtS55eNoB/np/PWRZb6XcE5O507F+XiAavTmT9ui3ryHq
         3agA==
X-Received: by 10.129.53.148 with SMTP id c142mr6524300ywa.138.1447208001595;
        Tue, 10 Nov 2015 18:13:21 -0800 (PST)
Received: from localhost.localdomain (ool-18e4990e.dyn.optonline.net. [24.228.153.14])
        by smtp.gmail.com with ESMTPSA id m128sm7948819ywm.34.2015.11.10.18.13.20
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 18:13:21 -0800 (PST)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281144>

If an updatable ref is checked out in any worktree, emulate merge
--ff-only to also update the local work tree (including executing the
post-merge hook).

If an updatable ref is not checked out in any worktree, the ref is
simply updated.

If a ref update is successful, that ref is reported as 'UPDATED'.  If
it is not successful, the ref is reported as 'UNABLE-TO-UPDATE'.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/ff-refs.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/builtin/ff-refs.c b/builtin/ff-refs.c
index 94a4649..f14afc5 100644
--- a/builtin/ff-refs.c
+++ b/builtin/ff-refs.c
@@ -59,6 +59,43 @@ static const char *result_type_str(enum ff_result_type result_type)
 }
 
 /**
+ * Do the ref update.
+ *  - If the ref is checked out in any worktree, emulate merge --ff-only to
+ *    also update the local work tree (including executing the post-merge hook).
+ *
+ *  - If the ref is not checked out in any worktree, update it
+ *
+ *  - If any of the ref updates fails, the result_type is set to UNABLE-TO-UPDATE
+ */
+static void do_ref_update(struct ff_ref_data *data, struct ff_ref_details *details)
+{
+	const char *refname = details->branch->refname;
+
+	if (details->wt) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_getcwd(&path);
+		chdir(details->wt->path);
+		set_git_dir(details->wt->git_dir);
+		read_index(&the_index);
+
+		if (checkout_fast_forward(details->branch_commit->object.sha1,
+				details->upstream_commit->object.sha1, 1))
+			details->result_type = NON_FAST_FORWARD;
+		else if (update_ref("ff-refs", refname, details->upstream_commit->object.sha1,
+				details->branch_commit->object.sha1, 0, UPDATE_REFS_QUIET_ON_ERR)) {
+			details->result_type = UNABLE_TO_UPDATE;
+			run_hook_le(NULL, "post-merge", "0", NULL);
+		}
+		discard_index(&the_index);
+		chdir(path.buf);
+		strbuf_release(&path);
+	} else if (update_ref("ff-refs", refname, details->upstream_commit->object.sha1,
+			details->branch_commit->object.sha1, 0, UPDATE_REFS_QUIET_ON_ERR))
+		details->result_type = UNABLE_TO_UPDATE;
+}
+
+/**
  * return the worktree with the given refname checked out, or NULL if that
  * ref is not checked out in any branch.
  *
@@ -98,6 +135,9 @@ static void process_refs(struct ff_ref_data *data)
 
 		printf("     %s -> %s%*.*s",
 			details->branch->name, details->shortened_upstream, padLen, padLen, padding);
+		if (details->result_type == UPDATABLE)
+			do_ref_update(data, details);
+
 		printf("[%s]\n", result_type_str(details->result_type));
 	}
 }
-- 
2.6.2
