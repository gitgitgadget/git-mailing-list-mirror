Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC478288
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240205; cv=none; b=tFtz8f6/D2YPMZKX45wNjA/eoL2yiZpjjQmrrGesRxikFk/ve+FtgnpXEsg9jKXHib3Zb7PZO2vE99FxVPlJeAkcJnxD0OnEpc+9Cw8RQbWYTS2dGO0Uenek7hk5z91GXeUk+6XuCM+GuiU8RubZmGZc4EZWFNuymuG7VyS7jds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240205; c=relaxed/simple;
	bh=yEF6r7vMjjKI16wNGo0KENo3skHK97MNGXlMeWa9LB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF3POR7ELtYt5G+Gk/aXrSO8Py49d642htYFpuDa22bog92thqOzxDcEboMU5OLTetf+nt0lsLFhLTkd79mMX1VrU/Ywxmo0I4rfEc45HR3Is7hHf/LrM5NIkz1OO4f1NO9JSiXiRmVdbuPldTItXTppKTMSngUb9wrrAasARiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=PjAuzKQf; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="PjAuzKQf"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42CAhIlf002855
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Mar 2024 11:43:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710240198; bh=yEF6r7vMjjKI16wNGo0KENo3skHK97MNGXlMeWa9LB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjAuzKQfKjwjwOtYS59zLvfO/IDru/5tzNj96Wy2oIQxJ8V3KPzpSPBMmeQwZJken
	 V+0TkiYN802cpOs0GL07fUJRjvUB7YitGn/0YV8sSyYh3FHxBWKAxmjCpJfF8H9Ha9
	 mHt7k+QuSurBfo3fi36ZNCZxQrKG4wbVVX/Bs/5k=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v2 1/1] Documentation/user-manual.txt: example for generating object hashes
Date: Tue, 12 Mar 2024 11:41:56 +0100
Message-ID: <20240312104238.4920-2-dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312104238.4920-1-dirk@gouders.net>
References: <cover.1709240261.git.dirk@gouders.net>
 <20240312104238.4920-1-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple example on how object hashes can be generated manually.

Further, because the document suggests to have a look at the initial
commit, clarify that some details changed since that time.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/user-manual.txt | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6433903491..90a4189358 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4093,7 +4093,38 @@ that not only specifies their type, but also provides size information
 about the data in the object.  It's worth noting that the SHA-1 hash
 that is used to name the object is the hash of the original data
 plus this header, so `sha1sum` 'file' does not match the object name
-for 'file'.
+for 'file' (the earliest versions of Git hashed slightly differently
+but the conclusion is still the same).
+
+The following is a short example that demonstrates how these hashes
+can be generated manually:
+
+Let's assume a small text file with some simple content:
+
+-------------------------------------------------
+$ echo "Hello world" >hello.txt
+-------------------------------------------------
+
+We can now manually generate the hash Git would use for this file:
+
+- The object we want the hash for is of type "blob" and its size is
+  12 bytes.
+
+- Prepend the object header to the file content and feed this to
+  `sha1sum`:
+
+-------------------------------------------------
+$ { printf "blob 12\0"; cat hello.txt; } | sha1sum
+802992c4220de19a90767f3000a79a31b98d0df7  -
+-------------------------------------------------
+
+This manually constructed hash can be verified using `git hash-object`
+which of course hides the addition of the header:
+
+-------------------------------------------------
+$ git hash-object hello.txt
+802992c4220de19a90767f3000a79a31b98d0df7
+-------------------------------------------------
 
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
@@ -4123,7 +4154,8 @@ $ git switch --detach e83c5163
 ----------------------------------------------------
 
 The initial revision lays the foundation for almost everything Git has
-today, but is small enough to read in one sitting.
+today (even though details may differ in a few places), but is small
+enough to read in one sitting.
 
 Note that terminology has changed since that revision.  For example, the
 README in that revision uses the word "changeset" to describe what we
-- 
2.43.0

