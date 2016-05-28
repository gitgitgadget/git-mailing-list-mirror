From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 6/8] xdiff: don't trim common tail with -W
Date: Sat, 28 May 2016 17:04:31 +0200
Message-ID: <5749B37F.4080301@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 17:04:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fnA-0006Q3-Q4
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbcE1PEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:04:41 -0400
Received: from mout.web.de ([212.227.15.4]:51757 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbcE1PEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:04:40 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MRA59-1ax5pv38E3-00UcrR; Sat, 28 May 2016 17:04:32
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:mFXSoW5Oa6+BNr/WsuHO0VSgRNzViXhNOJ2c6PSAMT6duBNDbLP
 o+0OSc2OzST8f2z8ib3yTDBnWQN9jz0bnjgpJoXRVp57ZHl2dsoP4JR7TyEn4/3xSVBEbRZ
 nXdcxsjyeSh1mLW9Y8Hw4b0msdHD8Ep5RfyWD9ZDnQOb9kC9k5w+y4cBNFpAp7xKL0sup5y
 X0pfg442e7UBIwq9daK/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wu3i9lwCVOs=:Y8vVjKd+r3k3JyYS1aGoTV
 M/kWFnbfrH3h/TCLceiGhljQhyRE96KWB/hsWrf644Ui3u9o0UOP21dHCjYap9hC/EgPhU/Vo
 YLqhzqPGVoUYXyxjuIRUgluvZPWpxqAdl3MZCxOccD3RPCRBveAwIOyrwKJgd6K+FL5UqYFMz
 6AYcsvrmY4NkD2yajS2b1A+Hz0EYsboWwOdixiNJkZ7VSaihAlwuwnFP8g4mgb05d30zYww9l
 8YT3QsWNLYovSRZQKiMnO9rUYdM7Do5ODZtog1A1RF45DaeM73rf97+ZkNUAgErLAjJ+eKTr1
 wtUXTNwbXV9XIl4nu5vCZ4O163A2Or+7wLhg8DlBqCrU4QhHC1BZ3u5HpkjutAOAR77BnZhuy
 QniBtn/f8uTXtkDQUG4QkNaLk5XeyAl1A8ScAnLJPG/NpCFiRBMVn4HIDRwDRZLS/kiKcpLfR
 XAyx/AsBWJkwZRPvIEvIHZgI8/uIKkgU+SEJVNmfE9P+nlFWYQGmNDl5+xb/Z4/dPK32vuu+l
 xZSJbVw5aY1q+HbRrYcsiZq3Lz2eHRpy4LVd86ZevZFWBn+pMiDkX4rLuE2TNFauMCsvxpC2Y
 /T17TVYnjGZMUJgXD0wcFdLVqXrp2GpKMJH0yUV+MRXftywQNEvXY/bhdJi3CoVUVrUqCj4bK
 uLG2YNJcQUZPouuvOxljfnXaHo7c+D3jFqGnfZLgtaY/gcVEzpdYNCezIiZio9gqhoMVjtMqk
 7S9AzehOQVJnSeDUVGjgVrLO/JclloXueUm+mzeXDScAlXZpkC5qkl74/m4Ekja5e6aQcO3C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295824>

The function trim_common_tail() exits early if context lines are
requested.  If -U0 and -W are specified together then it can still trim
context lines that might belong to a changed function.  As a result
that function is shown incompletely.

Fix that by calling trim_common_tail() only if no function context or
fixed context is requested.  The parameter ctx is no longer needed now;
remove it.

While at it fix an outdated comment as well.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh |  2 +-
 xdiff-interface.c                | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 9fe590f..88a3308 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -145,7 +145,7 @@ test_expect_success ' context includes begin' '
 	grep "^ .*Begin of first part" long_common_tail.diff
 '
 
-test_expect_failure ' context includes end' '
+test_expect_success ' context includes end' '
 	grep "^ .*End of second part" long_common_tail.diff
 '
 
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 54236f2..f34ea76 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -100,9 +100,9 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 
 /*
  * Trim down common substring at the end of the buffers,
- * but leave at least ctx lines at the end.
+ * but end on a complete line.
  */
-static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
+static void trim_common_tail(mmfile_t *a, mmfile_t *b)
 {
 	const int blk = 1024;
 	long trimmed = 0, recovered = 0;
@@ -110,9 +110,6 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 	char *bp = b->ptr + b->size;
 	long smaller = (a->size < b->size) ? a->size : b->size;
 
-	if (ctx)
-		return;
-
 	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
 		trimmed += blk;
 		ap -= blk;
@@ -134,7 +131,8 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
 		return -1;
 
-	trim_common_tail(&a, &b, xecfg->ctxlen);
+	if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
+		trim_common_tail(&a, &b);
 
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
-- 
2.8.3
