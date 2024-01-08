Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1754BC7
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="R2OgvCF2"
Received: from [195.4.92.124] (helo=sub5.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rMtaI-005jbv-Ks; Mon, 08 Jan 2024 18:38:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yl8M8c2zjQYxFEQm5JX2GkKKzs6fBKKN0MNbytDaF3E=; b=R2OgvCF2LU0ZvI4fghK+g3KPYA
	sHHZ0Uy/XBsCxoNyoYJpo8JOBPcfpY7HTazXzD+MS/6AInuWbbaZLmKsXejpcmDLQY5yE8L+6xbUt
	9vMQ64ZPVDK9oEimzwk4KReOzWLz+NKQ3zLu9N0EvMTX8qkaticsSkPoeamVTWG403Dk8O5Z2qn4p
	L1OAXgxyODEOnuk6pwxc7CEV0m6AJ3dy1BZXC9nx6bqYW3/DM6E9K0Q8D7VYZiTrzhxFXsvHRbD75
	+vjwnbWjPDpM17+3QtwIDyavPUlM4XBq9YJMS/xYJ6MVIBu81SLDgSDoOkScUnYeyB5hyqEQE8sZG
	i6SK9Q8w==;
Received: from p200300e2e7033900dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e703:3900:dacb:8aff:fee0:ca63]:60190 helo=soren-pc.lan)
	by sub5.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rMtaI-004xah-BB; Mon, 08 Jan 2024 18:38:46 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	j6t@kdbg.org,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v7 1/1] mingw: give more details about unsafe directory's ownership
Date: Mon,  8 Jan 2024 18:38:37 +0100
Message-Id: <20240108173837.20480-2-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108173837.20480-1-soekkle@freenet.de>
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
 <20240108173837.20480-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 170473552627D3152878BDO
X-Originated-At: 2003:e2:e703:3900:dacb:8aff:fee0:ca63!60190
X-Scan-TS: Mon, 08 Jan 2024 18:38:46 +0100

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
        DESKTOP-L78JVA6/Administrator (S-1-5-21-571067702-4104414259-3379520149-500)
but the current user is:
        DESKTOP-L78JVA6/test (S-1-5-21-571067702-4104414259-3379520149-1001)
To add an exception for this directory, call:

        git config --global --add safe.directory C:/Users/test/source/repos/git
'''

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/mingw.c | 70 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 42053c1f65..d85fae3747 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2684,6 +2684,30 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
+static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
+{
+	SID_NAME_USE pe_use;
+	DWORD len_user = 0, len_domain = 0;
+	BOOL translate_sid_to_user;
+
+	/*
+	 * returns only FALSE, because the string pointers are NULL
+	 */
+	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
+			  &pe_use); 
+	/*
+	 * Alloc needed space of the strings
+	 */
+	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user); 
+	translate_sid_to_user = LookupAccountSidA(NULL, sid,
+	    (*str) + len_domain, &len_user, *str, &len_domain, &pe_use);
+	if (!translate_sid_to_user)
+		FREE_AND_NULL(*str);
+	else
+		(*str)[len_domain] = '/';
+	return translate_sid_to_user;
+}
+
 static int acls_supported(const char *path)
 {
 	size_t offset = offset_1st_component(path);
@@ -2765,27 +2789,47 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 			strbuf_addf(report, "'%s' is on a file system that does "
 				    "not record ownership\n", path);
 		} else if (report) {
-			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
+			LPSTR str1, str2, str3, str4, to_free1 = NULL, 
+			    to_free3 = NULL, to_local_free2 = NULL,
+			    to_local_free4 = NULL;
 
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
+				    "\t%s (%s)\nbut the current user is:\n"
+				    "\t%s (%s)\n",
+				    path, str1, str2, str3, str4);
+			free(to_free1);
+			LocalFree(to_local_free2);
+			free(to_free3);
+			LocalFree(to_local_free4);
 		}
 	}
 
-- 
2.39.2

