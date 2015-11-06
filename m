From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] wt-status: use strncmp() for length-limited string comparison
Date: Fri, 6 Nov 2015 23:47:03 +0100
Message-ID: <563D2DE7.1030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zupmu-0002dm-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 23:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647AbbKFWrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 17:47:13 -0500
Received: from mout.web.de ([212.227.15.3]:58652 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbbKFWrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 17:47:12 -0500
Received: from [192.168.178.36] ([79.253.143.195]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M3PN2-1alpua1pfE-00qzTV; Fri, 06 Nov 2015 23:47:04
 +0100
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:JmJf8k/rrRwmtbiMQ9B1VIYERhjGDKeR2RD0AB+ckf3jL2rFMxl
 LHPy24mf3Uh8YxXSN9E5rV9ElmDMPTInohwH8gm29Xz9pRYkDEJS3c7CDL8MoN46hdyQHKN
 Ciwr6r4toc8Q8x95JgWfQ0ysvm1PUsH9KpTZRWGvI/NMh2TlC3ESpvE1zo88uUME/TGqMAE
 xHeOfkIL9IPqfZKc/PN1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:exKYiuzGNFw=:g3IvD0Urw8GSdpQcakYzTP
 kq1DvfmHreE7Y1aPDp0ZNNFnN4zp4aVWqqX9ED38s6GWL5/gss+q6zOqeKX9LgDL3A+JxNeyD
 oTk0/cF81a65zRVLg3FZ809EOuvOgipcQsudUCj7rjcSliioq4gc2gqy36nPZy9eSkDwSErlV
 T08D+I2GPIF21e2IgyfrECZQgUeM7CC28uWAkREYFs3Ejdw94DXeN0oQqbWbtjt+E4a9pyx+0
 Ha5JRrLBh6RVpWVm2F8/e3m+fm2Zx6o4nmiyhymscvQ35bRZQTguz0EobYGytr9XCIW45e75p
 fI2wg67tx3yZFzGcu/ULX1/Mzz/d9RuMjh2/RTioguBMHNA590GJ/Bq5NSqyAci8ujszWZUTx
 XUVPviOrZIYx7PaLogmDgP0wR7Y/vnAiaDkrW4KNfGhMC7T88uXQTk9q3Yb6cRRWolEq9kbbt
 cu1ZhAixSg+qXrrE9E0nlO6VuFekxTGJ6iOEHdmvzLFVgr/zdsqjL2KDQ2cAbV31gHZajW7oG
 YggaGYsPdHlyCQ9ti4vFAvOnpPAAPl2qYDGgl9+hqU2jS/tnWxJRBtZzyxeuaHslZcegXnAhS
 9vqLavT2zNLCIDeaKsqPXaAFrreuBWfC0rCK5pJNZ4jF8f+B7GmRpVMZwmGjcvDovZdyMmNwA
 lfz4qlgvuD5tdRjJphZWkesoY8XxKNvCGJvN22/WK77oUjs06/JS+BBmdfIYyH57BzK+Axqm2
 7lAYmUbB87naXnzWhnbWsxjY2zO+tlYk87VrnpkU9lAhZ472wq77OJ6FaoE3GRgg/NvYQRRK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281002>

When a branch name is longer than four characters, memcmp() can read
past the end of the string literal "HEAD".  Use strncmp() instead, which
stops at the end of a string.  This fixes the following test failures
with AddressSanitizer:

t3203-branch-output.sh                           (Wstat: 256 Tests: 18 Failed: 4)
  Failed tests:  12, 15-17
  Non-zero exit status: 1
t3412-rebase-root.sh                             (Wstat: 256 Tests: 31 Failed: 3)
  Failed tests:  28-29, 31
  Non-zero exit status: 1
t3507-cherry-pick-conflict.sh                    (Wstat: 256 Tests: 31 Failed: 4)
  Failed tests:  14, 29-31
  Non-zero exit status: 1
t3510-cherry-pick-sequence.sh                    (Wstat: 256 Tests: 39 Failed: 14)
  Failed tests:  17, 22-26, 28-30, 34-35, 37-39
  Non-zero exit status: 1
t3420-rebase-autostash.sh                        (Wstat: 256 Tests: 28 Failed: 4)
  Failed tests:  24-27
  Non-zero exit status: 1
t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 91 Failed: 57)
  Failed tests:  17, 19, 21-42, 44, 46-74, 77, 81-82
  Non-zero exit status: 1
t3900-i18n-commit.sh                             (Wstat: 256 Tests: 34 Failed: 1)
  Failed test:  34
  Non-zero exit status: 1
t5407-post-rewrite-hook.sh                       (Wstat: 256 Tests: 14 Failed: 6)
  Failed tests:  9-14
  Non-zero exit status: 1
t7001-mv.sh                                      (Wstat: 256 Tests: 46 Failed: 5)
  Failed tests:  39-43
  Non-zero exit status: 1
t7509-commit.sh                                  (Wstat: 256 Tests: 12 Failed: 2)
  Failed tests:  11-12
  Non-zero exit status: 1
t7512-status-help.sh                             (Wstat: 256 Tests: 39 Failed: 35)
  Failed tests:  5-39
  Non-zero exit status: 1
t6030-bisect-porcelain.sh                        (Wstat: 256 Tests: 70 Failed: 1)
  Failed test:  13
  Non-zero exit status: 1

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 435fc28..8dc281b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1319,7 +1319,7 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	hashcpy(cb->nsha1, nsha1);
 	for (end = target; *end && *end != '\n'; end++)
 		;
-	if (!memcmp(target, "HEAD", end - target)) {
+	if (!strncmp(target, "HEAD", end - target)) {
 		/* HEAD is relative. Resolve it to the right reflog entry. */
 		strbuf_addstr(&cb->buf,
 			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
-- 
2.6.3
