From: TBFowler <tbfowler4@gmail.com>
Subject: [PATCH] Add --allow-eof-whitelines to git-apply while still doing whitespace trailing-space fixing.
Date: Sat,  1 Aug 2009 17:12:53 -0500
Message-ID: <1249164774-13617-1-git-send-email-thell@almostautomated.com>
References: <1249145624.2774.16.camel@GWPortableVCS>
Cc: TBFowler <thell@almostautomated.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 00:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXMyF-0007rV-33
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 00:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZHAWWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZHAWWR
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 18:22:17 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:63136 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbZHAWWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 18:22:14 -0400
Received: by gxk9 with SMTP id 9so4846315gxk.13
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TPcy/M3Bbx76wy/1JdS2YFbfm435zvWh9xHAoi8Srhc=;
        b=Twqm9u4d9AML6mcbbFPNrJx3qDBs9b9DTarGSpNfpjGZgTzVViv1XALkGoseMgQtie
         NvpHava8WZtw89Y//iqygiaAB6e8JKuxYzl4hY2BdGh4+YUz7lAHLoqSap/RHHczwYHG
         kZY2o0OF3rdnnDttOekzhb4/vRO2depjHSBTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fodfT1mqQBhZhjN5/Y5ayvZSzIBpKRCnryt/vtzYFcw+G0kysPBu3mdJbr3XLnj0cB
         1tLxvZ/iRQfGsCnVGzL/QZxyTwwUKPH1zITqKCha9EsYgAcA7F9Z0ne4q5e68zJn+7fG
         2Z34gAIYTRvuiTO+TLx+tNSor5Q0zhcV16OkE=
Received: by 10.100.58.19 with SMTP id g19mr4480137ana.66.1249164948474;
        Sat, 01 Aug 2009 15:15:48 -0700 (PDT)
Received: from localhost.localdomain (ip70-178-75-143.ks.ks.cox.net [70.178.75.143])
        by mx.google.com with ESMTPS id c14sm3646763ana.12.2009.08.01.15.15.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 15:15:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.dirty
In-Reply-To: <1249145624.2774.16.camel@GWPortableVCS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124652>

- Added --allow-eof-whitelines to git apply to short-circuit removal of new empty lines when tailing-space is set.
  - Added pass-through to apply from git-am.sh
  - Added pass-through to git-am from git-rebase.sh
  - Added the auto-completion entries.

Signed-off-by: TBFowler <thell@almostautomated.com>
---
 builtin-apply.c                        |    5 ++++-
 contrib/completion/git-completion.bash |    4 ++--
 git-am.sh                              |    3 +++
 git-rebase.sh                          |    3 +++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index dc0ff5e..79be05c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -43,6 +43,7 @@ static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
+static int keep_new_eof_whitelines;
 static int no_add;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -1996,7 +1997,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				error("invalid start of line: '%c'", first);
 			return -1;
 		}
-		if (added_blank_line)
+		if (added_blank_line && !keep_new_eof_whitelines)
 			new_blank_lines_at_end++;
 		else
 			new_blank_lines_at_end = 0;
@@ -3304,6 +3305,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
 			"detect new or modified lines that have whitespace errors",
 			0, option_parse_whitespace },
+		OPT_BOOLEAN(0, "allow-eof-whitelines", &keep_new_eof_whitelines,
+			"allow processing of whitespace fix but don't suppress new whitelines at end of file"),
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
 			"apply the patch in reverse"),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 745b5fb..512b14c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -675,7 +675,7 @@ _git_am ()
 		__gitcomp "
 			--3way --committer-date-is-author-date --ignore-date
 			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace=
+			--whitespace= --allow-eof-whitelines
 			"
 		return
 	esac
@@ -695,7 +695,7 @@ _git_apply ()
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
 			--apply --no-add --exclude=
-			--whitespace= --inaccurate-eof --verbose
+			--whitespace= --allow-eof-whitelines --inaccurate-eof --verbose
 			"
 		return
 	esac
diff --git a/git-am.sh b/git-am.sh
index d64d997..5757674 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 whitespace=     pass it through git-apply
+allow-eof-whitelines        pass it through git-apply
 directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
@@ -299,6 +300,8 @@ do
 		shift; resolvemsg=$1 ;;
 	--whitespace|--directory)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
+	--allow-eof-whitelines)
+		git_apply_opt="$git_apply_opt $1" ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
 	--patch-format)
diff --git a/git-rebase.sh b/git-rebase.sh
index 18bc694..1556224 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -333,6 +333,9 @@ do
 			;;
 		esac
 		;;
+	--allow-eof-whitelines)
+		git_am_opt="$git_am_opt $1"
+		;;
 	--committer-date-is-author-date|--ignore-date)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
-- 
1.6.4.rc3.dirty
