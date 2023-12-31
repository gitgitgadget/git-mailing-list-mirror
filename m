Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D01844
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="Wb/+0gwg"
Received: from [195.4.92.119] (helo=sub0.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rJrsM-000SEz-BG; Sun, 31 Dec 2023 10:12:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KZXnf9PFOA0+GBOR+B0WeePN+8+z1u7ax5X7wmp7GN4=; b=Wb/+0gwg6awZs/nfjYbCY3c2sY
	1PgEE+UC/dmFBTBDmL1iTRc2OHPdaEX+VivTJlequ/qZ3Ft6jDnXbiCePfULdENdD48lyGEd4JNzN
	jVc06N+DytyciWEpr1Fm1RxtrD+yz+MEAGofd5XMS4FA/w5xHN4lRQYVwjxGm6HySBiroVbBl4iQ7
	S1+UvyLuftyo46BUILIrSoXhHea7ws0lU5bCWDlZKQWdJM3AGAxQyYXa3sl1cqRKKtHRC2+wexpSv
	b5vw5pHfF1h6+Ya5QbNR9sPOGHAEkK1kUnUQaCEAGem/Ljdkjmb9gXKz4+TKa2fGhstms6UDTcr0k
	wlKw2qDg==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:50650 helo=soren-pc.lan)
	by sub0.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rJrsM-00BgXI-1r; Sun, 31 Dec 2023 10:12:54 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v3 1/1] Replace SID with domain/username
Date: Sun, 31 Dec 2023 10:12:45 +0100
Message-Id: <20231231091245.2853-2-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231231091245.2853-1-soekkle@freenet.de>
References: <CAPig+cT4jy4MkyGxtSOZj6U3vUxLaRa-4wr7PON-EebAjT8pwQ@mail.gmail.com>
 <20231231091245.2853-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 170401397461DCC7F1C0BFO
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!50650
X-Scan-TS: Sun, 31 Dec 2023 10:12:54 +0100

Replace SID with domain/username in error message, if owner of repository
and user are not equal on windows systems.

Old message:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/test/source/repos/git' is owned by:
	'S-1-5-21-571067702-4104414259-3379520149-500'
but the current user is:
	'S-1-5-21-571067702-4104414259-3379520149-1001'
To add an exception for this directory, call:

	git config --global --add safe.directory C:/Users/test/source/repos/git
'''

New massage:
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
 compat/mingw.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 42053c1f65..05aeaaa9ad 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2684,6 +2684,26 @@ static PSID get_current_user_sid(void)
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
+	*(*str + len_domain) = '/';
+	if (translate_sid_to_user == FALSE) {
+		FREE_AND_NULL(*str);
+	}
+	return translate_sid_to_user;
+}
+
 static int acls_supported(const char *path)
 {
 	size_t offset = offset_1st_component(path);
@@ -2767,7 +2787,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 		} else if (report) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
 
-			if (ConvertSidToStringSidA(sid, &str1))
+			if (user_sid_to_user_name(sid, &str1))
 				to_free1 = str1;
 			else
 				str1 = "(inconvertible)";
@@ -2776,7 +2796,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 				str2 = "(none)";
 			else if (!IsValidSid(current_user_sid))
 				str2 = "(invalid)";
-			else if (ConvertSidToStringSidA(current_user_sid, &str2))
+			else if (user_sid_to_user_name(current_user_sid, &str2))
 				to_free2 = str2;
 			else
 				str2 = "(inconvertible)";
@@ -2784,8 +2804,8 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
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

