From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 1/2] sha1_name: try to use same abbrev length when core.abbrevguard is specified
Date: Tue,  8 Mar 2011 19:59:10 +0900
Message-ID: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 11:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwudT-0003HE-5B
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 11:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670Ab1CHK7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 05:59:21 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56701 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab1CHK7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 05:59:20 -0500
Received: by yia27 with SMTP id 27so1948163yia.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=4mnAAq88dAq7F7Wfe5w1RT4Tf4AKlaXi8F/qDF3Wm/k=;
        b=U4eXSimd/Y+5v1NCPa6Hnh1OtqOjUU8lz4puaxNYRBF62/jQG5UtvHVLcb/15PbM1K
         gCW99bdDqtV3qtd4xnx8i2wnxRDtQgEYzE+P6YYt9GBRS3ZPfF+MljO6vRDbkMoJCJ1+
         MFgDUIcbm/W/PXVPuVh07OXFoXszfFt4aJheU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Kq/YHV4sZOiYsPVmEVyFe/TN+YNpkq/J/3i9Rxgj8e82e2dYZCpObWVxqKLoHpSHif
         dvO2/CIIEx7CiC47EF7UNjpTk66yXZwLk55swKnIA25gu7B8uCSthgbVXFZFPylpg+/F
         EC1R+pbLRCo8egQwWwoDS5wqNfD1x53K9ih+A=
Received: by 10.150.178.2 with SMTP id a2mr4476558ybf.372.1299581959794;
        Tue, 08 Mar 2011 02:59:19 -0800 (PST)
Received: from localhost.localdomain ([118.176.73.109])
        by mx.google.com with ESMTPS id l2sm589368ybn.15.2011.03.08.02.59.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 02:59:19 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168655>

If find_unique_abbrev() finds a ambiguous SHA1 name, it tries
to find again with increased length. In this case, result hex
strings could have different lengths even though the
core.abbrevguard config option is specified. But if the option
is specified and increased length (delta) is less than its
value, the result could be adjusted to the same length.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 sha1_name.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 709ff2e..6bb8942 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -197,6 +197,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
 	int status, exists;
 	static char hex[41];
+	int extra_len = unique_abbrev_extra_length;
 
 	exists = has_sha1_file(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
@@ -208,12 +209,14 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
-			int cut_at = len + unique_abbrev_extra_length;
+			int cut_at = len + extra_len;
 			cut_at = (cut_at < 40) ? cut_at : 40;
 			hex[cut_at] = 0;
 			return hex;
 		}
 		len++;
+		if (extra_len > 0)
+			extra_len--;
 	}
 	return hex;
 }
-- 
1.7.4
