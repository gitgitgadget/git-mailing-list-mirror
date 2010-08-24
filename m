From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix 'git log' early pager startup error case
Date: Tue, 24 Aug 2010 10:33:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 19:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnxO2-0007U2-84
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 19:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab0HXReH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 13:34:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60231 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab0HXReF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 13:34:05 -0400
Received: by pwi7 with SMTP id 7so2549358pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:x-x-sender
         :to:subject:message-id:user-agent:mime-version:content-type;
        bh=bzBjjWEXMWDVeesuz+YmnLm0coBarOkhAapKqITQ6M8=;
        b=eHSNnzZDRwt4fxf8vfTI8x5YSg4OUgTMajJTE/beCEc0PqijfxExomZ3S84KOoxcSA
         17cWXcY/FCk6S4Qim2vSu0Mxac3TOfu+dUhBAcqDYpDnXSw7f9aCFe/9mWGkB3htkJ5y
         RZjbpSjHusi3+f5E2aiumiu99S6zJdFLGbgfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:x-x-sender:to:subject:message-id:user-agent
         :mime-version:content-type;
        b=uqvtTGy0DNNYMROh7PCNqM5tArcG33yv8h+cC69sT3KNSmgBeTwg3DHaUolrKuTwz2
         dMbKafz9xkAv1t2XQoCkFVP1/K64MeVT8BhGTIInijelvrCkomOaSJa9ZiOgF9w3cra1
         wdZhf0aS17J240hgnBeeJss18bioXcYS/cPDg=
Received: by 10.142.147.7 with SMTP id u7mr5864584wfd.218.1282671244805;
        Tue, 24 Aug 2010 10:34:04 -0700 (PDT)
Received: from [192.168.1.87] (c-24-22-22-194.hsd1.or.comcast.net [24.22.22.194])
        by mx.google.com with ESMTPS id 23sm361307wfa.22.2010.08.24.10.34.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 10:34:04 -0700 (PDT)
X-X-Sender: torvalds@i5.linux-foundation.org
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154327>


We start the pager too early for several git commands, which results in 
the errors sometimes going to the pager rather than show up as errors.

This is often hidden by the fact that we pass in '-X' to less by default, 
which causes 'less' to exit for small output, but if you do

  export LESS=-S

you can then clearly see the problem by doing

  git log --prretty

which shows the error message ("fatal: unrecognized argument: --prretty") 
being sent to the pager.

This happens for pretty much all git commands that use USE_PAGER, and then 
check arguments separately. But "git diff" does it too early too (even 
though it does an explicit setup_pager() call)

This only fixes it for the trivial "git log" family case.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I dunno. I noticed this as a result of a typo, and some (un)happy timing 
("less" will still start up as a pager if the input is delayed a bit). I 
think this is the right thing to do, but as mentioned, I only fixed a 
particular small error case.

 builtin/log.c |    7 +------
 git.c         |    6 +++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 08b8722..eaa1ee0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -125,6 +125,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
 	}
+	setup_pager();
 }
 
 /*
@@ -491,12 +492,6 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.use_terminator = 1;
 	rev.always_show_header = 1;
 
-	/*
-	 * We get called through "git reflog", so unlike the other log
-	 * routines, we need to set up our pager manually..
-	 */
-	setup_pager();
-
 	return cmd_log_walk(&rev);
 }
 
diff --git a/git.c b/git.c
index 6fc07a5..12d2952 100644
--- a/git.c
+++ b/git.c
@@ -337,7 +337,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
-		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
+		{ "log", cmd_log, RUN_SETUP },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote },
@@ -381,7 +381,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
-		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "show", cmd_show, RUN_SETUP },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
@@ -396,7 +396,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "var", cmd_var },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
-		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
+		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
