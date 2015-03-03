From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 7/7] reflog_expire(): never update a reference to null_sha1
Date: Tue,  3 Mar 2015 12:43:17 +0100
Message-ID: <1425382997-24984-8-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlF0-0003xn-RM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbbCCLnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:52 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42133 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756438AbbCCLns (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:48 -0500
X-AuditID: 1207440e-f79bc6d000000c43-bb-54f59e6ffd6b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 54.7E.03139.F6E95F45; Tue,  3 Mar 2015 06:43:43 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqK016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:41 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJs/72uIwf4tuhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bm99z4yF9zireje38fSwPiOq4uR
	k0NCwETiaed5dghbTOLCvfVsXYxcHEIClxkljm16zAThHGOSWH37MStIFZuArsSinmYmEFtE
	QE1iYtshFhCbWeAHk8ShFbUgtrCAn8SKn//A4iwCqhKn1/Yyg9i8Ai4S0zu/MkJsk5M4f/wn
	WJxTwFVi5dqtQPM5gJa5SNz6UDGBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzM
	Er3UlNJNjJBQ5NvB2L5e5hCjAAejEg/vBPavIUKsiWXFlbmHGCU5mJREeeVnA4X4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8DLPBcrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFk
	ZTg4lCR49UEaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3p9z
	QPYWFyTmAkUhWk8xKkqJ8z4FSQiAJDJK8+DGwhLMK0ZxoC+FeZ+DVPEAkxNc9yugwUxAg28p
	fgEZXJKIkJJqYJQKjeUyeHny3cMfzeYpxvvusffLy5ctf+BonrMmrGKR662Z22bdX8f/op7z
	CzvL5ql81bd7/Ziq0j6Iqqx7eiL84y8+5dIe3fKNlzr/2Er9adbwqP/q4S+zrliT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264657>

Currently, if --updateref is specified and the very last reflog entry
is expired or deleted, the reference's value is set to 0{40}. This is
an invalid state of the repository, and breaks, for example, "git
fsck" and "git for-each-ref".

The only place we use --updateref in our own code is when dropping
stash entries. In that code, the very next step is to check if the
reflog has been made empty, and if so, delete the "refs/stash"
reference entirely. Thus that code path ultimately leaves the
repository in a valid state.

But we don't want to the repository in an invalid state even
temporarily, and we don't want to leave an invalid state if other
callers of "git reflog expire|delete --updateref" don't think to do
the extra cleanup step.

So, if "git reflog expire|delete" leaves no more entries in the
reflog, just leave the reference unchanged.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 48bb9e8..d6244b6 100644
--- a/refs.c
+++ b/refs.c
@@ -4080,10 +4080,13 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		/*
 		 * It doesn't make sense to adjust a reference pointed
 		 * to by a symbolic ref based on expiring entries in
-		 * the symbolic reference's reflog.
+		 * the symbolic reference's reflog. Nor can we update
+		 * a reference if there are no remaining reflog
+		 * entries.
 		 */
 		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			!(type & REF_ISSYMREF);
+			!(type & REF_ISSYMREF) &&
+			!is_null_sha1(cb.last_kept_sha1);
 
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
-- 
2.1.4
