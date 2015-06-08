From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/14] register_tempfile_object(): new function, extracted from create_tempfile()
Date: Mon,  8 Jun 2015 11:07:36 +0200
Message-ID: <608b8507531b9184f0cf01de084390633e4506d5.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2T-0002UY-DY
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbbFHJIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57504 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752698AbbFHJH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:07:59 -0400
X-AuditID: 12074413-f79386d000000d23-77-55755b6e42f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 50.0F.03363.E6B55755; Mon,  8 Jun 2015 05:07:58 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojT010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:57 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqJsXXRpq8L5L36LrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd0du7iang
	Mk/F1AVrWBsYd3B1MXJySAiYSDybcpcVwhaTuHBvPVsXIxeHkMBlRontc+8yQTgnmCSmTjnM
	DFLFJqArsainmQnEFhFwlDjx4DpYN7OAg8Tmz42MILawQKLE5mtPwGpYBFQldne8BqvhFYiS
	6F3+kA1im5zE+eM/wWZyClhI/Pq6C6ieA2iZucSPuawTGHkXMDKsYpRLzCnN1c1NzMwpTk3W
	LU5OzMtLLdI118vNLNFLTSndxAgJH+EdjLtOyh1iFOBgVOLhPbCoJFSINbGsuDL3EKMkB5OS
	KO/HiNJQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8TBZAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/
	IYH0xJLU7NTUgtQimKwMB4eSBK95FFCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlG
	PCgy4ouBsQGS4gHayw3SzltckJgLFIVoPcWoKCXOawSSEABJZJTmwY2FJYVXjOJAXwrzloNU
	8QATClz3K6DBTECDv38tBhlckoiQkmpgLDvxbHvereAf1nvad67dWuqxQldCxU1mxaaJRve5
	uXeynNB8kq98PEZbe41q7n0+AddrwV/vPj36+ufv05Uz1ogdOlK3W+em6PsFPe3Pzs86s7gv
	SZZjMevdy1MLkqv04sRWvtry1PYCzzI+u5+HjZ+3neWwNZv46/W2F7delDuZpYvJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270999>

This makes the next step easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 tempfile.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index bde7fd3..f76bc07 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -31,11 +31,8 @@ static void remove_tempfiles_on_signal(int signo)
 	raise(signo);
 }
 
-/* Make sure errno contains a meaningful value on error */
-int create_tempfile(struct tempfile *tempfile, const char *path)
+static void register_tempfile_object(struct tempfile *tempfile, const char *path)
 {
-	size_t pathlen = strlen(path);
-
 	if (!tempfile_list) {
 		/* One-time initialization */
 		sigchain_push_common(remove_tempfiles_on_signal);
@@ -51,7 +48,7 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 		tempfile->fp = NULL;
 		tempfile->active = 0;
 		tempfile->owner = 0;
-		strbuf_init(&tempfile->filename, pathlen);
+		strbuf_init(&tempfile->filename, strlen(path));
 		tempfile->next = tempfile_list;
 		tempfile_list = tempfile;
 		tempfile->on_list = 1;
@@ -60,6 +57,12 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 		die("BUG: tempfile(\"%s\") called with improperly-reset tempfile object",
 		    path);
 	}
+}
+
+/* Make sure errno contains a meaningful value on error */
+int create_tempfile(struct tempfile *tempfile, const char *path)
+{
+	register_tempfile_object(tempfile, path);
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
-- 
2.1.4
