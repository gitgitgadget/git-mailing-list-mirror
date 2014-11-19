From: Aleksey Vasenev <margtu-fivt@ya.ru>
Subject: [PATCH] wincred: fix get credential if username has @
Date: Thu, 20 Nov 2014 00:47:32 +0300
Message-ID: <1416433652-6840-1-git-send-email-margtu-fivt@ya.ru>
References: <1415832746-5116-1-git-send-email-margtu-fivt@ya.ru>
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksey Vasenev <margtu-fivt@ya.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 22:55:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrDDV-00068D-GG
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933643AbaKSVzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:55:09 -0500
Received: from forward10l.mail.yandex.net ([84.201.143.143]:60481 "EHLO
	forward10l.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932980AbaKSVzF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2014 16:55:05 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Nov 2014 16:55:04 EST
Received: from smtp18.mail.yandex.net (smtp18.mail.yandex.net [95.108.252.18])
	by forward10l.mail.yandex.net (Yandex) with ESMTP id DF2CEBA19E2;
	Thu, 20 Nov 2014 00:47:55 +0300 (MSK)
Received: from smtp18.mail.yandex.net (localhost [127.0.0.1])
	by smtp18.mail.yandex.net (Yandex) with ESMTP id 6299518A00B8;
	Thu, 20 Nov 2014 00:47:55 +0300 (MSK)
Received: from dynamic-2a02-2698-2424-0.yola.ertelecom.ru (dynamic-2a02-2698-2424-0.yola.ertelecom.ru [2a02:2698:2424:9:381c:e038:625c:e89b])
	by smtp18.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id V9r564g9tv-lseq7uBp;
	Thu, 20 Nov 2014 00:47:54 +0300
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: cac2251e-8312-4270-9e61-fb8404a6be8d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1416433674;
	bh=LQlDRl9dHVJpoG80cv52aZopT9V/IrxE/Ab2FsetfDM=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=eJja+TZfQLO6ECL5wyXEqaQ5WBQDO5CHV9FjZQYekWtE+WKRPgbRz/pHtd+i/+du6
	 IH9BVy4a/K272Lp3TLVi+D72IaYLsDHoAmmPz3B1CTGwSQNQi7A0FxHRwVr78V+Isg
	 k8Q4L4DsGqUjtpjHssdt1PJHJL6q8HvBo5yUtE0E=
Authentication-Results: smtp18.mail.yandex.net; dkim=pass header.i=@ya.ru
X-Mailer: git-send-email 1.9.4.msysgit.2
In-Reply-To: <1415832746-5116-1-git-send-email-margtu-fivt@ya.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Aleksey Vasenev <margtu-fivt@ya.ru>
---
 .../credential/wincred/git-credential-wincred.c    | 25 +++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index a1d38f0..0061340 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -111,14 +111,23 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
  * Match an (optional) expected string and a delimiter in the target string,
  * consuming the matched text by updating the target pointer.
  */
-static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
+
+static LPCWSTR wcsstr_last(LPCWSTR str, LPCWSTR find)
+{
+	LPCWSTR res = NULL, pos;
+	for (pos = wcsstr(str, find); pos; pos = wcsstr(pos + 1, find))
+		res = pos;
+	return res;
+}
+
+static int match_part_with_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim, int last)
 {
 	LPCWSTR delim_pos, start = *ptarget;
 	int len;
 
 	/* find start of delimiter (or end-of-string if delim is empty) */
 	if (*delim)
-		delim_pos = wcsstr(start, delim);
+		delim_pos = last ? wcsstr_last(start, delim) : wcsstr(start, delim);
 	else
 		delim_pos = start + wcslen(start);
 
@@ -138,6 +147,16 @@ static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
 	return !want || (!wcsncmp(want, start, len) && !want[len]);
 }
 
+static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
+{
+	return match_part_with_last(ptarget, want, delim, 0);
+}
+
+static int match_part_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
+{
+	return match_part_with_last(ptarget, want, delim, 1);
+}
+
 static int match_cred(const CREDENTIALW *cred)
 {
 	LPCWSTR target = cred->TargetName;
@@ -146,7 +165,7 @@ static int match_cred(const CREDENTIALW *cred)
 
 	return match_part(&target, L"git", L":") &&
 		match_part(&target, protocol, L"://") &&
-		match_part(&target, wusername, L"@") &&
+		match_part_last(&target, wusername, L"@") &&
 		match_part(&target, host, L"/") &&
 		match_part(&target, path, L"");
 }
-- 
1.9.4.msysgit.2
