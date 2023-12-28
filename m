Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC448473
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="MTEUAX2h"
Received: from [195.4.92.122] (helo=sub3.freenet.de)
	by mout2.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rIqRU-002qPa-SO
	for git@vger.kernel.org; Thu, 28 Dec 2023 14:28:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=guko7ZMyn09L/vOgu6A91++p+pSb84WxHd8WPunTOs4=; b=MTEUAX2hQYkbv5gzQZJpxx/HM1
	l7dv1xG+Z+coc+LaGZRN6RtFJg88Leybnd5aoDAR3RBShRWwx+Ngu89WSe/JBSa9gZQI2Wh0D4TZm
	rnXKOalpPT+PKYc1zPdUNO0hNE2fvWRuvyvXi2bPMDRCefd6MqUmq5NpGMDZf3WmO6A30oLF6T3Ex
	AmMLe0SyJCDphhYIXVxOX6cIX5JXXXEwaGxQcSepkcmhSUKC+lAQKVeG8i8O33WsCYhQaZj/p6g5N
	FEv7JsU0z9Fu14i0MY5wmuDn+HWGe7uBA7VPvc6UO2THiSUYPwGX+fxHONX8GZvzOML5CpPqhYqA7
	6iaViuxQ==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:33666 helo=soren-pc.lan)
	by sub3.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rIqRU-004Ja0-Ir; Thu, 28 Dec 2023 14:28:56 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: soekkle <soekkle@freenet.de>
Subject: [PATCH 1/1] Replace SID with domain/username
Date: Thu, 28 Dec 2023 14:28:44 +0100
Message-Id: <20231228132844.4240-2-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231228132844.4240-1-soekkle@freenet.de>
References: <20231228132844.4240-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1703770136077D1FFACACBO
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!33666
X-Scan-TS: Thu, 28 Dec 2023 14:28:56 +0100

From: soekkle <soekkle@freenet.de>

Replace SID with domain/username in erromessage, if owner of repository
and user are not equal on windows systems.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/mingw.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 42053c1f65..7318f0e20e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2684,6 +2684,25 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
+BOOL user_sid_to_string(PSID sid, LPSTR* str)
+{
+	SID_NAME_USE peUse;
+	DWORD lenName = { 0 }, lenDomain = { 0 };
+	LookupAccountSidA(NULL, sid, NULL, &lenName, NULL,
+					&lenDomain, &peUse); // returns only FALSE, because the string pointers are NULL
+	ALLOC_ARRAY((*str), (size_t)lenDomain + (size_t)lenName); // Alloc neded Space of the strings
+	BOOL retVal = LookupAccountSidA(NULL, sid, (*str) + lenDomain, &lenName,
+				       *str,
+					&lenDomain, &peUse);
+	*(*str + lenDomain) = '/';
+	if (retVal == FALSE)
+	{
+		free(*str);
+		*str = NULL;
+	}
+	return retVal;
+}
+
 static int acls_supported(const char *path)
 {
 	size_t offset = offset_1st_component(path);
@@ -2767,7 +2786,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 		} else if (report) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
 
-			if (ConvertSidToStringSidA(sid, &str1))
+			if (user_sid_to_string(sid, &str1))
 				to_free1 = str1;
 			else
 				str1 = "(inconvertible)";
@@ -2776,7 +2795,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 				str2 = "(none)";
 			else if (!IsValidSid(current_user_sid))
 				str2 = "(invalid)";
-			else if (ConvertSidToStringSidA(current_user_sid, &str2))
+			else if (user_sid_to_string(current_user_sid, &str2))
 				to_free2 = str2;
 			else
 				str2 = "(inconvertible)";
@@ -2784,8 +2803,8 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 				    "'%s' is owned by:\n"
 				    "\t'%s'\nbut the current user is:\n"
 				    "\t'%s'\n", path, str1, str2);
-			LocalFree(to_free1);
-			LocalFree(to_free2);
+			free(to_free1);
+			free(to_free2);
 		}
 	}
 
-- 
2.39.2

