From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 28/39] commit_lock_file(): use a strbuf to manage temporary space
Date: Fri, 26 Sep 2014 12:08:28 +0200
Message-ID: <1411726119-31598-29-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTJ-0004Bi-8q
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbaIZKJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:41 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53341 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756193AbaIZKJg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:36 -0400
X-AuditID: 1207440e-f79da6d0000002fc-55-54253b5f0e23
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.49.00764.F5B35245; Fri, 26 Sep 2014 06:09:36 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMD013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:34 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1E2wVg0x2NDGbNF1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd0bP7gtsBUs4K3bNX8ncwHiOvYuR
	k0NCwERi2qcOKFtM4sK99WxdjFwcQgKXGSUmTt/DCJIQEtjEJHH8XSiIzSagK7Gop5kJxBYR
	UJOY2HaIBaSBWWAxk8SEQ5vYQBLCAiESd48dYgWxWQRUJU5M+QLWwCvgKrHvVS8rxDY5iQ27
	/4Mt4ASKN26/BrXMRaJl/WSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbo
	paaUbmKEBCPfDsb29TKHGAU4GJV4eG+sUwkRYk0sK67MPcQoycGkJMr7xUI1RIgvKT+lMiOx
	OCO+qDQntfgQowQHs5II7x0joBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxW
	hoNDSYK3yAqoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7fUA
	aectLkjMBYpCtJ5i1OVY1/mtn0mIJS8/L1VKnPeIJVCRAEhRRmke3ApY6nnFKA70sTCvL8go
	HmDagpv0CmgJE9ASpSPKIEtKEhFSUg2MMt3ti5YpTUkperEm9fMG9atbf2ae8359nGmSzFJr
	ppCdoa66tubF7QYnpH+1HnTY1b7o7uJP95eeMIlvbtirM2WT3LfdodqrOOYd8vu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257516>

Avoid relying on the filename length restrictions that are currently
checked by lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 89043f5..1dd118f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -319,7 +319,8 @@ int reopen_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	static struct strbuf result_file = STRBUF_INIT;
+	int err;
 
 	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
@@ -327,11 +328,12 @@ int commit_lock_file(struct lock_file *lk)
 	if (close_lock_file(lk))
 		return -1;
 
-	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-
-	if (rename(lk->filename, result_file)) {
+	strbuf_add(&result_file, lk->filename,
+		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
+	err = rename(lk->filename, result_file.buf);
+	strbuf_reset(&result_file);
+	if (err) {
 		int save_errno = errno;
 		rollback_lock_file(lk);
 		errno = save_errno;
-- 
2.1.0
