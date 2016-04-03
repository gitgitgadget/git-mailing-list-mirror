From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/log.c: fixup format-patch --base segfault
Date: Sun, 3 Apr 2016 02:19:53 +0100
Message-ID: <57006FB9.4080904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: xiaolong.ye@intel.com
X-From: git-owner@vger.kernel.org Sun Apr 03 03:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amWhz-0001mr-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 03:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbcDCBUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 21:20:01 -0400
Received: from avasout07.plus.net ([84.93.230.235]:40059 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbcDCBUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 21:20:00 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id ddKw1s0012D2Veb01dKxGj; Sun, 03 Apr 2016 02:19:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=WwHGVQEjXcAMIhAnR-sA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290619>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Xiaolong,

When you next re-roll your 'xy/format-patch-base' branch could you
please squash this (or something like it) into the relevant patch.
(commit 50ff6afd, "format-patch: add '--base' option to record base
tree info", 31-03-2016).

The pu branch, for me, fails a shed load of tests in the following:

    t3301-notes.sh
    t3901-i18n-patch.sh
    t4014-format-patch.sh
    t4021-format-patch-numbered.sh
    t4028-format-patch-mime-headers.sh
    t4030-diff-textconv.sh
    t4036-format-patch-signer-mime.sh
    t4052-stat-output.sh
    t4122-apply-symlink-inside.sh
    t4150-am.sh
    t4151-am-abort.sh
    t4152-am-subjects.sh
    t4255-am-submodule.sh
    t7400-submodule-basic.sh
    t7512-status-help.sh
    t9001-send-email.sh

Looking at the first failure, the cause was a segfault while running
git-format-patch. A quick trip to the debugger showed that the segfault
was in print_bases(). Furthermore, the contents of the bases structure
passed in looked very dodgy (bases->nr_patch_id was 32767 and bases->patch_id[0]
was 0xc). Indeed, it looked like it had not been initialized ...

[NOTE: t6038-merge-text-auto.sh also fails for me, but it has nothing
to do with your patch series. ;-)]

This patch was just a quick fix, you may chose a different approach to
fix the problem (eg don't call print_bases() unconditionally ...).

ATB,
Ramsay Jones

 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 48c74f5..fed0f99 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1625,8 +1625,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		signature = strbuf_detach(&buf, NULL);
 	}
 
+	memset(&bases, 0, sizeof(bases));
 	if (base_commit || config_base_commit) {
-		memset(&bases, 0, sizeof(bases));
 		reset_revision_walk();
 		prepare_bases(&bases, base_commit, list, nr);
 	}
-- 
2.8.0
