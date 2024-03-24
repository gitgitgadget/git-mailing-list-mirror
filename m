Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA0ECF
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242795; cv=none; b=rfBG2KS47Ib1EI6qHeJ+o6Znuf+nY7YqM2X0wnn3v0z/dRvCajitSQmII4k6ZNE8Eeza6JDZ2dyep7uh17Dm07TOw7rGGGzDXGbqPwEqivxRyzYnKX97nWslVSXaHZMK0SflqqVbVliVqnT8FEJT5lgPnESwa5aaR2WmRTvCs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242795; c=relaxed/simple;
	bh=nkKd0E37Am2K8HItmwId5mlnNWgfJnJARVeNMIObChc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIUxD4AZED3QxWIBiNzP3yU7aqxz1H3uGolEFAIkh90pOGUAk3jbMjRySlAUfOXXU6S0BvnZhOicYs8Rk+IpBjWu4qEeO+21Xhc1sWanAI665bEI0I+MCD9hCPpqDVo+SJTLX3h9WcPkuce7gXqLBiEJmfSxjmAk1zIAhiLi/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=itSIMOal; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="itSIMOal"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 759875D47E;
	Sun, 24 Mar 2024 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=nkKd0E37Am2K8HItmwId5mlnNWgfJnJARVeNMIObChc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=itSIMOal76RtURegA7pY9cLNiVIa8DSlqG0LadWRi1df4TbddV5vCshPJiggS+nt0
	 PXOqBRCIrgo3Y3Jb00DToMltS6uHKkyNXV3zE6aC007veHU9YsfsHb4H1EHCCIccjF
	 A4aiWgXPAHn4lyCeK+HB3BDfA9VlvCnmL/kG3VPXNwX8iedBsGtl2gGthR/2kR+1Y5
	 Py+3FMpMNBYI+1PA/rj22Q27j8C+AMDv10GbCn+lT5T/mBh1qmeLDz5wyKms+/tss3
	 nMIE33sBMrNNAflIJf3EwmN5Iaal7ap6tWvm0XWHQRA06KFLro6rWoKdosihUiOLko
	 tZP0Rjht5twAyDsnXNozGv7HVSSXX/HGvj58EB3zOJzCbTpAitsMqrRkLXd9JyfoAv
	 Z1N72Wj0Z7dOa1ZsCD5Ir3mzsSLdQNLXaNh6OyRqfLqDuTWf1ZGmUT5erCIjE/jfhd
	 E6gAxCQ0ADAo5Q0sbfE0lMIoHBMYvZC0ThRZygnSBBYipOtTgaL
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 12/13] strvec: implement swapping two strvecs
Date: Sun, 24 Mar 2024 01:13:00 +0000
Message-ID: <20240324011301.1553072-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we'll want the ability to efficiently swap the
contents of two strvec instances without needing to copy any data.
Since a strvec is simply a pointer and two sizes, swapping them is as
simply as copying the two pointers and sizes, so let's do that.

We use a temporary here simply because C doesn't provide a standard
swapping function, unlike C++ and Rust, but a good optimizing compiler
will recognize this syntax and handle it appropriately using an
optimization pass.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 strvec.c | 7 +++++++
 strvec.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/strvec.c b/strvec.c
index 178f4f3748..93006f1e63 100644
--- a/strvec.c
+++ b/strvec.c
@@ -106,3 +106,10 @@ const char **strvec_detach(struct strvec *array)
 		return ret;
 	}
 }
+
+void strvec_swap(struct strvec *a, struct strvec *b)
+{
+	struct strvec t = *a;
+	*a = *b;
+	*b = t;
+}
diff --git a/strvec.h b/strvec.h
index 4715d3e51f..5b762532bb 100644
--- a/strvec.h
+++ b/strvec.h
@@ -88,4 +88,9 @@ void strvec_clear(struct strvec *);
  */
 const char **strvec_detach(struct strvec *);
 
+/**
+ * Swap the contents of two `strvec` structs without allocating.
+ */
+void strvec_swap(struct strvec *, struct strvec *);
+
 #endif /* STRVEC_H */
