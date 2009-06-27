From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 2/4] die_errno(): double % in strerror() output just in case
Date: Sat, 27 Jun 2009 17:58:45 +0200
Message-ID: <c3635ed5bd260b5f358893917d05bd09320ae9d6.1246115205.git.trast@student.ethz.ch>
References: <cover.1244494646.git.trast@student.ethz.ch> <cover.1246115204.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 17:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKaIu-0004IM-JE
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 17:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbZF0P6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 11:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZF0P6x
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 11:58:53 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16289 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893AbZF0P6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 11:58:50 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:49 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:49 +0200
X-Mailer: git-send-email 1.6.3.3.433.gc91b
In-Reply-To: <cover.1246115204.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 27 Jun 2009 15:58:49.0273 (UTC) FILETIME=[28E36A90:01C9F740]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122370>

From: Junio C Hamano <gitster@pobox.com>

[tr: handle border case where % is placed at end of buffer]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 usage.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/usage.c b/usage.c
index fd936a1..b6aea45 100644
--- a/usage.c
+++ b/usage.c
@@ -64,8 +64,24 @@ void die_errno(const char *fmt, ...)
 {
 	va_list params;
 	char fmt_with_err[1024];
-
-	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, strerror(errno));
+	char str_error[256], *err;
+	int i, j;
+
+	err = strerror(errno);
+	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
+		if ((str_error[j++] = err[i++]) != '%')
+			continue;
+		if (j < sizeof(str_error) - 1) {
+			str_error[j++] = '%';
+		} else {
+			/* No room to double the '%', so we overwrite it with
+			 * '\0' below */
+			j--;
+			break;
+		}
+	}
+	str_error[j] = 0;
+	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
 
 	va_start(params, fmt);
 	die_routine(fmt_with_err, params);
-- 
1.6.3.3.433.gc91b
