Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1A4C66
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003789; cv=none; b=AHHOZBTsqfZQlf1sbdo+P2Ne7H8vg5bDsXcjYz2m2lALLDhfWo8jgxUhWziS4dhcB51qF+orXgXgUsmcZKAzZ7+HP8CnLr/zOn4fyh3W65p8zM4a5UDLjcJjjIkQtv+rRrQCeN17Dx3Y+5o58G9SDqgTpXDBvgLDHcy5QF4EAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003789; c=relaxed/simple;
	bh=2s4jc2uIvjx9nV/oRLdP8XcShrteL9+cYU2LpNVK030=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG4ARMm/0h2P5HDHdNkxxlUP9MDnOKuov8/AKpkVEbNtFyDjaW0i0VcazOUVDwBk8Hfzw3JnMmU40x0mfGuTuw86Ak24/vpWjtYEH0oQbQuDci0vKse+dJGEg3gZB47b6d18Owwjlkikswk4Mqubl3WgUl6SoGnOQue922WQ1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=KrRrNMte; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="KrRrNMte"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312651F5BB;
	Mon, 15 Jul 2024 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003721;
	bh=2s4jc2uIvjx9nV/oRLdP8XcShrteL9+cYU2LpNVK030=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrRrNMteueH8M9nAMuDbsvd0Hg1P5ng7+U3f+bVdMntLrIJaxg2Cp0/jgf5ClJly0
	 yY3XBBiPU7FK8EvZ7cXRizKAqtHLS8iJ6jwowR9Nimj0l6PwENs5KquSpTKXiN/b0M
	 QGr7WPx6IbAn+r+6srRZakS6/yphM8+RI8+haxZY=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 09/10] cat-file: batch_write: use size_t for length
Date: Mon, 15 Jul 2024 00:35:18 +0000
Message-ID: <20240715003519.2671385-10-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
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
index c4c28236db..efc0df760c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -370,7 +370,7 @@ static void expand_format(struct strbuf *sb, const char *start,
 	}
 }
 
-static void batch_write(struct batch_options *opt, const void *data, int len)
+static void batch_write(struct batch_options *opt, const void *data, size_t len)
 {
 	if (opt->buffer_output) {
 		if (fwrite(data, 1, len, stdout) != len)
