Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463226FA4
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="RGXkxeWR"
Received: from [195.4.92.119] (helo=sub0.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rM4rm-0092Oe-Im; Sat, 06 Jan 2024 12:29:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cPKHy85Smnynf5w8nZQ3goa3ivsCasylJj+scoyuqz4=; b=RGXkxeWRBoWBxFWO7Ploh939/W
	hp+OLAeZfTvrsXINVWteqWVgcJrEC9wzR7spjXANcbQx3cpYUv3iAnIquNh6Jwa+NjvR3jWmwD9gD
	Y1s4JVUO02vebMcb+HCK8gxEC0ggb/LeRZt8Y6d0OtYW7eFAzQna7VkdlHtB5peTu+4Q5jZCGpmhV
	ML1O/T1tDXRz4D72hv9WomsY1CRUQR8qhSfM/gCsWKgv7iN0EroDXE9bgHfbyiy3iKLIZpVyGjAG3
	TFXG9lq1wJl1husAFUmEQdP3u1yHrg0XAdl/3w4h8N5RTTA3W7el0yii4EGLaSF6D7RTaKqSslWLi
	DVyNGIXA==;
Received: from p200300e2e7033900dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e703:3900:dacb:8aff:fee0:ca63]:53218 helo=soren-pc.lan)
	by sub0.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rM4rm-007k57-8R; Sat, 06 Jan 2024 12:29:26 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v6 1/1] mingw: give more details about unsafe directory's ownership
Date: Sat,  6 Jan 2024 12:29:17 +0100
Message-Id: <20240106112917.1870-2-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106112917.1870-1-soekkle@freenet.de>
References: <xmqqbka07te6.fsf@gitster.g>
 <20240106112917.1870-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1704540566414DC4613F8EO
X-Originated-At: 2003:e2:e703:3900:dacb:8aff:fee0:ca63!53218
X-Scan-TS: Sat, 06 Jan 2024 12:29:26 +0100

Add domain/username in error message, if owner sid of repository and
user sid are not equal on windows systems.

Old error message:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/test/source/repos/git' is owned by:
	'S-1-5-21-571067702-4104414259-3379520149-500'
but the current user is:
	'S-1-5-21-571067702-4104414259-3379520149-1001'
To add an exception for this directory, call:

	git config --global --add safe.directory C:/Users/test/source/repos/git
'''

New error message:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/test/source/repos/git' is owned by:
        'DESKTOP-L78JVA6/Administrator' (S-1-5-21-571067702-4104414259-3379520149-500)
but the current user is:
        'DESKTOP-L78JVA6/test' (S-1-5-21-571067702-4104414259-3379520149-1001)
To add an exception for this directory, call:

        git config --global --add safe.directory C:/Users/test/source/repos/git
'''

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/mingw.c | 64 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 42053c1f65..6240387205 100644
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
+	if (translate_sid_to_user == FALSE)
+		FREE_AND_NULL(*str);
+	else
+		(*str)[len_domain] = '/';
+	return translate_sid_to_user;
+}
+
 static int acls_supported(const char *path)
 {
 	size_t offset = offset_1st_component(path);
@@ -2765,27 +2785,45 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 			strbuf_addf(report, "'%s' is on a file system that does "
 				    "not record ownership\n", path);
 		} else if (report) {
-			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
+			LPSTR str1, str2, str3, str4, to_free1 = NULL, to_free3 = NULL, to_local_free2=NULL, to_local_free4=NULL;
 
-			if (ConvertSidToStringSidA(sid, &str1))
+			if (user_sid_to_user_name(sid, &str1))
 				to_free1 = str1;
 			else
 				str1 = "(inconvertible)";
-
-			if (!current_user_sid)
-				str2 = "(none)";
-			else if (!IsValidSid(current_user_sid))
-				str2 = "(invalid)";
-			else if (ConvertSidToStringSidA(current_user_sid, &str2))
-				to_free2 = str2;
+			if (ConvertSidToStringSidA(sid, &str2))
+				to_local_free2 = str2;
 			else
 				str2 = "(inconvertible)";
+
+			if (!current_user_sid) {
+				str3 = "(none)";
+				str4 = "(none)";
+			}
+			else if (!IsValidSid(current_user_sid)) {
+				str3 = "(invalid)";
+				str4 = "(invalid)";
+			} else {
+				if (user_sid_to_user_name(current_user_sid,
+							  &str3))
+					to_free3 = str3;
+				else
+					str3 = "(inconvertible)";
+				if (ConvertSidToStringSidA(current_user_sid,
+							   &str4))
+					to_local_free4 = str4;
+				else
+					str4 = "(inconvertible)";
+			}
 			strbuf_addf(report,
 				    "'%s' is owned by:\n"
-				    "\t'%s'\nbut the current user is:\n"
-				    "\t'%s'\n", path, str1, str2);
-			LocalFree(to_free1);
-			LocalFree(to_free2);
+				    "\t'%s' (%s)\nbut the current user is:\n"
+				    "\t'%s' (%s)\n",
+				    path, str1, str2, str3, str4);
+			free(to_free1);
+			LocalFree(to_local_free2);
+			free(to_free3);
+			LocalFree(to_local_free4);
 		}
 	}
 
-- 
2.39.2

