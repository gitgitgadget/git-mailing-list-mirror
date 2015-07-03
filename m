From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Change strbuf_read_file() to return ssize_t
Date: Fri,  3 Jul 2015 15:59:32 +0200
Message-ID: <74f6ccbe74486b1d5589e953c4cf6d39c82c5c05.1435931485.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 15:59:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB1VT-0006rV-SU
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 15:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbbGCN7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 09:59:51 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55465 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755307AbbGCN7t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2015 09:59:49 -0400
X-AuditID: 12074414-f794f6d000007852-7f-5596954b16a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.7D.30802.B4596955; Fri,  3 Jul 2015 09:59:39 -0400 (EDT)
Received: from michael.fritz.box (p5DDB0229.dip0.t-ipconnect.de [93.219.2.41])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t63Dxba8022644
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jul 2015 09:59:38 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqOs9dVqowaFWDYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xuuFO9gL
	pvBWrNoh28B4gKuLkZNDQsBEYteef2wQtpjEhXvrgWwuDiGBy4wS15u2QTlHmST+HL3IBFLF
	JqArsainGcwWEVCTmNh2iAXEZhZIkeh43s0IYgsL2Eg0r9kI1MzBwSKgKrFxuglImFcgSmLl
	8VYmiGVyEueP/2SewMi9gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI
	MIjsYDxyUu4QowAHoxIP74XTU0OFWBPLiitzDzFKcjApifIKTpoWKsSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmE93kwUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYL3
	xmSgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQmMcXAwMdJMUDtPcCSDtvcUFi
	LlAUovUUo6KUOK/qFKCEAEgiozQPbiwsxl8xigN9KcwrClLFA0wPcN2vgAYzAQ0WMQUbXJKI
	kJJqYAxebXxF7n/PGfP5QZd/BdfOKkyL/XVwj8/dXedvTVkxNTZz8YGEQzOPKhpsUHmg8XbN
	h3md3K/t1hi8lHZ48PDJkYsPjCakpezNi3GImxVydH7Zw4VSr07MYMneZf712Oz7ZmuLNRdz
	cjyI/a6+ft+8+l1Trx8vbLfo3b6jT2+rxXVVRtEE+4cPlFiKMxINtZiLihMB46Iy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273291>

It is currently declared to return int, which could overflow for large
files.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch is against maint, but it also rebases against master
without conflict.

I couldn't find any way to exploit this bug. Most callers only use
this function for locally-generated files in the first place. And the
correct length of the file is available in strbuf::len, so most
callers only use the return value for a "< 0" check. And they don't do
anything risky on the error path.

 strbuf.c | 5 +++--
 strbuf.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 88cafd4..b4da9f5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -481,9 +481,10 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
 	return 0;
 }
 
-int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
+ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
-	int fd, len;
+	int fd;
+	ssize_t len;
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
diff --git a/strbuf.h b/strbuf.h
index 1883494..1ea9d0b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -364,7 +364,7 @@ extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
  */
-extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 
 /**
  * Read the target of a symbolic link, specified by its path.  The third
-- 
2.1.4
