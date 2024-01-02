Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73B15AEA
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="mjPz6t7p"
Received: from [195.4.92.125] (helo=sub6.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rKkEV-00AxCs-WD; Tue, 02 Jan 2024 20:15:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r2xQG8ou5dvLP62wejwr3IgwsLXsNBrD4dIUwQwof2s=; b=mjPz6t7poeRl69rEfCjbtWu88e
	I1IXLhWgM6Inf3NNkvhuSURvOZA7Tz+19jfErqNDYV2P+wvkFDDsTtg0owZV9zQVW8RRrxRGrfPn8
	5lw5TawvdnEJCMx9Fz03PDer7okhSrxzbIxHXwrNkjEHKG+pYigY0a0bbyIi9+TFUBbHTh/a5Xb9j
	20p7bD/lsgLcJcye1PBtonBVDQ2PVDwL5pL1eNI7XoIGuGUXiQfbcZT5Zd31lVRtAdMvMQKXsoROC
	AVHkDQaEOO/3EG8aK5IAXEZw5svHSfDD76KDfhomjPTNmZx6zn6g1M9xwx/O7QmScZreA3Dcu7lct
	xMTocDTQ==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:60616 helo=soren-pc.lan)
	by sub6.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rKkEV-00HPxr-Ml; Tue, 02 Jan 2024 20:15:23 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH V4 1/1] Replace SID with domain/username
Date: Tue,  2 Jan 2024 20:15:14 +0100
Message-Id: <20240102191514.2583-2-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102191514.2583-1-soekkle@freenet.de>
References: <xmqqsf3feilq.fsf@gitster.g>
 <20240102191514.2583-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1704222923E214E23FAA05O
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!60616
X-Scan-TS: Tue, 02 Jan 2024 20:15:23 +0100

Replace SID with domain/username in error message, if owner of repository
and user are not equal on windows systems. Each user should have a unique
SID (https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-identifiers#what-are-security-identifiers).
This means that domain/username is not a loss of information. If the translation
fails the message contains the SID as string.

Old Prompted error message:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/test/source/repos/git' is owned by:
	'S-1-5-21-571067702-4104414259-3379520149-500'
but the current user is:
	'S-1-5-21-571067702-4104414259-3379520149-1001'
To add an exception for this directory, call:

	git config --global --add safe.directory C:/Users/test/source/repos/git
'''

New prompted error massage:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/test/source/repos/git' is owned by:
	'DESKTOP-L78JVA6/Administrator'
but the current user is:
	'DESKTOP-L78JVA6/test'
To add an exception for this directory, call:

	git config --global --add safe.directory C:/Users/test/source/repos/git
'''

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/mingw.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 42053c1f65..bfd9573a29 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2684,6 +2684,27 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
+static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
+{
+	SID_NAME_USE pe_use;
+	DWORD len_user = 0, len_domain = 0;
+	BOOL translate_sid_to_user;
+
+	/* returns only FALSE, because the string pointers are NULL*/
+	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
+			  &pe_use); 
+	/*Alloc needed space of the strings*/
+	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user); 
+	translate_sid_to_user = LookupAccountSidA(NULL, sid, (*str) + len_domain, &len_user,
+				   *str, &len_domain, &pe_use);
+	if (translate_sid_to_user == FALSE) {
+		FREE_AND_NULL(*str);
+	}
+	else
+		(*str)[len_domain] = '/';
+	return translate_sid_to_user;
+}
+
 static int acls_supported(const char *path)
 {
 	size_t offset = offset_1st_component(path);
@@ -2767,7 +2788,9 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 		} else if (report) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
 
-			if (ConvertSidToStringSidA(sid, &str1))
+			if (user_sid_to_user_name(sid, &str1))
+				to_free1 = str1;
+			else if (ConvertSidToStringSidA(sid, &str1))
 				to_free1 = str1;
 			else
 				str1 = "(inconvertible)";
@@ -2776,7 +2799,10 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 				str2 = "(none)";
 			else if (!IsValidSid(current_user_sid))
 				str2 = "(invalid)";
-			else if (ConvertSidToStringSidA(current_user_sid, &str2))
+			else if (user_sid_to_user_name(current_user_sid, &str2))
+				to_free2 = str2;
+			else if (ConvertSidToStringSidA(current_user_sid,
+							&str2))
 				to_free2 = str2;
 			else
 				str2 = "(inconvertible)";
@@ -2784,8 +2810,8 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
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

