From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/23] expire_reflog(): exit early if the reference has no reflog
Date: Fri,  5 Dec 2014 00:08:18 +0100
Message-ID: <1417734515-11812-7-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWu-0003KS-Gd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbaLDXIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:54 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42800 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933299AbaLDXIv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:51 -0500
X-AuditID: 12074413-f79f26d0000030e7-90-5480e9825b33
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.A0.12519.289E0845; Thu,  4 Dec 2014 18:08:50 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de3027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:49 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqNv0siHEYMMWXYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xrWHjxkLtnNV7Ni4lbWBcRdHFyMnh4SAicSNBecZIWwxiQv31rN1MXJxCAlc
	ZpTY0b+LFcI5xiTR2/2eGaSKTUBXYlFPMxOILSKgJjFz1WywDmaBE4wSvyZ3A43i4BAWCJSY
	0JcBUsMioCqx7PVhsA28Ai4SG2fMZQIpkRCQk9i6zhskzCngKjF1ZitYiRBQybNNC9knMPIu
	YGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESWsI7GHedlDvEKMDBqMTD
	W7C7PkSINbGsuDL3EKMkB5OSKO/Zpw0hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4jY8A5XhT
	EiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErylL4AaBYtS01Mr0jJzShDS
	TBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3jKQdt7igsRcoChE6ylGRSlx3nqQhABI
	IqM0D24sLGG8YhQH+lIYYjsPMNnAdb8CGswENPhsQy3I4JJEhJRUA6P1GZ3Pa20Onq5WvxpY
	1WsuyuhjvsWRv2ma24dXv0S75iRmLY49w+T83/zT0TNftO9G7zu4csbWx7MuXqxbIVP03e71
	FI2Ms+u1X8WyrJPvcJZg+5h2985klswpk7qdGXNdCrTf3b2vt/EQg88Uxjl7b996 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260828>

There is very little cleanup needed if the reference has no reflog. If
we move the initialization of log_file down a bit, there's even less.
So instead of jumping to the cleanup code at the end of the function,
just do the cleanup and return inline.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index df302f4..a282e60 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -368,9 +368,11 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
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
@@ -419,7 +421,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
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
