From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] log: rename "tweak" helpers
Date: Thu, 20 Aug 2015 15:43:09 -0700
Message-ID: <1440110591-12941-2-git-send-email-gitster@pobox.com>
References: <1440110591-12941-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 00:43:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSYYT-0002mX-RH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 00:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbbHTWnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 18:43:19 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34257 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbHTWnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 18:43:14 -0400
Received: by pdbfa8 with SMTP id fa8so19009353pdb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Pxoz2UZDY8i15Cp7B7xP140FW8srIQ75CyeeTWauecE=;
        b=P6sswqP3iRHjEgmD7tOckxqg9RSmkqoTUY0K7zdm1TFFj6sg1HDYkiVMkJzTPp7mQH
         +erW/6drqfN4/cJ9b7zitlT3xCoSPZ/yfG1fYBfN/bWispy8JGylzRfMUT8Qq+EaARAI
         QMry95vPPLOgjlhJJInmDGA84r00oaZtBNAoAOge2bIAtbVQOAWrpjtHwzDBfrSxKYZ+
         +jKS9iE1WFuHYr76m/eodm3N4TgL/9sVLJiAmR8svbbpcge59ChZKi1nVKTZ4FE3m7uI
         wlF2h86YU5XG+AWZukvzmIxLbCtl+Wm17XLWkD0Y6AsJlePk3EFrhrej/LaM2N74tXjO
         r2FA==
X-Received: by 10.70.92.138 with SMTP id cm10mr10930702pdb.63.1440110593732;
        Thu, 20 Aug 2015 15:43:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id tq6sm3126926pbc.57.2015.08.20.15.43.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 15:43:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-546-gb1bbc0d
In-Reply-To: <1440110591-12941-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276272>

The revision walking API allows the callers to tweak its
configuration at the last minute, immediately after all the revision
and pathspec parameters are parsed from the command line but before
the default actions are decided based on them, by defining a "tweak"
callback function when calling setup_revisions().  Traditionally,
this facility was used by "git show" to turn on the patch output
"-p" by default when no diff output option (e.g.  "--raw" or "-s" to
squelch the output altogether) is given on the command line, and
further give dense combined diffs "--cc" for merge commits when no
option to countermand it (e.g. "-m" to show pairwise patches).

Recently, "git log" started using the same facility, but we named
the callback function "default_follow_tweak()", as if the only kind
of tweaking we would want for "git log" will forever be limited to
turning "--follow" on by default when told by a configuration
variable.  That was myopic.

Rename it to more generic name "log_setup_revisions_tweak()", and
match the one used by show "show_setup_revisions_tweak()".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b50ef75..8651105 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -504,7 +504,8 @@ static int show_tree_object(const unsigned char *sha1,
 	return 0;
 }
 
-static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
+static void show_setup_revisions_tweak(struct rev_info *rev,
+				       struct setup_revision_opt *opt)
 {
 	if (rev->ignore_merges) {
 		/* There was no "-m" on the command line */
@@ -539,7 +540,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
-	opt.tweak = show_rev_tweak_rev;
+	opt.tweak = show_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
 	if (!rev.no_walk)
@@ -626,8 +627,8 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
-static void default_follow_tweak(struct rev_info *rev,
-				 struct setup_revision_opt *opt)
+static void log_setup_revisions_tweak(struct rev_info *rev,
+				      struct setup_revision_opt *opt)
 {
 	if (DIFF_OPT_TST(&rev->diffopt, DEFAULT_FOLLOW_RENAMES) &&
 	    rev->prune_data.nr == 1)
@@ -647,7 +648,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
-	opt.tweak = default_follow_tweak;
+	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
 }
-- 
2.5.0-546-gb1bbc0d
