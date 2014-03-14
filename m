From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 2/3] merge: Advise user to use "git merge --abort" to abort merges
Date: Fri, 14 Mar 2014 00:37:51 -0400
Message-ID: <1394771872-25940-3-git-send-email-andrew.kw.w@gmail.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 05:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJuK-000396-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaCNEjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:39:32 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:40844 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaCNEjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:39:07 -0400
Received: by mail-ig0-f172.google.com with SMTP id uq10so19158642igb.5
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 21:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4snsRB49vB+CfO/UFmnW9BOo6Qtzzsi5FIbORhhQ0N8=;
        b=QoOnKBbbAMfmB2XEjDiASzYqerINb2CxtN3Yusfq+WewpAycKu6R/tgYC9R3XaWamj
         fNvIr5E61r9LBHUam+0Ej/FN8QUsoaKH2whJKRz0AsGRIqnKWvGcfKAvVigVWvYqFdnT
         wdMMBwBHhZTMIYrCLAiyfT7c3vdnAe/x9AW5IRMb1ze7QGlIXb8au1H6rzfhrqnf5t75
         RespbvPDJNcWEloCBaZDnzy8YhedE/Xmc9dmUqecBmaHd9lE0sZnSMb8GakmQDsMMlvh
         rJcGUmlGt4WeFZi4iYyCnC8cwA3n/5/3Itz9Ikg2D87vBE1NaEjmPBX6beAB0+dhfJdQ
         8YVg==
X-Received: by 10.50.115.102 with SMTP id jn6mr5588698igb.10.1394771943997;
        Thu, 13 Mar 2014 21:39:03 -0700 (PDT)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id ji9sm2293656igb.1.2014.03.13.21.39.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 21:39:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.175.gb69385f
In-Reply-To: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244079>

Print message during "git merge" and "git status".

Add a new "mergeHints" advice to silence these messages.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 Documentation/config.txt | 3 +++
 advice.c                 | 2 ++
 advice.h                 | 1 +
 builtin/merge.c          | 6 ++++++
 wt-status.c              | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73904bc..936a20b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -196,6 +196,9 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
+	mergeHints::
+                Show directions on how to proceed from the current state in the
+                output of linkgit:git-merge[1].
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index 486f823..e910734 100644
--- a/advice.c
+++ b/advice.c
@@ -15,6 +15,7 @@ int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
+int advice_merge_hints = 1;
 
 static struct {
 	const char *name;
@@ -35,6 +36,7 @@ static struct {
 	{ "setupstreamfailure", &advice_set_upstream_failure },
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
+	{ "mergehints", &advice_merge_hints },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 5ecc6c1..d337f1c 100644
--- a/advice.h
+++ b/advice.h
@@ -18,6 +18,7 @@ extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
+extern int advice_merge_hints;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/merge.c b/builtin/merge.c
index f0cf120..c55ac03 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -805,6 +805,8 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 		error("%s", err_msg);
 	fprintf(stderr,
 		_("Not committing merge; use 'git commit' to complete the merge.\n"));
+	if (advice_merge_hints)
+		printf(_("  (use \"git merge --abort\" to abort the merge)\n"));
 	write_merge_state(remoteheads);
 	exit(1);
 }
@@ -913,6 +915,8 @@ static int suggest_conflicts(int renormalizing)
 	rerere(allow_rerere_auto);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
+	if (advice_merge_hints)
+		printf(_("  (use \"git merge --abort\" to abort the merge)\n"));
 	return 1;
 }
 
@@ -1559,6 +1563,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (merge_was_ok)
 		fprintf(stderr, _("Automatic merge went well; "
 			"stopped before committing as requested\n"));
+	if (advice_merge_hints)
+		printf(_("  (use \"git merge --abort\" to abort the merge)\n"));
 	else
 		ret = suggest_conflicts(option_renormalize);
 
diff --git a/wt-status.c b/wt-status.c
index 9f2358a..3b30bf9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -907,6 +907,9 @@ static void show_merge_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git commit\" to conclude the merge)"));
 	}
+	if (s->hints)
+		status_printf_ln(s, color,
+			_("  (use \"git merge --abort\" to abort the merge)"));
 	wt_status_print_trailer(s);
 }
 
-- 
1.9.0.174.g6f75b8f
