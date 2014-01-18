From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/17] remove_dir_recurse(): handle disappearing files and directories
Date: Sat, 18 Jan 2014 23:48:57 +0100
Message-ID: <1390085341-2553-14-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiW-0005Nw-7n
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbaARWuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:50:13 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58708 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751783AbaARWtp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:45 -0500
X-AuditID: 1207440c-b7f566d000004272-9c-52db0508cb48
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 41.CE.17010.8050BD25; Sat, 18 Jan 2014 17:49:44 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN96030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:43 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqMvBejvIYOMWYYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Y+G0iW8EegYpHl56xNDBe
	4+li5OSQEDCR+DDxAzuELSZx4d56ti5GLg4hgcuMEnf3HmWGcE4wScxr+sMCUsUmoCuxqKeZ
	CcQWEVCTmNh2CCzOLOAgsflzIyOILSwQKfFm1j+wGhYBVYnrD9Yzg9i8Ai4SE66/BrI5gLYp
	SKy+LgQS5gQKH5l/AaxcSMBZ4ubrJ+wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI1
	1MvNLNFLTSndxAgJFZ4djN/WyRxiFOBgVOLhzWC4HSTEmlhWXJl7iFGSg0lJlFeZCSjEl5Sf
	UpmRWJwRX1Sak1p8iFGCg1lJhDd4w60gId6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTU
	gtQimKwMB4eSBK8AC9BQwaLU9NSKtMycEoQ0EwcniOAC2cADtEESpJC3uCAxtzgzHaLoFKOi
	lDivPEhCACSRUZoHNwAW1a8YxYH+Eea9zwxUxQNMCHDdr4AGMwENFom9CTK4JBEhJdXAqFz7
	RMbnyuZ3X/w5tjprB3ffmfZ9RuWektLX1xnvMe5pnRS4Y+60ZJYN7m+tvkbkTrL838u1JFWT
	u9La7v1yXvmn0yurjzLlJnmnBLG8/3BFezL//z0/tKrZT0TtC9O9Pdkpqkd/oiVP3ZOGVe+X
	PEu9tMqj6OzS/1fYHCe883u1XdvLYac3sxJLcUaioRZzUXEiACrKxXHFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240664>

If a file or directory that we are trying to remove disappears (e.g.,
because another process has pruned it), do not consider it an error.

However, if REMOVE_DIR_KEEP_TOPLEVEL is set, and the toplevel
directory is missing, then consider it an error (like before).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 dir.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 785a83e..b35b633 100644
--- a/dir.c
+++ b/dir.c
@@ -1511,7 +1511,9 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
 	dir = opendir(path->buf);
 	if (!dir) {
-		if (errno == EACCES && !keep_toplevel)
+		if (errno == ENOENT)
+			return keep_toplevel ? -1 : 0;
+		else if (errno == EACCES && !keep_toplevel)
 			/*
 			 * An empty dir could be removable even if it
 			 * is unreadable:
@@ -1531,13 +1533,21 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
-			; /* fall thru */
-		else if (S_ISDIR(st.st_mode)) {
+		if (lstat(path->buf, &st)) {
+			if (errno == ENOENT)
+				/*
+				 * file disappeared, which is what we
+				 * wanted anyway
+				 */
+				continue;
+			/* fall thru */
+		} else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recurse(path, flag, &kept_down))
 				continue; /* happy */
-		} else if (!only_empty && !unlink(path->buf))
+		} else if (!only_empty &&
+			   (!unlink(path->buf) || errno == ENOENT)) {
 			continue; /* happy, too */
+		}
 
 		/* path too long, stat fails, or non-directory still exists */
 		ret = -1;
@@ -1547,7 +1557,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 
 	strbuf_setlen(path, original_len);
 	if (!ret && !keep_toplevel && !kept_down)
-		ret = rmdir(path->buf);
+		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
 	else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
-- 
1.8.5.2
