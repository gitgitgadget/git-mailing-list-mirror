From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/17] rename_tmp_log(): limit the number of remote_empty_directories() attempts
Date: Sat, 18 Jan 2014 23:49:00 +0100
Message-ID: <1390085341-2553-17-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiV-0005Nw-Ku
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbaARWuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:50:11 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64026 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751744AbaARWts (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:48 -0500
X-AuditID: 12074411-b7f426d000005455-0e-52db050bf31c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 41.EB.21589.B050BD25; Sat, 18 Jan 2014 17:49:47 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN99030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:47 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqMvNejvIYN4yc4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y0XqWuWAeV8W23+dYGhj7
	OboYOTkkBEwk9q38zgJhi0lcuLeerYuRi0NI4DKjxLcl8xkhnBNMEjsf/WEDqWIT0JVY1NPM
	BGKLCKhJTGw7BNbNLOAgsflzIyOILSyQLPH5wyageg4OFgFViTM/40DCvAIuEhuWdzGChCUE
	FCRWXxcCCXMChY/MvwA2UUjAWeLm6yfsExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3S
	NdXLzSzRS00p3cQICRTBHYwzTsodYhTgYFTi4T3AdDtIiDWxrLgy9xCjJAeTkiivMkiILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCG/whltBQrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2amp
	BalFMFkZDg4lCV5vFqChgkWp6akVaZk5JQhpJg5OEMEFsoEHZANIIW9xQWJucWY6RNEpRkUp
	cd5wkIQASCKjNA9uACymXzGKA/0jzCsFUsUDTAdw3a+ABjMBDRaJvQkyuCQRISXVwBjy4U6T
	XleiVMKsA3YyPmf38V3zeMTyMFJYZjOjyKv+vPn10z7Ucjy3EunZMX1LavnZW38PyOkF3GiM
	rEjqk+7STk1fkrX1cXT6xhMXytrSmk80HowNmvfWWS1qgXqMddUGJo7fwuZSmbxh0Xx8G4yv
	X7+66OOXq5vtGxZE2Gh8s802fNrvrMRSnJFoqMVcVJwIALEUzo/EAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240665>

This doesn't seem to be a likely error, but we've got the counter
anyway, so we might as well use it for an added bit of safety.

Please note that the first call to rename() is optimistic, and it is
normal for it to fail if there is a directory in the way.  So bump the
total number of allowed attempts to 4, to be sure that we can still
have at least 3 retries in the case of a race.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index a90904b..134d5aa 100644
--- a/refs.c
+++ b/refs.c
@@ -2530,7 +2530,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 static int rename_tmp_log(const char *newrefname)
 {
-	int attempts_remaining = 3;
+	int attempts_remaining = 4;
 
  retry:
 	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
@@ -2539,7 +2539,7 @@ static int rename_tmp_log(const char *newrefname)
 	}
 
 	if (rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
-		if (errno==EISDIR || errno==ENOTDIR) {
+		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
 			/*
 			 * rename(a, b) when b is an existing
 			 * directory ought to result in ISDIR, but
-- 
1.8.5.2
