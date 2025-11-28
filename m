Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6779CD
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347856; cv=none; b=lNIFimhslc7odlOpv7kWa07FsCPwwJBroNu/1FZtBt9hisIyyzRH3VA/XpSVVlm4z4uzQaPoFgyi8h6o2Vev5dZp91S7ExjKxw09ZFlBICIVVxbYhcRP8tAaLBPoJLqAje/o2oaZVVUhzWXfGb/LaDF9YGdHmiFWlMZPuaXMEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347856; c=relaxed/simple;
	bh=i5fXMovpJ/axuE8BSK7xlgM6cT5GrxYqUYL+Kt7sySI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IQtNYCmcD/PY5KDbU/yNpIAdPUKgQ16Dp4lSLh0t+xqxi+5SrCUJnfsJVhy7wFnJAqJvYDDHdD/UY2nN4j5wpjDBa4dgw9ifGC06h94xFuVLhWNI9If//7kc2xtUCfIz6ffypptmTOcPbXbKzTAXEGMDso5CGtA4k3t70OUJw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aTZO1FkM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aTZO1FkM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764347848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsbUMTXVzxZ5ko8M9T5jRZz/yZjhFTkfMb3C9YHVmvQ=;
	b=aTZO1FkMnKkXYo5rN9UxtMY7ibYSf5BL/4bAq8kHdWiu9wxnKPNZoI60uEVjMjFgHeRLhE
	42DJKu+wmmOKwEHgJc5Y0Hy+eCc6ZgJdynQ1Gjvaeu5C92i0m9tKJH5e2HAnjByl7Y8jIU
	PsAD0iRid9QoTeRKyv513dwH6IuT95w=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 28 Nov 2025 17:37:13 +0100
Subject: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
X-B4-Tracking: v=1; b=H4sIALjPKWkC/x3MQQqAIBBA0avErBtIK6OuEi00x5rNGBoRRHdPW
 r7F/w9kSkwZpuqBRBdnjlKg6grW3cpGyL4YdKN7pbTBM0ZBxxuSeLaCK2Mgo51rjRqHDkp4JAp
 8/9N5ed8P1tJGu2QAAAA=
X-Change-ID: 20251126-toon-big-endian-ci-fe62bb361974
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Anders Kaseorg <andersk@MIT.EDU>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

git-last-modified(1) uses a scratch bitmap to keep track of paths that
have been changed between commits. To avoid reallocating a bitmap on
each call of process_parent(), the scratch bitmap is kept and reused.
Although, it seems an incorrect length is passed to memset(3).

`struct bitmap` uses `eword_t` to for internal storage. This type is
typedef'd to uint64_t. To fully zero the memory used by the bitmap,
multiply the length (saved in `struct bitmap::word_alloc`) by the size
of `eword_t`.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
It was reported [1] the tests in t8020 fail on s390x. After some
research, it seems it was related to s390x being big-endian. Well,
actually, not really. Using big-endian simply uncovered the problem in
test.

[1]: https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu/
---
 builtin/last-modified.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index b0ecbdc540..cc5fd2e795 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -327,7 +327,7 @@ static void process_parent(struct last_modified *lm,
 	if (!(parent->object.flags & PARENT1))
 		active_paths_free(lm, parent);
 
-	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
+	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc * sizeof(eword_t));
 	diff_queue_clear(&diff_queued_diff);
 }
 

---
base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
change-id: 20251126-toon-big-endian-ci-fe62bb361974

