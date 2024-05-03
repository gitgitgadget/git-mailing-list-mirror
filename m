Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19114D71C
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727704; cv=none; b=nMazud3Ew3eBBhlYDkcSjNtbP4UdpJ8TGY0fraqZNQNCmQfl23zb9jTCO9ovYRURuoBYzsSvOUNANGWSDD+gChdgy6Gkqc/lhtkiIKz1pQqqmraGm/tTB0X5GE0W6x9c5kKLfeW31NVSrP9U5+JbPliIoz+BnPuVJ+ySam7L5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727704; c=relaxed/simple;
	bh=pUc9LccvVjNLHQTCIlc2f/gM+zPQ5ScFoUlEmpkR6y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/FUF6xNqOxOym/WdavvNYQqqTK9V1z3368XjwkLe11vJS0C2MoG+w8mgtvEJ5/9P8piD/WUXJbBci7FAT8ERnJFGL0j24wClZlCpX81JNWg476EKadBblu1eyG3ddrO6SHJFsFDglwXvQL2/2FtyJyPK8VS+yMsaONZ6gUPiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1s2p0J-007gP2-0D;
	Fri, 03 May 2024 09:14:55 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1s2p0C-00Bmar-0j;
	Fri, 03 May 2024 18:14:48 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH] Win32: Fix building with NO_UNIX_SOCKETS
Date: Fri,  3 May 2024 18:14:27 +0900
Message-ID: <20240503091427.2808390-1-mh@glandium.org>
X-Mailer: git-send-email 2.45.0.1.ge6f3e402ce
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 2406bf5fc5 it fails with:

compat/mingw.c:4160:5: error: no previous prototype for function 'mingw_have_unix_sockets' [-Werror,-Wmissing-prototypes]
   4160 | int mingw_have_unix_sockets(void)
        |     ^

because the prototype is behind `ifndef NO_UNIX_SOCKETS`

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 compat/mingw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4876344b5b..6b06ea540f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3159,6 +3159,7 @@ int uname(struct utsname *buf)
 	return 0;
 }
 
+#ifndef NO_UNIX_SOCKETS
 int mingw_have_unix_sockets(void)
 {
 	SC_HANDLE scm, srvc;
@@ -3177,3 +3178,4 @@ int mingw_have_unix_sockets(void)
 	}
 	return ret;
 }
+#endif
-- 
2.45.0.1.ge6f3e402ce

