From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/6] userdiff: add xdiff_clear_find_func()
Date: Thu, 02 Jul 2009 00:01:43 +0200
Message-ID: <4A4BDCC7.1090405@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7sF-0002X1-4o
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZGAWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbZGAWBk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:01:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:55647 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbZGAWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:01:40 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id AA11E2F8068;
	Thu,  2 Jul 2009 00:01:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4BDC65.80504@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122603>

xdiff_set_find_func() is used to set user defined regular expressions
for finding function signatures.  Add xdiff_clear_find_func(), which
frees the memory allocated by the former, making the API complete.

Also, use the new function in diff.c (the only call site of
xdiff_set_find_func()) to clean up after ourselves.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diff.c            |    1 +
 xdiff-interface.c |   15 +++++++++++++++
 xdiff-interface.h |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 43835d7..892921c 100644
--- a/diff.c
+++ b/diff.c
@@ -1603,6 +1603,7 @@ static void builtin_diff(const char *name_a,
 			free(mf1.ptr);
 		if (textconv_two)
 			free(mf2.ptr);
+		xdiff_clear_find_func(&xecfg);
 	}
 
  free_ab_and_return:
diff --git a/xdiff-interface.c b/xdiff-interface.c
index b9b0db8..01f14fb 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -309,6 +309,21 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 	}
 }
 
+void xdiff_clear_find_func(xdemitconf_t *xecfg)
+{
+	if (xecfg->find_func) {
+		int i;
+		struct ff_regs *regs = xecfg->find_func_priv;
+
+		for (i = 0; i < regs->nr; i++)
+			regfree(&regs->array[i].re);
+		free(regs->array);
+		free(regs);
+		xecfg->find_func = NULL;
+		xecfg->find_func_priv = NULL;
+	}
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 7352b9a..55572c3 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -21,6 +21,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
+extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
 extern int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
-- 
1.6.3.3
