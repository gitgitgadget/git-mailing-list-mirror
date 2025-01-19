Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215D1DA3D
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737293157; cv=none; b=RxmcF9iFKfOFwaWQmbpuUTebS7zY18aLjGgVY4R57yM1zrNsHhsJZTwP3LtYQrtV494Iv0xFbGuB5WV2LBbsUuVld+eRmqly3OP186nIF7SyZBhjwYTUEYJM5juA44DjlADkZ00DzkU97KxjppjcknHu3s0DRrkeg+RBxorRRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737293157; c=relaxed/simple;
	bh=PAxAqlbV0/EmRXxrrWIL0KmPpewo3kY+rgIi4Xyrkl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N61wLsvwADI81MZzPLhKvkEpWI8wibZLqAYawQK5lWTIOKtuMNf5RcH/cf1bQp2Gi6uSBnarZbVeHkODD+Nje3n++E3iI64hrax0/O++eq/NsXrxWv7UAH97I2XFeN8apLUn8mibcdrFxbehismTLDJX1YzTVbXgUPLpX8VXDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PWZU2BlU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PWZU2BlU"
Received: (qmail 8003 invoked by uid 109); 19 Jan 2025 13:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PAxAqlbV0/EmRXxrrWIL0KmPpewo3kY+rgIi4Xyrkl0=; b=PWZU2BlUMPb8qS5tLeIdyUXrErU4X9GH+RQLiZTIieV1aP4RKuYrT2wbvJzUYdM5/hR6UY872ywfwJ7zjpBtL4B6HW3zkNL+78OfeX4KapUY9Vps4Z6lFVqdlwnmYKXi8+KMPBXfCv/5zPj2Z+UwT1HN54sWmiA6m6yhBO0yOWVwUaR8qvH92Y+w9GBmu/qx/vOf5vpZA17k+/ZdUBHiXLEgdHpfXhXEWhWJ3DiIKexjq70qXp4O1ymM9fEqJHi45/2EQRN+8/JmDzEQf9gNPmumL1fUltlKPkJRtnU0Q6VcY2Z0uQIalkVX4YG7YhNYTJi55UISMnkf4KHQza8o3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 13:25:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 791 invoked by uid 111); 19 Jan 2025 13:25:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 08:25:54 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 08:25:53 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 5/5] index-pack, unpack-objects: use skip_prefix to avoid
 magic number
Message-ID: <20250119132553.GE1552263@coredump.intra.peff.net>
References: <20250119131224.GA1541095@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119131224.GA1541095@coredump.intra.peff.net>

When parsing --pack_header=, we manually skip 14 bytes to the data.
Let's use skip_prefix() to do this automatically.

Note that we overwrite our pointer to the front of the string, so we
have to add more context to the error message. We could avoid this by
declaring an extra pointer to hold the value, but I think the modified
message is actually preferable; it should give translators a bit more
context.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c     | 6 +++---
 builtin/unpack-objects.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d6fd4bbde6..c632d9f88b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1956,11 +1956,11 @@ int cmd_index_pack(int argc,
 					warning(_("no threads support, ignoring %s"), arg);
 					nr_threads = 1;
 				}
-			} else if (starts_with(arg, "--pack_header=")) {
-				if (parse_pack_header_option(arg + 14,
+			} else if (skip_prefix(arg, "--pack_header=", &arg)) {
+				if (parse_pack_header_option(arg,
 							     input_buffer,
 							     &input_len) < 0)
-					die(_("bad %s"), arg);
+					die(_("bad --pack_header: %s"), arg);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "--progress-title")) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 76c6a9031b..51a856d823 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -646,10 +646,10 @@ int cmd_unpack_objects(int argc,
 				fsck_set_msg_types(&fsck_options, arg);
 				continue;
 			}
-			if (starts_with(arg, "--pack_header=")) {
-				if (parse_pack_header_option(arg + 14,
+			if (skip_prefix(arg, "--pack_header=", &arg)) {
+				if (parse_pack_header_option(arg,
 							     buffer, &len) < 0)
-					die(_("bad %s"), arg);
+					die(_("bad --pack_header: %s"), arg);
 				continue;
 			}
 			if (skip_prefix(arg, "--max-input-size=", &arg)) {
-- 
2.48.1.466.g22b8cfd1fa
