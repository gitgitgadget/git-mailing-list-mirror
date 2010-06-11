From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] fast-import: die_nicely() back to vsnprintf (reverts part of ebaa79f)
Date: Fri, 11 Jun 2010 17:02:50 +0200
Message-ID: <769689aa933aa5b0d207e94983328c03db105594.1276268216.git.trast@student.ethz.ch>
References: <AANLkTikIQeY1ZieEkev_zjDSVI9W1NpfhiyTNCaToeys@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 17:03:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON5lT-0006e9-BP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 17:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab0FKPDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 11:03:15 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:51312 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0FKPDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 11:03:14 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 11 Jun
 2010 17:03:11 +0200
Received: from localhost.localdomain (192.33.107.117) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 11 Jun
 2010 17:02:51 +0200
X-Mailer: git-send-email 1.7.1.561.g94582
In-Reply-To: <AANLkTikIQeY1ZieEkev_zjDSVI9W1NpfhiyTNCaToeys@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148952>

ebaa79f (Make report() from usage.c public as vreportf() and use it.,
2010-03-06) changed fast-import's die_nicely() to use vreportf().
Unfortunately this is not possible: we need the message again for
write_report(), and vreportf() uses vsnprintf(), which invalidates the
va_list.  As pointed out by Erik Faye-Lund, va_copy is C99 and thus
not an option.

So revert the part of ebaa79f that pertains to die_nicely().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Erik Faye-Lund wrote:
> Ugh. We don't use the va_copy for portability reasons; it's C99, and
> impossible to implement in a portable way on non-C99 systems.

Ah well, that makes the patch easier to write though more annoying :-)

 fast-import.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c0728c2..1e5d66e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -483,12 +483,14 @@ static void dump_marks(void);
 static NORETURN void die_nicely(const char *err, va_list params)
 {
 	static int zombie;
+	char message[2 * PATH_MAX];
 
-	vreportf("fatal: ", err, params);
+	vsnprintf(message, sizeof(message), err, params);
+	fputs("fatal: ", stderr);
+	fputs(message, stderr);
+	fputc('\n', stderr);
 
 	if (!zombie) {
-		char message[2 * PATH_MAX];
-
 		zombie = 1;
 		write_crash_report(message);
 		end_packfile();
-- 
1.7.1.561.g94582
