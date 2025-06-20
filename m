Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CE1862BB
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401529; cv=none; b=Z3VoluOnS+xaj43ugQ/ifZTHXyCAJAEGFJy+MYmqLou9NdFtjW1SimrmbzLAA01ihjrfHEsOPdohZh5FcWY/7VbQ4OPHk1IqA269/dkAbo8VDa5rb3aL+YIPSwAu95qAcHGk++t1GU5k0WaKBPKbpDwrppXYnaaOQfbueHhhHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401529; c=relaxed/simple;
	bh=HBbsRWK3ynVLIVBlYO2ebtgwdXjghhGZBqi3+0ofsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3oFyz+fUgwQkvA7fGx/5+UEIYLkqr8C3bFZh3ez+hSW09Gwo0pzqWEMxHTXo7DP2UwX4G+QesZo8OAKabCNw9xAt/WjsJ93ChbaaVbZtaiT73cDgP9YyKBuo4jXDaCQjmgBKqzfQ3lGv16/fWAQb7JxCNPirFpM9n2eyk89rto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=nXK6aBIQ; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="nXK6aBIQ"
Received: from localhost (unknown [IPv6:2001:a61:2a2d:e101:8495:ad93:205d:87b2])
	by mail.thalheim.io (Postfix) with ESMTPSA id 296BC252F84;
	Fri, 20 Jun 2025 06:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750401525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSCq0act4Vh55nduKlcaElfZv5kwYCLPy2zlY3FX0EY=;
	b=nXK6aBIQBWuCYTdiiBP3mFnzmhV7W3Hh+FkayDZeR3hw8rtPSIyRS7LRC1LLNR29MozPBx
	h7h/DImVq8hpKQ3vfplBG6aRB4HIzPuJtPgQfnoSKte0G8vGx7jyqZpbpC0U7cOy4jDBqP
	JYhvVKrkQvX9v2aVBv2paCTkp31kz2Y=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v2 1/2] imap-send: fix confusing 'store' terminology in error message
Date: Fri, 20 Jun 2025 08:38:35 +0200
Message-ID: <20250620063836.252881-2-joerg@thalheim.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620063836.252881-1-joerg@thalheim.io>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
 <20250620063836.252881-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

The error message 'no imap store specified' is misleading because
it refers to 'store' when the actual missing configuration is
'imap.folder'. Update the message to use the correct terminology
that matches the configuration variable name.

This reduces confusion for users who might otherwise look for
non-existent 'imap.store' configuration when they see this error.

Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index ed4c34dadd..33690cd66a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1831,7 +1831,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!server.folder) {
-		fprintf(stderr, "no IMAP store specified\n");
+		fprintf(stderr, "no IMAP folder specified\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0

