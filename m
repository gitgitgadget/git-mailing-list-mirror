Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19ED1D6DB9
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992058; cv=none; b=P26e1ffAP/BUdXS2YWR+aDEjlplrs8lwpkhhoBd7LdUIcJafIBepTQy+LKpWhiYo9TQeske/8hdcp+seY/AAxqggGVKkMf9x2X3/ivUkyL4PFay8gnuRGnB8oJmyX7vL5kY1TcqimOGfGMJng7Rvm7xvAxE9hXttFd5soJfpHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992058; c=relaxed/simple;
	bh=lL7kfDRL9mh0ECSgrNzusJQRXcffvr2F2oj4Oreu2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxQtXa3AdnhhjeJyz3qvwn+7jHgV8lTUUNQCel4Ywa62qLvn2Nj5XPTFkuB4HhQGtxIZhux+4YnzeWHTOoOkdR2p2yHF53C1/lzw+LHWqDd6uE0MJFui1/p/WeXhYPv0X9rtJLy1YjjfWv60WBIH7Zjl8glEEGDcN35MQrzQMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1uMajF-001FHf-0t;
	Tue, 03 Jun 2025 23:07:33 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1uMaj8-009kGH-2f;
	Wed, 04 Jun 2025 08:07:26 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/4] Fix maybe-uninitialized warning with GCC at -O3
Date: Wed,  4 Jun 2025 08:06:43 +0900
Message-ID: <20250603230646.2322671-1-mh@glandium.org>
X-Mailer: git-send-email 2.50.0.rc1.593.g042f21cb9b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

```
In file included from parse-options.c:1:
git-compat-util.h: In function ‘get_value’:
git-compat-util.h:489:21: error: ‘arg’ may be used uninitialized [-Werror=maybe-uninitialized]
  489 | #define error(...) (error(__VA_ARGS__), const_error())
      |                     ^~~~~
parse-options.c:76:21: note: ‘arg’ was declared here
   76 |         const char *arg;
      |                     ^~~
```

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef..cf79805bc0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -73,7 +73,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  enum opt_parsed flags,
 					  const char **argp)
 {
-	const char *arg;
+	const char *arg = NULL;
 	const int unset = flags & OPT_UNSET;
 	int err;
 
-- 
2.50.0.rc1.593.g042f21cb9b

