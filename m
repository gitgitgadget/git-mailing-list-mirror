From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2] wt-status: correct and simplify check for detached HEAD
Date: Wed, 25 Nov 2015 15:10:18 +0100
Message-ID: <5655C14A.1060308@web.de>
References: <563D2DE7.1030005@web.de>
 <20151124213601.GB29185@sigill.intra.peff.net> <56551A11.9030809@web.de>
 <20151125091503.GA1779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 15:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ame-0002S4-3c
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 15:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbbKYOKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 09:10:54 -0500
Received: from mout.web.de ([212.227.17.12]:51785 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442AbbKYOKw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 09:10:52 -0500
Received: from [192.168.178.36] ([79.253.136.54]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lm4hJ-1aaNQh0ZWr-00ZedT; Wed, 25 Nov 2015 15:10:26
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151125091503.GA1779@sigill.intra.peff.net>
X-Provags-ID: V03:K0:gAY5C+lZhTCE/LXDLTla1eCTq3ilvZAR4sJY2ZMxtxz+xei2pYt
 w/WColkwADi1c2dPjy31cc3Zl/LxuKuWjJnwORPbkHBlVMGeErQLogBqx1SnylQ+KVbrmKz
 8jXHPbqh7XLmr/+qhzswL3bj3aDJkPdS8BTP2AKltrPrviy/7adFbgLfqItG12CO/9UPJ6i
 7rOgcUs6wtlW2fzUtF+sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gl7cIIBiy9I=:gEtrcHK10Jua+d+EKRvOwt
 L8ZeexJWqfgWyEPnA2G3/YB7E9UoWUnHKMiUnF0I2VpDuHMYdgnB6G1ZiMbNenZRfX0T1QtPo
 JLpVV1Bk945RI3Z64VaYYO4Y7RHdSdd5QH+0J9pJvA6MSoOxQyj98ZPeREcbx/QX/bDdX15qc
 dsFlG3pqy0O6feI3X4Yr3q9cHjAfhS0txRlkQVS2LV3G0HgZ2cCj5uv9RJ551ZKxyo4Dhtnqk
 Yd1MlydxmGJSc5fhPGlW8uf02onLxPvm5ETlo2Pp6tRWfNDIWmh05SALdD9Uy7WXnQy7ya/m4
 DlYyTeAcdXquyaj3SPTovQRguRADGvKiNxlJ4KvG+X6sbVrhOZhfZJ9pmPfORcW9csfr0sqtk
 Jl6HogJywZuXoJAChgh/So3ovUVJiY6hIYlEwSpfg1of2NtTn2pHDw78LGtYfDOS57BFiW2Oz
 Ypqgo2AerFEZQ8CG4NUn8gbfXm86GRIwR3VUsZCo0Hx5YUrIuLcwgUiRRXhj+FdbRI7XKDH0d
 SvlXhTOW36IxG5NG92OoV8/G8sqqb7/7ruXqdDbrYN9VtiHzInt0icDVBQaf8494ccbA0EkP0
 eStQOA/+n5LAEmFbY7OtIr0IXtkwRUWG3Sq//XcSM5ptspZmkuFZ2Uz0bb7+A0LeK1Z2TPXpB
 EI9tF4GgU9wqiusD3cBTZWeULjo4U8e19g9+GIYec/XdAMVnV+ck5JjrxuTrpP4K5XWrWIeiQ
 Z7FSQMLsYitnchenKwehHrO1u43OQLx9mbIcg9xjkcJKFWeS3s0L50LHdiWtxg/ATSPEoDW5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281713>

If a branch name is longer than four characters then memcmp() reads over
the end of the static string "HEAD".  This causes the following test
failures with AddressSanitizer:

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

And if a branch is named "H", "HE", or "HEA" then the current if clause
erroneously considers it as matching "HEAD" because it only compares
up to the end of the branch name.

Fix that by doing the comparison using strcmp() and only after the
branch name is extracted.  This way neither too less nor too many
characters are checked.  While at it call strchrnul() to find the end
of the branch name instead of open-coding it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
We can be more careful when parsing -- or avoid parsing and backtrack
if we found "HEAD" after all.  The latter is simpler, and string
parsing is tricky enough that we better take such opportunities to
simplify the code..

Changes since v1:
* strcmp() instead of strncmp()
* strchrnul() (unrelated cleanup)
* adjusted subject (and commit message)

 wt-status.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 435fc28..ced53dd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1317,15 +1317,14 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	target += strlen(" to ");
 	strbuf_reset(&cb->buf);
 	hashcpy(cb->nsha1, nsha1);
-	for (end = target; *end && *end != '\n'; end++)
-		;
-	if (!memcmp(target, "HEAD", end - target)) {
+	end = strchrnul(target, '\n');
+	strbuf_add(&cb->buf, target, end - target);
+	if (!strcmp(cb->buf.buf, "HEAD")) {
 		/* HEAD is relative. Resolve it to the right reflog entry. */
+		strbuf_reset(&cb->buf);
 		strbuf_addstr(&cb->buf,
 			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
-		return 1;
 	}
-	strbuf_add(&cb->buf, target, end - target);
 	return 1;
 }
 
-- 
2.6.3
