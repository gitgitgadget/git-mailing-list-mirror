From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/22] rollback_lock_file(): set fd to -1
Date: Tue,  1 Apr 2014 17:58:12 +0200
Message-ID: <1396367910-7299-5-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV17J-0008AR-UH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbaDAQAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 12:00:38 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56291 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828AbaDAP6m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:42 -0400
X-AuditID: 12074413-f79076d000002d17-b3-533ae231cd8a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E7.58.11543.132EA335; Tue,  1 Apr 2014 11:58:42 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWb8027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:40 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqGv0yCrY4PAuJouuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ0xb1cHS8Eq1op5v3waGBezdDFyckgImEhMn/2UGcIWk7hwbz0biC0kcJlRYvFuoy5G
	LiD7GJPE+wnLGEESbAK6Eot6mplAbBEBNYmJbYfABjELpEi8+rsLzBYWsJS4dPgWWA2LgKrE
	/bP/wBbwCjhLzP7XxgSxTE5iyu8F7CA2p4CLxKUHe1ghFjtLnH6zmHkCI+8CRoZVjHKJOaW5
	urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCEBJbyDcddJuUOMAhyMSjy8B85bBQuxJpYV
	V+YeYpTkYFIS5f1xFyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfWTaAcb0piZVVqUT5MSpqD
	RUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCN+ohUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFq
	XkpqUWJpSUY8KC7ii4GRAZLiAdo7HaSdt7ggMRcoCtF6ilFRSpw3BCQhAJLIKM2DGwtLE68Y
	xYG+FOZdDFLFA0wxcN2vgAYzAQ3mXgc2uCQRISXVwKjb8p/bXV8ilPu5/hST/Nu2TU1ZO3tC
	zi7Qf+LlP3+RDtPRju6ZSpEya68Ybj9wwC5g1dd/HHsuMvo6WdkIiZUZ/OZd8dgv1Prko844
	4/0vdk4RCt978N89k8u/fq+ZnOXvxh1Qv1zYynx1/I25LV+kejIc0iKfbzvoIdzw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245613>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1.  This could help prevent
confusion in the face of hypothetical future programming errors.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index d26711f..c1af65b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -275,7 +275,7 @@ void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
 		if (lk->fd >= 0)
-			close(lk->fd);
+			close_lock_file(lk);
 		unlink_or_warn(lk->filename);
 		lk->filename[0] = 0;
 	}
-- 
1.9.0
