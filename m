From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 15/35] remove_lock_file(): call rollback_lock_file()
Date: Tue, 16 Sep 2014 21:33:36 +0200
Message-ID: <1410896036-12750-16-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydS-0003W1-8I
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbaIPTly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50607 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755101AbaIPTlw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:52 -0400
X-AuditID: 12074412-f792e6d000005517-19-541890ceaeea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 78.45.21783.EC098145; Tue, 16 Sep 2014 15:34:38 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcJ001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:36 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqHtugkSIweLvwhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdMbmvibXgGmvF/50H2RsYj7J0MXJwSAiYSHxbbN7F
	yAlkiklcuLeerYuRi0NI4DKjxNyOPmaQhJDACSaJoy0uIDabgK7Eop5mJpAiEYE2RoldFzez
	gjjMAt2MEu9PnGYCqRIWcJc41rOcFcRmEVCVmLl3CwuIzSvgKnFv2SF2iHVyEht2/2cEuYIT
	KP51XwGIKSTgInHwrt8ERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3
	MUKCTmgH4/qTcocYBTgYlXh4PR6JhwixJpYVV+YeYpTkYFIS5f3XLREixJeUn1KZkVicEV9U
	mpNafIhRgoNZSYT3hy9QjjclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJ
	gvdmP1CjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgu4ouBkQGS4gHa+xGknbe4
	IDEXKArReorRmKOl6W0vE8e6zm/9TEIsefl5qVLivDYgpQIgpRmleXCLYOnmFaM40N/CvO9A
	qniAqQpu3iugVUxAq872iIGsKklESEk1MM5Y2fH496Kzhv5Lduo7KTWI6BWemHpnl6Ga5kzF
	10s1gm+FrbI/tPtS+dkUwdkfV13WcfpzhXebz+rOSzq101i/H1w7yWzBejvxu1zL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257168>

It does just what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 911f123..1c85b18 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -68,12 +68,8 @@ static void remove_lock_file(void)
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
-		}
+		if (lock_file_list->owner == me)
+			rollback_lock_file(lock_file_list);
 		lock_file_list = lock_file_list->next;
 	}
 }
-- 
2.1.0
