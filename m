Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E36136341
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465234; cv=none; b=R4cAQ5KOxH+H32NRLQ6/rVatkXavubqaaZjG9broSWIT3Pjozggr9HgZi04FB+mpAIIN8DD77hE5C67MeZx1j98D2k9Osl8XQfsknDQsiJ8BM48r2ovcUxV+GBoY6s4egC53roA04gau1DJeLcsx/Ywf4p+35ZRpaCgJO8u+v50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465234; c=relaxed/simple;
	bh=so0BICattfUdKDHR91f0iBp6WPIo+zEcUrlX5wN6v0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plHzqADdN7ZrwAk0DceFwfpomIHvs6I0Ou6T+IwkGCUmv/eGSQVh5LMZtP8ATBps8foEagmENwPHhkJz8GMrA07j0RX12vH+iQtV3RRUAEpJv0VzigD2jIjmXNd2Kz8TX0jpJ/UMIpZewTnArRocK8qbntMLTxc5QezmZjqAkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JKGTtjE0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JKGTtjE0"
Received: (qmail 24671 invoked by uid 109); 25 Feb 2025 06:33:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=so0BICattfUdKDHR91f0iBp6WPIo+zEcUrlX5wN6v0A=; b=JKGTtjE0oEhNk6Yr9Psx10L3+Tv2uBTylwcGMUneOatRfe6ZkXcWcMWhzlwrEm62Er5h8JIBKOaUKOC8CZWf4aINCbSsoB3IrfkOt+gQu9NdXuyzlUHJglTNI4HKkrv9LnH4AGrKOy7lE22IxkDoG/dMxS8laDBd8/xUgUMPp1veDHOO6O902aLLYt0rowGKqN+iXiPkWAxOOjchEpg4mcTO1V+1r6lZi37FS8rmnbUZH518pCmKORpnDWBF4LkJaB68DYM3ARiTWG+1F/G2802kd8Yn8MDcBt4RzyDD7vbDpKAWFXY8UVoHYEzccjzJeNrJAYw1Uw/MEAIUTXFP6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:33:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2803 invoked by uid 111); 25 Feb 2025 06:33:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:33:51 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:33:51 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 09/10] unpack_loose_rest(): simplify error handling
Message-ID: <20250225063351.GI1293961@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062518.GA1293854@coredump.intra.peff.net>

Inflating a loose object is considered successful only if we got
Z_STREAM_END and there were no more bytes. We check both of those
conditions and return success, but then have to check them a second time
to decide which error message to produce.

I.e., we do something like this:

  if (!error_1 && !error_2)
          ...return success...

  if (error_1)
          ...handle error1...
  else if (error_2)
          ...handle error2...
  ...common error handling...

This repetition was the source of a small bug fixed in an earlier commit
(our Z_STREAM_END check was not the same in the two conditionals).

Instead we can chain them all into a single if/else cascade, which
avoids repeating ourselves:

  if (error_1)
          ...handle error1...
  else if (error_2)
          ...handle error2....
  else
          ...return success...
  ...common error handling...

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8cf87caef5..b7928fb74e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1436,15 +1436,15 @@ static void *unpack_loose_rest(git_zstream *stream,
 			obj_read_lock();
 		}
 	}
-	if (status == Z_STREAM_END && !stream->avail_in) {
-		return buf;
-	}
 
 	if (status != Z_STREAM_END)
 		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
 	else if (stream->avail_in)
 		error(_("garbage at end of loose object '%s'"),
 		      oid_to_hex(oid));
+	else
+		return buf;
+
 	free(buf);
 	return NULL;
 }
-- 
2.48.1.709.gf47ae731ff

