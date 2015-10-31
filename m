From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/5] wt-status: avoid building bogus branch name with detached
 HEAD
Date: Sat, 31 Oct 2015 18:36:35 +0100
Message-ID: <5634FC23.2090703@web.de>
References: <5634FB59.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa5D-0003WB-8F
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbbJaRgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:36:47 -0400
Received: from mout.web.de ([212.227.17.12]:64820 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbbJaRgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:36:46 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGRVU-1ZfKWy0v1E-00DCd0; Sat, 31 Oct 2015 18:36:36
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5634FB59.1000506@web.de>
X-Provags-ID: V03:K0:3KC2JtO7zONMroFT9sInUd/Y2DG+pO8YlkFm1LGm8h/H0KlgD7X
 7j9OVmCHv9qzrAI8jGVwYhDJdp2riHIzf1TS6FecBh+vPD4Qoz6sSQuwZsYAJjueRqAvkRj
 Vv8fK+7F/a9xbMYqN+dDDtSs/uLXJ/sZJxIYMp5Mci6MLkTJ2LsA/Gd8l9Ac7szXQwGacfY
 QLOUW4UNpPgqypSWvBffQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4fB1AAH7YQA=:9VLsqxsi/+zrjAd6afTqT/
 tFwOBUA+pRf8TwFbkrYFpGpDpYOuoP8ZuiaS5/gXzI1+rK0Gmpi9SO8vImt4fdcSvoi216EN7
 RHRtiTDf10gJAvOr83ujrvEcVCgdhKDjx/65u1AOpg8E/tAnl8a8Y9m1cRgU0Z797pE9rcfTQ
 EHHheHPJxvMzDtoEwsP97ToMv9a8XiZTflKbhRSWRSStG4b22FmXcBd+lu7I+wFgiwP1qH+KG
 e9YXbbtG8aGOvyp6ueYxtHqNs8fxrFLrzpIyL7FWdkvYIsQQUYZszNtR4TCdFT45S0o68odNr
 fQ6oiKhFA64mMy4fN7ZJPWWNJM7XC6d+G9ygiQ71QEYBiK1NwHigOkbE+ZRFfgyVT6MD8qFWd
 FQVmS2Ti+vqxKeamK5AAR9nP1q/99mRbm7KznfK7o3WZlQ1h8UaBZbkep/QQoDGO77WKL1aSj
 40Fa3JpTkpgGq66rt6/PQJSh4D13pU+pUEqOFez2XpkWctLTCQ/x91LwPKhbpuKQIUAuK9mH6
 3U/pNqefb0fdpVMSr47DJ1siADK9qNABbRl70kpp/GZGMDYI32zsUcY2sIwg2MsTPC9S2xfr8
 0Ra8SG5XEuwQdwqek50VhlioXSXG/5OF84FJj+ZIS+MbGwwO1vdlPpfuatvrTixoeS2sl24WJ
 TxmjaPCjiz1/QpLgvZok+5LoF0mNvEQ6DMDxM+gDRMu4vQ8SPFdPVK/YJXX9f4HHZbYB4uNTM
 6zp6V9FRlAcOx/HCoYiobr1k4mSNC/Z7WvbSH7ACVPraWs3uX4Moqtd9QG1KTyoxabJsrUP5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280589>

If we're on a detached HEAD then wt_shortstatus_print_tracking() takes
the string "HEAD (no branch)", translates it, skips the first eleven
characters and passes the result to branch_get(), which returns a bogus
result and accesses memory out of bounds in order to produce it.
Somehow stat_tracking_info(), which is passed that result, does the
right thing anyway, i.e. it finds that there is no base.

Avoid the bogus results and memory accesses by checking for HEAD first
and exiting early in that case.  This fixes t7060 with --valgrind.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t7060-wtstatus.sh |  2 +-
 wt-status.c         | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index e6af772..44bf1d8 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -213,7 +213,7 @@ EOF
 	git checkout master
 '
 
-test_expect_failure 'status --branch with detached HEAD' '
+test_expect_success 'status --branch with detached HEAD' '
 	git reset --hard &&
 	git checkout master^0 &&
 	git status --branch --porcelain >actual &&
diff --git a/wt-status.c b/wt-status.c
index 083328f..e206cc9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1644,16 +1644,19 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		return;
 	branch_name = s->branch;
 
+	if (s->is_initial)
+		color_fprintf(s->fp, header_color, _("Initial commit on "));
+
+	if (!strcmp(s->branch, "HEAD")) {
+		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
+			      _("HEAD (no branch)"));
+		goto conclude;
+	}
+
 	if (starts_with(branch_name, "refs/heads/"))
 		branch_name += 11;
-	else if (!strcmp(branch_name, "HEAD")) {
-		branch_name = _("HEAD (no branch)");
-		branch_color_local = color(WT_STATUS_NOBRANCH, s);
-	}
 
 	branch = branch_get(s->branch + 11);
-	if (s->is_initial)
-		color_fprintf(s->fp, header_color, _("Initial commit on "));
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-- 
2.6.2
