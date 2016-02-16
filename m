From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/20] delete_ref_loose(): derive loose reference path from lock
Date: Tue, 16 Feb 2016 14:22:30 +0100
Message-ID: <e76003f80fd41fafd3b2df0a84cc199bf65bc555.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfb6-0005hs-1d
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbcBPNXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:23:16 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53794 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932117AbcBPNXP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:23:15 -0500
X-AuditID: 1207440f-db3ff70000007e44-ed-56c322c241a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6D.4C.32324.2C223C65; Tue, 16 Feb 2016 08:23:14 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOd028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:13 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHtI6XCYwdyvKhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8b2Hw8ZC16yVfRu38rWwHiYtYuRk0NCwETiZctR
	pi5GLg4hga2MEpvaO9khnBNMEqf7V7KBVLEJ6Eos6mlmArFFBNQkJrYdYgEpYhZ4xCjRtX87
	I0hCWCBA4sD25cwgNouAqsSuJUvAGngFoiSav19gglgnJ9HyYzfYak4BC4mTLb0sILaQgLnE
	nS97mCYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJk/DsYu9bL
	HGIU4GBU4uHl8DgUJsSaWFZcmXuIUZKDSUmUl4f7cJgQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed5/r4DKeVMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvB2KQEMFi1LT
	UyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQVEQXwyMA5AUD9DeNJB23uKCxFygKETrKUZd
	jgU/bq9lEmLJy89LlRLn3Q9SJABSlFGaB7cCllJeMYoDfSzMGwBSxQNMR3CTXgEtYQJaknMJ
	5LnikkSElFQD44qHF+eJ//33XNtmlt6+TqZmllbL6xaJTGn7fux3cVZTfu+9sSRx7RpNmZuh
	NUcrC28o5YQf7tB2KtASuOCnITHp6sOq/7e3T7+7VyApz57bPu6sg/Dmf7qlz3Yc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286357>

It is simpler to derive the path to the file that must be deleted from
"lock->ref_name" than from the lock_file object.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0a9f330..754d254 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2345,10 +2345,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = get_locked_file_path(lock->lk);
-		int res = unlink_or_msg(loose_filename, err);
-		free(loose_filename);
-		if (res)
+		if (unlink_or_msg(git_path("%s", lock->ref_name), err))
 			return 1;
 	}
 	return 0;
-- 
2.7.0
