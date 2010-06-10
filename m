From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] fast-import: revert die_nicely() to vsnprintf
Date: Thu, 10 Jun 2010 21:55:30 +0200
Message-ID: <29df1a625a82bd2d3fcee92068b3a15f56435c66.1276199549.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 21:55:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMnqn-0006f0-AY
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 21:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759713Ab0FJTzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 15:55:35 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:33675 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab0FJTze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 15:55:34 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 21:55:32 +0200
Received: from localhost.localdomain (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 21:55:32 +0200
X-Mailer: git-send-email 1.7.1.561.g94582
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148914>

ebaa79f (Make report() from usage.c public as vreportf() and use it.,
2010-03-06) changed fast-import's die_nicely() to use vreportf().

This requires some more care though.  First it forgot that we also
need to reformat the message for the crash report.  Second, vreportf()
uses vsnprintf(), which does not call va_end().  This leaves the
va_list passed to it in an undefined state.  Therefore we need to make
a copy of this va_list so that we can reuse it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Another valgrind catch.  I think that'll be the last one for today.
Thanks for your attention.


 fast-import.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c0728c2..1fa5de4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -483,12 +483,14 @@ static void dump_marks(void);
 static NORETURN void die_nicely(const char *err, va_list params)
 {
 	static int zombie;
+	va_list saved_params;
+	va_copy(saved_params, params);
 
 	vreportf("fatal: ", err, params);
 
 	if (!zombie) {
 		char message[2 * PATH_MAX];
-
+		vsnprintf(message, sizeof(message), err, saved_params);
 		zombie = 1;
 		write_crash_report(message);
 		end_packfile();
-- 
1.7.1.561.g94582
