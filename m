From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/17] remove_dir_recurse(): handle disappearing files and directories
Date: Mon,  6 Jan 2014 14:45:31 +0100
Message-ID: <1389015935-21936-14-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVq-00065n-S6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbaAFNqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:35 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57067 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557AbaAFNqc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:32 -0500
X-AuditID: 12074413-b7fc76d000002aba-03-52cab3b7ec40
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.30.10938.7B3BAC25; Mon,  6 Jan 2014 08:46:31 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPE021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:30 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLt986kggwvP+Sy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgz7m2bxVKwm79iba9eA+Nr7i5GTg4JAROJH9cesULYYhIX7q1n62Lk4hASuMwo8Xli
	E5RzjEliZc8/FpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAosZJbqmfWMESQgLRErc2dbLDmKz
	CKhKvPv1FayZV8BVon3mZ6AaDqB1ChKrrwuBhDmBwtOmHWYDsYUEXCTWHHrEMoGRdwEjwypG
	ucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkJAS3sG466TcIUYBDkYlHl6PZyeD
	hFgTy4orcw8xSnIwKYnycq4+FSTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhJdrAVCONyWxsiq1
	KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBm7MJqFGwKDU9tSItM6cEIc3EwQki
	uEA28ABtiAMp5C0uSMwtzkyHKDrFqCglzisGkhAASWSU5sENgEX/K0ZxoH+EectBqniAiQOu
	+xXQYCagwaFxYINLEhFSUg2MjCe97mxguyKVyPTDX+9K3mYvKf0jL98yzzgZJLN50vGgpG1h
	wn595lOXf5DRZjrkENmwcEtBzJFYturNfLxfF/qx/zndeyFxYjln52q/dds9XV5EnOSdv4y9
	rvLeikUldY/+Stefnpyj/m5bGo/T+XQTj39KN/aYPPgmUzJxreHUmXcqmI5XKrEU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239999>

If a file or directory that we are trying to remove disappears (e.g.,
because another process has pruned it), do not consider it an error.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 dir.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 11e1520..716b613 100644
--- a/dir.c
+++ b/dir.c
@@ -1476,7 +1476,9 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
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
@@ -1496,13 +1498,21 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 
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
@@ -1512,7 +1522,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 
 	strbuf_setlen(path, original_len);
 	if (!ret && !keep_toplevel && !kept_down)
-		ret = rmdir(path->buf);
+		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
 	else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
-- 
1.8.5.2
