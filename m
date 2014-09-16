From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 22/35] git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
Date: Tue, 16 Sep 2014 21:33:43 +0200
Message-ID: <1410896036-12750-23-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWf-0000NU-8J
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbaIPTeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:50 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53874 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755050AbaIPTet (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:49 -0400
X-AuditID: 12074414-f79446d000001f1d-17-541890d914a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.EA.07965.9D098145; Tue, 16 Sep 2014 15:34:49 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcQ001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:48 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHtzgkSIwfen4hZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cdsfr/fdaCFVwV65e2sjcwtnF0MXJySAiYSKz8eoIR
	whaTuHBvPVsXIxeHkMBlRond5x8wQTgnmCSetK4Bq2IT0JVY1NMMlhARaGOU2HVxMyuIwyzQ
	zSjx/sRpJpAqYYF4if7b88BsFgFViUmzlrGA2LwCrhKPfkxmh9gnJ7Fh93+gqRwcnEDxr/sK
	QEwhAReJg3f9JjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREngi
	OxiPnJQ7xCjAwajEw+vxSDxEiDWxrLgy9xCjJAeTkijvv26JECG+pPyUyozE4oz4otKc1OJD
	jBIczEoivD98gXK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK88/qB
	GgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP0N7NIO28xQWJuUBR
	iNZTjLoc6zq/9TMJseTl56VKifPagBQJgBRllObBrYClmVeM4kAfC/NuAaniAaYouEmvgJYw
	AS052yMGsqQkESEl1cDIZqDEtG4Ti+mdZOb0z/UPbkwPOrT3bQtHkZ9MIJ+0Tmva4o4TZb6X
	V7EKNefH5HuUMsz5MyVG1Gkqd1xq3sIjh5M2ZD3QKZ83obax3J9R7m/wYTX3tlV/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257152>

After commit_lock_file() is called, then the lock_file object is
necessarily either committed or rolled back.  So there is no need to
call rollback_lock_file() again in either of these cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 config.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 83c913a..a8ab809 100644
--- a/config.c
+++ b/config.c
@@ -2076,17 +2076,17 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	if (commit_lock_file(lock) < 0) {
 		error("could not commit config file %s", config_filename);
 		ret = CONFIG_NO_WRITE;
-		goto out_free;
-	}
+	} else
+		ret = 0;
 
 	/*
-	 * lock is committed, so don't try to roll it back below.
-	 * NOTE: Since lockfile.c keeps a linked list of all created
-	 * lock_file structures, it isn't safe to free(lock).  It's
-	 * better to just leave it hanging around.
+	 * lock is committed or rolled back now, so there is no need
+	 * to roll it back below.  NOTE: Since lockfile.c keeps a
+	 * linked list of all created lock_file structures, it isn't
+	 * safe to free(lock).  We have to just leave it hanging
+	 * around.
 	 */
 	lock = NULL;
-	ret = 0;
 
 	/* Invalidate the config cache */
 	git_config_clear();
-- 
2.1.0
