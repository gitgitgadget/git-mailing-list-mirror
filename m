From: Aleksey Vasenev <margtu-fivt@ya.ru>
Subject: [PATCH] wincred: fix get credential if username has @
Date: Thu, 13 Nov 2014 01:52:26 +0300
Message-ID: <1415832746-5116-1-git-send-email-margtu-fivt@ya.ru>
Cc: Aleksey Vasenev <margtu-fivt@ya.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 23:52:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XogmZ-0007ox-C2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 23:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbaKLWwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 17:52:55 -0500
Received: from forward18.mail.yandex.net ([95.108.253.143]:51818 "EHLO
	forward18.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbaKLWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 17:52:54 -0500
Received: from smtp17.mail.yandex.net (smtp17.mail.yandex.net [95.108.252.17])
	by forward18.mail.yandex.net (Yandex) with ESMTP id 4451B178110E
	for <git@vger.kernel.org>; Thu, 13 Nov 2014 01:52:48 +0300 (MSK)
Received: from smtp17.mail.yandex.net (localhost [127.0.0.1])
	by smtp17.mail.yandex.net (Yandex) with ESMTP id 0AD001900329;
	Thu, 13 Nov 2014 01:52:47 +0300 (MSK)
Received: from dynamic-2a02-2698-2424-0.yola.ertelecom.ru (dynamic-2a02-2698-2424-0.yola.ertelecom.ru [2a02:2698:2424:aaf9:381c:e038:625c:e89b])
	by smtp17.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id XQovGO6jeV-ql74Nb9E;
	Thu, 13 Nov 2014 01:52:47 +0300
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 0c4e7166-b0cd-4a4d-82b6-11749e02994e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1415832767;
	bh=CtUva2k1fBTuj2gyobxduhigIWdjFmGnefyin7MpXGI=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer;
	b=a6fL6SrCkpRV95pEHYBxJ0gr9+/JsgWap3YXLBoDvbKhw7RUnDwD6qXPk71AvF6J5
	 pDhjUAOx7BTNQZVVZg2A+zefQ0rNI/I/AzX3xnhcMeJ6FFYlMIkhWW9hOEBzfeMtn8
	 5g6EdBS96r1Elra7BbRM6UTyCJTuSvwFvT/RKI3M=
Authentication-Results: smtp17.mail.yandex.net; dkim=pass header.i=@ya.ru
X-Mailer: git-send-email 1.9.4.msysgit.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Aleksey Vasenev <margtu-fivt@ya.ru>
---
 .../credential/wincred/git-credential-wincred.c    | 25 +++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index a1d38f0..0229443 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -111,14 +111,23 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
  * Match an (optional) expected string and a delimiter in the target string,
  * consuming the matched text by updating the target pointer.
  */
-static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
+
+LPCWSTR wcsstr_last(LPCWSTR str, LPCWSTR find)
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
