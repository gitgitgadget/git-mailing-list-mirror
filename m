Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDA12E1C2
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215797; cv=none; b=eA9mVrcciFEzuMyMkEHehNUNTOzxWN2gkfkBZG2DOZGkK12uu4S5ttAyAD8O7VQ94tMPMECUUP75QDJ7bnYThvUF8B2KOM++9RpMLJEFAJNKkTNeISN/7/NAJn2AsRdJgDdcDA7+xtVeRCsjMyMMsGbJM5+e3k8Io7kCuIg49jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215797; c=relaxed/simple;
	bh=y7L5dFI6s5gyRGCtmhZRHU98xbfYXuLynF50+Y22aYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsRVpU+yN+a6kBVzwDmDZaARJtCf+KQqn61Ae3jWGh9jhW9AwyGpgNyj+58xWpng2uBH9QVBz38QyyQmSVreiXIJ9ln8g/Jn9dNEPZZJRoTj7SQ7TT7LFyHEU8ScQVH1jxjZNb73tA1kHhdlBncF8R+svJ6cup9n5ogTzs1Upg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15611 invoked by uid 109); 24 Sep 2024 22:09:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:09:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18844 invoked by uid 111); 24 Sep 2024 22:09:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:09:54 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:09:54 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 25/28] http-push: free xml_ctx.cdata after use
Message-ID: <20240924220954.GY1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

When we ask libexpat to parse XML data, we sometimes set xml_cdata as a
CharacterDataHandler callback. This fills in an allocated string in the
xml_ctx struct which we never free, causing a leak.

I won't pretend to understand the purpose of the field, but it looks
like it is used by other callbacks during the parse. At any rate, we
never look at it again after XML_Parse() returns, so we should be OK to
free() it then.

This fixes several leaks triggered by t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-push.c b/http-push.c
index 2e1c6851bb..1146d7c6fe 100644
--- a/http-push.c
+++ b/http-push.c
@@ -913,6 +913,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 			result = XML_Parse(parser, in_buffer.buf,
 					   in_buffer.len, 1);
 			free(ctx.name);
+			free(ctx.cdata);
 			if (result != XML_STATUS_OK) {
 				fprintf(stderr, "XML error: %s\n",
 					XML_ErrorString(
@@ -1170,6 +1171,7 @@ static void remote_ls(const char *path, int flags,
 			result = XML_Parse(parser, in_buffer.buf,
 					   in_buffer.len, 1);
 			free(ctx.name);
+			free(ctx.cdata);
 
 			if (result != XML_STATUS_OK) {
 				fprintf(stderr, "XML error: %s\n",
-- 
2.46.2.1011.gf1f9323e02

