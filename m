From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/10] wincred: fix get credential if username has "@"
Date: Wed, 18 Feb 2015 11:01:54 -0800
Message-ID: <1424286123-12985-1-git-send-email-gitster@pobox.com>
Cc: Aleksey Vasenev <margtu-fivt@ya.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 20:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9t8-0003kX-9u
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbbBRTCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:02:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753371AbbBRTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAFC238283;
	Wed, 18 Feb 2015 14:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=gx2YpK/G7C741q+gsXK6nKKPDf8
	=; b=xQ8jUdiJhnbDMcSz96dwFrVSR8xVcmoeukquZH11+7mjs1jW1/nQoMycVDC
	1CH4v8GD/fKXn76ElGC80VME1BeYjlfqfECw6byT8ts8lw8wAutFqAhx4hAOskDw
	t8uOpeRGYsH3xHSJ6NwA3FPEivMPF5g2Y4uBZ4b7+1/x3yeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=PCXH3cTw6BzOKHj4t4wBw
	/1OvxM+R3VpFGKA2rLyYDvdTkFNHA+7l89ZFIBLdPu4+1iZax20dhmakzKSzX4aO
	R0j8e8bPf+0KkLuZqt5Uk2GosL5wgr+I1BF9vawwIe2Oysa56X6W6GB+KjTbFQxK
	OnSwa6eHvnWFi/cCxO/KgU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D11DE38282;
	Wed, 18 Feb 2015 14:02:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 317383827A;
	Wed, 18 Feb 2015 14:02:05 -0500 (EST)
X-Mailer: git-send-email 2.3.0-301-g71e72fe
X-Pobox-Relay-ID: A105B9F2-B7A0-11E4-A116-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264046>

From: Aleksey Vasenev <margtu-fivt@ya.ru>

Such a username with "@" in it isn't all that unusual these days.

cf. https://groups.google.com/forum/#!msg/msysgit/YVuCqmwwRyY/HULHj5OoE88J

Signed-off-by: Aleksey Vasenev <margtu-fivt@ya.ru>
Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.3.0-301-g71e72fe
