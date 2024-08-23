Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A9194AD5
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453263; cv=none; b=DJt+/DYYqOHnhrFyTzYINbzwh4tbU7ZbmcgCKe+UDb74xFTlL31BRyeQTVg2NrTEZ5XgT7AZk+2AdhMpxIVfkW8NNwLylf0bY25me0gJ9Y707cuSZRs64NPX1v7MgSlxthsrBG38msOj4r5thsAgLlj0TqsEW968PEY9Wese8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453263; c=relaxed/simple;
	bh=SNOgkbi/GL4g3IV00zCRF6AWzeuhauu4CMmP6IucLO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaZuoP6MsKMznp9xs7ezBEYHdT2NjEE3UsOCLEf+nukT9nLg5b29kruCuc+lvAKYTej/74K84Ia1l3G/0iBwqRO0B/OpSJDczFtkbaBSZzP0ye9tsrL4ZN/Ed5ScZVF5kVChwNpKosF+HPPDSH8Mf8P3bt8oDy9kVddp8mm8iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=Jx3uJ96H; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="Jx3uJ96H"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3441F569;
	Fri, 23 Aug 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453192;
	bh=SNOgkbi/GL4g3IV00zCRF6AWzeuhauu4CMmP6IucLO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jx3uJ96HmD3IcoD747yYBC1G74/ofbB4dtziY02JMAqq5vaPFYVFbwIrlMZuKyEM6
	 ElycSvQSjVdUZIoGGUsIj8c90bdeO3wvhv8jbqMioeolj8V7TCjnzEKAqyMurn5QQL
	 HRQEiJ7hxkk0b1hskg7oYqUv4KQGk7nGs4NOLWUQ=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 09/10] cat-file: batch_write: use size_t for length
Date: Fri, 23 Aug 2024 22:46:29 +0000
Message-ID: <20240823224630.1180772-10-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwrite(3) and write(2), and all of our wrappers for them use
size_t while object size is `unsigned long', so there's no
excuse to use a potentially smaller representation.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 067cdbdbf9..bf81054662 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -369,7 +369,7 @@ static void expand_format(struct strbuf *sb, const char *start,
 	}
 }
 
-static void batch_write(struct batch_options *opt, const void *data, int len)
+static void batch_write(struct batch_options *opt, const void *data, size_t len)
 {
 	if (opt->buffer_output) {
 		if (fwrite(data, 1, len, stdout) != len)
