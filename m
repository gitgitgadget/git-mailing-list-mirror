From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/24] expire_reflog(): return early if the reference has no reflog
Date: Fri, 12 Dec 2014 09:56:45 +0100
Message-ID: <1418374623-5566-7-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3R-0005QU-Si
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934701AbaLLI6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:20 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49444 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934676AbaLLI5V (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:21 -0500
X-AuditID: 12074411-f79fa6d000006b8a-48-548aadf05513
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 95.DC.27530.0FDAA845; Fri, 12 Dec 2014 03:57:20 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nG023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:19 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqPthbVeIQe9RPYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3RsuK9WwFt7gqOh91MDcw3uHoYuTkkBAwkej8MpUVwhaTuHBvPVsXIxeHkMBl
	RommSRdZIZxjTBLr2s+BVbEJ6Eos6mlmArFFBNQkJrYdYgGxmQVOMErMbggBsYUFwiQObfvB
	DmKzCKhKXFm0mxnE5hVwlpja9Z2xi5EDaJucxNZ13iBhTgEXiYstT8DGCAGVbF3RyTqBkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJDQEtzBOOOk3CFGAQ5GJR7e
	F6ldIUKsiWXFlbmHGCU5mJREeb9PBgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4f0bBZTjTUms
	rEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwxq0BahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHRUZ8MTA2QFI8QHuDQdp5iwsSc4GiEK2nGBWlxHlbQRICIImM
	0jy4sbCE8YpRHOhLYd4zIFU8wGQD1/0KaDAT0ODlWzpABpckIqSkGhgNJuaejzXbdPMOh92x
	bsGSqvxPF57k3PbsDdlnZ7Y+5dyZdwEbYpV+ZJ3rPP/mOQcDc/2nX88Pewvd7Xw/X814v/Hh
	2+sD9ZTVd0lLu51oX3F9+QXXOIZIm7jiVq5n3K5HW24avKmLOrrvm3+1yW+HfXuY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261341>

There is very little cleanup needed if the reference has no reflog. If
we move the initialization of log_file down a bit, there's even less.
So instead of jumping to the cleanup code at the end of the function,
just do the cleanup and return inline.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reflog.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ff51dbf..37b33c9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -368,9 +368,11 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
+	if (!reflog_exists(refname)) {
+		unlock_ref(lock);
+		return 0;
+	}
 	log_file = git_pathdup("logs/%s", refname);
-	if (!reflog_exists(refname))
-		goto finish;
 	if (!cmd->dry_run) {
 		newlog_path = git_pathdup("logs/%s.lock", refname);
 		cb.newlog = fopen(newlog_path, "w");
@@ -419,7 +421,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			clear_commit_marks(tip_commit, REACHABLE);
 		}
 	}
- finish:
+
 	if (cb.newlog) {
 		if (fclose(cb.newlog)) {
 			status |= error("%s: %s", strerror(errno),
-- 
2.1.3
