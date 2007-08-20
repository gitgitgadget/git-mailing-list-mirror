From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: va_copy is not available on all systems.
Date: Mon, 20 Aug 2007 15:16:56 +0200
Organization: eudaptics software gmbh
Message-ID: <46C99448.2AB33DFF@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN77E-0005bo-On
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 15:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbXHTNQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 09:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbXHTNQP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 09:16:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53208 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbXHTNQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 09:16:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IN773-0001dy-Tn; Mon, 20 Aug 2007 15:16:10 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 808A254D; Mon, 20 Aug 2007 15:16:09 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.378, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56215>

This is just too ugly to be included...

die_nicely() uses the variable argument list twice. The recent fix for
this in 7e5dcea8311 uses va_copy. However, on older systems this function
is not available. This fix assumes that those systems that do have
the function actually implement it as macro, and we use it to remove
the entire nicely() functionality.

Since va_copy() must be provided by the compiler, we don't have a
reasonable chance to provide a working definition in git_compat_util.h.
---
 fast-import.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2d5224c..edc76a4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -349,6 +349,7 @@ static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct dbuf new_data;
 
+#ifdef va_copy
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
 	fprintf(rpt, "%s:\n", b->name);
@@ -456,6 +457,7 @@ static NORETURN void die_nicely(const char *err, va_list params)
 	va_end(x_params);
 	exit(128);
 }
+#endif
 
 static void alloc_objects(unsigned int cnt)
 {
@@ -2381,7 +2383,9 @@ int main(int argc, const char **argv)
 
 	prepare_packed_git();
 	start_packfile();
+#ifdef va_copy
 	set_die_routine(die_nicely);
+#endif
 	for (;;) {
 		read_next_command();
 		if (command_buf.eof)
-- 
1.5.3.rc5.15.g8ddb
