From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/25] rollback_lock_file(): do not clear filename redundantly
Date: Mon, 14 Apr 2014 15:54:33 +0200
Message-ID: <1397483695-10888-4-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhOA-0003BE-FA
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbaDNN5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:57:30 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59713 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754981AbaDNNzK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:10 -0400
X-AuditID: 12074413-f79076d000002d17-78-534be8bec260
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E3.40.11543.EB8EB435; Mon, 14 Apr 2014 09:55:10 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt093010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:08 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLvvhXewwefXQhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGfcmruDrWABS8X8Zw+YGxg3MHcx
	cnJICJhI9K29CWWLSVy4t56ti5GLQ0jgMqPEo8knmCCck0wSqw7cZQepYhPQlVjU08wEYosI
	qElMbDvEAlLELNDOJHFoRy9YQlggUGJFwwSgsRwcLAKqEjfnxIOEeQVcJFqmn2eF2CYncfLY
	ZFaQEk4BV4mFH7JAwkJAJXe/TGGdwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5u
	ZoleakrpJkZIKArvYNx1Uu4QowAHoxIPb8cc72Ah1sSy4srcQ4ySHExKorwZN4BCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHhdtwLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotg
	sjIcHEoSvDXPgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQZERXwyMDZAUD9De
	JJB23uKCxFygKETrKUZFKXHeEpCEAEgiozQPbiwswbxiFAf6Upg3DaSKB5ic4LpfAQ1mAhrM
	0g42uCQRISXVwFjcl5HxhNNEoyd+ivaTYoaXJyYfdIr/qOtktveCrVb1NUFGwel3HzQv2P6/
	Tlr5GNOONbXO/hnbdWeXLk+f7NGzsqdX1qXsyN0/EU0TttwUPbTHwnbqp+imrxe/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246246>

It is only necessary to clear the lock_file's filename field if it was
not already clear.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index d4bfb3f..7701267 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -277,6 +277,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
 	}
-	lk->filename[0] = 0;
 }
-- 
1.9.1
