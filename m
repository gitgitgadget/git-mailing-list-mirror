From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] xdiff: remove unused functions
Date: Wed, 09 May 2012 22:43:30 +0200
Message-ID: <4FAAD6F2.9050600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDjh-00046B-QD
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761181Ab2EIUnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:43:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:59445 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761110Ab2EIUno (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:43:44 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id D19602F803C;
	Wed,  9 May 2012 22:43:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197511>

The functions xdl_cha_first(), xdl_cha_next() and xdl_atol() are not used
by us.  While removing them increases the difference to the upstream
version of libxdiff, it only adds a bit to the more than 600 differing
lines in xutils.c (mmfile_t management was simplified significantly when
the library was imported initially).  Besides, if upstream modifies these
functions in the future, we won't need to think about importing those
changes, so in that sense it makes tracking modifications easier.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff/xutils.c |   43 -------------------------------------------
 xdiff/xutils.h |    3 ---
 2 files changed, 46 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 1b3b471..ae6ce0d 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -122,35 +122,6 @@ void *xdl_cha_alloc(chastore_t *cha) {
 	return data;
 }
 
-
-void *xdl_cha_first(chastore_t *cha) {
-	chanode_t *sncur;
-
-	if (!(cha->sncur = sncur = cha->head))
-		return NULL;
-
-	cha->scurr = 0;
-
-	return (char *) sncur + sizeof(chanode_t) + cha->scurr;
-}
-
-
-void *xdl_cha_next(chastore_t *cha) {
-	chanode_t *sncur;
-
-	if (!(sncur = cha->sncur))
-		return NULL;
-	cha->scurr += cha->isize;
-	if (cha->scurr == sncur->icurr) {
-		if (!(sncur = cha->sncur = sncur->next))
-			return NULL;
-		cha->scurr = 0;
-	}
-
-	return (char *) sncur + sizeof(chanode_t) + cha->scurr;
-}
-
-
 long xdl_guess_lines(mmfile_t *mf, long sample) {
 	long nl = 0, size, tsize = 0;
 	char const *data, *cur, *top;
@@ -430,20 +401,6 @@ int xdl_num_out(char *out, long val) {
 	return str - out;
 }
 
-
-long xdl_atol(char const *str, char const **next) {
-	long val, base;
-	char const *top;
-
-	for (top = str; XDL_ISDIGIT(*top); top++);
-	if (next)
-		*next = top;
-	for (val = 0, base = 1, top--; top >= str; top--, base *= 10)
-		val += base * (long)(*top - '0');
-	return val;
-}
-
-
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 		      const char *func, long funclen, xdemitcb_t *ecb) {
 	int nb = 0;
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 714719a..ad1428e 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -31,14 +31,11 @@ int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
 void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
-void *xdl_cha_first(chastore_t *cha);
-void *xdl_cha_next(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
 unsigned long xdl_hash_record(char const **data, char const *top, long flags);
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
-long xdl_atol(char const *str, char const **next);
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 		      const char *func, long funclen, xdemitcb_t *ecb);
 int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
-- 
1.7.10.1
